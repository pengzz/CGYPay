//
//  ZZPayAliPayOrder.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/17.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayAliPayOrder.h"
#import <AlipaySDK/AlipaySDK.h>//TO DO

@implementation ZZPayAliPayOrder

#pragma mark 把参数拼接成订单字符串(不包括sign)
-(NSString*)toOrderString_orderInfoEncoded
{
    NSString *appScheme = self.appScheme;
    if(appScheme==nil){
        //BundleID//调用支付的app注册在info.plist中的scheme
        appScheme = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    }

    ZZPay_APOrderInfo* order = self;
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = self.sign;
    if(signedString==nil){//pzz加判断
        Class classType=NSClassFromString(@"ZZPay_APRSASigner");
        if (classType) {
//            ZZPay_APRSASigner* signer = [[ZZPay_APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//            if ((rsa2PrivateKey.length > 1)) {
//                signedString = [signer signString:orderInfo withRSA2:YES];
//            } else {
//                signedString = [signer signString:orderInfo withRSA2:NO];
//            }
        }
    }
    
//    // NOTE: 如果加签成功，则继续执行支付
//    if (signedString != nil) {
//        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfoEncoded, signedString];
//        //return orderString;
//    }
    
    return orderInfoEncoded;
}
#pragma mark 把参数拼接成订单字符串(包括sign)
-(NSString*)toOrderString
{
    ZZPay_APOrderInfo* order = self;
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = self.sign;
    if(signedString==nil){//pzz加判断
        Class classType=NSClassFromString(@"ZZPay_APRSASigner");
        if (classType) {
//            ZZPay_APRSASigner* signer = [[ZZPay_APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//            if ((rsa2PrivateKey.length > 1)) {
//                signedString = [signer signString:orderInfo withRSA2:YES];
//            } else {
//                signedString = [signer signString:orderInfo withRSA2:NO];
//            }
        }
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        return orderString;
    }
    return nil;
}

#pragma mark   ==============产生随机订单号==============
+(NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}









#pragma mark   ==============点击订单模拟支付行为==============
#pragma mark   ==============点击订单模拟支付行为==============
//
// 选中商品调用支付宝极简支付
//
- (void)doAPPay
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        //        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
        //                                                                       message:@"缺少appId或者私钥,请检查参数设置"
        //                                                                preferredStyle:UIAlertControllerStyleAlert];
        //        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
        //                                                         style:UIAlertActionStyleDefault
        //                                                       handler:^(UIAlertAction *action){
        //
        //                                                       }];
        //        [alert addAction:action];
        //        [self presentViewController:alert animated:YES completion:^{ }];
        //        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    ZZPay_APOrderInfo* order = [ZZPay_APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [ZZPay_APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [ZZPayAliPayOrder generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    if(0){
//        ZZPay_APRSASigner* signer = [[ZZPay_APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//        if ((rsa2PrivateKey.length > 1)) {
//            signedString = [signer signString:orderInfo withRSA2:YES];
//        } else {
//            signedString = [signer signString:orderInfo withRSA2:NO];
//        }
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}



@end
