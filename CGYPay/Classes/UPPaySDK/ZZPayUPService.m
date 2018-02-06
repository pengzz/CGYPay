//
//  ZZPayUPService.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayUPService.h"

@implementation ZZPayUPService
NSSingletonM(Instance)

// 发送微信支付
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayUpOrder*)order callBack:(ZZPayCompleteBlock)callback {
    self.payCallBack = callback;
    if(channel==ZZPayChannel_weixin){
        if(!order.appScheme){//调用支付的app注册在info.plist中的scheme
            order.appScheme = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        }
        [[UPPaymentControl defaultControl] startPay:order.tn fromScheme:order.appScheme mode:order.mode viewController:order.viewController];
    }
}

#pragma mark - 从微信客户端返回
- (void) handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"uppayresult"]) {
        __weak typeof(self) _self = self;
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            __strong typeof(_self) self = _self;
            ZZPayStatusCode payStatus;
            if([code isEqualToString:@"success"]){
                payStatus = ZZPayStatusCode_PaySuccess;
            }else if([code isEqualToString:@"cancel"]){
                payStatus = ZZPayStatusCode_PayErrCodeUserCancel;
            }else if([code isEqualToString:@"fail"]){
                payStatus = ZZPayStatusCode_PayErrPayFail;
            }else {
                payStatus = ZZPayStatusCode_PayErrUnKnown;
            }
            !self.payCallBack?:self.payCallBack(payStatus, ZZPayChannel_upPay, data);
        }];
    }
}

@end
