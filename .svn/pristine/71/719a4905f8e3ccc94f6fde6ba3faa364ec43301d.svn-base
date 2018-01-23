<?php
namespace Api\Event;

use Think\Cache\Driver\Memcached;
use Think\Log;

class OrderEvent
{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 5;

    private $_goods_spu_model;
    private $_goods_sku_model;
    private $_order_model;
    private $_order_goods_model;
    private $_member_model;


    public function __construct()
    {
        $this->_log = new Log();
        $this->_goods_spu_model = D('GoodsSpu');
        $this->_goods_sku_model = D('GoodsSku');
        $this->_order_model = D('Order');
        $this->_order_goods_model = D('OrderGoods');
        $this->_member_model = D('Member');
    }

    public function create_goods_order($data, &$result = null){
        $params = array('sku_ids','member_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //根据skuid获取商品信息
        $sku_ids = $data['sku_ids'];
        $sku_condition = array(
            'sku_id' => array('in',$sku_ids)
        );
        $sku_list = array();
        $field = 'sku_id,spu_id,sku_price,delivery_num,spec';
        $sku_list = $this->_goods_sku_model->get_sku_condition($sku_condition,$field,$msg);
        if($sku_list === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
                //获取优惠券
        $result['voucher_info'] = get_member_voucher_list($data['member_id'],$sku_ids);
        //获取spu、sku商品的信息
        $recommend_sku = array();
        foreach ($sku_list as $key => $sku_info){
            $spu_id = $sku_info['spu_id'];
            $sku_id = $sku_info['sku_id'];
            $spu_info = array();
            $spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
            if($spu_info === false){
                $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                return 104;
            }
            $result['goods_info'][$key]['spu_id'] = $spu_id;
            $result['goods_info'][$key]['sku_id'] = $sku_id;
            $result['goods_info'][$key]['goods_name'] = $spu_info['goods_name'];
            $result['goods_info'][$key]['goods_img'] = set_img_path($spu_info['goods_img1']);
            $result['goods_info'][$key]['goods_price'] = $sku_info['sku_price'];
            $result['goods_info'][$key]['goods_spec'] = $sku_info['spec'];
            $result['goods_info'][$key]['delivery_num'] = $sku_info['delivery_num'];
            //商品预定送餐时间
            $delivery_time = unserialize($spu_info['delivery_time']);
            //去重保存推荐商品sku_id;

            foreach (unserialize($spu_info['recommend_sku_ids']) as $value){
                if(!in_array($value,$recommend_sku)){
                    $recommend_sku[] = $value;
                }
            }
        }
        //查找推荐sku信息
            if(count($recommend_sku) > 0){
            $recommend_sku_condition = array(
                'sku_id' => array('in',$recommend_sku)
            );
            $recommend_sku_list = $this->_goods_sku_model->get_sku_condition($recommend_sku_condition,$field,$msg);
            if($recommend_sku_list === false){
                $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            }
            foreach ($recommend_sku_list as $key => $recommend_sku){
                $spu_id = $recommend_sku['spu_id'];
                $sku_id = $recommend_sku['sku_id'];
                $recommend_spu_info = array();
                $recommend_spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
                if($recommend_spu_info === false){
                    $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                    return 104;
                }
                $result['recommend_goods'][$key]['spu_id'] = $spu_id;
                $result['recommend_goods'][$key]['sku_id'] = $sku_id;
                $result['recommend_goods'][$key]['goods_name'] = $recommend_spu_info['goods_name'];
                $result['recommend_goods'][$key]['goods_img'] = set_img_path($recommend_spu_info['goods_img1']);
                $result['recommend_goods'][$key]['goods_price'] = $recommend_sku['sku_price'];
                $result['recommend_goods'][$key]['goods_spec'] = $recommend_sku['spec'];
                $result['recommend_goods'][$key]['delivery_num'] = $recommend_sku['delivery_num'];
            }
        }
        $result['delivery_time'] = $delivery_time;
        //生成订单主表信息
        $insert_order_data = array(
            'order_sn' => sp_get_order_sn(),
            'member_id' => $data['member_id'],
            'create_time'   => time(),
            'order_type' => 1,//单买
            'order_state'   => 0
        );
        $order_id = $this->_order_model->create_order($insert_order_data,$msg);
        if($order_id === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        $result['order_sn'] = $insert_order_data['order_sn'];
        return true;
    }

    public function create_payment($data, &$result = null){
        $params = array('member_id','order_info','goods_info','address_info');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //声明参数
        $member_id = $data['member_id'];
        $order_sn = $data['order_info']['order_sn'];
        $order_type = $data['order_info']['order_type'];
        $order_amount = (float)$data['order_info']['amount'];
        $delivery_date = strtotime($data['order_info']['delivery_date']);
        $order_content = $data['order_info']['order_content'];
        $delivery_time = serialize($data['goods_info']['delivery_time']);
        $time_area = serialize($data['goods_info']['time_area']);
        $voucher_price = $data['voucher_info']['v_price'];
        $sku_ids = $data['goods_info']['sku_ids'];
        $receive_name = $data['address_info']['r_name'];
        $receive_mobile = $data['address_info']['r_mobile'];
        $d_id = $data['address_info']['d_id'];
        $t_id = $data['address_info']['t_id'];
        $receive_address = $data['address_info']['address'];


        M()->startTrans();
        /*step1创建订单商品数据，并计算送餐总次数，更新订单表中的送餐总次数*/
        $flag = true;
        $insert_order_goods = array();
        $sku_price_arr = array() ;//定义一个sku商品价格数组，和前端价格进行验证
        $delivery_num = 0;//订单总送餐次数

        foreach ($sku_ids as $key => $sku_id){
            //获取sku信息
            $sku_condition = array(
                'sku_id' => $sku_id
            );
            $sku_info = array();
            $sku_info = $this->_goods_sku_model->get_sku_condition($sku_condition,'*',$msg);
            if($sku_info === false){
                $flag = false;
                break;
            }
            $spu_id = $sku_info[0]['spu_id'];
            //获取spu信息
            $spu_info = array();
            $spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
            if($spu_info === false){
                $flag = false;
                break;
            }
            //计算订单总送餐次数
            $delivery_num += $sku_info[0]['delivery_num'];
            //组装订单商品信息
            $insert_order_goods[$key]['order_sn'] = $order_sn;
            $insert_order_goods[$key]['sku_id'] = $sku_id;
            $insert_order_goods[$key]['spu_name'] = $spu_info['goods_name'];
            $insert_order_goods[$key]['sku_spec'] = $sku_info[0]['spec'];
            $insert_order_goods[$key]['goods_img'] =$spu_info['goods_img1'];
            $insert_order_goods[$key]['order_type'] = $order_type;
            switch ($order_type){
                case 1:
                    $insert_order_goods[$key]['goods_price'] = $sku_info[0]['sku_price'];
                    $sku_price_arr[$key] = $sku_info[0]['sku_price'];
                    break;
                case 2:
                    $insert_order_goods[$key]['goods_price'] = $sku_info[0]['sku_2_price'];
                    $sku_price_arr[$key] = $sku_info[0]['sku_price'];
                    break;
                case 3:
                    $insert_order_goods[$key]['goods_price'] = $sku_info[0]['sku_4_price'];
                    $sku_price_arr[$key] = $sku_info[0]['sku_price'];
                    break;
            }
        }
        if(!$flag){
            //sku获取失败则告知支付失败
            M()->rollback();
            return 10101;
        }
        //验证前端订单价格和后端订单价格是否一致
        $order_amount_sum = get_order_amount($sku_price_arr,$voucher_price);
        if($order_amount_sum !== $order_amount){
            M()->rollback();
            return 10102;
        }
        //插入订单商品表
        $ret = $this->_order_goods_model->create_order_goods_arr($insert_order_goods,$msg);
        if($ret === false){
            M()->rollback();
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 10101;
        }
        /*step1 end*/
        //先判断前端计算价格和后端计算价格是否一致

        /*step2更新order表信息*/
        $order_condition = array(
            'order_sn' => $order_sn
        );
        $order_update['receive_name'] = $receive_name;
        $order_update['receive_mobile'] = $receive_mobile;
        $order_update['d_id'] = $d_id;
        $order_update['t_id'] = $t_id;
        $order_update['receive_address'] = $receive_address;
        $order_update['order_amount'] = $order_amount;
        $order_update['delivery_time'] = $delivery_time;
        $order_update['time_area'] = $time_area;
        $order_update['delivery_num'] = $delivery_num;
        $order_update['delivery_surplus_num'] = $delivery_num;
        $order_update['delivery_date'] = $delivery_date;
        $order_update['order_content'] = $order_content;
        $order_update['order_state'] = 1;
        if(!empty($voucher_price)){
            $order_update['voucher_price'] = $voucher_price;
        }
        $ret = $this->_order_model->update_order($order_condition,$order_update,$msg);
        if($ret === false){
            M()->rollback();
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        /*step2 end*/
        //获取用户的openid
        $member_info = array();
        $member_info = $this->_member_model->get_member_by_id($member_id,$msg);
        if($member_info === false){
            M()->rollback();
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 10103;
        }
        $openid = $member_info['wechat_openid'];
        M()->commit();
        $result['openid'] = $openid;
        $result['order_amount'] = $order_amount;
        $result['order_sn'] = $order_sn;
        return true;
    }

    public function get_order_list($data, &$result = null){
        $params = array('state','member_id','page','page_size');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $member_id = $data['member_id'];
        $state = $data['state'];
        if($state == 3){
            $condition = array(
                'order_state' => array('in',array(3,4)),
                'member_id' => $member_id
            );    
        }elseif ($state == 1){
            $condition = array(
                'order_state' => array('in',array(1,6)),
                'member_id' => $member_id
            );
        }elseif($state == 2){
            $condition = array(
                'order_state' => array('in',array(2,7,8)),
                'member_id' => $member_id
            );    
        }elseif ($state == 4){
            $condition = array(
                'order_state' => array('in',array(5)),
                'member_id' => $member_id
            );
        }

        //计算偏移量
        $page = $data['page'];
        $page_size = $data['page_size'];
        $offset = ($page-1)*$page_size;
        $order_list = array();
        $order = 'create_time desc';
        $field = 'order_sn,order_id,delivery_time,delivery_num,delivery_surplus_num';
        $order_list = $this->_order_model->get_order_list($condition,$field,$order,$offset,$page_size);
        if($order_list === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        //获取订单的订单商品信息
        foreach ($order_list as $key => $order_info) {
            $result['order_info'][$key]['order_id'] = $order_info['order_id'];
            $result['order_info'][$key]['order_sn'] = $order_info['order_sn'];
            $result['order_info'][$key]['delivery_time'] = unserialize($order_info['delivery_time']);
            $result['order_info'][$key]['delivery_surplus_num'] = $order_info['delivery_surplus_num'];//剩余送餐次数
            $result['order_info'][$key]['delivery_num'] = $order_info['delivery_num'];//总送餐次数
            //获取订单商品信息
            $order_goods_list = array();
            $order_goods_list = $this->_order_goods_model->get_order_goods_list($order_info['order_sn'],$msg);
            if($order_goods_list === false){
                $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            }
            foreach ($order_goods_list as $k => $v) {
                $result['order_info'][$key]['order_goods'][$k]['goods_name'] = $v['spu_name'];
                $result['order_info'][$key]['order_goods'][$k]['goods_img'] = set_img_path($v['goods_img']);
                $result['order_info'][$key]['order_goods'][$k]['goods_spec'] = $v['sku_spec'];
                $result['order_info'][$key]['order_goods'][$k]['goods_price'] = $v['goods_price'];
            }
        }
        return true;
    }

    public function get_order_info($data, &$result = null){
        $params = array('order_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $order_id = $data['order_id'];
        //获取订单信息
        $order_info = array();
        $order_info = $this->_order_model->get_order_by_id($order_id,$msg);
        if($order_info === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        //获取用户openid
        $member_id = $order_info['member_id'];
        $member_condition = array(
            'id' => $member_id
        );
        $member_info = $this->_member_model->get_member_by_id($member_condition,$msg);
        if($member_info === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }        
        //订单收货地址
        $result['address']['r_name'] = $order_info['receive_name'];
        $result['address']['r_mobile'] = $order_info['receive_mobile'];
        $result['address']['address_info'] = $order_info['receive_address'];
        $result['address']['d_id'] = $order_info['d_id'];
        $result['address']['t_id'] = $order_info['t_id'];
        //订单信息
        $result['order_info']['openid'] = $member_info['wechat_openid'];
        $result['order_info']['create_time'] = date("Y-m-d H:i:s",$order_info['create_time']);
        $result['order_info']['order_sn'] = $order_info['order_sn'];
        if(!empty($order_info['voucher_price']) ){
            $result['order_info']['voucher_price'] = $order_info['voucher_price'];
        }
        $result['order_info']['delivery_num'] = $order_info['delivery_num'];
        $result['order_info']['delivery_surplus_num'] = $order_info['delivery_surplus_num'];
        $result['order_info']['delivery_time'] = unserialize($order_info['delivery_time']);
        $result['order_info']['time_area'] = unserialize($order_info['time_area']);
        $result['order_info']['delivery_date'] = date("Y-m-d",$order_info['delivery_date']);
        $result['order_info']['content'] = $order_info['order_content'];
        $result['order_info']['state'] = $order_info['order_state'];
        $result['order_info']['order_amount'] = $order_info['order_amount'];
        //订单商品信息
        $order_goods_list = array();
        $order_goods_list = $this->_order_goods_model->get_order_goods_list($order_info['order_sn'],$msg);
        if($order_goods_list === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        $result['order_goods'] = array();
        foreach ($order_goods_list as $key => $value){
            $result['order_goods'][$key]['goods_name'] = $value['spu_name'];
            $result['order_goods'][$key]['goods_img'] = set_img_path($value['goods_img']);
            $result['order_goods'][$key]['goods_price'] = $value['goods_price'];
            $result['order_goods'][$key]['goods_spec'] = $value['sku_spec'];
        }
        //获取拼团信息
        if($order_info['order_type'] == 2 || $order_info['order_type'] == 3){
            $pin_order_list = $this->_order_model->get_pin_order_list($order_info['pin_order_sn'],$msg);
            foreach ($pin_order_list as $key => $pin_info){
                $member_id = $pin_info['member_id'];
                //获取拼团用户手机号
                $member_info = $this->_member_model->get_member_by_id($member_id);
                $result['pin_info'][$key]['nick_name'] = $member_info['nick_name'];
                $result['pin_info'][$key]['member_mobile'] = $member_info['mobile'];
                $result['pin_info'][$key]['pin_price'] = $pin_info['pin_youhui'];
                $result['pin_info'][$key]['pin_state'] = $pin_info['order_state'];
            }

        }
        return true;
    }

    public function change_temp_order_state($data, &$result = null){
        $params = array('order_sn');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'order_sn' => $data['order_sn']
        );
        $update_data = array(
            'order_state' => 1
        );
        $ret = $this->_order_model->update_order($condition,$update_data,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        return true;
    }

    public function create_pin_goods_order($data, &$result = null){
        $params = array('sku_id','member_mobiles','member_id','order_type');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //根据用户手机号，查找拼团用户的id
        $member_ids = array();
        $member_ids[0] = $data['member_id'];
        $i = 1;
        foreach($data['member_mobiles'] as $mobile) {
            //查找用户信息
            $member_info = $this->_member_model->get_member_by_mobile($mobile,$msg);
            if($member_info === false){
                return 10104;
                break;
            }
            if(empty($member_info)){
                return 10106;
                break;
            }
            $member_ids[$i] = $member_info['id'];
            $i++;
        }
        //判断拼团用户是否重复
        if (count($member_ids) != count(array_unique($member_ids))) {   
            return 10107; 
        }         
        //根据skuid获取商品信息
        $sku_id = $data['sku_id'];
        $sku_condition = array(
            'sku_id' => $sku_id
        );
        $sku_list = array();
        $field = '*';
        $sku_list = $this->_goods_sku_model->get_sku_condition($sku_condition,$field,$msg);
        if($sku_list === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        //获取spu、sku商品的信息
        $recommend_sku = array();
        foreach ($sku_list as $key => $sku_info){
            $spu_id = $sku_info['spu_id'];
            $sku_id = $sku_info['sku_id'];
            $spu_info = array();
            $spu_info = $this->_goods_spu_model->get_spu_by_id($spu_id,$msg);
            if($spu_info === false){
                $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                return 104;
            }
            $result['goods_info'][$key]['spu_id'] = $spu_id;
            $result['goods_info'][$key]['sku_id'] = $sku_id;
            $result['goods_info'][$key]['goods_name'] = $spu_info['goods_name'];
            $result['goods_info'][$key]['goods_img'] = set_img_path($spu_info['goods_img1']);
            $result['goods_info'][$key]['goods_price'] = $sku_info['sku_price'];
            $result['goods_info'][$key]['goods_spec'] = $sku_info['spec'];
            $result['goods_info'][$key]['delivery_num'] = $sku_info['delivery_num'];
            //商品预定送餐时间
            $delivery_time = unserialize($spu_info['delivery_time']);
            //去重保存推荐商品sku_id;

            foreach (unserialize($spu_info['recommend_sku_ids']) as $value){
                if(!in_array($value,$recommend_sku)){
                    $recommend_sku[] = $value;
                }
            }
        }
        $result['delivery_time'] = $delivery_time;
        //生成订单主表信息
        M()->startTrans();
        $pin_order_sn = sp_get_order_sn();
        foreach ($member_ids as $key => $member_id) {
            $order_sn = sp_get_order_sn();
            if($member_id == $data['member_id']){
                $order_sn = $pin_order_sn;
            }else{
                $order_sn = sp_get_order_sn();
            }

            $insert_order_data = array(
                'order_sn' => $order_sn,
                'member_id' => $member_id,
                'create_time'   => time(),
                'pin_order_sn' => $pin_order_sn,
                'order_type' => $data['order_type'],//拼团
                'delivery_time' => $spu_info['delivery_time'],
                'order_state'   => 6
            );
            if($data['order_type'] == 2){
                $insert_order_data['pin_youhui'] = $sku_list[0]['sku_price']-$sku_list[0]['sku_2_price'];
                $insert_order_data['order_amount'] = $sku_list[0]['sku_2_price'];
            }elseif ($data['order_type'] == 4){
                $insert_order_data['pin_youhui'] = $sku_list[0]['sku_price']-$sku_list[0]['sku_4_price'];
                $insert_order_data['order_amount'] = $sku_list[0]['sku_4_price'];
            }
            $order_id = $this->_order_model->create_order($insert_order_data,$msg);
            if($order_id === false){
                M()->rollback();
                $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
                return 104;
                break;
            }
            //生成订单商品表信息
            $insert_order_goods_data[0] = array(
                'order_sn' => $order_sn,
                'sku_id' => $sku_list[0]['sku_id'],
                'spu_name' => $spu_info['goods_name'],
                'sku_spec' =>  $sku_list[0]['spec'],
                'goods_img' => $spu_info['goods_img1']
            );
            if($data['order_type'] == 2){
                $insert_order_goods_data[0]['goods_price'] = $sku_list[0]['sku_2_price'];
                $insert_order_goods_data[0]['order_type'] = 2;
            }elseif ($data['order_type'] == 3){
                $insert_order_goods_data[0]['goods_price'] = $sku_list[0]['sku_4_price'];
                $insert_order_goods_data[0]['order_type'] = 3;
            }
            $ret = $this->_order_goods_model->create_order_goods_arr($insert_order_goods_data);
            
        }
        M()->commit();
        $result['order_sn'] = $pin_order_sn;
        //获取拼团的订单信息
        $pin_order_list = $this->_order_model->get_pin_order_list($pin_order_sn,$msg);
        if($pin_order_list === false){
            M()->rollback();
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 10105;
        }
        //获取拼团信息
        $pin_member_condition = array(
            'id' => array('in',$member_ids)
        );
        $pin_member_list = $this->_member_model->get_member_list_by_condition($pin_member_condition,$msg);
        if($pin_member_list === false){
            return 10105;
        }
        if($data['order_type'] == 2){
            $pin_price = $sku_list[0]['sku_price']-$sku_list[0]['sku_2_price'];
        }elseif($data['order_type'] == 3){
            $pin_price = $sku_list[0]['sku_price']-$sku_list[0]['sku_4_price'];
        }
        foreach ($pin_member_list as $key => $value) {
            $result['pin_info'][$key]['mobile'] = $value['mobile'];
            $result['pin_info'][$key]['pin_price'] = $pin_price;
            $result['pin_info'][$key]['nick_name'] = $value['nick_name'];
            foreach ($pin_order_list as $pin_info){
                if($value['id'] == $pin_info['member_id']){
                    $result['pin_info'][$key]['pin_state'] = $pin_info['order_state'];
                }
            }
        }
        return true;
    }

    public function apply_delayed($data, &$result = null){
        $params = array('member_id','order_id','delay_time');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }

        $condition = array(
            'member_id' => $data['member_id'],
            'order_id' => $data['order_id']
        );
        $update = array(
            'delivery_date' => strtotime($data['delay_time'])
        );
        $ret = $this->_order_model->update_order($condition,$update);
        if($ret === false){
            return 104;
        }
        return true;
    }

    public function change_order_address($data, &$result = null){
        $params = array('order_id','r_name','r_mobile','d_id','t_id','address');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $condition = array(
            'order_id' => $data['order_id']
        );
        $update_data = array(
            'receive_name' => $data['r_name'],
            'receive_mobile' => $data['r_mobile'],
            'd_id' => $data['d_id'],
            't_id' => $data['t_id'],
            'receive_address' => $data['address'],
        );
        $ret = $this->_order_model->update_order($condition,$update_data,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        return true;
    }

    public function create_pin_payment($data, &$result = null){
        $params = array('order_info','address_info');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        M()->startTrans();
        $order_sn = $data['order_info']['order_sn'];
        $order_condition = array(
            'order_sn' => $order_sn,
            'order_type' => array('in',array(2,3))
        );
        //组装订单更新信息
        $order_update = array(
            'delivery_date' => strtotime($data['order_info']['delivery_date']),
            'delivery_time' => serialize($data['order_info']['delivery_time']),
            'time_area' => serialize($data['order_info']['time_area']),
            'order_content' => $data['order_info']['order_content'],
            'receive_name' => $data['address_info']['r_name'],
            'receive_mobile' => $data['address_info']['r_mobile'],
            'd_id' => $data['address_info']['d_id'],
            't_id' => $data['address_info']['t_id'],
            'receive_address' => $data['address_info']['address']
        );
        $ret = $this->_order_model->update_order($order_condition,$order_update,$msg);
        if($ret === false){
            M()->rollback();
            $this->_log->write_array($order_update,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 10101;
        }
        //获取订单信息
        $order_info = $this->_order_model->get_order_by_sn($order_sn,$msg);
        $order_amount = $order_info['order_amount'];
        //获取用户openid
        $member_id = $order_info['member_id'];
        $member_info = $this->_member_model->get_member_by_id($member_id,$msg);
        if($member_info === false){
            M()->rollback();
            $this->_log->write_array($order_update,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 10108;
        }
        M()->commit();
        $openid = $member_info['wechat_openid'];

        $result['openid'] = $openid;
        $result['order_amount'] = $order_amount;
        $result['order_sn'] = $order_sn;
        return true;
    }

    public function get_time_area($data, &$result = null){
        $result['time_area'] = C('time_area');
        return true;
    }

}