//
//  ZZPayAliPayOrder.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/17.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPay_APOrderInfo.h"
//支付宝处理model
@interface ZZPayAliPayOrder : ZZPay_APOrderInfo
//
//@property(nonatomic, retain)ZZPay_APOrderInfo *model;
//签名
@property(nonatomic, copy)NSString* sign;
//URL types 下的 URL Scheme
@property(nonatomic, copy)NSString* appScheme;

// 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
// 如果商户两个都设置了，优先使用 rsa2PrivateKey
// rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
// 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
// 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
@property(nonatomic, copy)NSString* rsa2PrivateKey;// = @"";
@property(nonatomic, copy)NSString* rsaPrivateKey;// = @"";


#pragma mark 把参数拼接成订单字符串(不包括sign)
-(NSString*)toOrderString_orderInfoEncoded;
#pragma mark 把参数拼接成订单字符串(包括sign)
-(NSString*)toOrderString;


#pragma mark   ==============产生随机订单号==============
+(NSString *)generateTradeNO;


@end
