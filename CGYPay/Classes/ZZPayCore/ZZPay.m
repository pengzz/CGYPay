//
//  ZZPay.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPay.h"

@implementation ZZPay
/**
 调起支付
 
 - parameter channel:  支付渠道
 - parameter callBack: 支付回调
 */
+(void)createPayment:(ZZPayChannel)channel order:(id)order callBack:(ZZPayCompleteBlock)callBack
{
    switch (channel) {
        case ZZPayChannel_aliPay:
            {
                if([ZZPay aliPay]){
                    [[ZZPay aliPay] sendPay:channel order:order callBack:callBack];
                }else{
                    callBack(ZZPayStatusCode_PayErrSDKNotFound,ZZPayChannel_aliPay,nil);
                }
            }
            break;
        case ZZPayChannel_weixin:
        {
            if([ZZPay wxPay]){
                [[ZZPay wxPay] sendPay:channel order:order callBack:callBack];
            }else{
                callBack(ZZPayStatusCode_PayErrSDKNotFound,ZZPayChannel_weixin,nil);
            }
        }
            break;
        case ZZPayChannel_upPay:
        {
            if([ZZPay upPay]){
                [[ZZPay upPay] sendPay:channel order:order callBack:callBack];
            }else{
                callBack(ZZPayStatusCode_PayErrSDKNotFound,ZZPayChannel_upPay,nil);
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - 从APP返回时执行的回调:handleOpenURL
+(BOOL)handleOpenURL:(NSURL*)url
{
    if([ZZPay aliPay]){
        [[ZZPay aliPay] handleOpenURL:url];
    }
    if([ZZPay wxPay]){
        [[ZZPay wxPay] handleOpenURL:url];
    }
    if([ZZPay upPay]){
        [[ZZPay upPay] handleOpenURL:url];
    }
    return YES;
}

#pragma mark - 注册微信
-(void)registerWxAPP:(NSString*)appid {
    if([ZZPay wxPay]){
        [[ZZPay wxPay] registerWxAPP:appid];
    }
}

#pragma mark - 三种支付单例获取
//// 银联支付
//private static var upPay: BaseCGYPay? = {
//    let upPayType = NSObject.cgy_classFromString(className: "CGYPayUPService") as? BaseCGYPay.Type
//    return upPayType?.sharedInstance
//}()
//// 微信支付
//private static var wxPay: BaseCGYPay? = {
//    let wxPayType = NSObject.cgy_classFromString(className: "CGYPayWxService") as? BaseCGYPay.Type
//    return wxPayType?.sharedInstance
//}()
//// 支付宝支付
//private static var aliPay: BaseCGYPay? = {
//    let aliPayType = NSObject.cgy_classFromString(className: "CGYPayAliService") as? BaseCGYPay.Type
//    return aliPayType?.sharedInstance
//}()

//支付宝支付
+(ZZBasePay*)aliPay {
    ZZBasePay* sharedInstance = nil;
    Class classType = [NSObject zz_classFromString:@"ZZPayAliService"];
    if(classType){
        //if([classType isKindOfClass:[ZZBasePay class]]){
            sharedInstance = [classType sharedInstance];
        //}
    }else{
        sharedInstance = nil;
    }
    return sharedInstance;
    //下面这个或许理简单
//    if(2-2){
//       ZZBasePay* sharedInstance = nil;
//        Class classType=NSClassFromString(@"ZZPayAliService");
//        if (classType) {
//            sharedInstance = [classType sharedInstance];
//        }else{
//            sharedInstance = nil;
//        }
//        return sharedInstance;
//    }
}
//微信支付
+(ZZBasePay*)wxPay {
    ZZBasePay* sharedInstance = nil;
    Class classType=NSClassFromString(@"ZZPayWxService");
    if (classType) {
        sharedInstance = [classType sharedInstance];
    }else{
        sharedInstance = nil;
    }
    return sharedInstance;
}

//银联支付
+(ZZBasePay*)upPay {
    ZZBasePay* sharedInstance = nil;
    Class classType=NSClassFromString(@"ZZPayUPService");
    if (classType) {
        sharedInstance = [classType sharedInstance];
    }else{
        sharedInstance = nil;
    }
    return sharedInstance;
}


@end
