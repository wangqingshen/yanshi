<?php
namespace Common\Model;
use Think\Log;
class FoodDeliveryModel extends CommonModel{
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
            $msg = '查找配餐学校list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $list;
    }

    public function create_delivery($data,&$msg){
        if(count($data) < 1){
            $msg = '没有创建信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建送餐地点失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }
    public function get_delivery_and_take_place(){
        $delivery_list = $this->get_list();
        $take_place_model = D('TakeMealPlace');
        $list = array();
        foreach ($delivery_list as $key => $value){
            $list[$key]['d_id'] = $value['id'];
            $list[$key]['d_name'] = $value['name'];
            //查找取餐点
            $condition = array(
                'd_id' => $value['id']
            );
            $take_list = $take_place_model->get_list($condition);
            foreach ($take_list as $k => $v){
                $list[$key]['take_list'][$k]['t_id'] = $v['id'];
                $list[$key]['take_list'][$k]['t_name'] = $v['name'];
            }
        }
        return $list;
    }
}