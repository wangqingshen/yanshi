<?php

namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use Think\Log;

class GoodsController extends AdminbaseController{
    private $_log;//日志对象
    private $_goods_spec_model;
    private $_goods_spu_model;
    private $_goods_sku_model;
    private $_goods_stat_model;

    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 3;

    public function _initialize() {
        parent::_initialize();
        $this->_log = new Log();//声明日志对象
        $this->_goods_spec_model = D('GoodsSpec');
        $this->_goods_spu_model = D('GoodsSpu');
        $this->_goods_sku_model = D('GoodsSku');
        $this->_goods_stat_model = D('GoodsStat');
    }

    public function goods_spec(){
        $spec_list = array();
        $spec_list = $this->_goods_spec_model->get_spec();
        $list = array();
        foreach ($spec_list as $key => $value) {
            if($value['type'] == 1){
                $list['portion'][$key]['spec_value'] = $value['spec_value'];
                $list['portion'][$key]['id'] = $value['id'];
            }elseif ($value['type'] == 2) {
                $list['cycle'][$key]['spec_value'] = $value['spec_value'];
                $list['cycle'][$key]['id'] = $value['id'];
            }
        }

        $this->assign('portion',$list['portion']);
        $this->assign('cycle',$list['cycle']);
        $this->display('goods_spec');
    }

    public function add_spec_post(){
        $spec_value = I('spec_value');
        $insert_data = array(
            'type' => I('spec_type'),
            'spec_value' => $spec_value
        );
        $ret = $this->_goods_spec_model->create_spec($insert_data,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            $this->error($msg);
        }else{
            $this->success('添加成功',U('Goods/goods_spec'));
        }
    }
    public function edit_spec_post(){
        $condition = array(
            'id' => I("spec_id")
        );
        $update_data = array(
            "spec_value" => I("spec_value")
        );
        $ret = $this->_goods_spec_model->update_spec($condition,$update_data,$msg);
        if(!$ret){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            $json['errcode'] = 0;
        }else{
            $json['errcode'] = 1;
        }

        $this->ajaxReturn($json);
    }
    public function del_spec_post(){
        $spec_id = I('spec_id');
        $condition = array(
            'id' => $spec_id
        );
        $ret = $this->_goods_spec_model->del_spec($condition,$msg);
        if(!$ret){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            $json['errcode'] = 0;
        }else{
            $json['errcode'] = 1;
        }
        $this->ajaxReturn($json);
    }

    public function select_goods_list(){
        //统计商品总数
        $count = $this->_goods_spu_model->count_goods();
        //实例化分页类
        $size = 10;//默认10条
        $page = $this->Page($count,$size);
        $show = $page->show('Admin');
        //获取商品信息
        $order = 'spu_id desc';
        $field = 'spu_id,goods_name,goods_img1,goods_class';
        $list = $this->_goods_spu_model->get_goods_list_by_condition(null,$field,$page,$order,$msg);
        if($list == false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
        }
        $this->assign('goods_list',$list);
        $this->assign('goods_class',C('GOODS_CLASS_NAME'));
        $this->assign('page_show',$show);
        $this->display();
    }

    public function goods_list(){
        //统计商品总数
        $count = $this->_goods_spu_model->count_goods();
        //实例化分页类
        $size = 20;//默认20条
        $page = $this->Page($count,$size);
        $show = $page->show('Admin');
        //获取商品信息
        $order = 'spu_id desc';
        $field = 'spu_id,goods_name,goods_img1,goods_class,state';
        $list = $this->_goods_spu_model->get_goods_list_by_condition(null,$field,$page,$order,$msg);
        if($list == false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
        }
        //获取sku商品价格区间
        foreach ($list as $key => $value){
            $spu_id = $value['spu_id'];
            $sku_price_info = array();
            $sku_price_info = $this->_goods_sku_model->get_price_area_by_spu($spu_id);
            $list[$key]['price_area'] = $sku_price_info['min_sku_price'].'~'.$sku_price_info['max_sku_price'];
            $list[$key]['price_2_area'] = $sku_price_info['min_sku_2_price'].'~'.$sku_price_info['max_sku_2_price'];
            $list[$key]['price_4_area'] = $sku_price_info['min_sku_4_price'].'~'.$sku_price_info['max_sku_4_price'];
        }
        $this->assign('goods_list',$list);
        $this->assign('goods_class',C('GOODS_CLASS_NAME'));
        $this->assign('page_show',$show);
        $this->display();
    }

    public function add_goods(){
        //获取规格
        $spec_list = array();
        $spec_list = $this->_goods_spec_model->get_spec();
        $list = array();
        foreach ($spec_list as $key => $value) {
            if($value['type'] == 1){
                $list['portion'][$key]['spec_value'] = $value['spec_value'];
                $list['portion'][$key]['id'] = $value['id'];
            }elseif ($value['type'] == 2) {
                $list['cycle'][$key]['spec_value'] = $value['spec_value'];
                $list['cycle'][$key]['id'] = $value['id'];
            }
        }
        $this->assign('portion',$list['portion']);
        $this->assign('cycle',$list['cycle']);
        $this->display();
    }
    public  function add_goods_post(){
        $goods_name = I('goods_name');
        $goods_class = I('select_gooods_class');
        $delivery_explain = I('delivery_explain');
        $goods_img1 = I('goods_img1');
        $goods_slide_img = I('goods_slide_img');
        foreach ($goods_slide_img as $key => $value){
            if(empty($value)){
                unset($goods_slide_img[$key]);
            }
        }
        $goods_spu_img = I('goods_spu_img');
        foreach ($goods_spu_img as $key => $value){
            if(empty($value)){
                unset($goods_spu_img[$key]);
            }
        }
        $recommend = I('is_recommend');
        $recommend_img = I('goods_class_img');
        $spu_state = I('spu_state');
        $delivery_time = serialize(I('delivery_time'));
        $spec = I('spec');

        //获取选中规格值;
        $spu_spec = array();
        $spec_arra['portion'] = array();//份量
        $spec_arra['cycle'] = array();//周期
        foreach ($spec as $key => $value){
            $key_arr = explode('|',$key);
            if(!in_array($key_arr[0],$spu_spec['portion'])){
                $spu_spec['portion'][] = $key_arr[0];
            }
            if(!in_array($key_arr[1],$spu_spec['cycle'])){
                $spu_spec['cycle'][] = $key_arr[1];
            }
        }
        //开启创建商品事务
        M()->startTrans();
        //创建spu商品
        $insert_data = array(
            'goods_name' => $goods_name,
            'goods_class' => $goods_class,
            'delivery_explain' => $delivery_explain,
            'goods_img1' => $goods_img1,
            'goods_slide_img' => !empty($goods_slide_img)?serialize($goods_slide_img):'',
            'goods_spu_img' => !empty($goods_spu_img)?serialize($goods_spu_img):'',
            'recommend' => $recommend,
            'recommend_img' => $recommend_img,
            'spu_spec' => serialize($spu_spec),
            'delivery_time' => $delivery_time,
            'state' => $spu_state
        );
        $goods_spu_id = $this->_goods_spu_model->create_spu($insert_data,$msg);
        if($goods_spu_id == false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            M()->rollback();
            $this->error($msg);
        }
        //创建sku商品
        $insert_sku_data = array();
        $i = 0;
        foreach ($spec as $key => $value){
            $insert_sku_data[$i] = array(
                'spu_id' => $goods_spu_id,
                'sku_price' => $value[0],
                'sku_2_price' => $value[1],
                'sku_4_price' => $value[2],
                'delivery_num' => $value[3],
                'spec' => $key
            );
            $i++;
        }
        $ret = $this->_goods_sku_model->create_sku($insert_sku_data,$msg);
        if($ret == false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            M()->rollback();
            $this->error($msg);
        }
        //在商品统计中插入一条数据
        $insert_stat_data = array(
            'spu_id' => $goods_spu_id,
            'order_count' => 0
        );
        $ret = $this->_goods_stat_model->insert_stat($insert_stat_data,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            M()->rollback();
            $this->error($msg);
        }

        M()->commit();
        $this->success('创建商品成功',U('Goods/goods_list'));
    }

    public function goods_info(){
        $spu_id = I('spu_id');
        $res_spu = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
        if($res_spu == false){
            $this->error($msg);
        }
        $res_spu['goods_class'] = C('GOODS_CLASS_NAME')[$res_spu['goods_class']];
        $res_spu['goods_img1'] = set_img_path($res_spu['goods_img1']);
        $res_spu['goods_slide_img'] = unserialize($res_spu['goods_slide_img']);
        foreach ($res_spu['goods_slide_img'] as $key => $value){
            $res_spu['goods_slide_img'][$key] = set_img_path($value);
        }
        $res_spu['goods_spu_img'] = unserialize($res_spu['goods_spu_img']);
        foreach ($res_spu['goods_spu_img'] as $key => $value){
            $res_spu['goods_spu_img'][$key] = set_img_path($value);
        }
        $res_spu['recommend_img'] = set_img_path($res_spu['recommend_img']);
        $res_spu['delivery_time'] = unserialize($res_spu['delivery_time']);
        foreach ($res_spu['delivery_time'] as $key => $value){
            $res_spu['delivery_time'][$key] = C('delivery_time')[$value];
        }
        $res_spu['spu_spec'] = unserialize($res_spu['spu_spec']);
        //获取sku商品新
        $sku_list = $this->_goods_sku_model->get_sku_by_spu($spu_id);

        $this->assign('sku_list',$sku_list);
        $this->assign('spu_info',$res_spu);
        $this->display();
    }
    public function recommend_goods(){
        $spu_id = I('spu_id');
        //获取spu对应的送餐时间段
        $spu_info = array();
        $spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
        if($spu_info === false){
            $this->error('商品数据查询出错');
        }
        //根据送餐时间段查找符合条件的sku商品
        $spu_condition = array(
            'delivery_time' => $spu_info['delivery_time']
        );
        $spu_ids = array();
        $field = 'spu_id';
        $spu_ids = $this->_goods_spu_model->get_goods_list($spu_condition,$field,$msg);
        if($spu_ids === false){
            $this->error('获取spuid集合失败');
        }
        $sku_list = array();
        if(count($spu_ids) > 0){
            //根据spu的id集，获取对应的sku信息
            $sku_ids = array();
            foreach ($spu_ids as $id){
                $sku_ids[] = $id['spu_id'];
            }
            $sku_condition['sku_id'] = array('in',$sku_ids);
            $field = '*';
            $sku_list = $this->_goods_sku_model->get_sku_condition($sku_condition,$field,$msg);
            if($sku_list === false){
                $this->error('获取sku信息失败');
            }
        }
        foreach ($sku_list as $key => $value){
            //获取sku对应的spu name
            $sku_spu_id = $value['spu_id'];
            $sku_spu_info = $this->_goods_spu_model->get_spu_by_id($sku_spu_id);
            $sku_list[$key]['goods_name'] = $sku_spu_info['goods_name'];
        }
        $this->assign('spu_id',$spu_id);
        $this->assign('sku_list',$sku_list);
        $this->display();
    }

    public function add_recommend_goods_post(){
        $sku_ids = I('select_sku');
        $spu_id = I('spu_id');
        $condition = array(
            'spu_id' => $spu_id
        );
        $update_data = array(
            'recommend_sku_ids' => serialize($sku_ids)
        );
        $ret = $this->_goods_spu_model->update_spu($condition,$update_data,$msg);
        if($ret === false){
            $this->error('更新推荐sku商品失败');
        }
        $this->success('添加推荐sku商品成功');
    }

    public function get_recommend_list(){
        $spu_id = I('spu_id');
        //获取商品
        $spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id);
        if($spu_info === false){
            $this->error('获取推荐商品信息失败');
        }
        if(empty($spu_info['recommend_sku_ids'])){
            $this->display();exit;
        }
        $recommend_sku_ids = unserialize($spu_info['recommend_sku_ids']);
        //获取推荐商品信息
        $sku_condition = array(
            'sku_id' => array('in',$recommend_sku_ids)
        );
        $sku_list = $this->_goods_sku_model->get_sku_condition($sku_condition);
        if ($sku_list === false){
            $this->error('获取绑定的sku商品失败');
        }
        foreach ($sku_list as $key => $value){
            //获取sku对应的spu name
            $spu_id = $value['spu_id'];
            $sku_spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id);
            $sku_list[$key]['goods_name'] = $sku_spu_info['goods_name'];
        }
        $this->assign("sku_list",$sku_list);
        $this->display();

    }

    public function edit_goods_spu(){
        $spu_id = I('spu_id');
        $res_spu = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
        if($res_spu == false){
            $this->error($msg);
        }
        $res_spu['goods_slide_img'] = unserialize($res_spu['goods_slide_img']);
        $res_spu['goods_spu_img'] = unserialize($res_spu['goods_spu_img']);
        $res_spu['recommend_img'] = $res_spu['recommend_img'];
        $res_spu['delivery_time'] = unserialize($res_spu['delivery_time']);
        $res_spu['spu_spec'] = unserialize($res_spu['spu_spec']);
        //获取sku商品新
        $sku_list = $this->_goods_sku_model->get_sku_by_spu($spu_id);
        //获取规格
        $spec_list = array();
        $spec_list = $this->_goods_spec_model->get_spec();
        $list = array();
        foreach ($spec_list as $key => $value) {
            if($value['type'] == 1){
                $list['portion'][$key]['spec_value'] = $value['spec_value'];
                $list['portion'][$key]['id'] = $value['id'];
            }elseif ($value['type'] == 2) {
                $list['cycle'][$key]['spec_value'] = $value['spec_value'];
                $list['cycle'][$key]['id'] = $value['id'];
            }
        }

        $this->assign('portion',$list['portion']);
        $this->assign('cycle',$list['cycle']);
        $this->assign('goods_class',C('GOODS_CLASS_NAME'));
        $this->assign('sku_list',$sku_list);
        $this->assign('spu_info',$res_spu);
        $this->display();
    }
    public function edit_goods_spu_post(){
        $spu_condition = array(
            'spu_id' => I('spu_id')
        );
        $goods_name = I('goods_name');
        $goods_class = I('select_gooods_class');
        $delivery_explain = I('delivery_explain');
        $goods_img1 = I('goods_img1');
        $goods_slide_img = I('goods_slide_img');
        foreach ($goods_slide_img as $key => $value) {
            if(empty($value)){
                unset($goods_slide_img[$key]);
            }
        }
        $goods_slide_img = serialize($goods_slide_img);
        $goods_spu_img = I('goods_spu_img');
        foreach ($goods_spu_img as $key => $value) {
            if(empty($value)){
                unset($goods_spu_img[$key]);
            }
        }
        $goods_spu_img = serialize($goods_spu_img);
        $is_recommend = I('is_recommend');
        $recommend_img = I('goods_class_img');
        $delivery_time = serialize(I('delivery_time'));
        $state = I('spu_state');

        $spu_update = array(
            'goods_name' => $goods_name,
            'goods_class' => $goods_class,
            'delivery_explain' => $delivery_explain,
            'goods_img1' => $goods_img1,
            'goods_slide_img' => $goods_slide_img,
            'goods_spu_img' => $goods_spu_img,
            'is_recommend' => $is_recommend,
            'recommend_img' => $recommend_img,
            'delivery_time' => $delivery_time,
            'state' => $state
        );
        $ret = $this->_goods_spu_model->update_spu($spu_condition,$spu_update,$msg);
        if($ret === false){
            $this->error('更新spu商品出错');
        }
        $this->success('更新成功');
    }

    public function edit_sku(){
        $spu_id = I('spu_id');
        //获取sku信息
        $sku_list = $this->_goods_sku_model->get_sku_by_spu($spu_id);
        if($sku_list === false){
            $this->error('获取sku商品信息失败');
        }
        $this->assign('sku_list',$sku_list);
        $this->display();
    }
    public function edit_sku_post(){
        $type = I('type');
        $val = I('val');
        $sku_id = I('sku_id');
        $update_data = array();
        switch ($type){
            case 1: $update_data['sku_price'] = $val;
                break;
            case 2: $update_data['sku_2_price'] = $val;
                break;
            case 3: $update_data['sku_4_price'] = $val;
                break;
            case 4: $update_data['delivery_num'] = $val;
                break;
        }
        $condition = array(
            'sku_id' => $sku_id
        );
        $ret = $this->_goods_sku_model->update_sku($condition,$update_data,$msg);
        if($ret === false){
            $result['errcode'] = 0;
            $this->ajaxReturn($result);
        }else{
            $result['errcode'] = 1;
            $this->ajaxReturn($result);
        }
    }

    public function del_sku(){
        $sku_id = I('sku_id');
        if(empty($sku_id)){
            $this->error('缺少skuid');
        }
        $ret = $this->_goods_sku_model->del_sku($sku_id,$msg);
        if($ret === false){
            $this->error('删除失败');
        }
        $this->success('删除成功');
    }

}
