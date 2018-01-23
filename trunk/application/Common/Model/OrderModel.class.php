<?php
namespace Common\Model;
use Think\Log;
class OrderModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

    public function count_order($condition = null,&$msg){
        $count = $this->where($condition)->count();
        if($count === false){
            $msg = '统计订单数量失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $count;
    }

	public function create_order($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入订单信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建订单信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }

    public function update_order($condition, $update_data,&$msg){
        if(count($condition) < 1){
            $msg = '没有传入更新条件';
            return false;
        }
        if(count($update_data) < 1){
            $msg = '没有传入更新数据';
            return false;
        }
        $ret = $this->where($condition)->save($update_data);
        if($ret === false){
            $msg = '更新订单信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

    public function get_order_list($condition = null, $field = '*', $order=null, $offset = null, $num,&$msg){
        //必须分页
        if ($offset < 0 || empty($num)) {
            $msg = '没有传入必须参数';
            return false;
        }
        $result = $this->where($condition)->limit($offset, $num)->order($order)->field($field)->select();
        if($result === false){
            $msg = '查找订单list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function get_order_by_id($order_id,&$msg){
        if(empty($order_id)){
            $msg = 'order_id不能为空';
            return false;
        }
        $condition = array(
            'order_id' => $order_id
        );
        $order_info = $this->where($condition)->find();
        if($order_info === false){
            $msg = '查找订单订单信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $order_info;
    }

    public function get_order_by_sn($order_sn,&$msg){
        if(empty($order_sn)){
            $msg = 'order_sn不能为空';
            return false;
        }
        $condition = array(
            'order_sn' => $order_sn
        );
        $order_info = $this->where($condition)->find();
        if($order_info === false){
            $msg = '查找订单信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $order_info;
    }

    public function get_order_list_by_condition($condition = null, $field = '*', $page, $order = null, &$msg){
        $result = array();
        $result = $this->field($field)->where($condition)->limit($page->firstRow.','.$page->listRows)->order($order)->select();
        if($result === false){
            $msg = '查找订单list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function get_pin_order_list($pin_order_sn,&$msg){
        if(empty($pin_order_sn)){
            $msg = 'pin_order_sn不能为空';
            return false;
        }
        $condition = array(
            'pin_order_sn' => $pin_order_sn
        );
        $order_info = $this->where($condition)->select();
        if($order_info === false){
            $msg = '查找拼团订单信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $order_info;
    }

    public function get_all_by_condition($condition,&$msg){
        if(count($condition) < 1){
            $msg = '没有传入查询条件';
            return false;
        }
        $result = $this->where($condition)->select();
        if($result === false){
            $msg = '查找订单信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }


}