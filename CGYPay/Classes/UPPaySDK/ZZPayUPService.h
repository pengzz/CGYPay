//
//  ZZPayUPService.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZBasePay.h"
#import "UPPaymentControl.h"
#import "ZZPayUpOrder.h"
#import "ZZPayConstant.h"

@interface ZZPayUPService :ZZBasePay
NSSingletonH(Instance)
@property(nonatomic, copy)ZZPayCompleteBlock payCallBack;
#pragma mark - 银联支付
// 发送银联支付
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayUpOrder*)order callBack:(ZZPayCompleteBlock)callback;

#pragma mark - 从微信客户端返回
- (void) handleOpenURL:(NSURL *)url;

@end
