<?php
namespace Common\Model;
use Think\Log;
class OrderGoodsModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}



	public function create_order_goods_arr($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入订单商品信息';
            return false;
        }
        $ret = $this->addAll($data);
        if($ret === false){
            $msg = '创建订单商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }

    public function get_order_goods_list($order_sn,&$msg){
        if(empty($order_sn)){
            $msg = '没有订单编码';
            return false;
        }
        $condition = array(
            'order_sn' => $order_sn
        );
        $order_goods_list = $this->where($condition)->select();
        if($order_goods_list === false){
            $msg = '获取订单商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;   
        }
        return $order_goods_list;
    }


}