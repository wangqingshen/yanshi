<?php
namespace Api\Event;

use Think\Log;
class GoodsEvent
{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 5;

    private $_goods_spu_model;
    private $_goods_sku_model;
    private $_goods_stat_model;

    public function __construct()
    {
        $this->_goods_spu_model = D('GoodsSpu');
        $this->_goods_sku_model = D('GoodsSku');
        $this->_goods_stat_model = D('GoodsStat');
        $this->_log = new Log();
    }

    public function goods_demo($data, &$result = null)
    {
        $params = array('name');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $result['list'][0]['goods_name'] = '测试商品';
        $result['list'][0]['goods_price'] = 20.33;
        return 1;
    }

    public function goods_class_info($data, &$result = null){
        $params = array('class_type');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'goods_class' => $data['class_type'],
            'state' => 1
        );
        $res_recommend = $this->_goods_spu_model->get_goods_list($condition,'*',$msg);
        if($res_recommend === false){
            $this->_log->write_array(null,'获取分类商品失败', self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        $goods_list = array();
        foreach ($res_recommend as $key => $value){
            $goods_list[$key]['spu_id'] = $value['spu_id'];
            $goods_list[$key]['goods_name'] = $value['goods_name'];
            $goods_list[$key]['recommend'] = $value['recommend'];
            //获取商品的最优价格
            $res_sku = array();
            $res_sku = $this->_goods_sku_model->get_price_area_by_spu($value['spu_id']);
            if($res_sku === false){
                $this->_log->write_array(null,'获取分类商品失败', self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            }
            $goods_list[$key]['goods_price'] = $res_sku['min_sku_price'];

            //判断是否推荐商品
            if($value['recommend'] == 2){
                $goods_list[$key]['goods_img'] = '/'.C('UPLOADPATH').$value['recommend_img'];
                $goods_list[$key]['recommend_price_area'] = $res_sku['min_sku_4_price'].'-'.$res_sku['max_sku_2_price'];
            }elseif($value['recommend'] == 1){
                $goods_list[$key]['goods_img'] = '/'.C('UPLOADPATH').$value['goods_img1'];
            }
            //获取spu商品预定总数
            $res_stat = $this->_goods_stat_model->get_info_by_spu($value['spu_id'],$msg);
            if($res_stat === false){
                $this->_log->write_array(null,'获取商品统计信息失败', self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            }
            $goods_list[$key]['count'] = $res_stat['order_count'];
        }
        $result['list'] = $goods_list;
        return true;
    }

    public function get_goods_info($data, &$result = null){
        $params = array('spu_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $spu_id= $data['spu_id'];
        $res_spu = array();
        $res_spu = $this->_goods_spu_model->get_spu_by_id($spu_id);
        if($res_spu === false){
            return 104;
        }
        $result['spu_id'] = $spu_id;
        $result['goods_name'] = $res_spu['goods_name'];//商品名称
        //设置轮播图
        foreach (unserialize($res_spu['goods_slide_img']) as $value){
            $goods_slide[] = set_img_path($value);
        }
        $goods_slide[4] = set_img_path($res_spu['goods_img1']);
        asort($goods_slide);
        $result['goods_slide'] = $goods_slide;//商品轮播图
        //设置商品详情图
        foreach (unserialize($res_spu['goods_spu_img']) as $value){
            $result['goods_img'][] = set_img_path($value);
        }
        //获取spu商品价格区间
        $res_sku_price = array();
        $res_sku_price = $this->_goods_sku_model->get_price_area_by_spu($spu_id);
        if($res_sku_price === false){
            return 104;
        }
        $result['goods_price'] = $res_sku_price['min_sku_price'];//商品最低价格
        $result['recommend_price_area'] = $res_sku_price['min_sku_4_price'].'-'.$res_sku_price['max_sku_2_price'];//拼团价格区间
        $result['delivery_explain'] = $res_spu['delivery_explain'];
        //商品统计
        $res_goods_stat = $this->_goods_stat_model->get_info_by_spu($spu_id);
        if($res_goods_stat === false){
            return 104;
        }
        $result['count'] = $res_goods_stat['order_count'];
        //获取spu商品的规格及sku对应价格
        $result['spec'] = unserialize($res_spu['spu_spec']);
        //获取spu对应的sku信息
        $sku_list = array();
        $sku_list = $this->_goods_sku_model->get_sku_by_spu($spu_id,$msg);
        if($sku_list === false){
            return 104;
        }
        $result['sku'] = array();
        foreach ($sku_list as $value){
            $result['sku'][$value['spec']]['goods_price'] = $value['sku_price'];
            $result['sku'][$value['spec']]['sku_2_price'] = $value['sku_2_price'];
            $result['sku'][$value['spec']]['sku_4_price'] = $value['sku_4_price'];
        }
        return true;
    }

    public function get_goods_sku_by_spec($data, &$result = null){
        $params = array('spec','spu_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $spec = $data['spec'];
        $condition = array(
            'spec' => $spec,
            'spu_id' => $data['spu_id']
        );
        $sku_info = $this->_goods_sku_model->get_sku_condition($condition,$msg);
        if($sku_info === false){
            return 104;
        }
        $result['sku_id'] = $sku_info[0]['sku_id'];
        return true;
    }



}