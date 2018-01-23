<?php
namespace Common\Model;
use Think\Log;
class VoucherModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 7;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

	public function count_voucher($conditon,&$msg){
	    $count = $this->where($conditon)->count();
        if($count === false){
            $msg = '统计优惠券信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $count;
    }

	public function create_voucher($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入优惠券信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建优惠券失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }
    public function get_voucher_list_by_condition($condition = null, $field = '*', $page, $order = null,&$msg){
        $result = array();
        $result = $this->field($field)->where($condition)->limit($page->firstRow.','.$page->listRows)->order($order)->select();
        if($result === false){
            $msg = '查找优惠券list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }
    public function get_voucher_info($condition,&$msg){
        $result = $this->where($condition)->find();
        if($result === false){
            $msg = '查找优惠券信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }
}