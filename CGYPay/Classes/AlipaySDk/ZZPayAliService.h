//
//  ZZPayAliService.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZBasePay.h"
#import <AlipaySDK/AlipaySDK.h>//TO DO
#import "ZZPayAliPayOrder.h"
#import "ZZPayConstant.h"//TO DO
//#import "ZZPay.h"

//@interface ZZPayAliService : NSObject//BaseZZPay
@interface ZZPayAliService : ZZBasePay
//NSSingletonH(Instance)//sharedInstance
@property(nonatomic, copy)ZZPayCompleteBlock payCallBack;

// 发送支付宝支付
//-(void)sendPay:(ZZPayChannel)channel callBack:(ZZPayCompleteBlock)callback;
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayAliPayOrder*)order callBack:(ZZPayCompleteBlock)callback;
/**
 从支付宝返回到app
 
 - parameter url: url
 */
-(void)handleOpenURL:(NSURL*)url;

///**
// 支付宝支付返回的结果处理
//
// - parameter resultDic: 支付宝返回的结果
//
// - returns: 返回处理结果
// */
//private func aliPayResultHandler(resultDic: [String:AnyObject]) -> CGYPayStatusCode;//


@end
