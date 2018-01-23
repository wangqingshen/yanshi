<?php
namespace Common\Model;
use Think\Log;
class TakeMealPlaceModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

    public function get_list($condition = null,&$msg){
        $list = $this->where($condition)->select();
        if($list === false){
            $msg = '查找取餐地点list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $list;
    }

    public function create_meal_place($data,&$msg){
        if(count($data) < 1){
            $msg = '没有创建信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建取餐地点失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

    public function del_take_place($take_place_id,&$msg){
        if(empty($take_place_id)){
            $msg = 'take_place_id不能为空';
            return false;
        }
        $condition = array(
            'id' => $take_place_id
        );
        $ret = $this->where($condition)->delete();
        if($ret === false){
            $msg = '删除失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }
}