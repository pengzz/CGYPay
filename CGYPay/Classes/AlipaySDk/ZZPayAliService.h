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

@interface ZZPayAliService : ZZBasePay
NSSingletonH(Instance)
@property(nonatomic, copy)ZZPayCompleteBlock payCallBack;

// 发送支付宝支付
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayAliPayOrder*)order callBack:(ZZPayCompleteBlock)callback;
//新方法：增加直接传orderString方法
-(void)sendPay:(ZZPayChannel)channel orderStr:(NSString*)orderStr fromScheme:(NSString *)schemeStr callBack:(ZZPayCompleteBlock)callback;

#pragma mark - 从支付宝返回到app
- (void) handleOpenURL:(NSURL *)url;

@end
