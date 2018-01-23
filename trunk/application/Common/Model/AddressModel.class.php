<?php
namespace Common\Model;
use Think\Log;
class AddressModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

	public function update_address($condition,$update_data,&$msg){
	    if(count($condition) < 1){
	        $msg = '没有更新条件';
	        return false;
        }
        if(count($update_data) < 1){
            $msg = '没有更新数据';
            return false;
        }
        $ret = $this->where($condition)->save($update_data);
        if($ret === false){
            $msg = '更新失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

    public function get_list($condition = null,&$msg){
        $list = $this->where($condition)->select();
        if($list === false){
            $msg = '查找配餐地址list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $list;
    }

    public function create_address($data,&$msg){
        if(count($data) < 1){
            $msg = '没有创建信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建配送地址失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

    public function get_address($condition,&$msg){
        if(count($condition) < 1){
            $msg = '没有查询条件';
            return false;
        }
        $result = $this->where($condition)->find();
        if($result === false){
            $msg = '查找配送地址失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function del_address($condition,&$msg){
        if(count($condition) < 1){
            $msg = '没有查询条件';
            return false;
        }
        $ret = $this->where($condition)->delete();
        if($ret === false){
            $msg = '删除配餐地址失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;

    }
}