<?php

namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use Think\Log;

class MemberController extends AdminbaseController{
    private $_log;//日志对象
    private $_member_model;

    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 2;

    public function _initialize() {
        parent::_initialize();
        $this->_log = new Log();//声明日志对象
        $this->_member_model = D('Member');
    }

    public function member_list(){
        //统计会员总数
        $count = $this->_member_model->count_member();
        //实例化分页类
        $size = 20;//默认20条
        $page = $this->Page($count,$size);
        $show = $page->show('Admin');
        //获取商品信息
        $field = "*, FROM_UNIXTIME(reg_time,'%Y-%m-%d %H:%i:%S') as reg_time";
        $order = 'id desc';
        $list = $this->_member_model->get_member_list_by_condition(null,$field,$page,$order,$msg);
        if($list == false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
        }
        $this->assign('member_list',$list);
        $this->assign('page_show',$show);
        $this->display();
    }



}
