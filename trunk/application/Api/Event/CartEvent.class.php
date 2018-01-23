<?php
namespace Api\Event;

use Think\Log;

class CartEvent
{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 5;

    private $_cart_model;
    private $_goods_sku_model;

    public function __construct()
    {
        $this->_log = new Log();
        $this->_cart_model = D('Cart');
        $this->_goods_sku_model = D('GoodsSku');
    }

    public function add_cart($data, &$result = null){
        $params = array('member_id','sku_spec','spu_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //查找sku_id
        $sku_condition = array(
            'spu_id' => $data['spu_id'],
            'spec' => $data['sku_spec']
        );
        $sku_info = array();
        $sku_info = $this->_goods_sku_model->get_sku_condition($sku_condition,$msg);
        $sku_id = $sku_info[0]['sku_id'];

        $insert_data = array(
            'member_id' => $data['member_id'],
            'sku_id' => $sku_id
        );
        $ret = $this->_cart_model->create_cart($insert_data,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        return true;
    }

    public function get_cart_list($data, &$result = null){
        $params = array('member_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $member_id = $data['member_id'];
        //获取购物车信息
        $cart_list = array();
        $sku_field = 'sku_id,spu_id,sku_price,spec';
        $cart_list = $this->_cart_model->get_cart_list_by_member($member_id,$sku_field,$msg);
        if($cart_list === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        $result['list'] = $cart_list;
        return true;
    }

    public function del_cart($data, &$result = null){
        $params = array('member_id','sku_ids');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'member_id' => $data['member_id'],
            'sku_id' => array('in',$data['sku_ids'])
        );
        $ret = $this->_cart_model->del_cart_ids($condition,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        return true;
    }


}