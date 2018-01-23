<?php

namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use Think\Log;

class VoucherController extends AdminbaseController{
    private $_log;//日志对象
    private $_voucher_model;

    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 7;

    public function _initialize() {
        parent::_initialize();
        $this->_log = new Log();//声明日志对象
        $this->_voucher_model = D('Voucher');
    }

    public function voucher_list(){
        //统计会员总数
        $count = $this->_voucher_model->count_voucher();
        //实例化分页类
        $size = 20;//默认20条
        $page = $this->Page($count,$size);
        $show = $page->show('Admin');
        //获取商品信息
        $field = "*, FROM_UNIXTIME(start_time,'%Y-%m-%d') as start_time,FROM_UNIXTIME(end_time,'%Y-%m-%d') as end_time";
        $order = 'id desc';
        $list = $this->_voucher_model->get_voucher_list_by_condition(null,$field,$page,$order,$msg);
        if($list == false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
        }
        $this->assign('voucher_list',$list);
        $this->assign('page_show',$show);
        $this->display();
    }

    public function bind_goods_list($vid){
        //获取绑定的商品id
        $condition = array(
            'id' => $vid
        );
        $voucher = $this->_voucher_model->get_voucher_info($condition);
        if($voucher === false){
            $this->error('获取代金券信息失败');
        }
        //查找商品信息
        $goods_spu_model = D('GoodsSpu');
        $g_ids = unserialize($voucher['bind_g_ids']);
        $condition['spu_id'] = array('in',$g_ids);
        $filed = 'goods_name,goods_img1';
        $list = $goods_spu_model->get_goods_list($condition,$filed,$msg);
        if($list == false){
            $this->error('获取代金券绑定商品失败');
        }
        foreach ($list as $key => $value){
            $list[$key]['goods_img1'] = set_img_path($value['goods_img1']);
        }

        $this->assign('goods_list',$list);
        $this->display();
    }

    public function add_voucher(){
        $this->display();
    }
    public function add_voucher_post(){
        $v_name = I('voucher_name');
        $v_type= I('voucher_type');
        $v_goods_ids = I('select_goods_ids');
        $v_price = I('voucher_price');
        $v_start_time = I('start_time');
        $v_end_time = I('end_time');

        $insert_data = array(
            'voucher_name' => $v_name,
            'type' => $v_type,
            'voucher_price' => $v_price,
            'start_time' => strtotime($v_start_time),
            'end_time' => strtotime($v_end_time)
        );
        if($v_type == 2){
            $insert_data['bind_g_ids'] = serialize($v_goods_ids);
        }
        $ret = $this->_voucher_model->create_voucher($insert_data);
        if($ret == false){
            $this->error('添加优惠券失败');
        }
        $this->success('添加优惠券成功',U('Voucher/voucher_list'));
    }
    public function get_voucher_qr_img(){
        $vid = I('vid');
        $url = 'http://'.$_SERVER['SERVER_NAME'];
        $url .= '/wap.php?s=/Index/exchange_voucher/vid/'.$vid;
        Vendor('phpqrcode.phpqrcode');
        $size = 4;
//        $file = C('UPLOADPATH').'/qrcode';
        \QRcode::png($url,false,'L',$size);

        echo 33;exit;
    }



}
