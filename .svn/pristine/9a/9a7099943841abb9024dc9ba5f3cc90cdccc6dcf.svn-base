<?php
namespace Common\Model;
use Think\Log;
class GoodsSpuModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

	public function count_goods($condition,$msg){
        $count = $this->where($condition)->count();
        if($count === false){
            $msg = '统计spu商品失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $count;

    }

	public function create_spu($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入spu商品信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建spu商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }
    public function update_spu($condition,$update_data,&$msg){
        if(count($condition)<1){
            $msg = '没有更新条件';
            return false;
        }
        if(count($update_data) < 1){
            $msg = '没有更新数据';
            return false;
        }
        $ret = $this->where($condition)->save($update_data);
        if($ret === false){
            $msg = '更新spu商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

    public function get_goods_list_by_condition($condition = null, $field = '*', $page, $order = null, &$msg){
        $result = array();
        $result = $this->field($field)->where($condition)->limit($page->firstRow.','.$page->listRows)->order($order)->select();
        if($result === false){
            $msg = '查找商品list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function get_goods_list($condition = null,$field='*',&$msg){
        if(count($condition) < 1){
            $msg = '没有查询条件';
            return false;
        }
        $list = $this->field($field)->where($condition)->select();
        if($list === false){
            $msg = '查找商品list失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $list;
    }

    public function get_spu_by_id($spu_id,&$msg){
        if(empty($spu_id)){
            $msg = 'spuid不能为空';
            return false;
        }
        $condition = array(
            'spu_id' => $spu_id
        );
        $result = $this->where($condition)->find();
        if($result === false){
            $msg = '查找spu商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

}