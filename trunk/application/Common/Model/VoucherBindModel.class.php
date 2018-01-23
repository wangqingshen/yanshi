<?php
namespace Common\Model;
use Think\Log;
class VoucherBindModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 7;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

    public function count_voucher_bind($conditon,&$msg){
        $count = $this->where($conditon)->count();
        if($count === false){
            $msg = '统计绑定优惠券信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $count;
    }


	public function create_voucher_bind($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入用户绑定优惠券信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建优惠券绑定信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }
    public function get_voucher_list_by_condition($condition = null, $field = '*', $order=null, $offset = null, $num,&$msg){
        //必须分页
        if ($offset < 0 || empty($num)) {
            $msg = '没有传入必须参数';
            return false;
        }
        $result = $this->where($condition)->limit($offset, $num)->order($order)->field($field)->select();
        if($result === false){
            $msg = '查找优惠券list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }

        return $result;
    }
   public function get_voucher_bind_list($condition,$field='*',&$msg){
       $result = $this->field($field)->where($condition)->select();
       if($result === false){
           $msg = '查找优惠券信息失败';
           $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
           return false;
       }
       return $result;
   }
}