<?php
namespace Api\Event;

use Think\Log;

class AddressEvent
{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 5;

    private $_address_model;
    private $_food_delivery_model;

    public function __construct()
    {
        $this->_log = new Log();
        $this->_address_model = D('Address');
        $this->_food_delivery_model = D('FoodDelivery');
    }

    public function get_fd_list($data, &$result = null){
        $list = $this->_food_delivery_model->get_delivery_and_take_place();
        $result['list'] = $list;
        return true;
    }

    public function add_receive_address($data, &$result = null){
        $params = array('member_id','r_name','r_mobile','d_id','d_name','t_id','is_default');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //组装新增地址的数组
        $insert_data = array(
            'member_id' => $data['member_id'],
            'receive_name' => $data['r_name'],
            'receive_mobile' => $data['r_mobile'],
            'd_id' => $data['d_id'],
            't_id' => $data['t_id']
        );
        //t_id若为0，自定义
        if($data['t_id'] == 0){
            $insert_data['receive_address'] = $data['d_name'].$data['content'];
        }else{
            $insert_data['receive_address'] = $data['d_name'].$data['t_name'];
        }
        M()->startTrans();
        //判断此地址是否为默认地址
        if($data['is_default'] == 0){
            $insert_data['is_default'] = 0;
        }elseif($data['is_default'] == 1){
            //需要先修改默认地址为非默认地址
            $edit_condition = array(
                'member_id' => $data['member_id'],
                'is_default' => 1
            );
            $update_data['is_default'] = 0;
            $ret = $this->_address_model->update_address($edit_condition,$update_data,$msg);
            if($ret === false){
                M()->rollback();
                $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                return 104;
            }
            $insert_data['is_default'] = 1;
        }
        $ret = $this->_address_model->create_address($insert_data,$msg);
        if($ret === false){
            M()->rollback();
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        M()->commit();
        return true;
    }

    public function edit_receive_address($data, &$result = null){
        $params = array('address_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //组装新增地址的数组
        $update_data = array(
            'receive_name' => $data['r_name'],
            'receive_mobile' => $data['r_mobile'],
            'd_id' => $data['d_id'],
            't_id' => $data['t_id']
        );
        //t_id若为0，自定义
        if($data['t_id'] == 0){
            $update_data['receive_address'] = $data['d_name'].$data['content'];
        }else{
            $update_data['receive_address'] = $data['d_name'].$data['t_name'];
        }
        //判断此地址是否为默认地址
        if($data['is_default'] == 1){
            $update_data['is_default'] = 1;
        }
        foreach ($update_data as $key => $value){
            if(empty($value)){
                unset($update_data[$key]);
            }
        }
        $condition = array(
            'id' => $data['address_id']
        );

        $ret = $this->_address_model->update_address($condition,$update_data,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        return true;
    }

    public function change_address_default($data, &$result = null){
        $params = array('member_id','address_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //需要先修改默认地址为非默认地址
        M()->startTrans();
        $edit_condition = array(
            'member_id' => $data['member_id'],
            'is_default' => 1
        );
        $update_data['is_default'] = 0;
        $ret = $this->_address_model->update_address($edit_condition,$update_data,$msg);
        if($ret === false){
            M()->rollback();
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        //变更默认地址
        $edit_condition = array(
            'id' => $data['address_id']
        );
        $update_data['is_default'] = 1;
        $ret = $this->_address_model->update_address($edit_condition,$update_data,$msg);
        if($ret === false){
            M()->rollback();
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        M()->commit();
        return true;
    }

    public function get_address_list($data, &$result = null){
        $params = array('member_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'member_id' => $data['member_id']
        );
        $list = array();
        $list = $this->_address_model->get_list($condition,$msg);
        if($list === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        $i = 1;
        foreach ($list as $value){
            if($value['is_default'] == 1){
                $result['list'][0]['address_id'] = $value['id'];
                $result['list'][0]['r_name'] = $value['receive_name'];
                $result['list'][0]['r_mobile'] = $value['receive_mobile'];
                $result['list'][0]['address'] = $value['receive_address'];
                $result['list'][0]['is_default'] = $value['is_default'];
                $result['list'][0]['d_id'] = $value['d_id'];
                $result['list'][0]['t_id'] = $value['t_id'];
            }else{
                $result['list'][$i]['address_id'] = $value['id'];
                $result['list'][$i]['r_name'] = $value['receive_name'];
                $result['list'][$i]['r_mobile'] = $value['receive_mobile'];
                $result['list'][$i]['address'] = $value['receive_address'];
                $result['list'][$i]['is_default'] = $value['is_default'];
                $result['list'][$i]['d_id'] = $value['d_id'];
                $result['list'][$i]['t_id'] = $value['t_id'];
            }
            $i++;
        }
        return true;
    }

    public function get_address($data, &$result = null){
        $params = array('member_id','address_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'member_id' => $data['member_id'],
            'id' => $data['address_id']
        );
        $addres_info = $this->_address_model->get_address($condition,$msg);
        if($addres_info === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        $result['r_name'] = $addres_info['receive_name'];
        $result['r_mobile'] = $addres_info['receive_mobile'];
        $result['d_id'] = $addres_info['d_id'];
        $result['t_id'] = $addres_info['t_id'];
        $result['content'] = $addres_info['receive_address'];
        $result['is_default'] = $addres_info['is_default'];
        return true;
    }

    public function del_address($data, &$result = null){
        $params = array('member_id','address_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'member_id' => $data['member_id'],
            'id' => $data['address_id']
        );
        $ret = $this->_address_model->del_address($condition,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        return true;
    }

    public function get_default_address($data, &$result = null){
        $params = array('member_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'member_id' => $data['member_id'],
            'is_default' => 1
        );
        $address_info = $this->_address_model->get_address($condition,$msg);
        if($address_info === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        if(count($address_info) < 1){
            return true;
        }
        $result['address_id'] = $address_info['id'];
        $result['r_name'] = $address_info['receive_name'];
        $result['r_mobile'] = $address_info['receive_mobile'];
        $result['address'] = $address_info['receive_address'];
        $result['d_id'] = $address_info['d_id'];
        $result['t_id'] = $address_info['t_id'];
        return true;
    }

}