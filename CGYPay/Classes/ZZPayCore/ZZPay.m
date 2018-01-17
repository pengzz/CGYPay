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
//public class func createPayment(channel: CGYPayChannel, callBack: CGYPayCompletedBlock) {
//    switch channel {
//    case .weixin:
//        if let wxPay = wxPay {
//            wxPay.sendPay(channel: channel, callBack: callBack)
//        } else {
//            callBack(.PayErrSDKNotFound)
//        }
//    case .aliPay:
//        if let aliPay = aliPay {
//            aliPay.sendPay(channel: channel, callBack: callBack)
//        } else {
//            callBack(.PayErrSDKNotFound)
//        }
//    case .upPay:
//        if let upPay = upPay {
//            upPay.sendPay(channel: channel, callBack: callBack)
//        } else {
//            callBack(.PayErrSDKNotFound)
//        }
//    }
//}
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
//            if let wxPay = wxPay {
//                wxPay.sendPay(channel: channel, callBack: callBack)
//            } else {
//                callBack(.PayErrSDKNotFound)
//            }
        }
            break;
        case ZZPayChannel_upPay:
        {
//            if let upPay = upPay {
//                upPay.sendPay(channel: channel, callBack: callBack)
//            } else {
//                callBack(.PayErrSDKNotFound)
//            }
        }
            break;
        default:
            break;
    }
}

/**
 从APP返回时执行的回调

 - parameter url: url

 - returns:
 */
//public class func handlerOpenURL(url: NSURL) -> Bool {
//    if let wxPay = wxPay {
//        wxPay.handleOpenURL(url: url)
//    }
//    if let aliPay = aliPay {
//        aliPay.handleOpenURL(url: url)
//    }
//    if let upPay = upPay {
//        upPay.handleOpenURL(url: url)
//    }
//    return true
//}

//public class func handlerOpenURL(url: NSURL) -> Bool
+(BOOL)handleOpenURL:(NSURL*)url
{
    if([ZZPay aliPay]){
        [[ZZPay aliPay] handleOpenURL:url];
    }
//    if let wxPay = wxPay {
//        wxPay.handleOpenURL(url: url)
//    }
//    if let upPay = upPay {
//        upPay.handleOpenURL(url: url)
//    }
    return YES;
}

/**
 注册微信

 - parameter appid: appid
 */
//public class func registerWxAPP(appid: String) {
//    if let wxPay = wxPay {
//        wxPay.registerWxAPP(appid: appid)
//    }
//}
-(void)registerWxAPP:(NSString*)appid
{
    //    if let wxPay = wxPay {
    //        wxPay.registerWxAPP(appid: appid)
    //    }
}

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


// 银联支付
//private static var upPay: BaseCGYPay? = {
//+(BaseZZPay2*)upPay
//{
//    id sharedInstance = ({
//        Class upPayType = (BaseZZPay2*)[NSObject zz_classFromString(className: "ZZPayUPService")];
//        if(upPayType){
//            return [upPayType sharedInstance];
//        }else{
//            return nil;
//        }
//    });
//}
// 微信支付
//private static var wxPay: BaseCGYPay? = {
//    let wxPayType = NSObject.cgy_classFromString(className: "CGYPayWxService") as? BaseCGYPay.Type
//    return wxPayType?.sharedInstance
//}()
// 支付宝支付
//private static var aliPay: BaseCGYPay? = {
//    let aliPayType = NSObject.cgy_classFromString(className: "CGYPayAliService") as? BaseCGYPay.Type
//    return aliPayType?.sharedInstance
//}()
+(ZZBasePay*)aliPay
{
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

@end
