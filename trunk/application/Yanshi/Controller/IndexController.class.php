<?php
namespace Yanshi\Controller;
use Think\Controller;
use Think\Log;

class IndexController extends Controller {
    private $_wechat_obj;
    private $_member_model;
    private $_order_model;

    private $_log;
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 10;

    public function _initialize() {
        Vendor('Wechat');
        $this->_wechat_obj = new \Wechat();
        $this->_member_model = D('Member');
        $this->_order_model = D('Order');

        $this->_log = new Log();
    }

    public function index(){
        $url = 'http://'.$_SERVER['SERVER_NAME'].'/wap.php/Index/wechat_auth';
        $this->_wechat_obj->get_wechat_code($url);
        exit;
    }
    /**
     * 微信鉴权
     */
    public function wechat_auth(){
        $wechat_code = I('code');
        $res_wechat = $this->_wechat_obj->get_wechat_info($wechat_code);
        $openid = $res_wechat['openid'];
        $access_token = $res_wechat['access_token'];
        //将openid放入session中
        session('wechat_openid',$openid);
        //判断用户openid是否存在
        $member_model = D('Member');
        $condition = array(
            'wechat_openid' => $openid
        );
        $count = $member_model->count_member($condition,$msg);
        //获取用户微信信息
        $wechat_member_info = $this->_wechat_obj->get_member_wechat_info($access_token,$openid);
        if($count == 0){
            $member_info = array(
                'nick_name' => bin2hex($wechat_member_info['nickname']),
                'openid' => $wechat_member_info['openid'],
                'avatar' => substr($wechat_member_info['headimgurl'],0,strlen($wechat_member_info['headimgurl'])-1)
            );
            //进入注册页面
            $this->assign('member_info',$member_info);
            $this->display('Register/index');
        }elseif ($count == 1){
            //进入项目首页
            $member_info = $this->_member_model->get_member_by_openid($wechat_member_info['openid']);
            $this->assign('member_id',$member_info['id']);
            $this->display('index');
        }
    }
    public function home(){
        $this->display('index');
    }
    public function exchange_voucher(){
        //判断openid是否在session中
        if(empty(session('wechat_openid'))){
            $this->redirect('Index/index',null,3,'需要登陆系统');
        }else{
            $vid = I('get.vid');
            //获取用户信息
            $wechat_openid = session('wechat_openid');
            $member_model = D('Member');
            $member_info = $member_model->get_member_by_openid($wechat_openid);
            if($member_info === false){
                $this->error('领取优惠券失败');
            }
            $member_id = $member_info['id'];
            //根据优惠券id获取优惠劵信息
            $voucher_model = D('Voucher');
            $voucher_condition = array(
                'id' => $vid
            );
            $voucher_info = $voucher_model->get_voucher_info($voucher_condition);
            if($voucher_info === false){
                $this->error('领取优惠券失败');
            }
            $voucher_bind_model = D('VoucherBind');
            //判断是否已经领用过当前优惠券
            $count_condition = array(
                'v_id' => $vid,
                'member_id' => $member_id
            );
            $count = $voucher_bind_model->count_voucher_bind($count_condition);
            if($count === false){
                $this->error('领取优惠券失败');
            }elseif ($count >= 1){
                $this->error('您已领取过此优惠券');
            }
            $insert_voucher_bind_data = array(
                'v_id' => $vid,
                'member_id' => $member_id,
                'voucher_name' => $voucher_info['voucher_name'],
                'voucher_price' => $voucher_info['voucher_price'],
                'type' => $voucher_info['type'],
                'bind_g_ids' => $voucher_info['bind_g_ids'],
                'start_time' => $voucher_info['start_time'],
                'end_time' => $voucher_info['end_time'],
                'bind_time' => time(),
                'state' => 1
            );
            $ret = $voucher_bind_model->create_voucher_bind($insert_voucher_bind_data);
            if($ret === false){
                $this->error('领取优惠券失败');
            }
            $this->success('领取成功');
            //跳转到优惠劵列表
            $this->redirect('Coupon/index',array('member_id'=>$member_id));
        }

    }

    public function wxpay(){
        $openid = I('openid');
        $order_amount = I('order_amount');
        $order_sn = I('order_sn');
        Vendor('Wxpay.WxPay#Api');
        Vendor('Wxpay.WxPay#JsApiPay');
        $input = new \WxPayUnifiedOrder();
        $input->SetBody('test商品简要描述');// 订单描述（需要根据自己的业务修改）
        $input->SetOut_trade_no($order_sn);// 订单号
        $input->SetTotal_fee($order_amount*100);// 支付单金额  以(分)为单位
        $input->SetTime_start(date("YmdHis"));//支付单生成时间
        $input->SetTime_expire(date("YmdHis", time() + 600));//支付单失效时间
        $input->SetNotify_url("http://www.yanshihealth.com/Index/notify");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid($openid);
        $wxpayapi = new \WxPayApi();
        $order = $wxpayapi->unifiedOrder($input);
        $tools = new \JsApiPay();
        $wechat_pay_parameters = $tools->GetJsApiParameters($order);
        $this->assign('wechat_pay_parameters',$wechat_pay_parameters);
        $this->assign('order_amount',$order_amount);
        $this->display();
    }

    public function notify(){
        $xml = file_get_contents('php://input');
        $xml_arr = xml2arr($xml);
        if($xml_arr['result_code'] !== 'SUCCESS'){
            $msg = '微信支付回调失败';
            $this->_log->write_array($xml_arr,$msg, 'ERR', __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,9);
            echo 'false';
        }else{

            $order_sn = $xml_arr['out_trade_no'];
            $pay_sn = $xml_arr['transaction_id'];

            // $order_sn = '2017073152515397';
            //获取订单信息
            $order_info = $this->_order_model->get_order_by_sn($order_sn,$msg);
            if($order_info === false){
                $this->_log->write_array($msg,'获取订单信息失败', 'ERR', __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,9);
                echo 'false';
                exit;
            }
            $order_type = $order_info['order_type'];
            if($order_type == 2 || $order_type == 3){
                //需要先判断拼团关联单据是否全部已支付
                $pin_order_sn = $order_info['pin_order_sn'];
                $pin_order_condition = array(
                    'pin_order_sn' => $pin_order_sn,
                    'order_sn' => array('NEQ',$order_sn),
                    'order_state' => 6
                );
                $pin_order_list = $this->_order_model->get_order_list_by_condition($pin_order_condition,$msg);
                if($pin_order_list === false){
                    $this->_log->write_array($msg,'没有获取到拼团相关订单', 'ERR', __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,9);
                    echo 'false';
                }
                //判断是否还有未付款的拼团单
                if(count($pin_order_list)>0){
                    $update_data = array(
                        'pay_sn' => $pay_sn,
                        'pay_time' => time(),
                        'order_state' => 7
                    );
                    $condition = array(
                        'order_sn' => $order_sn
                    );
                    $ret = $this->_order_model->update_order($condition,$update_data,$msg);
                    if($ret === false){
                        $this->_log->write_array($msg,'更新订单状态失败', 'ERR', __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,9);
                        echo false;exit;
                    }
                }else{
                    M()->startTrans();
                    //全部订单付款完成，step1更新自身订单状态
                    $update_data = array(
                        'pay_sn' => $pay_sn,
                        'pay_time' => time(),
                        'order_state' => 8
                    );
                    $condition = array(
                        'order_sn' => $order_sn
                    );
                    $ret = $this->_order_model->update_order($condition,$update_data,$msg);
                    if($ret === false){
                        M()->rollback();
                        $this->_log->write_array($msg,'更新订单状态失败', 'ERR', __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,9);
                        echo false;exit;
                    }
                    //step2 更新拼团相关单据的状态
                    $update_data = array(
                        'order_state' => 8
                    );
                    $pin_order_condition = array(
                        'pin_order_sn' => $pin_order_sn
                    );
                    $ret = $this->_order_model->update_order($pin_order_condition,$update_data,$msg);
                    if($ret === false){
                        M()->rollback();
                        $this->_log->write_array($msg,'更新所有拼团订单状态失败', 'ERR', __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,9);
                        echo false;exit;
                    }
                    M()->commit();
                }
            }elseif ($order_type == 1){
                $update_data = array(
                    'pay_sn' => $pay_sn,
                    'pay_time' => time(),
                    'order_state' => 2
                );
                $condition = array(
                    'order_sn' => $order_sn
                );
                $ret = $this->_order_model->update_order($condition,$update_data,$msg);
                if($ret === false){
                    $this->_log->write_array($xml_arr,'微信支付回调失败', 'ERR', __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,9);
                    echo false;exit;
                }
            }
            /* 如果不回复这个xml  微信会给我们发送三次xml */
            $su = '<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>';
            echo $su;exit;
        }
    }

}
