//
//  ZZPay.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZPayConstant.h"//TO DO

@interface ZZPay : NSObject

/**
 调起支付
 
 - parameter channel:  支付渠道//TO DO
 - parameter callBack: 支付回调
 */
//public class func createPayment(channel: CGYPayChannel, callBack: CGYPayCompletedBlock);
-(void)createPayment:(ZZPayChannel)channel order:(id)order callBack:(ZZPayCompleteBlock)callBack;

/**
从APP返回时执行的回调

- parameter url: url

- returns:
*/
//public class func handlerOpenURL(url: NSURL) -> Bool;

/**
 注册微信
 
 - parameter appid: appid
 */
//public class func registerWxAPP;//

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



@end
