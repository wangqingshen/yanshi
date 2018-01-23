<?php
/**
 * 功能描述：凌凯短信类
 * 日期: 2017/5/23
 * 创建人: risoli
 */
class LinkaiSns {
    private $_corp_id = 'CDJS002907';//账号
    private $_pwd = 'zm0513@';//密码
    private $_url = 'http://sdk2.028lk.com/sdk2/';//地址
    private $_params;//参数字符串
    private $_contents;//所有类型短信内容
    private $_content;//短信内容
    private $_sign = '';//签名
    private $_seccode;//随机四位数字验证码
    private $_cell;//扩展号
    private $_send_time;//定时发送时间
    private $_mobile;//用户手机号码
    private $_err_code;//获取错误码
    private $_cache_time = 600;//缓存周期，单位s

    public function __construct()
    {
        $this->_set_err_code();
        $this->_set_sms_content();
    }

    /**
     * 函数用途描述:设置错误码
     * @date:2017-5-23
     * @author:risoli
     */
    private function _set_err_code()
    {
        //对应api/config下的错误码信息
        $this->_err_code = array(
            '-1' => '10001',
            '-2' => '10002',
            '-3' => '10003',
            '-5' => '10004',
            '-6' => '10005',
            '-7' => '10006',
            '-8' => '10007',
            '-9' => '10008',
            '-10' => '10009',
            '-100' => '10010',
            '-102' => '10011',
            '-103' => '10012'
        );
    }

    /**
     * 函数用途描述:设置短信内容
     * @date:2017-5-23
     * @author:risoli
     */
    private function _set_sms_content(){
        $this->_contents = array(
            1 => '您的手机验证码是：'.$this->_seccode.'，请在5分钟内输入验证码'
        );
    }
    /**
     * 函数用途描述:组装参数信息
     * Author:risoli
     */
    private function _set_params()
    {
        $this->_params = 'CorpID='.$this->_corp_id.'&';
        $this->_params .= 'Pwd='.$this->_pwd.'&';
        $this->_params .= 'Mobile='.$this->_mobile.'&';
        $this->_params .= 'Content='.urlencode($this->_content).'&';
        $this->_params .= 'Cell='.$this->_cell.'&';
        $this->_params .= 'SendTime='.$this->_send_time;
    }

    /**
     * 函数用途描述:组装短信url
     * @date:2017-5-23
     * @author:risoli
     * @param $cmd
     * @return string
     */
    private function _send_sms($cmd)
    {
        $this->_url .= $cmd.'.aspx?'.$this->_params;
        return file_get_contents($this->_url);
    }

    /**
     * 函数用途描述:获取短信内容
     * @date:2017-5-23
     * @author:risoli
     * @param $type
     */
    private function _get_content($type){
        //根据请求类型，获取短信内容
        $this->_content =  $this->_contents[$type].$this->_sign;
        $this->_content = iconv("utf-8","gb2312",$this->_content);
    }

    /**
     * 函数用途描述:发送验证码
     * @date:2017-5-23
     * @author:risoli
     * @param $mobile
     * @param $sccode
     */
    public function send_seccode($mobile, $sccode){
        $this->_mobile = $mobile;
        $this->_seccode = $sccode;
        self::_set_sms_content();
        self::_get_content(1);
        self::_set_params();
        $ret = $this->_send_sms('BatchSend2');
        if($ret < 0 ){
            return $this->_err_code[$ret];
        }
        return true;
    }



}