<?php
namespace Common\Model;
use Think\Log;
class CartModel extends CommonModel{
    private $_log;//日志对象
    private $_goods_sku_model;
    private $_goods_spu_model;


    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 7;

	protected function _before_write(&$data) {
		parent::_before_write($data);
        $this->_log = new Log();//声明日志对象
	}

	public function create_cart($data,&$msg){
        if(count($data) < 1){
            $msg = '没有传入购物车信息';
            return false;
        }
        $ret = $this->add($data);
        if($ret === false){
            $msg = '创建购物车信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return $ret;
    }

    public function get_cart_list_by_member($member_id,$sku_field='*', &$msg){
        if(empty($member_id)){
            $msg = 'member_id不能为空';
            return false;
        }
        $condition = array(
            'member_id' => $member_id
        );
        $res_sku = array();
        $cart_field = 'sku_id';
        $res_sku = $this->where($condition)->field($cart_field)->select();
        if($res_sku === false){
            $msg = '查找购物车信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }elseif(count($res_sku) < 1){
            return $res_sku;
        }

        $res_sku = array_column($res_sku,'sku_id');
        $condition['sku_id'] = array('in',$res_sku);
        $sku_list = array();
        $this->_goods_sku_model = D('GoodsSku');
        $sku_list = $this->_goods_sku_model->get_sku_condition($condition,$sku_field,$msg);
        if($sku_list === false){
            $msg = '查找sku信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        $this->_goods_spu_model = D('GoodsSpu');
        foreach ($sku_list as $key => $value){
            $res_spu = $this->_goods_spu_model->get_spu_by_id($value['spu_id'],$msg);
            if($res_spu === false){
                $msg = '查找spu信息失败';
                $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                unset($sku_list[$key]);
                continue;
            }
            $spec_arr = explode('|',$value['spec']);
            $sku_list[$key]['spec'] = $spec_arr[0].','.$spec_arr[1];
            $sku_list[$key]['goods_name'] = $res_spu['goods_name'];
            $sku_list[$key]['goods_img'] = set_img_path($res_spu['goods_img1']);
            $sku_list[$key]['goods_state'] = $res_spu['state'];
            $sku_list[$key]['delivery_time'] = unserialize($res_spu['delivery_time']);
        }
        return $sku_list;
	}

	public function del_cart_ids($condition,&$msg){
	    if(count($condition) < 1){
	        $msg = '没有查询条件';
	        return false;
        }
        $ret = $this->where($condition)->delete();
        if($ret === false){
            $msg = '清理购物车信息失败';
            $this->_log->write_array($this->getLastSql(),$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return false;
        }
        return true;
    }
}