<?php
namespace Common\Model;
use Think\Log;
class GoodsSkuModel extends CommonModel{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 6;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

	public function create_sku($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入sku商品信息';
            return false;
        }
        $ret = $this->addAll($data);
        if($ret === false){
            $msg = '创建sku商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }

    public function update_sku($condition,$update_data,&$msg){
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
            $msg = '更新sku商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

    public function del_sku($sku_id,&$msg){
        if(empty($sku_id)){
            $msg = '缺少skuid';
            return false;
        }
        $condition = array(
            'sku_id' => $sku_id
        );
        $ret = $this->where($condition)->delete();
        if($ret === false){
            $msg = '删除sku商品信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }

    public function get_price_area_by_spu($spu_id,&$msg){
        if(empty($spu_id)){
            $msg = '没有spu商品id';
            return false;
        }
        $condition = array(
            'spu_id' => $spu_id
        );
        $field = 'max(sku_price) as max_sku_price,min(sku_price) as min_sku_price,max(sku_2_price) as max_sku_2_price,min(sku_2_price) as min_sku_2_price,max(sku_4_price) as max_sku_4_price,min(sku_4_price) as min_sku_4_price';
        $result = $this->field($field)->where($condition)->find();
        if($result === false){
            $msg = '查找sku商品价格区域失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function get_sku_by_spu($spu_id,&$msg){
        if(empty($spu_id)){
            $msg = 'spu_id不能为空';
            return false;
        }
        $condition = array(
            'spu_id' => $spu_id
        );
        $result = $this->where($condition)->select();
        if($result === false){
            $msg = '查找sku商品失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

    public function get_sku_condition($condition,$field='*',&$msg){
        if(count($condition) < 1){
            $msg = '查询条件不能为空';
            return false;
        }
        $result = array();
        $result = $this->field($field)->where($condition)->select();
        if($result === false){
            $msg = '查找sku商品失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $result;
    }

}