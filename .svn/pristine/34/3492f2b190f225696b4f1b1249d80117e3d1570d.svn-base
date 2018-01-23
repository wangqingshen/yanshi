<?php
function SendDataByCurl($url,$data=array(),&$errorCode){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);

//    curl_setopt($ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HEADER, false);
    curl_setopt($ch,CURLOPT_TIMEOUT,1000);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    $output = curl_exec($ch);
    $errorCode = curl_errno($ch);
    curl_close($ch);
    if(0 !== $errorCode) {
        return false;
    }
    return 	$output;
}

$appid = 100;
$nonce = rand(0, 9).rand(0, 9).rand(0, 9).rand(0, 9).rand(0, 9);
$timestamp = date("ymdHis");
$sid = $timestamp.$nonce;
$signature = sha1($timestamp.$nonce);
$signature = sha1($signature.$appid);

$data = array(
    /*修改送餐地址*/
    'edit_receive_address' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'edit_receive_address'
        ),
        'data' => array(
            'address_id' => 2,
            'r_name' => "测试商品",
            'r_mobile' => '18628062001',
            'd_id' => 2,
            'd_name' => '发生发大水发大水',
            't_id' => 10,
            't_name' => 'b1',
            'is_default' => 0
        )
    ),
    /*添加购物车信息*/
    'add_cart' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'add_cart'
        ),
        'data' => array(
            'member_id' => 9,
            'spu_id' => 45,
            'sku_spec' => '大份|1天'
        )
    ),
    /*获取购物车信息*/
    'get_cart_list' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_cart_list'
        ),
        'data' => array(
            'member_id' => 9
        )
    ),
    /*获取商品详情*/
    'get_goods_info' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_goods_info'
        ),
        'data' => array(
            'spu_id' => 46
        )
    ),
    /*根据配送地址获取配送信息*/
    'get_address' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_address'
        ),
        'data' => array(
            'member_id' => 9,
            'address_id' => 2
        )
    ),
    /*清理购物车信息*/
    'del_cart' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'del_cart'
        ),
        'data' => array(
            'member_id' => 9,
            'cart_ids' => array(1)
        )
    ),
    /*创建订单*/
    'create_goods_order' => array(
    'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'create_goods_order'
        ),
        'data' => array(
            'sku_ids' => array(7,3,9),
            'member_id' => 1
        )
    ),
    /*获取用户的优惠券*/
    'get_member_voucher' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_member_voucher'
        ),
        'data' => array(
            'member_id' => 9,
            'state' => 1
        )
    ),
    /*创建支付单*/
    'create_payment' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'create_payment'
        ),
        'data' => array(
            'member_id' => 13,
            'order_info' => array(
                'order_sn' => '2017072199571015',
                'order_type' => 1,
                'amount'  => 12.00
            ),
            'goods_info' => array(
                'sku_ids' => array(7,8),
                'delivery_time' => array(1,2)
            ),
            'voucher_info' => array(
                'v_id' => 7,
                'v_price' => 20
            ),
            'address_info' => array(
                'r_name' => '李想',
                'r_mobile' => '18628062001',
                'd_id' => 1,
                't_id' => 1,
                'address' => '西财a1'
            )
        )
    ),
    /*获取用户的优惠券*/
    'get_goods_sku_by_spec' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_goods_sku_by_spec'
        ),
        'data' => array(
            'spec' => '大份|1天',
            'spu_id' => 1
        )
    ),
    /*根据用户id获取用户地址信息*/
    'get_default_address' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_default_address'
        ),
        'data' => array(
            'member_id' => 9
        )
    ),
    /*根据订单状态获取用户订单列表*/
    'get_order_list' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_order_list'
        ),
        'data' => array(
            'member_id' => 1,
            'state' => 1,
            'page' => 1,
            'page_size' => 10
        )
    ),
    /*根据订单id获取订单信息*/
    'get_order_info' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_order_info'
        ),
        'data' => array(
            'order_id' => 3,
        )
    ),
    /*将临时订单状态变更为未付款状态*/
    'change_temp_order_state' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'change_temp_order_state'
        ),
        'data' => array(
            'order_sn' => '2017072448995051',
        )
    ),
    /*创建拼团单据*/
    'create_pin_goods_order' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'create_pin_goods_order'
        ),
        'data' => array(
            'sku_id' => 1,
            'member_mobiles' => array('18628062001'),
            'member_id' => 1,
            'order_type' => 2
        )
    ),
    /*根据订单id修改订单地址*/
    'change_order_address' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'change_order_address'
        ),
        'data' => array(
            'order_id' => 28,
            'r_name' => '李三',
            'r_mobile' => '18628062001',
            'd_id' => 1,
            't_id' => 2,
            'address' => '接口自测配餐地址'
        )
    ),
    /*更新拼团支付单信息*/
    'create_pin_payment' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'create_pin_payment'
        ),
        'data' => array(
            'order_info' => array(
                'order_sn' => '2017073152515353',
                'delivery_date' => '2017-07-23',
                'delivery_time' => array(1,2)
            ),
            'address_info' => array(
                'r_name' => '李三',
                'r_mobile' => '18628062001',
                'd_id' => 1,
                't_id' => 2,
                'address' => '接口自测配餐地址'
            )
        )
    ),
    /*获取可送餐时间段*/
    'get_time_area' => array(
        'header' => array(
            'signature' => $signature,
            'timestamp' => $timestamp,
            'nonce' => $nonce
        ),
        'cmd' => array(
            'name' => 'get_time_area'
        ),
        'data' => array( )
    ),
);

$data = json_encode($data['get_time_area']);
$url = 'http://local.yanshi.com/api.php';//本地
//$url = 'http://www.yanshihealth.com/api';//测试环境
var_dump(SendDataByCurl($url,$data, $errorCode));
?>

