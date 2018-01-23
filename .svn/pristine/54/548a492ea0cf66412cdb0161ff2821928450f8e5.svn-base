<?php
namespace Common\Model;
use Think\Log;
class GoodsSpecModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

	public function count_spec($condition){
	    $count = $this->where($condition)->count();
        if($count === false){
            $this->_log->write_array($this->getLastSql(), '统计规格数量失败', self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $count;
    }
	public function create_spec($data,&$msg){
	    $where = array(
	        'type' => $data['type']
        );
        //规格最多允许5个
        $count = $this->count_spec($where);
        if($count>=5){
            $msg = '商品规格最多能创建5个';
            return false;
        }
        //判断规格值是否重名
        $find = $this->where($data)->select();
        if(count($find) > 0){
            $msg = '规格值重名';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建商品规格失败';
            $this->_log->write_array($this->getLastSql(), $msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }
    public function get_spec($condition,&$msg){
        $result = $this->where($condition)->order('type')->select();
        if($result === false){
            $msg = '查询商品规格失败 '; 
            $this->_log->write_array($this->getLastSql(), $msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;

    }
    public function del_spec($condition,&$msg){
        if(count($condition) < 1){
            $msg = '删除条件不能为空';
            return false;
        }
        $ret = $this->where($condition)->delete();
        if($ret === false){
            $msg = '删除商品规格失败 '; 
            $this->_log->write_array($this->getLastSql(), $msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }
    public function update_spec($condition,$data,&$msg){
        if(count($condition) < 1){
            $msg = '修改条件不能为空';
            return false;
        }
        $ret = $this->where($condition)->save($data);
        if($ret === false){
            $msg = '修改商品规格失败 '; 
            $this->_log->write_array($this->getLastSql(), $msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }
}