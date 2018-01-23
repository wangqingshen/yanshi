<?php
namespace Yanshi\Controller;
use Think\Controller;

class CouponController extends Controller {
    
    function index(){
        $member_id = I('member_id');
        $this->assign('member_id',$member_id);
        $this->display();
    }

}
