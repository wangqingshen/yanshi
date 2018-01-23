<?php

class Wechat{
    private $_app_id;
    private $_app_secret;
    private $_wechat_open_url;
    private $_wechat_api_url;
    private $_redirect_url;

    public function __construct()
    {
        $this->_app_id = 'wx6cbe2d9fa1dc1274';
        $this->_app_secret = 'bc47e8d2869e8d6f997c1939dbbdb810';
        $this->_wechat_open_url = 'https://open.weixin.qq.com/';
        $this->_wechat_api_url = 'https://api.weixin.qq.com/';
    }

    private function _send_post_data($url,$data)
    {
        //初始化curl
        $ch = curl_init();
        //设置超时
        curl_setopt($ch, CURLOPT_TIMEOUT, 6);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER,FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,FALSE);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
//        if(WxPayConfig::CURL_PROXY_HOST != "0.0.0.0"
//            && WxPayConfig::CURL_PROXY_PORT != 0){
//            curl_setopt($ch,CURLOPT_PROXY, WxPayConfig::CURL_PROXY_HOST);
//            curl_setopt($ch,CURLOPT_PROXYPORT, WxPayConfig::CURL_PROXY_PORT);
//        }
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        //运行curl，结果以jason形式返回
        $res = curl_exec($ch);
        curl_close($ch);
        return $res;
    }


    /*
     * 用户授权
     * @return string
     */
    private function _set_auth_open_url($redirect_uri){
        return $this->_wechat_open_url .'connect/oauth2/authorize?appid='.$this->_app_id.'&redirect_uri='.urlencode($redirect_uri).'&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect';
    }
    /*
     * 获取网页授权access_token
     * @return string
     */
    private function _set_base_access_token_url(){
        return $this->_wechat_api_url."cgi-bin/token?grant_type=client_credential&appid=".$this->_app_id."&secret=".$this->_app_secret;
    }
    /*
     * 获取网页授权access_token
     * @return string
     */
    private function _set_access_token_url($code){
        return $this->_wechat_api_url . 'sns/oauth2/access_token?appid='.$this->_app_id.'&secret='.$this->_app_secret.'&code='.$code.'&grant_type=authorization_code';
    }
    /*
     *组装调用用户信息的url
     */
    private function _set_get_user_info_url($access_token,$openid){
        return $this->_wechat_api_url . 'sns/userinfo?access_token='.$access_token.'&openid='.$openid.'&lang=zh_CN';
    }

    private function _set_base_access_token(){     
        S('access_token',null);
        $access_token = S('access_token');
        if(empty($access_token)){
            //获取基础token
            $access_token = file_get_contents($this->_set_base_access_token_url());
            $access_token = json_decode($access_token,true);
            S('access_token',$access_token['access_token'],$access_token['expires_in']);
            $access_token = $access_token['access_token'];
        }
        return $access_token;

    }


    public function get_wechat_code($redirect_uri){
        header("Location:".$this->_set_auth_open_url($redirect_uri));
        exit;
    }
    public function get_wechat_info($code){
        $json = file_get_contents($this->_set_access_token_url($code));
        $json = json_decode($json,true);
        //需要将获取的token放入缓存
        $access_token = $json['access_token'];
        S('access_token',$access_token,7200);
        $expires_in = $json['expires_in'];
        //若token失效，需要刷新token
        $refresh_token = $json['refresh_token'];

        return $json;
    }
    /*
    *获取用户信息
     */
    public function get_member_wechat_info($access_token,$openid){
        $json = file_get_contents($this->_set_get_user_info_url($access_token,$openid));
        $json = json_decode($json,true);
        return $json;
    }


    //推送模板信息
    public function push_msg_temple_wechat($post_data){
        $access_token = $this->_set_base_access_token();
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=".$access_token;        
        $post_data = urldecode(json_encode($post_data));

        $out_put = $this->_send_post_data($url,$post_data);
        return $out_put;
    }



}