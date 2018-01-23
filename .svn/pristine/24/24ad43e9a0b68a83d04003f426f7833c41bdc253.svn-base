<?php
namespace Common\Model;
use Think\Log;
class GoodsStatModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

    public function get_info_by_spu($spu_id,&$msg){
        if(empty($spu_id)){
            $msg = 'spuid不能为空';
            return false;
        }
        $condition = array(
            'spu_id' => $spu_id
        );
        $result = $this->where($condition)->find();
        if($result === false){
            $msg = '查找spu商品统计失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function insert_stat($data,&$msg){
        if(count($data) < 1){
            $msg = '没有创建信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建spu商品统计失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
    }

}