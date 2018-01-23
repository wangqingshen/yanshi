<?php

namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use Think\Log;

class FoodDeliveryController extends AdminbaseController{
    private $_log;//日志对象
    private $_food_delivery_model;
    private $_take_meal_place_model;

    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 8;

    public function _initialize() {
        parent::_initialize();
        $this->_log = new Log();//声明日志对象
        $this->_food_delivery_model = D('FoodDelivery');
        $this->_take_meal_place_model = D('TakeMealPlace');
    }

    public function delivery_list(){
        $list = $this->_food_delivery_model->get_list();
        foreach ($list as $key => $value){
            //获取取餐点
            $condition = array(
                'd_id' => $value['id']
            );
            $take_place_info = $this->_take_meal_place_model->get_list($condition);
            $take_place = '';
            foreach ($take_place_info as $val){
                $take_place .= $val['name'].'|';
            }
            $list[$key]['take_place'] = rtrim($take_place,'|');
        }
        $this->assign('list',$list);
        $this->display();
    }
    public function add_delivery(){
        $this->display();
    }
    public function add_delivery_post(){
        $name = I('d_name');
        $insert_data = array(
            'name' => $name
        );
        $ret = $this->_food_delivery_model->create_delivery($insert_data);
        if($ret === false){
            $this->error('创建失败');
        }
        $this->success('创建成功',U('FoodDelivery/delivery_list'));
    }
    public function add_meal_place($d_id,$d_name){
        $this->assign('d_id',$d_id);
        $this->assign('d_name',$d_name);
        $this->display();
    }
    public function add_meal_place_post(){
        $d_id = I('d_id');
        $take_place = I('take_place');
        $insert_data = array(
            'd_id' => $d_id,
            'name' => $take_place
        );
        $ret = $this->_take_meal_place_model->create_meal_place($insert_data);
        if($ret === false){
            $this->error('创建失败');
        }
        $this->success('创建成功');
    }
    public function edit_meal_place($d_id,$d_name){
        //获取取餐点列表
        $condition = array(
            'd_id' => $d_id
        );
        $list = $this->_take_meal_place_model->get_list($condition);

        $this->assign('list',$list);
        $this->assign('d_id',$d_id);
        $this->assign('d_name',$d_name);
        $this->display();
    }
    public function del_tak_place_post(){
        $tid = I('tid');
        $ret = $this->_take_meal_place_model->del_take_place($tid,$msg);
        if($ret === false){
            $data['errcode'] = 0;
        }else{
            $data['errcode'] = 1;
        }
        $this->ajaxReturn($data,'json');
    }



}
