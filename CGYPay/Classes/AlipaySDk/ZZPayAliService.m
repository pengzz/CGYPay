//
//  ZZPayAliService.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayAliService.h"

@implementation ZZPayAliService
NSSingletonM(Instance)

//发送支付宝支付
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayAliPayOrder*)order callBack:(ZZPayCompleteBlock)callback
{
    self.payCallBack = callback;
    if(channel==ZZPayChannel_aliPay){
        NSString *orderString = [order toOrderString];
        @weakify(self)
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:order.appScheme callback:^(NSDictionary *resultDic) {
            @strongify(self)
            NSLog(@"----- %@",resultDic);
            ZZPayStatusCode payStatus = [self aliPayResultHandler:resultDic];
            NSString *aliPayResult = resultDic[@"result"];
            !self.payCallBack?:self.payCallBack(payStatus, ZZPayChannel_aliPay, aliPayResult);
        }];
    }
}
//新方法：增加直接传orderString方法
-(void)sendPay:(ZZPayChannel)channel orderStr:(NSString*)orderStr fromScheme:(NSString *)schemeStr callBack:(ZZPayCompleteBlock)callback
{
    self.payCallBack = callback;
    if(!schemeStr){//调用支付的app注册在info.plist中的scheme
        schemeStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    }
    if(channel==ZZPayChannel_aliPay){
        NSString *orderString = orderStr;
        @weakify(self)
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:schemeStr callback:^(NSDictionary *resultDic) {
            @strongify(self)
            NSLog(@"----- %@",resultDic);
            ZZPayStatusCode payStatus = [self aliPayResultHandler:resultDic];
            NSString *aliPayResult = resultDic[@"result"];
            !self.payCallBack?:self.payCallBack(payStatus, ZZPayChannel_aliPay, aliPayResult);
        }];
    }
}

//支付宝支付返回的结果处理
-(ZZPayStatusCode)aliPayResultHandler:(NSDictionary*)resultDic
{
    ZZPayStatusCode payStatus;
    switch ([(NSNumber*)resultDic[@"resultStatus"] intValue]) {
    case 9000:
            payStatus = ZZPayStatusCode_PaySuccess;
    case 8000:
            payStatus = ZZPayStatusCode_PayProcessing;
    case 4000:
            payStatus = ZZPayStatusCode_PayErrPayFail;
    case 6001:
            payStatus = ZZPayStatusCode_PayErrCodeUserCancel;
    case 6002:
            payStatus = ZZPayStatusCode_PayErrNetWorkFail;
    default:
            payStatus = ZZPayStatusCode_PayErrUnKnown;
    }
    return payStatus;
}

#pragma mark - 从支付宝返回到app
- (void) handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]
        ||[url.host isEqualToString:@"platformapi"]//这一行是干什么的？pzz
        )
    {
        @weakify(self)
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            @strongify(self)
            NSLog(@"----- %@",resultDic);
            ZZPayStatusCode payStatus = [self aliPayResultHandler:resultDic];
            NSString *aliPayResult = resultDic[@"result"];
            !self.payCallBack?:self.payCallBack(payStatus, ZZPayChannel_aliPay, aliPayResult);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            //@strongify(self)
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
//        return YES;//pzz去掉
    }
//    return YES;//pzz去掉
}

@end
