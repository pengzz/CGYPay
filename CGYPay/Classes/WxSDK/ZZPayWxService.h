//
//  ZZPayWxService.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZBasePay.h"
#import <UIKit/UIKit.h>//下面导入的WXApi中有用到UIViewController，需要导入UIKit
#import "WXApi.h"
#import "ZZPayWxOrder.h"
#import "ZZPayConstant.h"

@interface ZZPayWxService : ZZBasePay <WXApiDelegate>
NSSingletonH(Instance)
@property(nonatomic, copy)ZZPayCompleteBlock payCallBack;
//注册微信
- (void)registerWxAPP:(NSString*)appid;
#pragma mark - 微信支付
// 发送微信支付
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayWxOrder*)order callBack:(ZZPayCompleteBlock)callback;

#pragma mark - 从微信客户端返回
- (void) handleOpenURL:(NSURL *)url;

@end
