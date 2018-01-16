//
//  ZZPayAliPayOrder.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>
//支付宝处理model
@interface ZZPayAliPayOrder : NSObject
/**
 *  支付宝订单
 */

/// 商家id（以2088开头的16位纯数字组成）
@property(nonatomic, copy)NSString* partner;
/// 支付宝账号
@property(nonatomic, copy)NSString* seller_id;
/// 订单号
@property(nonatomic, copy)NSString* out_trade_no;
/// 商品名称（该参数最长为128个汉字）
@property(nonatomic, copy)NSString* subject;
/// 商品详情
@property(nonatomic, copy)NSString* body;
/// 总金额（精确到小数点后两位）
@property(nonatomic, copy)NSString* total_fee;
/// 服务器异步通知页面路径（支付宝服务器主动通知商户网站里指定的页面http路径）
@property(nonatomic, copy)NSString* notify_url;
/// 接口名称（固定值：mobile.securitypay.pay）
@property(nonatomic, copy)NSString* service;
/// 支付类型（默认值为：1（商品购买））
@property(nonatomic, copy)NSString* payment_type;
/// 参数编码字符集（固定值：utf-8）
@property(nonatomic, copy)NSString* input_charset;
/// 签名
@property(nonatomic, copy)NSString* sign;
/// 签名方式（目前仅支持RSA）
@property(nonatomic, copy)NSString* sign_type;
/// URL types 下的 URL Scheme
@property(nonatomic, copy)NSString* appScheme;
// ------------------ 以下字段可以为空 ---------------------
/// 未付款交易的超时时间
@property(nonatomic, copy)NSString* it_b_pay;
/// appid
@property(nonatomic, copy)NSString* app_id;
/// 客户端来源
@property(nonatomic, copy)NSString* appenv;
/// 商品类型
@property(nonatomic, copy)NSString* goods_type;
/// 是否发起实名校验
@property(nonatomic, copy)NSString* rn_check;
/// 授权令牌
@property(nonatomic, copy)NSString* extern_token;
/// 商户业务扩展参数
@property(nonatomic, copy)NSString* out_context;


//init方法
-(instancetype)initWith_partner:(NSString*)partner
                      seller_id:(NSString*)seller_id
                   out_trade_no:(NSString*)out_trade_no
                        subject:(NSString*)subject
                           body:(NSString*)body
                      total_fee:(NSString*)total_fee
                     notify_url:(NSString*)notify_url
                   payment_type:(NSString*)payment_type//=@"1"//: String = "1",
                           sign:(NSString*)sign
                      appScheme:(NSString*)appScheme;
/**
 把参数拼接成订单字符串
 
 - returns: 调起支付的订单字符串
 */
-(NSString*)toOrderString;



#pragma mark - 222222222222222222222222222222222222
/**
 *  获取订单信息串
 *
 *  @param bEncoded       订单信息串中的各个value是否encode
 *                        非encode订单信息串，用于生成签名
 *                        encode订单信息串 + 签名，用于最终的支付请求订单信息串
 */
- (NSString *)orderInfoEncoded:(BOOL)bEncoded;

@end
