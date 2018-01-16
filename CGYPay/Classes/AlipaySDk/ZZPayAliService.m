//
//  ZZPayAliService.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayAliService.h"

@implementation ZZPayAliService
//NSSingletonM(Instance)//sharedInstance

// 发送支付宝支付
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayAliPayOrder*)order callBack:(ZZPayCompleteBlock)callback;
{
    self.payCallBack = callback;
    if(channel==ZZPayChannel_aliPay){
        NSString *orderString = [order toOrderString];
        @weakify(self)
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:order.appScheme callback:^(NSDictionary *resultDic) {
            @strongify(self)
            NSLog(@"----- %@",resultDic);
            ZZPayStatusCode payStatus = [self aliPayResultHandler:resultDic];
            NSString *aliPayResult = [resultDic[@"result"] stringValue];
            !self.payCallBack?:self.payCallBack(payStatus, ZZPayChannel_aliPay, aliPayResult);
        }];
    }
}
//override
//public func sendPay(channel: CGYPayChannel, callBack: @escaping CGYPayCompletedBlock) {
//    payCallBack = callBack
//    if case .aliPay(let order) = channel {
//        AlipaySDK.defaultService().payOrder(order.toOrderString(), fromScheme: order.appScheme, callback: { [unowned self] resultDic in
//            if let dic = resultDic as? [String:AnyObject] {
//                let payStatus = self.aliPayResultHandler(resultDic: dic)
//                self.payCallBack?(payStatus)
//            }
//        })
//    }
//}

/**
 支付宝支付返回的结果处理
 
 - parameter resultDic: 支付宝返回的结果
 
 - returns: 返回处理结果
 */
-(ZZPayStatusCode)aliPayResultHandler:(NSDictionary*)resultDic
{
    ZZPayStatusCode payStatus;
    switch ([(NSNumber*)resultDic[@"resultStatus"] intValue]) {
    case 9000:
            payStatus = ZZPayStatusCode_PaySuccess;//(wxPayResult: nil, aliPayResult: resultDic["result"]?.stringValue, upPayResult: nil)
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



/**
 从支付宝返回到app
 
 - parameter url: url
 */
//override public func handleOpenURL(url: NSURL) {
//    guard url.host == "safepay" || url.host == "platformapi" else { return }
//    AlipaySDK.defaultService().processOrder(withPaymentResult: url as URL!, standbyCallback: { [unowned self] resultDic in
//        if let dic = resultDic as? [String:AnyObject] {
//            let payStatus = self.aliPayResultHandler(resultDic: dic)
//            self.payCallBack?(payStatus)
//        }
//    })
//}

/**
 从支付宝返回到app
 
 - parameter url: url
 */
- (void) handleOpenURL:(NSURL *) url
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
            NSString *aliPayResult = [resultDic[@"result"] stringValue];
            !self.payCallBack?:self.payCallBack(payStatus, ZZPayChannel_aliPay, aliPayResult);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            @strongify(self)
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
    } //([url.host isEqualToString:@"pay"]) //微信支付
    //return [WXApi handleOpenURL:url delegate:self];
//    return YES;//pzz去掉
}

@end
