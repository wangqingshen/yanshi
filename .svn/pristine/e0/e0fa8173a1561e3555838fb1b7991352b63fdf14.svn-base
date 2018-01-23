<?php
namespace Common\Model;
use Think\Log;
class DeliveryInfoModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}


	public function create_delivery_info($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入送餐信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建送餐信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }

    public function get_delivery_list($order_id,&$msg){
        if(empty($order_id)){
            $msg = '没有订单id';
            return false;
        }
        $condition = array(
            'order_id' => $order_id
        );
        $delivery_list = $this->where($condition)->select();
        if($delivery_list === false){
            $msg = '获取配送列表失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $delivery_list;
    }

    public function get_all_by_condition($condition, &$msg){
        if(count($condition) < 1){
            $msg = '没有查询条件';
            return false;
        }
        $result = $this->where($condition)->select();
        if($result === false){
            $msg = '获取配送信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }




}