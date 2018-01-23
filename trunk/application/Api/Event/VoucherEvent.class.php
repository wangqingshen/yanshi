<?php
namespace Api\Event;

use Think\Cache\Driver\Memcached;
use Think\Log;

class VoucherEvent
{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 5;

    private $_voucher_bind_model;
    private $_goods_sku_model;
    private $_goods_spu_model;

    public function __construct()
    {
        $this->_log = new Log();
        $this->_voucher_bind_model = D('VoucherBind');
        $this->_goods_sku_model = D('GoodsSku');
        $this->_goods_spu_model = D('GoodsSpu');
    }

    public function get_member_voucher($data, &$result = null){
        $params = array('state','member_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        if($data['state'] == 2){
            $condition =array(
                'member_id' => $data['member_id'],
                'state' => array('in',array(2,3))
            );
        }else{
            $condition =array(
                'member_id' => $data['member_id'],
                'state' => $data['state']
            );
        }

        //用户优惠券总数
        $count = $this->_voucher_bind_model->count_voucher_bind($condition,$msg);
        if($count === false){
            $msg = '统计用户优惠券失败';
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        if($count == 0){
            return true;
        }
        $voucher_list = array();
        $order = 'bind_time desc';
        $voucher_list = $this->_voucher_bind_model->get_voucher_list_by_condition($condition,"*",$order,0,$count,$msg);
        if($voucher_list === false){
            $msg = '获取用户优惠券列表失败';
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        $list = array();
        foreach ($voucher_list as $key => $value){
            $list[$key]['voucher_id'] = $value['v_id'];
            $list[$key]['voucher_name'] = $value['voucher_name'];
            $list[$key]['voucher_price'] = $value['voucher_price'];
            $list[$key]['voucher_type'] = $value['type'];
            $list[$key]['start_time'] = date("Y-m-d",$value['start_time']);
            $list[$key]['end_time'] = date("Y-m-d",$value['end_time']);
            $list[$key]['state'] = $value['state'];
            //查找绑定商品
            if($value['type'] == 1){
                continue;
            }
            $bind_ids = unserialize($value['bind_g_ids']);
            $goods_info = array();
            foreach ($bind_ids as $k => $sku_id){
                $condition_sku = array(
                    'sku_id' => $sku_id
                );
                $field = 'spu_id';
                $sku_info = array();
                $sku_info = $this->_goods_sku_model->get_sku_condition($condition_sku,$field,$msg);
                if($sku_info === false){
                    $msg = '查询skuid对应的spuid失败';
                    $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                    continue;
                }
                $spu_id = $sku_info[0]['spu_id'];
                $spu_info = array();
                $spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
                if($spu_info === false){
                    $msg = '查询spu商品信息失败';
                    $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                    continue;
                }
                $goods_info[$k]['goods_name'] = $spu_info['goods_name'];
            }
            $list[$key]['goods_info'] = $goods_info;
        }
        $result['list'] = $list;
        return true;
    }




}