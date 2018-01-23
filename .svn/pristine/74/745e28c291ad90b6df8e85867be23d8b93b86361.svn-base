<?php

namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use Think\Log;

class OrderController extends AdminbaseController{
    private $_log;//日志对象
    private $_order_model;
    private $_order_goods_model;
    private $_delivery_info_model;
    private $_member_model;

    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 3;

    public function _initialize() {
//        parent::_initialize();
        $this->_log = new Log();//声明日志对象
        $this->_order_model = D('Order');
        $this->_order_goods_model = D('OrderGoods');
        $this->_delivery_info_model = D('DeliveryInfo');
        $this->_member_model =D('Member');
    }

    public function index(){
        $condition = array(
            'order_state' => array('in',array(1,2,3,4,5,6,7,8))
        );
        //统计会员总数
        $count = $this->_order_model->count_order($condition);
        //实例化分页类
        $size = 10;//默认20条
        $page = $this->Page($count,$size);
        $show = $page->show('Admin');
        $order_list = array();
        $order = "FIELD('order_state',2,8,3,4,7,1,6,5)";
        $order_list =$this->_order_model->get_order_list_by_condition($condition,'*',$page,$order,$msg);
        if($order_list === false){
            $this->error('获取订单列表失败');
        }
        $states = C('order_state');
        $d_times = C('delivery_time');
        foreach ($order_list as $key => $value){
            $order_list[$key]['state'] = $states[$value['order_state']];
            $order_list[$key]['create_time'] = date("Y-m-d H:i:s",$value['create_time']);
            $delivery_time = unserialize($value['delivery_time']);
            $time_area = unserialize($value['time_area']);
            $order_list[$key]['delivery_time'] = $d_times[$delivery_time[0]].':'.$time_area[0].'|'.$d_times[$delivery_time[1]];
            $order_list[$key]['delivery_date'] = date("Y-m-d",$value['delivery_date']);
            if($value['order_type'] == 1){
                $order_list[$key]['order_type_cn'] = '普通';
            }elseif ($value['order_type'] == 2){
                $order_list[$key]['order_type_cn'] = '两人拼团';
            }elseif ($value['order_type'] == 3){
                $order_list[$key]['order_type_cn'] = '四人拼团';
            }
        }
        $this->assign("page_show",$show);
        $this->assign('order_list',$order_list);
        $this->display('order_list');
    }

    public function change_order_state(){
        $order_id = I('order_id');
        $now_state = I('now_state');
        //根据当前状态获取下一阶段状态
        $order_info = array();
        $order_info = $this->_order_model->get_order_by_id($order_id,$msg);
        if($order_info === false){
            $this->error('获取订单信息失败');
        }
        $delivery_surplus_num = $order_info['delivery_surplus_num'];
        if($now_state == 4){
            //step1 判断剩余送餐次数是否为0
            if($delivery_surplus_num == 0){
                $change_state = 5;
            }else{
                $change_state = 3;
            }
        }else{
            if($now_state == 8){
                $change_state = 3;
            }else{
                $change_state = $now_state + 1;
            }
        }
        $order_state_arr = C('order_state');

        $this->assign('now_state_cn',$order_state_arr[$now_state]);
        $this->assign('change_state_cn',$order_state_arr[$change_state]);
        $this->assign('order_id',$order_id);
        $this->assign('change_state',$change_state);
        $this->assign('delivery_surplus_num',$delivery_surplus_num);

        $this->display();
    }

    public function change_order_state_post(){
        $order_id = I('order_id');
        $next_state = I('next_state');
        $delivery_people = I('delivery_people');
        $delivery_contact_mobile = I('delivery_contact_mobile');
        //更新订单状态
        $order_condition = array(
            'order_id' => $order_id
        );
        //获取订单信息
        $order_info = $this->_order_model->get_order_by_id($order_id,$msg);
        if($order_info === false){
            $result['errcode'] = 0;
            $this->ajaxReturn($result);
        }
        if($next_state == 3 && $order_info['delivery_surplus_num'] > 0){
            $order_update = array(
                'order_state' => $next_state,
                'delivery_surplus_num' => (int)$order_info['delivery_surplus_num']-1
            );
        }elseif($next_state == 4){
            //判断第二天是否周6
            $next_day = strtotime("+1 day");
            if(date('w',$next_day)==6){
                $next_day = strtotime("+2 day");
            }
            $order_update = array(
                'order_state' => $next_state,
                'delivery_date' => $next_day
            );
        }else{
            $order_finish_time = time();
            $order_update = array(
                'order_state' => $next_state,
                'finish_time' => $order_finish_time
            );
        }
        M()->startTrans();
        $ret = $this->_order_model->update_order($order_condition,$order_update,$msg);
        if($ret === false){
            M()->rollback();
            $result['errcode'] = 0;
            $this->ajaxReturn($result);
        }
        //获取用的openid
        $member_id = $order_info['member_id'];
        $member_info = $this->_member_model->get_member_by_id($member_id);
        if($member_info === false){
            M()->rollback();
            $result['errcode'] = 0;
            $this->ajaxReturn($result);
        }
        $openid = $member_info['wechat_openid'];
        if($next_state == 3) {
            //插入送餐信息
            $insert_delivery_data = array(
                'order_id' => $order_id,
                'delivery_time' => time(),
                'delivery_people' => $delivery_people,
                'delivery_contact_mobile' => $delivery_contact_mobile
            );
            $ret = $this->_delivery_info_model->create_delivery_info($insert_delivery_data);
            if ($ret === false) {
                M()->rollback();
                $result['errcode'] = 0;
                $this->ajaxReturn($result);
            }
            //向微信推送配送信息
            Vendor('Wechat');
            $wechat_obj = new \Wechat();
            $wechat_template = $this->_get_wechat_msg_template($next_state,$openid,$delivery_people,$delivery_contact_mobile);
            $res_wechat = $wechat_obj->push_msg_temple_wechat($wechat_template);
            $res_wechat = json_decode($res_wechat, true);
            if ($res_wechat['errcode'] > 0) {
                M()->rollback();
                $result['errcode'] = 0;
                $this->ajaxReturn($result);
            }
        }elseif ($next_state == 5){
            //向微信推送配送信息
            Vendor('Wechat');
            $wechat_obj = new \Wechat();
            $wechat_template = $this->_get_wechat_msg_template($next_state,$openid,null,null,$order_info['order_sn'],$order_info['order_amount'],$order_info['create_time'],$order_finish_time);
            $res_wechat = $wechat_obj->push_msg_temple_wechat($wechat_template);
            $res_wechat = json_decode($res_wechat, true);
            if ($res_wechat['errcode'] > 0) {
                M()->rollback();
                $result['errcode'] = 0;
                $this->ajaxReturn($result);
            }
        }
        M()->commit();
        $result['errcode'] = 1;
        $this->ajaxReturn($result);
    }

    private function _get_wechat_msg_template($state,$openid,$delivery_people,$delivery_contact_mobile,$order_sn,$order_amount,$order_create_time,$order_finish_time){
        $template = array(
            3 => array(
                'touser' => $openid,
                'template_id' => 'VtjOvKjrCpSEOHG9hg0Z427LmPIAWhc1mgtcP7irtEs',
                'url' => 'http://www.yanshihealth.com/wap.php',
                'data' => array(
                    'first' => array(
                        'value' => '订餐已开始配送'
                    ),
                    'keyword1' => array(
                        'value' => '亲爱的同学您好,您的配送员已经出发，餐将于您预留的默认时间地点送至，届时请直接领取'
                    ),
                    'keyword2' => array(
                        'value' => $delivery_people.'('.$delivery_contact_mobile.')'
                    ),
                    'remark' => array(
                        'value' => '如有疑问，请联系客服：028-67273707'
                    )
                )
            ),
            5 =>  array(
                'touser' => $openid,
                'template_id' => 'jTSEAOcEEbb_eLO1ypmprKwI2-M6YQaChrozymzizTI',
                'url' => 'http://www.yanshihealth.com/wap.php',
                'data' => array(
                    'first' => array(
                        'value' => '订餐配送已结束'
                    ),
                    'keyword1' => array(
                        'value' => $order_sn
                    ),
                    'keyword2' => array(
                        'value' => $order_amount
                    ),
                    'keyword3' => array(
                        'value' => date("Y-m-d H:i:s",$order_create_time)
                    ),
                    'keyword4' => array(
                        'value' => date("Y-m-d",$order_finish_time)
                    ),
                    'remark' => array(
                        'value' => '您的订单已经全部配送完毕，感谢您对我们的支持，欢迎继续续订！'
                    )
                )
            ),
        );
        return $template[$state];
    }

    public function order_info(){
        $order_id = I('order_id');
        //获取订单信息
        $order_info = $this->_order_model->get_order_by_id($order_id,$msg);
        if($order_info === false){
            $this->error('查找订单信息失败');
        }
        $order_info['create_time'] = date("Y-m-d H:i:s",$order_info['create_time']);
        $order_info['pay_time'] = date("Y-m-d H:i:s",$order_info['pay_time']);
        $order_info['order_state_cn'] = C('order_state')[$order_info['order_state']];
        $order_info['content'] = $order_info['order_content'];
        //获取订单商品信息
        $order_goods_list = $this->_order_goods_model->get_order_goods_list($order_info['order_sn']);
        if($order_goods_list === false){
            $this->error('获取订单商品信息失败');
        }
        foreach ($order_goods_list as $key => $value){
            $order_goods_list[$key]['goods_img'] = set_img_path($value['goods_img']);
            $order_goods_list[$key]['type'] = C('order_type')[$value['order_type']];
        }
        //获取配餐信息
        $delivery_list = $this->_delivery_info_model->get_delivery_list($order_id);
        if($delivery_list === false){
            $this->error('获取配餐信息失败');
        }
        foreach ($delivery_list as $key => $value){
            $delivery_list[$key]['delivery_time'] = date("Y-m-d H:i:s",$value['delivery_time']);
        }

        $this->assign('delivery_list',$delivery_list);
        $this->assign('order_goods_list',$order_goods_list);
        $this->assign('order_info',$order_info);
        $this->display();

    }

    public function batch_change_order_state(){
        $post_order_ids = I('order_ids');
        $order_ids =explode(',',$post_order_ids);
        $order_ids = array_filter($order_ids);
        //获取订单信息
        $order_condition = array(
            'order_id' => array('in',$order_ids)
        );
        $field = 'order_id,order_state,delivery_surplus_num';
        $order_list = $this->_order_model->get_order_list_by_condition($order_condition,$field);
        if($order_list === false){
            $this->error('获取订单信息失败');
            exit;
        }
        //判断是否同一状态
        $order_state = '';
        foreach ($order_list as $key => $value){
            if(empty($order_state)){
                $order_state = $value['order_state'];
            }else{
                if($value['order_state'] !== $order_state){
                    $this->error('只能变更同一状态下的订单');
                    exit;
                }
                if($value['delivery_surplus_num'] == 0){
                    $this->error('含有送餐次数为0的订单');
                    exit;
                }
                if($value['order_state'] == 7 || $value['order_state'] == 6){
                    $this->error('拼团等待中的订单不能翻遍状态');
                    exit;
                }
            }
        }
        if($order_state == 4){
            $change_state = 3;
        }else{
            if($order_state == 8){
                $change_state = 3;
            }else{
                $change_state = $order_state + 1;
            }
        }

        $order_state_arr = C('order_state');
        $this->assign('now_state_cn',$order_state_arr[$order_state]);
        $this->assign('change_state_cn',$order_state_arr[$change_state]);
        $this->assign('order_ids',$post_order_ids);
        $this->assign('change_state',$change_state);

        $this->display();
    }

    public function batch_change_order_state_post(){
        $post_order_ids = I('order_ids');
        $order_ids =explode(',',$post_order_ids);
        $order_ids = array_filter($order_ids);
        $next_state = I('next_state');
        $delivery_people = I('delivery_people');
        $delivery_contact_mobile = I('delivery_contact_mobile');
        if($next_state == 3){
            $order_update = array(
                'order_state' => $next_state,
                'delivery_surplus_num' => array('EXP','delivery_surplus_num-1')
            );
        }elseif($next_state == 4){
            //判断第二天是否周6
            $next_day = strtotime("+1 day");
            if(date('w',$next_day)==6){
                $next_day = strtotime("+2 day");
            }
            $order_update = array(
                'order_state' => $next_state,
                'delivery_date' => $next_day
            );
        }else{
            $order_finish_time = time();
            $order_update = array(
                'order_state' => $next_state,
                'finish_time' => $order_finish_time
            );
        }
        M()->startTrans();
        $order_condition = array(
            'order_id' => array('in',$order_ids)
        );
        $ret = $this->_order_model->update_order($order_condition,$order_update,$msg);
        if($ret === false){
            M()->rollback();
            $result['errcode'] = 0;
            $this->ajaxReturn($result);
        }
        //获取订单信息
        $order_list = $this->_order_model->get_order_list($order_condition,'*',null,0,count($order_ids));
        if($order_list === false){
            M()->rollback();
            $result['errcode'] = 0;
            $this->ajaxReturn($result);
        }
        foreach ($order_list as $key => $value) {        
            //获取用的openid
            $member_id = $value['member_id'];
            $member_info = $this->_member_model->get_member_by_id($member_id);
            if($member_info === false){
                M()->rollback();
                $result['errcode'] = 0;
                $this->ajaxReturn($result);
                exit;
            }
            $openid = $member_info['wechat_openid'];
            if($next_state == 3) {
                //插入送餐信息
                $insert_delivery_data = array(
                    'order_id' => $value['order_id'],
                    'delivery_time' => time(),
                    'delivery_people' => $delivery_people,
                    'delivery_contact_mobile' => $delivery_contact_mobile
                );
                $ret = $this->_delivery_info_model->create_delivery_info($insert_delivery_data);
                if ($ret === false) {
                    M()->rollback();
                    $result['errcode'] = 0;
                    $this->ajaxReturn($result);
                }
                //向微信推送配送信息
                Vendor('Wechat');
                $wechat_obj = new \Wechat();
                $wechat_template = $this->_get_wechat_msg_template($next_state,$openid,$delivery_people,$delivery_contact_mobile);
                $res_wechat = $wechat_obj->push_msg_temple_wechat($wechat_template);
                $res_wechat = json_decode($res_wechat, true);
                if ($res_wechat['errcode'] > 0) {
                    M()->rollback();
                    $result['errcode'] = 0;
                    $this->ajaxReturn($result);
                }
            }elseif ($next_state == 5){
                //向微信推送配送信息
                Vendor('Wechat');
                $wechat_obj = new \Wechat();
                $wechat_template = $this->_get_wechat_msg_template($next_state,$openid,null,null,$order_info['order_sn'],$order_info['order_amount'],$order_info['create_time'],$order_finish_time);
                $res_wechat = $wechat_obj->push_msg_temple_wechat($wechat_template);
                $res_wechat = json_decode($res_wechat, true);
                if ($res_wechat['errcode'] > 0) {
                    M()->rollback();
                    $result['errcode'] = 0;
                    $this->ajaxReturn($result);
                }
            }

        }
        M()->commit();
        $result['errcode'] = 1;
        $this->ajaxReturn($result);
    }

    public function export_today_order_excel(){
        $start_time = strtotime(date("Y-m-d 00:00:00"));
        $end_time = strtotime(date("Y-m-d 23:59:59"));
        $condition['delivery_date'] = array(
            array('EGT',$start_time), 
            array('ELT',$end_time)
        );
        $order_list = $this->_order_model->get_all_by_condition($condition,$msg);
        if($order_list === false){
            $this->error('查找订单信息失败');
        }

        //导出excel
        vendor('PHPExcel.PHPExcel');
        $excel = new \PHPExcel();
        $xls_name = date("Y-m-d").'.xls';//导出文件命名
        //判断是否ie
        if(strpos($_SERVER["HTTP_USER_AGENT"],'MSIE')!==false || strpos($_SERVER["HTTP_USER_AGENT"],'rv:11.0')){
            $xls_name = urlencode($xls_name);
        }

        $sheet = $excel->getActiveSheet();
        $sheet->setTitle("当日配送");
        $sheet->setCellValue('A1', '配餐人');
        $sheet->setCellValue('B1', '配送手机号');
        $sheet->setCellValue('C1', '订单编号');
        $sheet->setCellValue('D1', '中午送餐时间');
        $sheet->setCellValue('E1', '晚上送餐时间');
        $sheet->setCellValue('F1', '送餐地址');
        $i = 2;
        foreach ($order_list as $value){
            $sheet->setCellValue('A'.$i, $value['receive_name']);
            $sheet->setCellValue('B'.$i, "'".$value['receive_mobile']);
            $sheet->setCellValue('C'.$i, "'".$value['order_sn']);
            //处理timearea
            $time_area = unserialize($value['time_area']);
            $sheet->setCellValue('D'.$i, $time_area[0]);
            $sheet->setCellValue('E'.$i, $time_area[1]);
            $sheet->setCellValue('F'.$i, $value['receive_address']);
            $i++;
        }

        $objWriter = new \PHPExcel_Writer_Excel5($excel);
        ob_end_clean();//清除缓冲区,避免乱码
        header("Pragma: public");
        header("Expires: 0");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Content-Type: application/force-download");
        header("Content-Type: application/download");
        header("Content-Disposition: attachment;filename=$xls_name");
        header("Content-Transfer-Encoding: binary ");
        $objWriter->save('php://output');
        exit;//此结束符必须存在
    }

    public function export_today_amount(){
        //获取当天的推送信息
        $start_time = strtotime(date("Y-m-d 00:00:00"));
        $end_time = strtotime(date("Y-m-d 23:59:59"));
        $delivery_info_condition['delivery_time'] = array(
            array('EGT',$start_time),
            array('ELT',$end_time)
        );
        $delivery_info_list = $this->_delivery_info_model->get_all_by_condition($delivery_info_condition,$msg);
        if($delivery_info_condition === false){
            $this->error('获取配送信息失败');
            exit;
        }
        //导出excel
        vendor('PHPExcel.PHPExcel');
        $excel = new \PHPExcel();
        $xls_name = date("Y-m-d").'.xls';//导出文件命名
        //判断是否ie
        if(strpos($_SERVER["HTTP_USER_AGENT"],'MSIE')!==false || strpos($_SERVER["HTTP_USER_AGENT"],'rv:11.0')){
            $xls_name = urlencode($xls_name);
        }

        $sheet = $excel->getActiveSheet();
        $sheet->setTitle("当日配送");
        $sheet->setCellValue('A1', '配餐人');
        $sheet->setCellValue('B1', '配送手机号');
        $sheet->setCellValue('C1', '送餐时间');
        $sheet->setCellValue('D1', '订单号');
        $sheet->setCellValue('E1', '订单金额');
        $sheet->setCellValue('F1', '总配送次数');
        $sheet->setCellValue('G1', '今日配送金额');
        $i = 2;
        $today_amount = 0;
        foreach ($delivery_info_list as $key => $delivery_info){
            $sheet->setCellValue('A'.$i, $delivery_info['delivery_people']);
            $sheet->setCellValue('B'.$i, $delivery_info['delivery_contact_mobile']);
            $sheet->setCellValue('C'.$i, date("Y-m-d H:i:s",$delivery_info['delivery_time']));
            //获取订单信息
            $order_id = $delivery_info['order_id'];
            $order_info = $this->_order_model->get_order_by_id($order_id,$msg);
            $sheet->setCellValue('D'.$i, $order_info['order_sn']);
            $sheet->setCellValue('E'.$i, $order_info['order_amount']);
            $sheet->setCellValue('F'.$i, $order_info['delivery_num']);
            //计算当日配送金额
            $today_amount += ($order_info['order_amount']/$order_info['delivery_num']);
            $i++;
        }
        $sheet->setCellValue('G2',$today_amount);

        $objWriter = new \PHPExcel_Writer_Excel5($excel);
        ob_end_clean();//清除缓冲区,避免乱码
        header("Pragma: public");
        header("Expires: 0");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Content-Type: application/force-download");
        header("Content-Type: application/download");
        header("Content-Disposition: attachment;filename=$xls_name");
        header("Content-Transfer-Encoding: binary ");
        $objWriter->save('php://output');
        exit;//此结束符必须存在

    }


}
