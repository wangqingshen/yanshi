<?php
namespace Common\Model;
use Think\Log;

class MemberModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
	}

	public function set_log(){
        $this->_log = new Log();//声明日志对象
    }

	public function count_member($conditon,$msg){
	    self::set_log();
	    $count = $this->where($conditon)->count();
        if($count === false){
            $msg = '统计用户信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $count;
    }

    public function get_member_by_openid($openid,&$msg){
        self::set_log();
        if(empty($openid)){
            $msg = 'openid不能为空';
            return false;
        }
        $condition = array(
            'wechat_openid' => $openid
        );
        $result = $this->where($condition)->find();
        if($result === false){
            $msg = '查找用户信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function get_member_by_id($member_id,&$msg){
        self::set_log();
        if(empty($member_id)){
            $msg = 'member_id不能为空';
            return false;
        }
        $condition = array(
            'id' => $member_id
        );
        $result = $this->where($condition)->find();
        if($result === false){
            $msg = '查找用户信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function get_member_by_mobile($member_mobile,&$msg){
        self::set_log();
        if(empty($member_mobile)){
            $msg = 'member_mobile不能为空';
            return false;
        }
        $condition = array(
            'mobile' => $member_mobile
        );
        $result = $this->where($condition)->find();
        if($result === false){
            $msg = '查找用户信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

	public function create_member($data,&$msg){
        self::set_log();
        if(count($data) < 1){
            $msg = '没有传入用户信息';
            return false;
        }
        $data['nick_name'] = jsonName($data['nick_name']);
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建用户信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }
    public function get_member_list_by_condition($condition = null, $field = '*', $page, $order = null, &$msg){
        self::set_log();
        $result = array();
        $result = $this->field($field)->where($condition)->limit($page->firstRow.','.$page->listRows)->order($order)->select();
        if($result === false){
            $msg = '查找用户list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }
    public function update_member_info($member_id,$update_data,&$msgg){
        self::set_log();
        if(empty($member_id)){
            $msg = 'member_id不能为空';
            return false;
        }
        if(count($update_data) < 1){
            $msg = '没有传入用户信息';
            return false;
        }
        $condition = array(
            'id' => $member_id
        );
        $ret = $this->where($condition)->save($update_data);
        if($ret === false){
            $msg = $this->getLastSql();
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

}