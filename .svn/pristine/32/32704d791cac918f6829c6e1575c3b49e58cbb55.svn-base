<?php
/**
 * 功能描述：api入口文件，权限认证，api应用层
 * 日期: 2017/5/16
 * 创建人: risoli
 */

namespace Api\Controller;
use Think\Log;

class IndexController {
    private $_log;//日志对象
    private $_app_cfg;//应用id
    private $_err_code;//错误代码数组
    private $_interface_method;//api方法

    /*日志常量*/
    const INFO = 'INFO';  // 流水日志
    const ERR = 'ERR';  // 一般错误
    const LOG_FILE = 7;

    public function __construct(){
        $this->_log = new Log();//声明日志对象
        $this->_app_cfg = C('application_cfg');
        $this->_err_code = C('err_code');
        $this->_interface_method = C('interface_method');

    }

    /**
     * 函数用途描述:签名握手验证
     * @date:2017-5-16
     * @author:risoli
     * @param $json
     * @param $app
     * @return bool|int
     */
    private function _check_safety($json,&$app)
    {
        foreach ($this->_app_cfg as $app_cfg)
        {
            $nonce = $json['nonce'];
            $timestamp = $json['timestamp'];
            $signature = sha1($timestamp . $nonce);
            $signature = sha1($signature . $app_cfg);
            if ($signature == $json['signature'])
            {
                $app = $app_cfg;
                return true;
            }
        }
        return 1005;
    }

    /**
     * 函数用途描述:输出json字符串
     * @date:2017-05-17
     * @author:risoli
     * @param $result
     */
    private function _display_ok($result)
    {
        $json = array('errcode' => 1, 'errmsg' => 'succ', 'data' => $result);
        echo json_encode($json);exit;
    }

    /**
     * 函数用途描述:输出错误信息json
     * @date:2017-05-17
     * @author:risoli
     * @param $result
     */
    private function _display_error($result)
    {
        $this->_log->write_array($result, $result['errmsg'], self::ERR, __LINE__,self::LOG_FILE);
        echo json_encode($result);exit;
    }

    public function index(){
        //获取post json数据
        $json = $GLOBALS['HTTP_RAW_POST_DATA'] ? urldecode($GLOBALS['HTTP_RAW_POST_DATA']) : file_get_contents('php://input') ;
        // $json = mb_convert_encoding($json, 'utf-8', 'GBK,UTF-8,ASCII');
        $this->_log->write_array(array($json), '', self::INFO, __LINE__, self::LOG_FILE);
        $json = json_decode($json, true);
        //权限验证
        $app = null;
        $ret = $this->_check_safety($json['header'],$app);
        if ($ret !== true) {
            $result = array(
                'errcode' => $ret,
                'errmsg' => $this->_err_code[$ret]
            );
            $this->_display_error($result);
        }

        //接口验证
        $cmd = $json['cmd']['name'];
        if (!array_key_exists($cmd, $this->_interface_method))
        {
            $result = array(
                'errcode' => 1003,
                'errmsg' => $this->_err_code[1003],
                'data' => $json['cmd']
            );
            $this->_display_error($result);
        }

        //声明event
        $event_obj = D($this->_interface_method[$cmd],'Event');
        $result = array();
        $data = $json['data'];
        $ret = $event_obj->$cmd($data,$result);
        if ($ret !== true) {
            $result = array(
                'errcode' => $ret,
                'errmsg' => $this->_err_code[$ret],
                'data' => $result
            );
            $this->_display_error($result);
        }
        $this->_display_ok($result);
    }
}
