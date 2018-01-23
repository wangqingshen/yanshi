/**
 * yanshi common.js
 * @author wxy
 * @date 2017.07.13
 */

// var apiUrl = 'http://local.yanshi.com/api.php';
// var apiUrl = 'http://www.manyouku.com/api.php';
var apiUrl = '../../../api.php';

var wechat = 100;

/**
 * ajax公共方法
 * @author wxy
 * @private
 */
function ajaxFun(info, beforeFun, successFun, completeFun, errorFun) {
	$.ajax({
		type: 'POST',
		url: apiUrl,
		data: JSON.stringify(info),
		dataType: 'json',
		contentType: "application/json; charset=utf-8",
	 	beforeSend: beforeFune,
    	success: successFun,
    	complete: completeFun,
    	error: errorFun
    })
}

// 浮点数加法
function accAdd(arg1, arg2) {
    var r1, r2, m, c, n;
    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
    c = Math.abs(r1 - r2);
    m = Math.pow(10, Math.max(r1, r2))
    if (c > 0) {
        var cm = Math.pow(10, c);
        if (r1 > r2) {
            arg1 = Number(arg1.toString().replace(".", ""));
            arg2 = Number(arg2.toString().replace(".", "")) * cm;
        } else {
            arg1 = Number(arg1.toString().replace(".", "")) * cm;
            arg2 = Number(arg2.toString().replace(".", ""));
        }
    } else {
        arg1 = Number(arg1.toString().replace(".", ""));
        arg2 = Number(arg2.toString().replace(".", ""));
    }	
    	n=(r1>=r2)?r1:r2;
        return ((arg1 + arg2) / m).toFixed(n);
}

// 浮点数减法
function accSub(arg1,arg2){
　　 var r1,r2,m,n;
　　 try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
　　 try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
　　 m=Math.pow(10,Math.max(r1,r2));
　　 //last modify by deeka
　　 //动态控制精度长度
　　 n=(r1>=r2)?r1:r2;
　　 return ((arg1*m-arg2*m)/m).toFixed(n);
}

// 动态创建loading dom
function createLoadDom(id) {
	var d = $('<div />').addClass('load-wrapper loading-'+id),
		l = $('<img />').attr('src', localStorage.localStorage_url+'loading.gif'),
		s = $('<span />').text('加载中');
	d.append(l,s);
	return d;
}

// 动态创建遮罩层
function createDialog() {
	var d = $('<div />').addClass('zhezhao'),
		l = $('<img />').attr('src', localStorage.localStorage_url+'loading.gif');
	d.append(l);
	return d;
}

/**
 * 正则匹配手机号码
 * @author wxy
 * @private
 */
function checkMobileNo(str) {
	var re =/^1[3|7|5|8]\d{9}$/;
	if(re.test(str)) return true;
	else return false;
}

// 清除内容
function clearEvt(m, n) {
	m.bind('click', function(){
		if(n.val()) {
			n.val('');
		}
	});
}

/**
 * 检测输入的数值是否为数字
 * @param {mixed} [n] 被检测的对象
 * @return {Boolean} ture|false
 * @author wxy
 */
function checkIsNumber(n){
	var reg = new RegExp("^[0-9]*[1-9][0-9]*$"),//正则正整数
		reg1 = new RegExp("^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$");//正则正浮点数
	if (reg.test(n)||reg1.test(n)) {
		return true;
	} else {
		return false;
	}
}

// 点击全选（或反选）
// function checkAll(d, s) {
// 	d.click(function(){   
// 	    if(this.checked){   
// 	        s.prop("checked", true);  
// 	    }else{   
// 			s.prop("checked", false);
// 	    }   
// 	});
// }

/**
 * 获取当前时间格式为ymdhis的时间字符串
 * @return {String} ymdhis
 * @author wxy
 */

function getCurTime() {
	var date = new Date(),
		y = date.getFullYear().toString().substr(2),
		m = (date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1).toString(),
		d = date.getDate() < 10 ? '0' + date.getDate() : date.getDate().toString(),
		h = date.getHours() % 12 < 10 ? '0' + date.getHours() % 12 : (date.getHours() % 12).toString(),
		i = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes().toString(),
		s = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds().toString();
	return (y + m + d + h + i + s);
}

function getCurDate() {
	var date = new Date(),
		y = date.getFullYear().toString().substr(2),
		m = (date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1).toString(),
		d = date.getDate() < 10 ? '0' + date.getDate() : date.getDate().toString();
	return (y+m+d);
}

// 获取url后面的参数
function getParams(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
   	var r = window.location.search.substr(1).match(reg);
   	if (r != null) return unescape(r[2]); return null;
}

/**
 * 随机生成一个n位的随机数
 * @param [Int] [n] 一个正整数
 * @return {String} [str] 生成的随机数
 * @author wxy
 * @private
 */

function getRandStr(n) {
	var str = '';
	for (var i = 0; i < n; i++) {
		str += Math.floor(Math.random() * 10).toString();
	}
	return str;
}

// 跳转页面
function gotoLocation(url, str) {
	window.location.href = url + str;
}

/**
 * 自动组合api接口所需的信息
 * @param {String} [apiName] api接口的方法名
 * @param {Object} [data] 传给api的data对象
 * @return {Object} [info] 组合以后的info对象
 * @author wxy
 * @private
 */

function mergeInfo(apiName, data) {
	var appId = wechat,
		randStr = getRandStr(5),
		date = getCurTime(),
		// timestamp = new Date().getTime(),
		signature = hex_sha1(hex_sha1(date + randStr) + appId),
		info = {
			"header": {
				"timestamp": date,
				"nonce": randStr,
				"signature": signature
			},
			"cmd": {
				"name": apiName
			},
			"data": data
		};
	return info;
}


// Home Page
var Index = (function($) {
	var detail_url = $('input[type="hidden"].detail-url').val();
	var module = {
		type:  {
			'1': '健身餐',
			'2': '健康餐',
			'3': '沙拉',
			'4': '饮品',
			'5': '零食'
		},

		/**
		 * YS HOME PAGE INIT 
		 * @author wxy
		 * @public
		 */
		init: function() {
			var member_id = $('input[name="member_id"]').val();
			if(member_id) {
				window.localStorage.setItem('member_id', member_id);
			}
			window.localStorage.setItem('localStorage_url', $('.localStorage-url').val());
			for(var i in module.type) {
				module.getGoodsInfo(i);
			}
			module.pullRefresh();
		},

		// 下拉刷新列表
		pullRefresh: function(){
			var pullRefresh = new auiPullToRefresh({
	            container: document.querySelector('.aui-refresh-content'),
	            triggerDistance: 100
	        },function(ret){
	            if(ret.status=="success"){
	                setTimeout(function(){
	                    for(var i in module.type) {
		            		var _c = $('.ys-home-index .ys-goods-list>.aui-content').eq(i-1).children('.aui-card-list')
							_c.children('.ys-list-content').children().remove();
							_c.find('.ys-list-content-padded>.aui-row').children().remove();
							module.getGoodsInfo(i);
						}
						pullRefresh.cancelLoading(); //刷新成功后调用此方法隐藏
	                },1500)
	            }
	        })
		},

		// 为copy生成的dom赋值
		setCopyInfo: function(d, c) {
			d.find('.ys-copy-img').attr({'src':c.goods_img, 'data-id': c.spu_id});
			d.find('.ys-copy-title').attr('data-id', c.spu_id).text(c.goods_name);
			d.find('.ys-copy-price').text(parseInt(c.goods_price));
			c.count > 0 ? d.find('.ys-copy-count').text(c.count) : d.find('.ys-copy-count').text('0');
			if(c.recommend_price_area == '' || c.recommend_price_area == 0 || c.recommend_price_area == undefined) {
				d.find('.ys-list-item-right').remove();
			} else {
				var str = module.changePriceArea(c.recommend_price_area);
				d.find('.ys-copy-price-area').text(str);
			}
			return d;
		},

		// 截取团购价区间中的整数部分
		changePriceArea: function(p) {
			var arr = p.split('-');
			var arr1 = [];
			for(var i in arr) {
				arr1.push(parseInt(arr[i]));
			}
			return arr1.join('-');
		},

		// 跳转点击事件
		jumpEvt: function(c) {
			c.find('.ys-copy-img, .ys-copy-title').click(function(){
				var spu_id = $(this).attr('data-id');
				gotoLocation(detail_url, '&id='+spu_id);
			})
		},

		/**
		 * Home page get goods list
		 * @author wxy
		 * @public
		 */
		getGoodsInfo: function(id) {
			var data = {'class_type': id},
				info = mergeInfo('goods_class_info', data);
			var _c = $('.ys-home-index .ys-goods-list>.aui-content').eq(id-1).children('.aui-card-list');
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
			 	beforeSend: function() {
					var load = createLoadDom(id);
					_c.children('.ys-list-content').append(load);
			 	},
		    	success: function(data) {
		    		$('.loading-'+id).remove();
		    		var code = data.errcode;
		    		if(code == 1) {
		    			var list = data.data.list;
		    			if(list.length) {
		    				for(var i in list) {
		    					var _copy, _y;
		    					if(list[i].recommend == 2) {
		    						_copy = $('.copy-recommend').clone(true);
		    						_y = _c.children('.ys-list-content');

		    					}else if(list[i].recommend == 1) {
		    						_copy = $('.copy-item').clone(true);
		    						_y = _c.find('.ys-list-content-padded>.aui-row');
		    					}
		    					var _d = module.setCopyInfo(_copy, list[i]);
		    					_y.append(_d.html());
		    				}
		    				module.jumpEvt(_c);
		    			} else {
		    				var _empty = $('<img src="'+localStorage.localStorage_url+'img_empty.png" />').addClass('empty-img');
		    				var _text = $('<div />').addClass('empty-text').text('暂无商品');
		    				_c.children('.ys-list-content').append(_empty, _text);
		    			}
		    		} else {
		    			alert(data.errmsg);
		    		}
		    	},
		    	complete: function() {
		    		// console.log('complete');
		    	},
		    	error: function (data) {
		    		$('.loading-'+id).remove();
		    		// console.log('error:' + data);
		    		alert('获取商品列表失败，请刷新重试');
		    	}
		    })
		}
	};

	return {
		init: module.init
	};

}(jQuery));

// detail page
var GoodsDetail = (function($){
	var dialog = new auiDialog();
	var sku = [];
	var order_type; //拼团标识
	var addToCartUrl = $('input[name="addToCartUrl"]').val(); //跳转到购车列表地址
	var reserveUrl = $('input[name="reserveUrl"]').val(); //跳转到预订页面地址
	var module ={
		init: function() {
			module.getGoodsDetail();
			module.goToCar();
			module.addToCart();
			module.openSpellDialog();
			module.reserveEvt();
		},

		// 跳转至购物车事件
		goToCar: function() {
			$('.goto-car').click(function(){
				gotoLocation(addToCartUrl, '');	
			})
		},

		// 添加到购物车
		addToCart: function() {
			$('.addToCart').bind('click', function(){
				var spu_id = getParams('id');
				var sku_id = module.getSkuId('|');
				if(!sku_id) {
					alert('你还未给商品选择规格哟');
					return false;
				}
				var data = {'spu_id': spu_id, 'member_id': localStorage.member_id, 'sku_spec': sku_id},
					info = mergeInfo('add_cart', data);
				$.ajax({
					type: 'POST',
					url: apiUrl,
					data: JSON.stringify(info),
					dataType: 'json',
					contentType: "application/json; charset=utf-8",
					beforeSend: function() {
						var mark = createDialog();
						$('.ys-product-detail').append(mark);
					},
					success: function(data) {
						$('.zhezhao').remove();
						if(data.errcode == 1) {
							gotoLocation(addToCartUrl, '');
						}else{
							alert(data.errmsg);
						}
					},
					error: function(data) {
						$('.zhezhao').remove();
						alert('网络错误，请刷新重试');
					}
				});
			});
		},

		// 获取sku组成，以|分隔
		getSkuId: function(s) {
			var skuId = '';
			if($('.portion-type>div').hasClass('ys-type-selected') && $('.cycle-type>div').hasClass('ys-type-selected')) {
				skuId += $('.portion-type .ys-type-selected .ys-type-select').text();
				skuId += s;
				skuId += $('.cycle-type .ys-type-selected .ys-type-select').text();
			}
			return skuId;
		},

		// 分量周期选择事件
		specSelectEvt: function(d) {
			d.click(function(){
				if($(this).parent().hasClass('ys-type-selected')) {
					return;
				}else{
					d.parent().removeClass('ys-type-selected');
					$(this).parent().addClass('ys-type-selected');
					var skuId = module.getSkuId('|');
					if(skuId) {
						$('.ys-goods-price').text(sku[skuId].goods_price);
						$('.ys-goods-price').next('em').remove();
					}
				}
				
			});
		},

		// 关闭dialog
		closeSpellDialog: function() {
			$('.dialog-exit').click(function(){
				$('.aui-mask').removeClass('aui-mask-in');
				$('.aui-dialog').remove();
			});
		},

		// 拼团电话检查
		checkPtInfo: function() {
			var num = $('.aui-dialog-body .dialog-tab>.aui-active').attr('data-num');
			var _index;
			if(num == 2) {
				_index = 0;
				order_type = 2;
			}else if (num == 4) {
				_index = 1;
				order_type = 3;
			}
			var member_mob = {};
			$('.aui-dialog-body .aui-tab-content>.aui-list').eq(_index).find('li.aui-list-item').each(function(){
				if($(this).find('input').val() == '' || !checkMobileNo($(this).find('input').val())) {
					alert('输入的好友手机号不正确');
					return false;
				} else {
					member_mob[$(this).index()] = $(this).find('input').val();
				}
			});
			module.getSkuIds(member_mob);
		},

		// 一起拼dialog事件
		openSpellDialog: function() {
			$('.spellDialogBtn').click(function(){
				var s = module.getSkuId('，');
				if(s) {
					var skuId = module.getSkuId('|');
					var num = $('#dialog-inner-content .dialog-tab>.aui-active').attr('data-num');
					if(num == 2) {
						// 2人组团价
						$('.dialog-min-price').text(sku[skuId].sku_2_price);
					}else if(num == 4) {
						// 4人组团价
						$('.dialog-min-price').text(sku[skuId].sku_4_price);
					}
					$('.dialog-sku-spec').text(s);
					dialog.alert({
	                	title:"",
	                	msg:document.getElementById('dialog-inner-content').innerHTML,
	                	buttons:['预订']
	            	},function(ret){
	                	if(ret.buttonIndex == 1){
	                    	module.checkPtInfo();
	                	}
	            	});
	            	module.closeSpellDialog();
	            	module.tabSelectEvt(skuId);
				}else{
					alert('您还未选择商品规格哟');
				}
			})
		},

		// 获取商品的详细信息
		getGoodsDetail: function() {
			var spu_id = getParams('id');
			var data = {'spu_id': spu_id},
				info = mergeInfo('get_goods_info', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-product-detail').append(mark);
				},
				success: function(data) {
					$('.zhezhao').remove();
					if(data.errcode == 1) {
						var d = data.data;
						$('.ys-goods-name').text(d.goods_name);
						$('.ys-goods-price').text(d.goods_price);
						$('.notice-desc').text(d.delivery_explain);
						d.count == '' ? $('.ys-goods-count').text(0):$('.ys-goods-count').text(d.count);
						$('.ys-goods-price-area').text(d.recommend_price_area);
						sku = d.sku;
						var _slider = d.goods_slide;
						var sliderHtml = '';
						for(var i in _slider) {
							sliderHtml += '<div class="aui-slide-node bg-dark"><img src="'+_slider[i]+'" /></div>';
						}
						$('#aui-slide>.aui-slide-wrap').append(sliderHtml);
						var slide = new auiSlide({
					        container:document.getElementById("aui-slide"),
					        // "width":300,
					        "height":260,
					        "speed":300,
					        "autoPlay": 2000,
					        "pageShow":true,
					        "pageStyle":'dot',
					        "loop":true,
					        'dotPosition':'center',
					        currentPage: function() {}
	    				});
	    				var _imgs = d.goods_img;
	    				var imgHtml = '';
	    				for(var j in _imgs) {
	    					imgHtml += '<div class="aui-card-list-content"><img src="'+_imgs[j]+'" /></div>';
	    				}
	    				$('.ys-goods-imgs').append(imgHtml);
	    				var portionList = d.spec.portion,
	    					cycleList = d.spec.cycle,
	    					portionHtml = '',
	    					cycleHtml = '';
	    				for(var x in portionList) {
	    					portionHtml += '<div class="ys-col-xs-7"><span class="ys-type-select">'+portionList[x]+'</span></div>';
	    				}
	    				$('.portion-type').append(portionHtml);
	    				for(var y in cycleList) {
	    					cycleHtml += '<div class="ys-col-xs-7"><span class="ys-type-select">'+cycleList[y]+'</span></div>';
	    				}
	    				$('.cycle-type').append(cycleHtml);
	   					$('.dialog-goods-img').attr('src', _slider[0]);
	    				module.specSelectEvt($('.portion-type .ys-type-select'));
	    				module.specSelectEvt($('.cycle-type .ys-type-select'));
					}else{
						 alert(data.errmsg);
					}
				},
				error: function(data) {
					alert('获取商品信息失败，请刷新重试');
				}
			});
		},

		// 根据规格值获取skuid
		getSkuIds: function(member_mob) {
			var sku_id = module.getSkuId('|');
			if(!sku_id) {
				alert('您还未选择商品规格哟');
				return false;
			}
			var data = {'spec': sku_id, 'spu_id': getParams('id')},
				info = mergeInfo('get_goods_sku_by_spec', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					
				},
				success: function(data) {
					if(data.errcode == 1) {
						var d = {};
						var apiName;
						var payState;
						d.member_id = localStorage.member_id;
						if(member_mob == '') {
							var sku_ids = {};
							sku_ids[0] = data.data.sku_id;
							d.sku_ids = sku_ids;
							apiName = 'create_goods_order';
							payState = 2;
						}else{	
							d.sku_id = data.data.sku_id;
							d.member_mobiles = member_mob;
							d.order_type = order_type;
							apiName = 'create_pin_goods_order';
							payState = 1;
						}	
						module.createGoodsOrder(apiName, d, payState);

					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
				}
			})
		},

		// 创建订单
		createGoodsOrder: function(apiName, d, payState) {
			var info = mergeInfo(apiName, d);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-product-detail').append(mark);
				},
				success: function(data) {
					$('.zhezhao').remove();
					if(data.errcode == 1) {
						window.localStorage.setItem('orderData', JSON.stringify(data.data));
						gotoLocation(reserveUrl, '&payState='+payState);
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.zhezhao').remove();
					alert('网络错误，请刷新重试');
				}
			});
		},


		// 我要预订事件
		reserveEvt: function() {
			$('.reserve-btn').bind('click', function(){
				var that = $(this);
				module.getSkuIds('');
			})
		},

		// aui-tab 选择事件
		tabSelectEvt: function(skuId) {
			$('.dialog-tab>.aui-tab-item').click(function(){
				if($(this).hasClass('aui-active')) {
					return;
				}else{
					var _index = $(this).index();
					var num = $(this).attr('data-num');
					if(num == 2) {
						// 2人组团价
						$('.dialog-min-price').text(sku[skuId].sku_2_price);
					}else if(num == 4) {
						// 4人组团价
						$('.dialog-min-price').text(sku[skuId].sku_4_price);
					}
					$('.dialog-tab>.aui-tab-item').removeClass('aui-active');
					$('#dialog-inner-content .dialog-tab>.aui-tab-item').eq(_index).addClass('aui-active');
					$('.aui-dialog-body .dialog-tab>.aui-tab-item').eq(_index).addClass('aui-active');
					$('.aui-tab-content>.aui-list').addClass('aui-hide');
					$('#dialog-inner-content .aui-tab-content>.aui-list').eq(_index).removeClass('aui-hide');
					$('.aui-dialog-body .aui-tab-content>.aui-list').eq(_index).removeClass('aui-hide');
				}
			});
		}
	};
	return {
		init: module.init
	};
}(jQuery));

// Reserve page
var Reserve = (function($){
	var address_info = {};
	var sku_ids = [];
	var payParams = {};
	var pin_state = {
		'2': '已付款',
		'6': '未付款'
	};
	var module = {
		init: function() {
			module.createGoodsOrder();
			module.changeAddress();
			module.setAddressInfo();
			module.wxPay();
		},

		// 给地址内容赋值
		setAddressInfo: function(info) {
			if(getParams('address_id') == undefined) {
				module.getDefaultAddress();
			}else{
				module.getAddressInfo();
			}
		},

		//获取指定id下的地址信息
		getAddressInfo: function() {
			var data = {'member_id': localStorage.member_id, 'address_id': getParams('address_id')},
				info = mergeInfo('get_address', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				success: function(data){
					if(data.errcode == 1) {
						var d = data.data;
						address_info = d;
						address_info.address = d.content;
						$('.address-info .order-address').text(d.content);
						$('.address-info .order-username').text(d.r_name);
						$('.address-info .order-tel').text(d.r_mobile);
					}else{
						// alert(data.errmsg);
					}
				},
				error: function(data) {alert('网络错误，请刷新重试');}
			})
		},

		// 获取送餐时间段
		getTimeArea: function(state) {
			var data = {},
				info = mergeInfo('get_time_area', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				success: function(data){
					if(data.errcode == 1) {
						var d = data.data.time_area;
						var noonDate = d.noon,
							nightDate = d.night;
						if(state == 1 || state == 2) {
							for(var i in noonDate) {
								var _opt = $('<option />').val(i).text(noonDate[i]);
								$('select[name="select-day-area"]').append(_opt).removeClass('aui-hide');
							}
						}
						if(state == 1 || state == 3) {
							for(var i in nightDate) {
								var _opt = $('<option />').val(i).text(nightDate[i]);
								$('select[name="select-night-area"]').append(_opt).removeClass('aui-hide');
							}
						}
					}else{
						// alert(data.errmsg);
					}
				},
				error: function(data) {alert('网络错误，请刷新重试');}
			})
		},

		// 改变checkbox触发事件
		changeRadioEvt: function(d) {
			d.click(function(){
				var _v = $(this).val();
				if($(this).attr('checked') != undefined) {
					_v == 1 ? $('.delivery-day-area').removeClass('aui-hide') : $('.delivery-night-area').removeClass('aui-hide');
				}else{
					_v == 1 ? $('.delivery-day-area').addClass('aui-hide') : $('.delivery-night-area').addClass('aui-hide');
				}
			});
		},

		// 加入或取消订单
		addToList: function() {
			$('.recommend_list .aui-list-item .yp-select-btn').click(function(){
				var _that = $(this),
					state = _that.attr('data-state'),
					spu_id = _that.attr('data-spu'),
					sku_id = _that.attr('data-sku'),
					price = _that.attr('data-price'),
					amount = $('.pay-total').text();
				if(state == 1) {
					var _c = $('.recommend_list li.aui-list-item[data-spu='+spu_id+']').clone(true);
					_c.find('.yp-detele-wrapper').remove();
					$('.ys-goods-info .aui-list').append(_c);
					_that.text('取消').attr('data-state', 2);
					sku_ids.push(sku_id);
					amount = accAdd(amount, price);
				}else if(state == 2){
					$('.ys-goods-info li.aui-list-item[data-spu='+spu_id+']').remove();
					sku_ids.splice($.inArray(sku_id,sku_ids),1);
					_that.text('加入订单').attr('data-state', 1);
					amount = accSub(amount, price);;
				}
				$('.pay-total').text(amount);
			});
		},

		// 跳转地址管理页面
		changeAddress: function() {
			$('.address-info').click(function(){
				localStorage.setItem('urlState', 'reserve');
				gotoLocation($(this).attr('data-url'), '');
			});
		},

		// 创建商品订单
		createGoodsOrder: function() {
			var d = JSON.parse(localStorage.orderData),
				totalPay = 0;
				delivery_time = d.delivery_time,
				info = d.goods_info,
				order_sn = d.order_sn,
				recommend_goods = d.recommend_goods,
				pin_info = d.pin_info,
				voucher_info = d.voucher_info;
			$('.order_sn').text(order_sn);
			for(var i in info) {
				var _copy = $('.copy-item').clone(true);
				_copy.find('.goods_img').attr('src', info[i].goods_img);
				_copy.find('.goods_name').text(info[i].goods_name);
				_copy.find('.goods_price').text(info[i].goods_price);
				_copy.find('.goods_spec').text(info[i].goods_spec.split('|').join(','));
				_copy.find('.delivery_num').text('送餐次数：'+info[i].delivery_num+'次');
				sku_ids.push(info[i].sku_id);
				$('.ys-goods-info>.aui-list').append(_copy.html());
				totalPay = accAdd(totalPay, info[i].goods_price);
			}
			if(recommend_goods == undefined || recommend_goods.length == 0 || getParams('order_type')) {
				$('.recommend_list').remove();
			} else {
				for(var j in recommend_goods) {
					var _c = $('.copy-item').clone(true);
					_c.children('.aui-list-item').attr({
						'data-spu': recommend_goods[j].spu_id,
						'data-sku': recommend_goods[j].sku_id
					});
					_c.find('.goods_img').attr('src', recommend_goods[j].goods_img);
					_c.find('.goods_name').text(recommend_goods[j].goods_name);
					_c.find('.goods_price').text(recommend_goods[j].goods_price);
					_c.find('.goods_spec').text(recommend_goods[j].goods_spec.split('|').join(','));
					_c.find('.delivery_num').text('送餐次数：'+recommend_goods[j].delivery_num+'次');
					var optItem = $('<div class="yp-detele-wrapper"/>'),
						optBtn = $('<div class="yp-select-btn" />').text('加入订单').attr({
							'data-spu': recommend_goods[j].spu_id,
							'data-sku': recommend_goods[j].sku_id,
							'data-state': 1, //1为加入，2为取消
							'data-price': recommend_goods[j].goods_price
						});
					optItem.append(optBtn);
					_c.find('.aui-list-item-inner').after(optItem);
					$('.recommend_list .aui-list').append(_c.html());
				}
				module.addToList();
			}
			if(pin_info == undefined || pin_info.length == 0) {
				$('.pt-content').remove();
			}else{
				var pin_amount = 0;
				for(var p in pin_info) {
					var _d = $('.copy-pt-item').clone(true);
					_d.find('.pt-name').text(pin_info[p].nick_name);
					_d.find('.pt-mob').text(pin_info[p].mobile);
					_d.find('.pt-price').text(pin_info[p].pin_price);
					_d.find('.pt-state').text(pin_state[pin_info[p].pin_state]);
					pin_amount = accAdd(pin_amount, pin_info[p].pin_price);
					$('.pt-list').append(_d.html());
				}
				$('.yh-money').text(pin_amount);
				totalPay = accSub(totalPay, pin_amount);
			}
			if(voucher_info == undefined || voucher_info.length == 0) {
				$('.coupon-area').remove();
			}else {
				$('.coupon-list').text(voucher_info.length+'个可用');
				var _s = [];
				var _b = {};
				_b['d_id'] = -1;
				_b['d_name'] = '不使用优惠券';
				_b['d_price'] = 0;
				_s.push(_b);
				for(var q in voucher_info) {
					var _a = {};
					_a['d_id'] = voucher_info[q].v_b_id;
					_a['d_name'] = voucher_info[q].voucher_name;
					_a['d_price'] = voucher_info[q].voucher_price;
					_s.push(_a);
				}
				var select = new MobileSelect({
					trigger: '.coupon-list', 
					title: '',  
					wheels: [{data: _s}]
				});
			}
			var delivery_state = 1;
			if(delivery_time.length == 1) {
				var delivery_count = delivery_time[0];
				if(delivery_count == 1) { //配送午餐
					delivery_state = 2;
					$('li.delivery-night-item').remove();
				}else if(delivery_count == 2) { //配送晚餐
					delivery_state = 3;
					$('li.delivery-day-item').remove();
				}
			} 
			module.changeRadioEvt($('input[name="delivery-time"]'));
			module.getTimeArea(delivery_state);
			$('.pay-total').text(totalPay);
		},

		// 判断对象是否为空
		isEmptyObject: function(e) {  
		    var t;  
		    for (t in e)  
		        return !1;  
		    return !0  
		},

		// 获取默认地址
		getDefaultAddress: function() {
			var data = {'member_id': localStorage.member_id},
				info = mergeInfo('get_default_address', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {},
				success: function(data) {
					if(data.errcode == 1) {
						var d = data.data;
						var state = module.isEmptyObject(d);
						if(!state) {
							address_info = d;
							$('.address-info .order-address').text(d.address);
							$('.address-info .order-username').text(d.r_name);
							$('.address-info .order-tel').text(d.r_mobile);
						}else{
							$('.address-info').html('暂无默认收货地址').css('font-size', '15px');
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					alert('网络错误，请刷新重试');
				}
			});
		},

		// 微信支付
		wxPay: function() {
			$('.wx-pay').click(function(){
				var data = {};
				var order_type = 1;
				var urlApi = '';
				if(getParams('payState') == 1) {
					data.order_info = {
						'order_sn': $('.order_sn').text()
					};
					if(!module.isEmptyObject(address_info)) {
						data.address_info = address_info;
					}else{
						alert('亲，你还没设置默认收货地址呢，快先去设置一下吧');
						return false;
					}
					if($('#reserveDayDate').val()) {
						data.order_info['delivery_date'] = $('#reserveDayDate').val();
					}else{
						alert('亲，你还没选择送餐日期呢');
						return false;
					}
					if($('input[name="delivery-time"]:checked').val()){
						var delivery_time = [];
						$('input[name="delivery-time"]:checked').each(function(){
							delivery_time.push($(this).val());
						});
						data.order_info['delivery_time'] = delivery_time;
					}else{
						alert('亲，你还未选择送餐时间段呢');
						return false;
					}
					if($('.f-textarea>textarea').val()) {
						data.order_info['order_content'] = $('.f-textarea>textarea').val();
					}
					urlApi = 'create_pin_payment';
					// order_type = getParams('order_type');
				} else if(getParams('payState') == 2){
					data.member_id = localStorage.member_id;
					if($('.pay-total').text() > 0 ) {
						data.order_info = {
							'order_sn': $('.order_sn').text(),
							'order_type': order_type, //1、单人，2、双人预订，3、4人预订
							'amount': $('.pay-total').text()
						};
					} else {
						alert('亲，付款金额必须大于等于0呢');
						return false;
					}
					if(!module.isEmptyObject(address_info)) {
						data.address_info = address_info;
					}else{
						alert('亲，你还没设置默认收货地址呢，快先去设置一下吧');
						return false;
					}
					if($('#reserveDayDate').val()) {
						data.order_info['delivery_date'] = $('#reserveDayDate').val();
					}else{
						alert('亲，你还没选择送餐日期呢');
						return false;
					}
					data.goods_info = {};
					if($('input[name="delivery-time"]:checked').val()){
						var delivery_time = [];
						var time_area = {};
						var time_area_state = true;
						$('input[name="delivery-time"]:checked').each(function(){
							delivery_time.push($(this).val());
							if($(this).val() == 1) {
								var selectV = $('select[name="select-day-area"]').find("option:selected").val(),
									selectT = $('select[name="select-day-area"]').find("option:selected").text();
								if(selectV == -1) {
									alert('亲，还没选择午餐送餐时间段呢');
									time_area_state = false;
								}else{
									time_area['0'] = selectT;
								}

							}else if($(this).val() == 2) {
								var selectV1 = $('select[name="select-night-area"]').find("option:selected").val(),
									selectT1 = $('select[name="select-night-area"]').find("option:selected").text();
								if(selectV1 == -1) {
									alert('亲，还没选择晚餐送餐时间段呢');
									time_area_state = false;
								}else{
									time_area['1'] = selectT1;	
								}
							}
						});
						if(time_area_state) {
							data.goods_info['time_area'] = time_area;
						}else{
							return false;
						}
						data.goods_info['delivery_time'] = delivery_time;
					}else{
						alert('亲，你还未选择送餐时间段呢');
						return false;
					}
					if($('.f-textarea>textarea').val()) {
						data.order_info['order_content'] = $('.f-textarea>textarea').val();
					}
					if($('.coupon-list').val() != undefined && $('.coupon-list').attr('data-id') != undefined || $('.coupon-list').attr('data-id') != '-1') {
						data.voucher_info = {
							'v_id': $('.coupon-list').attr('data-id'),
							'v_price': $('.coupon-list').attr('data-price')
						}
					}
					data.goods_info.sku_ids = sku_ids;
					urlApi = 'create_payment';
				}
	
				var	info = mergeInfo(urlApi, data);
				$.ajax({
					type: 'POST',
					url: apiUrl,
					data: JSON.stringify(info),
					dataType: 'json',
					contentType: "application/json; charset=utf-8",
					beforeSend: function() {
						var mark = createDialog();
						$('.ys-reserve').append(mark);
					},
					success: function(data) {
						$('.zhezhao').remove();
						if(data.errcode == 1) {
							gotoLocation($('input[name="wx-url"]').val(), '&openid='+data.data.openid+'&order_amount='+data.data.order_amount+'&order_sn='+data.data.order_sn);
						}else{
							alert(data.errmsg);
						}
					},
					error: function(data) {
						$('.zhezhao').remove();
						alert('网络错误，请刷新重试');
					}
				})
			});
		}
	};
	return {
		init: module.init
	};
}(jQuery));

// Order List page
var Order = (function($){
	var order_state = {
		'1': '待付款',
		'2': '已付款',
		'3': '配送中',
		'4': '已完成'
	};
	var scrollState = false;
	var page = 1; //当前页码
	var pagesize = 10;//显示条数
	var default_state = $('#tab>.aui-tab-item.aui-active').attr('data-index');
	var module = {
		init: function() {
			module.tabSelectEvt();
			module.getOrderList(default_state);
			module.pullRefresh();
			module.scrollEvt();
		},

		// 判断对象是否为空
		isEmptyObject: function(e) {  
		    var t;  
		    for (t in e)  
		        return !1;  
		    return !0  
		},

		// 进入订单详细页
		gotoGoodsDetail: function() {
			$('.order-list-content>.aui-content').click(function(){
				var id = $(this).find('.order_sn').attr('data-id');
				gotoLocation($('input[name="detail_url"]').val(), '&id='+id);
			});
		},

		// 获取订单列表
		getOrderList: function(state) {
			var data = {'member_id': localStorage.member_id, 'state': state, 'page': page, 'page_size': pagesize},
				info = mergeInfo('get_order_list', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var load = createLoadDom('order');
					$('.ys-order-list .order-list-content').append(load);
				},
				success: function(data) {
					$('.loading-order').remove();
					if(data.errcode == 1) {
						var order_info = data.data.order_info;
						if(order_info == undefined || module.isEmptyObject(order_info)) {
		    				var _text = $('<div />').addClass('empty-text').text('无更多数据').css({'margin-top': '15px','margin-bottom': '30px', 'font-size': '12px'});
		    				$('.ys-order-list .order-list-content').append(_text);
						}else{
							scrollState = true;
							for(var i in order_info) {
								var _c = $('.copy-content').clone(true);
								var delivery_num = order_info[i].delivery_num;
								var delivery_time = order_info[i].delivery_time;
								var time_text = '';
								var order_goods = order_info[i].order_goods;
								if(delivery_time.length == 2) {
									time_text = '含中、晚餐';
								}else{
									var time_num = delivery_time[0];
									time_num == 1 ? time_text='含中餐' : time_text='含晚餐';
								}
								if(state == 3 || state == 4) {
									var delivery_surplus = order_info[i].delivery_surplus_num;
								}
 								_c.find('.order_sn').text(order_info[i].order_sn).attr('data-id', order_info[i].order_id);
 								for(var j in order_goods) {
 									_p = $('.copy-item').clone(true);
 									_p.find('.goods-img').attr('src', order_goods[j].goods_img);
 									_p.find('.goods-name').text(order_goods[j].goods_name);
 									_p.find('.goods-price').text(order_goods[j].goods_price);
 									_p.find('.goods_spec').text(order_goods[j].goods_spec.split('|').join(','));
 									_p.find('.order-num').text('总送餐次数：'+delivery_num+'次');
 									_p.find('.order-time').text(time_text);
 									if(state == 3 || state == 4) {
 										_p.find('.delivery_surplus').text('剩余次数：'+delivery_surplus+'次');
 									}else{
 										_p.find('.delivery_surplus').remove();
 									}
 									_c.find('.aui-list').append(_p.html());
 								}
 								$('.ys-order-list .order-list-content').append(_c.html());
							}
							module.gotoGoodsDetail();
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.loading-order').remove();
					//alert('网络错误，请刷新重试');
				}
			})
		},

		// 下拉刷新列表
		pullRefresh: function(){
			var pullRefresh = new auiPullToRefresh({
	            container: document.querySelector('.aui-refresh-content'),
	            triggerDistance: 100
	        },function(ret){
	            if(ret.status=="success"){
	                setTimeout(function(){
	                	page = 1; // 初始化数据
		       			$('.ys-order-list .order-list-content').children().remove();
		       			module.getOrderList($('#tab>.aui-active').attr('data-index'));
						pullRefresh.cancelLoading(); //刷新成功后调用此方法隐藏
	                },1500)
	            }
	        })
		},

		// tab选择事件
		tabSelectEvt: function() {
			$('#tab>.aui-tab-item').click(function(){
				if($(this).hasClass('aui-active')) {
            		return;
            	}else{
            		var _index = $(this).index();
            		gotoLocation(orderUrl[_index], '');
            	}
			});
		},

		// 滚动下拉获取更多
		scrollEvt: function() {
		    var scroll = new auiScroll({
		        listen:true,
		        distance:0 //判断到达底部的距离，isToBottom为true
		    },function(ret){
		        if(ret.isToBottom && scrollState){
		            scrollState = false;
		            page++;
		           	module.getOrderList($('#tab>.aui-active').attr('data-index'));
		        }
		    });
		}
	};
	return {
		init: module.init
	};
}(jQuery));

// Order Detail page
var OrderDetail = (function($){
	var order_state = {
		'1': '待付款',
		'2': '已付款',
		'3': '配送中',
		'4': '已送达',
		'5': '交易完成',
		'6': '拼团未付款',
		'7': '拼团个人已付款',
		'8': '拼团付款完成'
	};
	var address_list = {};
	var delivery_time_list = [];
	var order_sn_list = '';
	var pin_state = {
		'2': '已付款',
		'6': '未付款'
	};
	var module = {
		init: function() {
			module.getOrderDetail();
			module.changeAddress();
		},

		// 跳转地址管理页面
		changeAddress: function() {
			$('.order-edit-address').click(function(){
				localStorage.setItem('urlState', 'orderDetail');
				gotoLocation($(this).attr('data-url'), '&id='+getParams('id'));
			});
		},

		// 给地址内容赋值
		setAddressInfo: function(info) {
			if(getParams('address_id') == undefined) {
				var address_info = info['address_info'],
				 	r_name = info['r_name'], 
				 	r_mobile = info['r_mobile'];
				if(address_info == null &&  r_name == null && r_mobile == null) {
					address_info = '';
					r_name = '';
					r_mobile = '';
				} else {
					address_list = info;
				}
				$('.order-address').text(address_info);
				$('.order-username').text(r_name);
				$('.order-tel').text(r_mobile);
			}else{
				module.getAddressInfo();
			}
		},

		// 更改订单收货地址
		changeOrderAddress: function(data) {
			data.order_id = getParams('id');
			var info = mergeInfo('change_order_address', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				success: function(data){},
				error: function(data){alert('网络错误，请刷新重试');},
			});
		},

		// 配送延时
		applyDelayed: function(delay_time) {
			var data = {'member_id': localStorage.member_id, 'order_id': getParams('id'), 'delay_time': delay_time},
				info = mergeInfo('apply_delayed', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				success: function(data){
					if(data.errcode == 1) {
					
					}else{
						// alert(data.errmsg);
					}
				},
				error: function(data) {alert('网络错误，请刷新重试');}
			})
		},

		// 判断对象是否为空
		isEmptyObject: function(e) {  
		    var t;  
		    for (t in e)  
		        return !1;  
		    return !0  
		},

		//获取指定id下的地址信息
		getAddressInfo: function() {
			var data = {'member_id': localStorage.member_id, 'address_id': getParams('address_id')},
				info = mergeInfo('get_address', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				success: function(data){
					if(data.errcode == 1) {
						var d = data.data;
						d.address = d.content;
						$('.order-address').text(d['content']);
						$('.order-username').text(d['r_name']);
						$('.order-tel').text(d['r_mobile']);
						address_list = d;
						module.changeOrderAddress(d);
					}else{
						// alert(data.errmsg);
					}
				},
				error: function(data) {alert('网络错误，请刷新重试');}
			})
		},

		// 继续支付
		continuePay: function(order_info) {
			$('.order-sub-btn').click(function(){
				if(order_info['state'] == 1) { //普通待支付订单继续支付
					gotoLocation($('input[name="wx-url"]').val(), '&openid='+order_info['openid']+'&order_amount='+order_info['order_amount']+'&order_sn='+order_info['order_sn']);
				}else if(order_info['state'] == 6) { //拼团待支付订单继续支付
					var data = {
						'order_info': {
							'order_sn': order_sn_list,
							'delivery_time': delivery_time_list
						}
					};
					if($('#ps-time').val() == '') {
						alert('配送时间不能为空哦');
						return false;
					} else {
						data.order_info['delivery_date'] = $('#ps-time').val();
					}
					if(!module.isEmptyObject(address_list)) {
						data.address_info = address_list;
					}else{
						alert('亲，还未设置送货地址呢');
						return false;
					}
					var info = mergeInfo('create_pin_payment', data);
					$.ajax({
						type: 'POST',
						url: apiUrl,
						data: JSON.stringify(info),
						dataType: 'json',
						contentType: "application/json; charset=utf-8",
						beforeSend: function() {
							var mark = createDialog();
							$('.ys-order-detail').append(mark);
						},
						success: function(data) {
							$('.zhezhao').remove();
							if(data.errcode == 1) {
								gotoLocation($('input[name="wx-url"]').val(), '&openid='+data.data.openid+'&order_amount='+data.data.order_amount+'&order_sn='+data.data.order_sn);
							}else{
								alert(data.errmsg);
							}
						},
						error: function(data) {
							$('.zhezhao').remove();
							alert('网络错误，请刷新重试');
						}
					});
				}
				
			});
		},

		// 获取订单列表
		getOrderDetail: function() {
			var id = getParams('id');
			var data = {'order_id': id},
				info = mergeInfo('get_order_info', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-order-detail').append(mark);
				},
				success: function(data) {
					$('.zhezhao').remove();
					if(data.errcode == 1) {
						var address_info = data.data.address,
							order_info = data.data.order_info,
							order_goods = data.data.order_goods;
							pin_info = data.data.pin_info;
						if(order_info['content'] == undefined || !order_info['content']) {
							$('.order-remark').text('暂无信息');
						} else {
							$('.order-remark').text(order_info['content']);
						}
						$('.order_amount').text(order_info['order_amount']);
						$('.order_state').text(order_state[order_info['state']]);
						$('.order-time').text(order_info['create_time']);
						$('.order_sn').text(order_info['order_sn']);
						module.setAddressInfo(address_info);
						var delivery_num = order_info['delivery_num'];
						var delivery_surplus = order_info['delivery_surplus_num'];
						var delivery_time = order_info['delivery_time'];
						var time_text = '';
						var delivery_date = order_info['delivery_date'];
						var time_area = order_info['time_area'];
						if(order_info['state'] == 1 || order_info['state'] == 6) {
							module.continuePay(order_info);
							$('.order-sub-wrap').removeClass('aui-hide');
						}
						if(delivery_time.length == 2) {
								time_text = '含中、晚餐';
						}else{
							var time_num = delivery_time[0];
							time_num == 1 ? time_text='含中餐' : time_text='含晚餐';
						}
						delivery_time_list = delivery_time;
						order_sn_list = order_info['order_sn'];
						if(time_area != undefined && time_area != null && time_area != false) {
							if(time_area.length == 2) {
								$('.time-area-day').text(time_area[0]);
								$('.time-area-night').text(time_area[1]);
							}else if(time_area.length == 1) {
								if(time_area[0] != undefined) {
									$('.time-area-night-info').addClass('aui-hide');
									$('.time-area-day').text(time_area[0]);
								}
								if(time_area[1] != undefined) {
									$('.time-area-day-info').addClass('aui-hide');
									$('.time-area-night').text(time_area[1]);
								}
							}
						}else{
							$('.time-area-night-info, .time-area-day-info').addClass('aui-hide');
						}

						if(delivery_date != undefined || delivery_date != null) {
							$('#ps-time').val(delivery_date);
						}
						
						for(var j in order_goods) {
 							_p = $('.copy-item').clone(true);
 							_p.find('.goods-img').attr('src', order_goods[j].goods_img);
 							_p.find('.goods-name').text(order_goods[j].goods_name);
 							_p.find('.goods-price').text(order_goods[j].goods_price);
 							_p.find('.goods_spec').text(order_goods[j].goods_spec.split('|').join(','));
 							_p.find('.order-num').text('总送餐次数：'+delivery_num+'次');
 							_p.find('.order-time').text(time_text);
 							if(delivery_surplus == undefined) {
 								_p.find('.delivery_surplus').remove();
 							} else if (delivery_surplus == '' || delivery_surplus == 0) {
 								_p.find('.delivery_surplus').text('剩余次数：0次');
 							} else {
 								_p.find('.delivery_surplus').text('剩余次数：'+delivery_surplus+'次');
 							}
 							$('.ys-order-list .aui-list').append(_p.html());
 						}
 						if(pin_info == undefined || pin_info.length == 0) {
							$('.pt-content').remove();
						}else{
							var pin_amount = 0;
							for(var p in pin_info) {
								var _d = $('.copy-pt-item').clone(true);
								_d.find('.pt-name').text(pin_info[p].nick_name);
								_d.find('.pt-mob').text(pin_info[p].member_mobile);
								_d.find('.pt-price').text(pin_info[p].pin_price);
								_d.find('.pt-state').text(pin_state[pin_info[p].pin_state]);
								pin_amount = accAdd(pin_amount, pin_info[p].pin_price);
								$('.pt-list').append(_d.html());
							}
							$('.pt-price').text(pin_amount);
							$('.pt-content').show();
							// totalPay = accSub(totalPay, pin_amount);
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.zhezhao').remove();
					alert('网络错误，请刷新重试');
				}
			});
		}
	};
	return {
		delay: module.applyDelayed,
		init: module.init
	};
}(jQuery));

// Account page
var Account = (function($) {
	var module = {
		init: function() {
			module.getUserInfo();
		},

		// 获取用户基本信息
		getUserInfo: function() {
			var data = {'member_id': localStorage.member_id},
				info = mergeInfo('get_member', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-myaccount').append(mark);
				},
				success: function(data) {
					$('.zhezhao').remove();
					var url = localStorage.localStorage_url;
					if(data.errcode == 1) {
						var userLogo = $('.user-logo'),
							userName = $('.user-no'),
							userSex = $('.user-sex>img');
						data.data.nick_name ? userName.text(data.data.nick_name) : userName.text('');
						data.data.sex == 1 ? userSex.attr('src', url + 'ico_mr.png') :  userSex.attr('src', url + 'ico_lady.png');
						data.data.avatar ? userLogo.attr('src', data.data.avatar) : userLogo.attr('src', url + 'my-logo.jpg');
						window.localStorage.setItem('sex', data.data.sex);
						window.localStorage.setItem('username', data.data.nick_name);
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.zhezhao').remove();
					alert('用户信息获取失败，请刷新重试');
				}
			});
		}
	};

	return {
		init: module.init
	};
}(jQuery));

//address list page
var Address = (function($) {
	var module = {
		init: function() {
			module.getAddressList();
			module.addAddressEvt();
		}, 

		// 跳转订单详情页
		clickItemEvt: function() {
			$('.aui-list .aui-list-item').click(function(event){
				event.stopPropagation();
				if(localStorage.urlState == 'orderDetail') {
					var url = $('input[name="order-url"]').val();
					gotoLocation(url, '&address_id='+$(this).attr('id')+'&id='+getParams('id'));
				}else if(localStorage.urlState == 'reserve') {
					var url = $('input[name="order-url1"]').val();
					gotoLocation(url, '&address_id='+$(this).attr('id'));
				}
				
			});
		},

		// 添加新地址跳转
		addAddressEvt: function() {
			$('.add-address-btn').click(function(event){ 
				event.stopPropagation();
				var url = $('input[name="add-url"]').val();
				var addressState = $('input[name="address-state"]').val();
				var str = '&state='+addressState;
				if(addressState == 2) {
					str +=  '&orderId='+getParams('id');
				}
				gotoLocation(url, str);
			});
		},

		// 改变默认地址
		changeDefaultAddress: function() {
			$('.ys-address-list .aui-radio').click(function(event){
				event.stopPropagation();
				var that = $(this);
				var address_id = that.parent('.radio-label').attr('address-id');
				var data = {'member_id': localStorage.member_id, 'address_id': address_id},
					info = mergeInfo('change_address_default', data);
				$.ajax({
					type: 'POST',
					url: apiUrl,
					data: JSON.stringify(info),
					dataType: 'json',
					contentType: "application/json; charset=utf-8",
					beforeSend: function() {
						var mark = createDialog();
						$('.ys-address-list').append(mark);
					},
					success: function(data) {
						$('.zhezhao').remove();
						if(data.errcode == 1) {
							$('.ys-address-list .aui-radio').next('span').text('设为默认');
							that.next('span').text('默认地址');
							$('.ys-address-list .aui-radio').parent('.radio-label').removeClass('default-label');
							that.parent('.radio-label').addClass('default-label');
						}else{
							alert(data.errmsg);
						}
					},
					error: function(data) {
						$('.zhezhao').remove();
						alert('默认地址设置失败，请刷新重试');
					}
				});
			});
		},

		// 编辑地址
		editEvt: function() {
			$('.edit-img').click(function(event){
				event.stopPropagation();
				var url = $('input[name="edit-url"]').val(),
					id = $(this).attr('data-id');
				var addressState = $('input[name="address-state"]').val();
				var str = '&id='+id+'&state='+$('input[name="address-state"]').val();
				if(addressState == 2) {
					str +=  '&orderId='+getParams('id');
				}
				gotoLocation(url, str);
			})
		},

		// 删除地址
		delEvt: function() {
			$('.del-img').click(function(event){
				event.stopPropagation();
				var that = $(this);
				var dialog = new auiDialog();
				dialog.alert({
                    title:"温馨提示",
                    msg:'是否删除地址',
                    buttons:['取消','确定']
                },function(ret){
                    if(ret.buttonIndex == 2) {
                    	var data = {'member_id': localStorage.member_id, 'address_id': that.attr('data-id')},
							info = mergeInfo('del_address', data);
						$.ajax({
							type: 'POST',
							url: apiUrl,
							data: JSON.stringify(info),
							dataType: 'json',
							contentType: "application/json; charset=utf-8",
							beforeSend: function() {
								var mark = createDialog();
								$('.ys-address-list').append(mark);
							},
							success: function(data) {
								$('.zhezhao').remove();
								if(data.errcode == 1) {
									var id = that.attr('data-id');
									$('li.aui-list-item[id="'+id+'"]').remove();
								}else{
									alert(data.errmsg);
								}
							},
							error: function(data) {
								$('.zhezhao').remove();
								alert('网络错误， 请刷新重试');
							}
						});
                    }
                })
			})
		},

		// 获取用户地址
		getAddressList: function() {
			var data = {'member_id': localStorage.member_id},
				info = mergeInfo('get_address_list', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var load = createLoadDom('address');
					$('.ys-address-list .aui-list').append(load);
				},
				success: function(data) {
					$('.loading-address').remove();
					var code = data.errcode;
					if(code == 1) {
						var l = data.data.list;
						if(l) {
							for(var i in l) {
								var _copy = $('.address-item-copy').clone(true);
								_copy.children('.aui-list-item').attr('id', l[i].address_id);
								_copy.find('.order-address').text(l[i].address);
								_copy.find('.order-username').text(l[i].r_name);
								_copy.find('.order-tel').text(l[i].r_mobile);
								_copy.find('.radio-label').attr('address-id', l[i].address_id);
								if(l[i].is_default == 1) {
									_copy.find('.radio-label').addClass('default-label');
									_copy.find('.aui-radio').attr('checked', true);
									_copy.find('.radio-label>span').text('默认地址');
								}
								_copy.find('.edit-img').attr('data-id', l[i].address_id);
								_copy.find('.del-img').attr('data-id', l[i].address_id);
								$('.ys-address-list .aui-list').append(_copy.html());
								
							}
							if($('input[name="address-state"]').val() == 2) {
								module.clickItemEvt();
							}
							module.changeDefaultAddress();
							module.editEvt();
							module.delEvt();
						}else{
							var _empty = $('<img src="'+localStorage.localStorage_url+'img_empty.png" />').addClass('empty-img');
		    				var _text = $('<div />').addClass('empty-text').text('亲，您在哪里呀，快点告诉我们，点击下方按钮去添加取餐地址吧~');
		    				$('.ys-address-list .aui-list').append(_empty, _text);
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.loading-address').remove();
					alert('地址获取失败，请刷新重试');
				}
			});
		}
	};

	return {
		init: module.init
	}
}(jQuery));

//add new address page
var AddAddress = (function($) {
	var toast = new auiToast();
	var module = {
		init: function() {
			module.getAddressList();
			module.addEvt();
			clearEvt($('.ys-add-address .input-del-icon'), $('input[name="add-name"]'));
		},

		// check mobile 
		checkMobile: function(m) {
			var mob = m.val();
			if(mob == '') {
				toast.fail({
                    title:"请输入手机号",
                    duration:2000
                });
                m.focus();
                return false;
			} else if (!checkMobileNo(mob)) {
				toast.fail({
                    title:"手机号格式不正确",
                    duration:2000
                });
                m.focus();
                return false;
            } 
            return true;
		},

		// 添加地址
		addEvt: function() {
			$('.ys-add-address .add-address-wrapper>button').click(function(){
				var _that = $(this);
				var data = {};
				var n = $('input[name="add-name"]');
				if(!n.val()) {
					toast.fail({
	                    title:"订餐人姓名不能为空",
	                    duration:2000
	                });
	                n.focus();
					return false;
				}
				var state = module.checkMobile($('input[name="add-tel"]'));
				if(!state) {
					return false;
				}
				var d = $('span.select-sc-address'),
					t = $('span.select-qc-address');
				if(d.attr('data-id') == undefined) {
					toast.fail({
	                    title:"请选择送餐学校",
	                    duration:2000
	                });
	                return false;
				}
				data.member_id = localStorage.member_id;
				data.r_name = n.val();
				data.r_mobile = $('input[name="add-tel"]').val();
				data.d_id = d.attr('data-id');
				data.d_name = d.text();
				if(t.attr('data-id') == undefined || t.attr('data-id') ==  -1) {
					var _area = $('.f-textarea>textarea');
					data.t_id = 0;
					if(_area.val() == '') {
						toast.fail({
		                    title:"请输入详细送餐地址",
		                    duration:2000
		                });
	                	return false;
					}
					data.content = _area.val();
				} else {
					data.t_id = t.attr('data-id');
					data.t_name = t.text();
				}
				$('input[name="is-default"]:checked').val() == undefined ? data.is_default = 2 :  data.is_default = 1;
				var info = mergeInfo('add_receive_address', data);
				$.ajax({
					type: 'POST',
					url: apiUrl,
					data: JSON.stringify(info),
					dataType: 'json',
					contentType: "application/json; charset=utf-8",
					beforeSend: function() {
						_that.attr('disabled', true);
						var mark = createDialog();
						$('.ys-add-address').append(mark);
					},
					success: function(data) {
						$('.zhezhao').remove();
						_that.removeAttr('disabled');
						if(data.errcode == 1) {
							var addUrl = '';
							var str = '';
							if(getParams('state') == 1) {
								addUrl = addressUrl[0];
							}else if(getParams('state') == 2) {
								addUrl = addressUrl[1];
								str = '&id='+getParams('orderId');
							}
							gotoLocation(addUrl, str);
						}else{
							alert(data.errmsg);
						}    
					},
					complete: function() {
						console.log('complete');
					},
					error: function(data) {
						$('.zhezhao').remove();
						_that.removeAttr('disabled');
					}
				})
			});
		},

		// 获取初始送餐取餐地址
		getAddressList: function() {
			var data = {},
				info = mergeInfo('get_fd_list', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-add-address').append(mark);
				},
				success: function(data) {
					$('.zhezhao').remove();
					if(data.errcode == 1) {
						var l = data.data.list;
						if(l.length) {			
							var _s = [];
							var _x = {};
							for(var i in l) {
								var _a = {};
								_a['d_id'] = l[i].d_id;
								_a['d_name'] = l[i].d_name;
								_s.push(_a);
								var _y = {};
								_y['-1'] = '自提点取餐';
								for(var j in l[i].take_list) {
									_y[l[i].take_list[j].t_id] = l[i].take_list[j].t_name;	
								}

								_x[l[i].d_id] = _y;
							}
							var first_id = _s[0]['d_id'];
							window.localStorage.setItem('school_list', JSON.stringify(_s));
							window.localStorage.setItem('take_meal_list', JSON.stringify(_x));
							var select1 = new MobileSelect({
						        trigger: '.select-sc-address', 
						        title: '',  
						        wheels: [
						                {data: _s}
						            ]
						     	 //初始化定位 打开时默认选中的哪个  如果不填默认为0
						    });
						    var select2 = new MobileSelect({
						        trigger: '.select-qc-address', 
						        title: '',  
						        wheels: [
						                {data:  _x[first_id]}
						            ]
						    });
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.zhezhao').remove();
					alert('获取送餐学校失败，请刷新重试');
				}
			});
		}
	};

	return {
		init: module.init
	}
}(jQuery));

//edit address list page
var EditAddress = (function($) {
	var toast = new auiToast();
	var id = getParams('id'); //获取address_id
	var module = {
		init: function() {
			module.getAddressInfo();
			module.editClickEvt();
			clearEvt($('.ys-edit-address .input-del-icon'), $('input[name="add-name"]'));
		},

		// check mobile 
		checkMobile: function(m) {
			var mob = m.val();
			if(mob == '') {
				toast.fail({
                    title:"请输入手机号",
                    duration:2000
                });
                m.focus();
                return false;
			} else if (!checkMobileNo(mob)) {
				toast.fail({
                    title:"手机号格式不正确",
                    duration:2000
                });
                m.focus();
                return false;
            } 
            return true;
		},

		// 保存修改后的地址
		editClickEvt: function() {
			$('.ys-edit-address .add-address-wrapper>button').click(function(){
				var _that = $(this);
				var data = {};
				var n = $('input[name="add-name"]');
				if(!n.val()) {
					toast.fail({
	                    title:"订餐人姓名不能为空",
	                    duration:2000
	                });
	                n.focus();
					return false;
				}
				var state = module.checkMobile($('input[name="add-tel"]'));
				if(!state) {
					return false;
				}
				var d = $('span.select-sc-address'),
					t = $('span.select-qc-address');
				if(d.attr('data-id') == undefined) {
					toast.fail({
	                    title:"请选择送餐学校",
	                    duration:2000
	                });
	                return false;
				}
				data.member_id = localStorage.member_id;
				data.r_name = n.val();
				data.r_mobile = $('input[name="add-tel"]').val();
				data.d_id = d.attr('data-id');
				data.d_name = d.text();
				if(t.attr('data-id') == undefined || t.attr('data-id') == -1) {
					var _area = $('.f-textarea>textarea');
					data.t_id = 0;
					if(_area.val() == '') {
						toast.fail({
		                    title:"请输入详细送餐地址",
		                    duration:2000
		                });
	                	return false;
					}
					data.content = _area.val();
				} else {
					data.t_id = t.attr('data-id');
					data.t_name = t.text();
				}
				$('input[name="is-default"]:checked').val() == undefined ? data.is_default = 2 :  data.is_default = 1;
				data.address_id = id;
				var info = mergeInfo('edit_receive_address', data);
				$.ajax({
					type: 'POST',
					url: apiUrl,
					data: JSON.stringify(info),
					dataType: 'json',
					contentType: "application/json; charset=utf-8",
					beforeSend: function() {
						_that.attr('disabled', true);
						var mark = createDialog();
						$('.ys-add-address').append(mark);
					},
					success: function(data) {
						$('.zhezhao').remove();
						_that.removeAttr('disabled');
						if(data.errcode == 1) {
							var addUrl = '';
							var str = '';
							if(getParams('state') == 1) {
								addUrl = addressUrl[0];
							}else if(getParams('state') == 2) {
								addUrl = addressUrl[1];
								str = '&id='+getParams('orderId');
							}
							gotoLocation(addUrl, str);
						}else{
							alert(data.errmsg);
						}    
					},
					complete: function() {
						console.log('complete');
					},
					error: function(data) {
						$('.zhezhao').remove();
						_that.removeAttr('disabled');
					}
				})
			});
		},

		//获取指定id下的地址信息
		getAddressInfo: function() {
			var data = {'member_id': localStorage.member_id, 'address_id': id},
				info = mergeInfo('get_address', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-edit-address').append(mark);
				},
				success: function(data){
					$('.zhezhao').remove();
					if(data.errcode == 1) {
						var d = data.data;
						$('input[name="add-name"]').val(d.r_name);
						$('input[name="add-tel"]').val(d.r_mobile);
						if(d.t_id == 0 || d.t_id == '') {
							$('.f-textarea>textarea').val(d.content);
							$('.select-qc-address').attr('data-id', '-1').text('自提点取餐');
						}else{
							$('.address-textarea').addClass('aui-hide');
						}
						if(d.is_default == 1) {
							$('input[name="is-default"]').attr('checked', true);
						}
						module.getSchoolList(d);
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.zhezhao').remove();
					alert('网络错误，请刷新重试');
				}
			})
		},

		// 获取初始送餐取餐地址
		getSchoolList: function(d) {
			var data = {},
				info = mergeInfo('get_fd_list', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					// var mark = createDialog();
					// $('.ys-add-address').append(mark);
				},
				success: function(data) {
					// $('.zhezhao').remove();
					if(data.errcode == 1) {
						var l = data.data.list;
						if(l.length) {			
							var _s = [];
							var _x = {};
							var d_index, t_index = 0;
							for(var i in l) {
								var _a = {};
								_a['d_id'] = l[i].d_id;
								_a['d_name'] = l[i].d_name;
								_s.push(_a); 
								if(l[i].d_id == d.d_id) {
									d_index = i;
									$('.select-sc-address').attr('data-id', d.d_id).text(l[i].d_name);
								}
								var _y = {};
								_y['-1'] = '自提点取餐';
								for(var j in l[i].take_list) {
									_y[l[i].take_list[j].t_id] = l[i].take_list[j].t_name;
									if(l[i].take_list[j].t_id == d.t_id) {
										t_index = j;
										$('.select-qc-address').attr('data-id', d.t_id).text(l[i].take_list[j].t_name);
									}
								}
								_x[l[i].d_id] = _y;
							}
							var first_id = _s[d_index]['d_id'];
							
							window.localStorage.setItem('school_list', JSON.stringify(_s));
							window.localStorage.setItem('take_meal_list', JSON.stringify(_x));
							
							var select1 = new MobileSelect({
						        trigger: '.select-sc-address', 
						        title: '',  
						        wheels: [
						                {data: _s}
						            ],
						     	 //初始化定位 打开时默认选中的哪个  如果不填默认为0
						     	 position: [d_index]
						    });
						    var select2 = new MobileSelect({
						        trigger: '.select-qc-address', 
						        title: '',  
						        wheels: [
						                {data:  _x[first_id]}
						            ],
						         position: [t_index]
						    });
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					// $('.zhezhao').remove();
					alert('获取送餐学校失败，请刷新重试');
				}
			});
		}
	};

	return {
		init: module.init
	}
}(jQuery));


// edit user page
var User = (function($) {
	var module = {
		init: function() {
			module.defaultSelected();
			module.selectSexEvt();
			module.saveUser();
		},

		// 保存修改后的用户信息
		saveUser: function() {
			$('.edit-user-wrapper>button').click(function(){
				var _this = $(this);
				var data = {'member_id': localStorage.member_id, 'sex': $('.selected').attr('data-sex')},
					info = mergeInfo('change_member_sex', data);
				$.ajax({
					type: 'POST',
					url: apiUrl,
					data: JSON.stringify(info),
					dataType: 'json',
					contentType: "application/json; charset=utf-8",
					beforeSend: function() {
						var mark = createDialog();
						$('.ys-myaccount-edit').append(mark);
					},
					success: function(data) {
						$('.zhezhao').remove();
						if(data.errcode == 1) {
							gotoLocation(_this.attr('data-url'), '');
						}else{
							alert(data.errmsg);
						}
					},
					error: function(data) {
						$('.zhezhao').remove();
						alert('用户信息保存失败，请刷新重试');
					}
				});
			});
		},

		// 获取初始状态
		defaultSelected: function() {
			var name = localStorage.username,
				sex = localStorage.sex;
			$('.username').text(name);
			$('.sex-select').each(function(){
				if($(this).attr('data-sex') == sex) {
					$(this).addClass('selected');
				}
			});
		},

		// 选择性别select事件
		selectSexEvt: function() {
			$('.sex-select').click(function(){
				$('.sex-select').removeClass('selected');
				$(this).addClass('selected');
			});
		}
	};

	return {
		init: module.init
	};

}(jQuery))

// Register Page
var Register = (function($) {
	var toast = new auiToast();
	var module =  {

		init: function() {
			clearEvt($('.ys-register .input-del-icon'), $('.user-mobile'));
			module.getVerCode();
			module.checkRegisterInfo();
		},

		// check mobile 
		checkMobile: function(mob) {
			$('.ys-mob-item').removeClass('error-info');
			if(mob == '') {
				toast.fail({
                    title:"请输入手机号",
                    duration:2000
                });
                $('.user-mobile').focus();
                $('.ys-mob-item').addClass('error-info');
                return false;
			} else if (!checkMobileNo(mob)) {
				toast.fail({
                    title:"手机号格式不正确",
                    duration:2000
                });
                $('.user-mobile').focus();
                $('.ys-mob-item').addClass('error-info');
                return false;
            } 
            return true;
		},

		// check code
		checkCode: function(code) {
			$('.ys-code-item').removeClass('error-info');
			if(code == '') {
				toast.fail({
                    title:"请输入验证码",
                    duration:2000
                });
                $('.verify').focus();
                $('.ys-code-item').addClass('error-info');
                return false;
			} else if (code.length < 6) {
				toast.fail({
                    title:"验证码格式不正确",
                    duration:2000
                });
                $('.verify').focus();
                $('.ys-code-item').addClass('error-info');
                return false;
            } 
            return true;
		},

		// 验证登录信息
		checkRegisterInfo: function() {
			$('.ys-register .next-btn').bind('click', function(){
				var _that = $(this);
				var mob = $('.user-mobile').val();
				var code = $('.verify').val();
				var mobState = module.checkMobile(mob);
				if(mobState) { 
					var codeState = module.checkCode(code);
					if(codeState) {
						var data = {'mobile': mob, 'seccode': code},
						info = mergeInfo('reg_check', data);
						$.ajax({
							type: 'POST',
							url: apiUrl,
							data: JSON.stringify(info),
							dataType: 'json',
							contentType: "application/json; charset=utf-8",
							beforeSend: function() {
						 		_that.attr('disabled', true);
						 	},
						 	success: function(data) {
						 		if(data.errcode == 1) {
						 			var nickName = $('.name').val();
						 			var openid = $('.openid').val();
						 			var avatar = $('.avatar').val();
						 			var _s = {
						 				'nickName': nickName,
						 				'openid': openid,
						 				'avatar': avatar,
						 				'mob': mob
						 			};
						 			window.localStorage.setItem('user_info', JSON.stringify(_s));
						 			gotoLocation($('.question-url').val(), '');
						 		}else{
						 			alert(data.errmsg);
						 		}
					            _that.removeAttr('disabled');
						 	},
						 	complete: function() {
						 		console.log('complete');
						 	},
						 	error: function(data) {
						 		_that.removeAttr('disabled');
						 	}
						})
					}	
				}
				
			})
		},

		// 获取手机验证码
		getVerCode: function() {
			$('.ys-register .get-verify-btn').bind('click', function(){
				var _this = $(this);
				var mob = $('.user-mobile').val();
				var state = module.checkMobile(mob);
				if(state) {
					var data = {'mobile': mob},
						info = mergeInfo('send_seccode', data);
					$.ajax({
						type: 'POST',
						url: apiUrl,
						data: JSON.stringify(info),
						dataType: 'json',
						contentType: "application/json; charset=utf-8",
					 	beforeSend: function() {
					 		_this.attr('disabled', true);
					 	},
				    	success: function(data) {
				    		if(data.errcode == 1) {
				    			_this.css('background-color', '#ccc');
				    			var d = new Date();
									d.setSeconds(d.getSeconds() + 59);
									var m = d.getMonth() + 1;
									var time = d.getFullYear() + '-' + m + '-' + d.getDate() + ' ' + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds();
									var end_time = new Date(Date.parse(time.replace(/-/g, "/"))).getTime(),
									//月份是实际月份-1
									sys_second = (end_time - new Date().getTime()) / 1000;
									var timer = setInterval(function() {
									if (sys_second > 1) {
									sys_second -= 1;
									var day = Math.floor((sys_second / 3600) / 24);
									var hour = Math.floor((sys_second / 3600) % 24);
									var minute = Math.floor((sys_second / 60) % 60);
									var second = Math.floor(sys_second % 60);
									var time_text = '';
									if (day > 0) {
									time_text += day + '天';
									}
									if (hour > 0) {
									if (hour < 10) {
									hour = '0' + hour;
									}
									time_text += hour + '小时';
									}
									if (minute > 0) {
									if (minute < 10) {
									minute = '0' + minute;
									}
									time_text += minute + '分';
									}
									if (second > 0) {
									if (second < 10) {
									second = '0' + second;
									}
									time_text += second + '秒';
									}
									_this.text(time_text);
									} else {
									clearInterval(timer);
									_this.attr("disabled", false);
									_this.text('重新获取验证码');
									_this.css('background-color','#fa5400');
									}
									},
									1000);
								} else {
									toast.fail({
				                    	title:"获取验证码失败",
				                    	duration:2000
				                	});
				                	_this.attr("disabled", false);
								}
				    	},
				    	complete: function() {
				    		console.log('complete');
				    	},
				    	error: function (data) {
				    		console.log('error:' + data);
				    		_this.attr("disabled", false);
				    	}
				    })
				}
			
			})
		}
	};
	return {
		init: module.init
	}
}(jQuery));

// register question page
var Question = (function($){
	var module = {
		init: function() {
			module.changeRedioEvt($('input.aui-radio[name="radio1"]'));
			module.changeRedioEvt($('input.aui-radio[name="radio2"]'));
			module.changeRedioEvt($('input.aui-radio[name="radio3"]'));
			module.changeRedioEvt($('input.aui-radio[name="radio4"]'));
			module.registerEvt();
		},

		// change radio style
		changeRedioEvt: function(_radios) {
			var _this = _radios;
			_this.change(function(){
				_this.parent('.radio-label').removeClass('default-label');
				$(this).parent('.radio-label').addClass('default-label');
			})
		},

   		// 注册
   		registerEvt: function() {
   			$('.ys-register-question .question-sub-btn').bind('click', function(){
   				var _this = $(this);
   				var user_info = JSON.parse(localStorage.user_info);
   				var q1 = $('input.aui-radio[name="radio1"]:checked').val(),
   					q2 = $('input.aui-radio[name="radio2"]:checked').val(),
   					q3 = $('input.aui-radio[name="radio3"]:checked').val(),
   					q4 = $('input.aui-radio[name="radio4"]:checked').val(),
   					mob = user_info.mob,
   					nickName = user_info.nickName,
   					openid = user_info.openid,
   					avatar = user_info.avatar;
   				var data = {
   					'mobile': mob,
   					'openid': openid,
   					'avatar': avatar,
   					'nick_name': nickName,
   					'question': {
   						'q1': q1,
   						'q2': q2,
   						'q3': q3,
   						'q4': q4
   						}
   					},
					info = mergeInfo('reg_member', data);
				$.ajax({
					type: 'POST',
					url: apiUrl,
					data: JSON.stringify(info),
					dataType: 'json',
					contentType: "application/json; charset=utf-8",
					beforeSend: function() {
					 	_this.attr('disabled', true);
					 	var url = $('.localStorage-url').val();
					 	var d = $('<div />').addClass('zhezhao'),
							l = $('<img />').attr('src',url +'loading.gif');
						d.append(l);
					 	$('.ys-register-question').append(d);
					 },
				    success: function(data) {
				    	$('.zhezhao').remove();
				    	_this.removeAttr('disabled');
				    	if(data.errcode == 1) {
				    		window.localStorage.setItem('member_id', data.data.member_id);
				    		gotoLocation($('.ys-register-question .home-url').val(), '');
				    	}else{
				    		console.log(data.errmsg);
				    	}
				    },
				    error: function(data) {
				    	$('.zhezhao').remove();
				    	_this.removeAttr('disabled');
				    }
				})

   			})
   		}
	};
	return {
		init: module.init
	}
})(jQuery);

// shoppingcar list page
var Shoppingcar = (function($){
	var dialog = new auiDialog();
	var module = {
		init: function(state) { //state 1:shopping index, 2:shopping delete
			module.getCarList(state);
			module.gotoReserveEvt();
			module.gotoDelCar();
			module.delcarEvt();
		},

		// 结算事件
		gotoReserveEvt: function() {
			$('.go-pay-btn').click(function(){
				var that = $(this);
				var len = $('input[name="itemRadio"]:checked').length;
				if(len) {
					var sku_ids = {};
					var state_arr = [];
					var time_state ;
					var url_state = true;
                	$('input[name="itemRadio"]:checked').each(function(i){
                		sku_ids[i] = $(this).attr('data-sku');
                		time_state = $(this).attr('time-state');
                		if(i == 0) {
                			state_arr.push(time_state);
                		}else {
                			if($.inArray(time_state, state_arr) == '-1') {
                				alert('亲，请选择相同时间段的商品');
                				url_state = false;
                				return false;
                			}
                		}
                	});
                	if(url_state) {
                		var d = {};
                		d.sku_ids = sku_ids;
                		module.createGoodsOrder(d, that.attr('data-url'));
                	}
				}else{
					alert('亲，还没有等待结算的商品呢');
				}
			});
		},

		// 创建订单
		createGoodsOrder: function(d, jumpUrl) {
			d.member_id = localStorage.member_id;
			var info = mergeInfo('create_goods_order', d);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-product-detail').append(mark);
				},
				success: function(data) {
					$('.zhezhao').remove();
					if(data.errcode == 1) {
						window.localStorage.setItem('orderData', JSON.stringify(data.data));
						gotoLocation(jumpUrl, '&payState=2');
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.zhezhao').remove();
					alert('网络错误，请刷新重试');
				}
			});
		},

		// 跳转删除商品页
		gotoDelCar: function() {
			$('.ys-edit-text').click(function(){
				gotoLocation($(this).attr('data-url'), '');
			});
		},

		// 全选与反选事件
		checkAll: function() {
			$('input[name="checkAll"]').click(function(){ 
	    		if(this.checked){   
	    			var len = $('.good-list input[name="itemRadio"]').length,
	    				totalValue = 0;
	        		$('.good-list input[name="itemRadio"]').prop("checked", true); 
	        		$('.good-list input[name="itemRadio"]').each(function(){
	        			totalValue = accAdd(totalValue, $(this).attr('data-price'));
	        		});
	        		$('.total-value').text(totalValue);
					$('.pay-num').text(len);
	    		}else{   
					$('input[name="itemRadio"]').prop("checked", false);
					$('.total-value').text('0.00');
					$('.pay-num').text('0');
	    		}   
			});
		},

		// 删除选中购物车商品
		delcarEvt: function() {
			$('.del-shop-item, .delete-spcar-btn').bind('click', function(){
				var len = $('input[name="itemRadio"]:checked').length;
				if(len) {
					dialog.alert({
                    	title:"温馨提示",
                    	msg:'是否删除所选商品',
                    	buttons:['取消','确定']
                		},function(ret){
                			if(ret.buttonIndex == 2) {
                				var sku_ids = {};
                				$('input[name="itemRadio"]:checked').each(function(i){
                					sku_ids[i] = $(this).attr('data-sku');
                				});
		                    	var data = {'member_id': localStorage.member_id, 'sku_ids': sku_ids},
									info = mergeInfo('del_cart', data);
								$.ajax({
									type: 'POST',
									url: apiUrl,
									data: JSON.stringify(info),
									dataType: 'json',
									contentType: "application/json; charset=utf-8",
									beforeSend: function() {
										var mark = createDialog();
										$('.ys-shopping-car').append(mark);
									},
									success: function(data) {
										$('.zhezhao').remove();
										if(data.errcode == 1) {
											window.location.reload();
										}else{
											alert(data.errmsg);
										}
									},
									error: function(data) {
										$('.zhezhao').remove();
										alert('网络错误， 请刷新重试');
									}
								});
		                    }
                		}
                	);
				}else{
					alert('主人，还没有商品等您删除呢');
				}
			})
		},

		// 商品选中事件
		itemSelectEvt: function() {
			$('input[name="itemRadio"]').change(function(){
				var totalValue = $('.total-value').text(),
					totalNum = $('.pay-num').text();
				if(this.checked) {
					totalValue = accAdd(totalValue, $(this).attr('data-price'));
					totalNum++;
				}else{
					totalValue = accSub(totalValue, $(this).attr('data-price'));
					totalNum--;
					if($('input[name="checkAll"]')[0].checked) {
						$('input[name="checkAll"]').prop('checked', false);
					}
				}
				$('.total-value').text(totalValue);
				$('.pay-num').text(totalNum);
			});
		},

		// 获取购物车列表
		getCarList: function(state) {
			var data = {'member_id': localStorage.member_id},
				info = mergeInfo('get_cart_list', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					var mark = createDialog();
					$('.ys-shopping-car').append(mark);
				},
				success: function(data) {
					$('.zhezhao').remove();
					if(data.errcode == 1) {
						var l = data.data.list;
						$('.good-list').css('background-color',' #fff');
						if(l.length) {
							for(var i in l) {
								var _copy = $('.copy-item').clone(true);
								var delivery_time = l[i].delivery_time;
								var time_text = "";
								var time_state;
								if(delivery_time.length == 2) {
									time_text = '含中、晚餐';
									time_state = 1;
								}else{
									var time_num = delivery_time[0];
									time_num == 1 ? time_text='含中餐' : time_text='含晚餐';
									time_num == 1 ? time_state = 2 : time_state = 3;
								}
								if(state == 1 && l[i].goods_state == 2) {
									_copy.find('input[name="itemRadio"]').addClass('aui-invisible').removeAttr('name');
								}else {
									_copy.find('input[name="itemRadio"]').attr({
										'data-price': l[i].sku_price,
										'data-spu': l[i].spu_id,
										'data-sku': l[i].sku_id,
										'time-state': time_state
									});
								}
								if(l[i].goods_state == 2) {
									_copy.children('li.aui-list-item').addClass('invalid-item');
									var invalidMask = $('<div class="invalid-mask" />'),
										invalidText = $('<div class="invalid-text" />').text('已失效');
									_copy.find('.good-img').after(invalidMask, invalidText);
								}
								_copy.find('.delivery_time').text(time_text);
								_copy.find('.good-img').attr('src', l[i].goods_img);
								_copy.find('.good-name').text(l[i].goods_name);
								_copy.find('.good-price').text(l[i].sku_price);
								_copy.find('.good-price-area').text(l[i].spec);
								$('.good-list').append(_copy.html());
							}
		
    						module.checkAll();
    						module.itemSelectEvt();
						}else{
							var _empty = $('<img src="'+localStorage.localStorage_url+'img_empty.png" />').addClass('empty-img');
		    				var _text = $('<div />').addClass('empty-text').text('亲，购物车空瘪瘪的，赶快去添加商品吧');
		    				$('.ys-shopping-car .good-list').append(_empty, _text).css('background-color', '#f5f5f5');
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function() {
					$('.zhezhao').remove();
					alert('网络错误，请刷新重试');
				}
			});
		}
	};
	return {
		init: module.init
	}
}(jQuery));

// 优惠券列表页
var Coupon = (function(){
	var state = [1,2]; //1为未使用，2为已过期
	var couponStatus = {
		'1': '未使用',
		'2': '已使用',
		'3': '已失效'
	};
	var member_id;
	var module = {
		init: function() {
			member_id = $('input[name="member_id"]').val();
			member_id ? localStorage.setItem('member_id', member_id) : member_id = localStorage.member_id;
			module.getCouponList(state[0]);
			module.tabSelectEvt();
		},

		// 优惠券tab选择事件
		tabSelectEvt: function() {
			var tab = new auiTab({
		        element:document.getElementById("tab")
		    },function(ret){
		        if(ret) {
		           var _index = ret.index;
		          module.getCouponList(_index);
		        }
		    });
		},

		// 判断对象是否为空
		isEmptyObject: function(e) {  
		    var t;  
		    for (t in e)  
		        return !1;  
		    return !0  
		},

		//获取优惠券列表
		getCouponList: function(s) {
			var data = {'member_id': member_id, 'state': s},
				info = mergeInfo('get_member_voucher', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {
					$('.ys-coupon .aui-list').children().remove();
					var load = createLoadDom('coupon');
					$('.ys-coupon .aui-list').append(load);
				},
				success: function(data) {
					$('.loading-coupon').remove();
					var code = data.errcode;
					if(code == 1) {
						var d = data.data;
						if(!module.isEmptyObject(d)) {
							var list = d.list;
							for(var i in list) {
								var _copy = $('.copy-item').clone(true);
								var rangeText = '';
								_copy.find('.voucher_price').text(list[i].voucher_price);
								if(list[i].voucher_type == 1) {
									rangeText = '全店配餐均可使用';
								}else if(list[i].voucher_type == 2) {
									var goods_info = list[i].goods_info;
									rangeText = '仅限于';
									for(var j in goods_info) {
										if(j ==  (goods_info.length-1)) {
											rangeText += goods_info[j].goods_name;
										}else{
											rangeText += goods_info[j].goods_name + '、';
										}	
									}
								}
								_copy.find('.coupon-range').text(list[i].voucher_name);
								_copy.find('.coupon-limit-info').text(rangeText);
								_copy.find('.coupon-start-date').text(list[i].start_time);
								_copy.find('.coupon-end-date').text(list[i].end_time);
								if(s == 2) {
									var coupon_state = $('<p class="coupon-state" />').text(couponStatus[list[i].state]);
									_copy.find('.coupon-limit').after(coupon_state);
									_copy.find('.coupon-demonation,.coupon-limit, .coupon-range, .coupon-limit-info, .coupon-limit-date-title, .coupon-limit-date').addClass('disabled');
								}
								$('.ys-coupon .aui-list').append(_copy.html());
							}
						}else{
							var _empty = $('<img src="'+localStorage.localStorage_url+'img_empty.png" />').addClass('empty-img');
		    				var _text = $('<div />').addClass('empty-text').text('亲，你还未拥有优惠券哦');
		    				$('.ys-coupon .aui-list').append(_empty, _text);
						}
					}else{
						alert(data.errmsg);
					}
				},
				error: function(data) {
					$('.loading-coupon').remove();
					alert('网络错误，请刷新重试');
				}
			});
		}
	};
	return {
		init: module.init
	}
}(jQuery));

// 退款
var Refund = (function($){
	var module = {
		init: function() {
			module.jumpToApply();
		},

		// 跳转申请退款页面
		jumpToApply: function() {
			$('.apply-refund-btn').click(function(){
				gotoLocation($(this).attr('data-url'), '');
			})
		},

		tabSelectEvt: function(){
			$('#footer>.aui-bar-tab-item').bind('click', function(i){
            	if($(this).hasClass('aui-active')) {
            		return;
            	}else{
            		var _index = $(this).index();
            		gotoLocation(urlArr[_index], '');
            	}
        	})
		}
	};
	return {
		init: module.init
	}
}(jQuery));

// 预订成功页
var OrderSuccess = (function($){
	var module = {
		init: function() {
			$('.order-no').text(getParams('order_sn'));
			$('.see-order-btn').click(function(){
				gotoLocation($(this).attr('data-url'), '');
			});
		}
	};
	return {
		init: module.init
	}
}(jQuery));

// 微信支付
var WXpay = (function($){
	var module = {
		init: function() {
			module.changeOrderState();
		},

		// 更改支付状态
		changeOrderState: function() {
			var order_sn = getParams('order_sn');
			var data = {'order_sn': order_sn},
				info = mergeInfo('change_temp_order_state', data);
			$.ajax({
				type: 'POST',
				url: apiUrl,
				data: JSON.stringify(info),
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				beforeSend: function() {},
				success: function(data) {},
				error: function(data) {}
			});
		}
	};
	return {
		init: module.init
	}
}(jQuery));

// footer部分
var Footer = (function($){
	var module = {
		init: function() {
			module.tabSelectEvt();
		},

		tabSelectEvt: function(){
			$('#footer>.aui-bar-tab-item').bind('click', function(i){
            	if($(this).hasClass('aui-active')) {
            		return;
            	}else{
            		var _index = $(this).index();
            		gotoLocation(urlArr[_index], '');
            	}
        	})
		}
	};
	return {
		init: module.init
	}
}(jQuery));
