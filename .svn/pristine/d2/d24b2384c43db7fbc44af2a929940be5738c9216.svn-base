<?php
namespace Api\Event;

use Think\Log;

class MemberEvent
{
    private $_log;//日志对象
    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 5;

    private $_member_model;

    public function __construct()
    {
        $this->_member_model = D('Member');
        $this->_log = new Log();
    }

    public function send_seccode($data, &$result = null){
        $params = array('mobile');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $mobile = $data['mobile'];
        $seccode = rand(0,9).rand(0,9).rand(0,9).rand(0,9).rand(0,9).rand(0,9);//生成6位数字验证码
        vendor('LinkaiSns');
        $linkai_obj = new \LinkaiSns();
        $ret = $linkai_obj->send_seccode($mobile,$seccode);
        if($ret !== true){
            return $ret;
        }
        //发送成功后，计入缓存
        S($mobile.'reg',$seccode,300);
        return true;
    }

    public function reg_check($data, &$result = null){
        $params = array('mobile','seccode');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $mobile = $data['mobile'];
        $mem_seccode = S($mobile.'reg');
        if(empty($mem_seccode)){
            return 10014;
        }elseif($mem_seccode != $data['seccode']){
            return 10013;
        }
        return true;
    }

    public function reg_member($data, &$result = null)
    {
        $params = array('mobile','openid','nick_name','question');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        //解析question
        $question = $data['question'];
        $nick_name = hex2bin($data['nick_name']);
        $insert_data = array(
            'mobile' => $data['mobile'],
            'wechat_openid' =>$data['openid'],
            'nick_name' => $nick_name,
            'sex' => $question['q3'],
            'reg_time' => time(),
            'avatar' => $data['avatar']
        );
        M()->startTrans();
        //创建会员
        $member_id = $this->_member_model->create_member($insert_data,$msg);
        if($member_id === false){
            $this->_log->write_array($insert_data,'创建会员失败', self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            M()->rollback();
            return 104;
        }
        //插入调查问卷
        $question_model = D('Questionnaire');
        $insert_q_data = array(
            'member_id' => $member_id,
            'q1' => $question['q1'],
            'q2' => $question['q2'],
            'q3' => $question['q3'],
            'q4' => $question['q4'],
        );
        $ret = $question_model->create_question($insert_q_data);
        if($ret === false){
            $this->_log->write_array($insert_q_data,'创建问卷信息失败', self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            M()->rollback();
            return 104;
        }
        M()->commit();

        $result = array(
            'member_id' => $member_id
        );
        return true;
    }

    public function get_member($data, &$result = null){
        $params = array('member_id');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $member_id = $data['member_id'];
        $member_info = $this->_member_model->get_member_by_id($member_id,$msg);
        if($member_info === false){
            return 104;
        }
        $result['nick_name'] = $member_info['nick_name'];
        $result['sex'] = $member_info['sex'];
        $result['avatar'] = $member_info['avatar'];
        return true;
    }

    public function change_member_sex($data, &$result = null){
        $params = array('member_id','sex');
        $ret = check_must_params($data, $params);
        if ($ret !== true) {
            return $ret;
        }
        $member_id = $data['member_id'];
        $update_date = array(
            'sex' => $data['sex']
        );
        $ret = $this->_member_model->update_member_info($member_id,$update_date,$msg);
        if($ret === false){
            $this->_log->write_array(null,$msg, self::ERR, __CLASS__.'\\'.__FUNCTION__.'\\'.__LINE__,self::LOG_FILE);
            return 104;
        }
        return true;

    }



}