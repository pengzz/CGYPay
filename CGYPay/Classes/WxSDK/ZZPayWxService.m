//
//  ZZPayWxService.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayWxService.h"
#import <UIKit/UIKit.h>

//Show Error 上的按钮文字
static NSString* const kCancleWordingText = @"知道了";
//Show Error
#define ADShowErrorAlert(wording)                               \
[[[UIAlertView alloc] initWithTitle:nil                 \
message:wording             \
delegate:nil                 \
cancelButtonTitle:kCancleWordingText  \
otherButtonTitles:nil] show]

//1.判断是否安装微信
static NSString* const kWXNotInstallErrorTitle = @"您尚未安装\"微信App\",请先安装后再返回支付";
//2.判断微信的版本是否支持最新Api
static NSString* const kWXNotSupportErrorTitle = @"您微信当前版本不支持此功能,请先升级微信应用";



@implementation ZZPayWxService
NSSingletonM(Instance)

//注册微信
- (void)registerWxAPP:(NSString*)appid {
    [WXApi registerApp:appid];
}

// 发送微信支付
-(void)sendPay:(ZZPayChannel)channel order:(ZZPayWxOrder*)order callBack:(ZZPayCompleteBlock)callback {
    self.payCallBack = callback;
    if(channel==ZZPayChannel_weixin){
        //1.判断是否安装微信
        if (![WXApi isWXAppInstalled]) {
            ADShowErrorAlert(kWXNotInstallErrorTitle);
            return;
        }
        //2.判断微信的版本是否支持最新Api
        if (![WXApi isWXAppSupportApi]) {
            ADShowErrorAlert(kWXNotSupportErrorTitle);
            return;
        }
        
        //微信文档参考
        //https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=8_5
        //https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12
        //其它参考方法
        //http://www.2cto.com/kf/201505/403114.html
        //http://www.jianshu.com/p/af8cbc9d51b0
        
        //    请求参数
        //    字段名    变量名    类型    必填    示例值    描述
        //    应用ID    appid    String(32)    是    wx8888888888888888    微信开放平台审核通过的应用APPID
        //    商户号    partnerid    String(32)    是    1900000109    微信支付分配的商户号
        //    预支付交易会话ID    prepayid    String(32)    是    WX1217752501201407033233368018    微信返回的支付交易会话ID
        //    扩展字段    package    String(128)    是    Sign=WXPay    暂填写固定值Sign=WXPay
        //    随机字符串    noncestr    String(32)    是    5K8264ILTKCH16CQ2502SI8ZNMTM67VS    随机字符串，不长于32位。推荐随机数生成算法
        //    时间戳    timestamp    String(10)    是    1412000000    时间戳，请见接口规则-参数规定
        //    签名    sign    String(32)    是    C380BEC2BFD727A4B6845133519F3AD6    签名，详见签名生成算法
        
        // 发起微信支付，设置参数
        PayReq *request = [[PayReq alloc] init];
        //request.openID = appid;//官方文档上没有这一行
        request.partnerId = order.partnerId;
        request.prepayId= order.prepayId;
        request.package = order.package?order.package:@"Sign=WXPay";
        request.nonceStr= order.nonceStr;
        request.timeStamp= [order.timeStamp intValue];
        
        // 签名加密
        request.sign = order.sign;
        
        // 调用微信
        [WXApi sendReq:request];//return [WXApi sendReq:request];
    }
}


#pragma mark - WXApiDelegate
-(void)onReq:(BaseReq*)req {
    // just leave it here, WeChat will not call our app
    NSLog(@"onReq:req==%@",req);
}

-(void)onResp:(BaseResp*)resp {
    NSLog(@"onResp:resq==%@",resp);
    // 其他微信的响应, 可以在这里添加...
    //认证
    if([resp isKindOfClass:[SendAuthResp class]]) {
//        SendAuthResp* authResp = (SendAuthResp*)resp;
//        /* Prevent Cross Site Request Forgery */
//        if (![authResp.state isEqualToString:self.authState]) {
//            if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthDenied)])
//                [self.delegate wxAuthDenied];
//            return;
//        }
//
//        switch (resp.errCode) {
//            case WXSuccess:
//                NSLog(@"RESP:code:%@,state:%@\n", authResp.code, authResp.state);
//                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthSucceed:)])
//                    [self.delegate wxAuthSucceed:authResp.code];
//                break;
//            case WXErrCodeAuthDeny:
//                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthDenied)])
//                    [self.delegate wxAuthDenied];
//                break;
//            case WXErrCodeUserCancel:
//                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthCancel)])
//                    [self.delegate wxAuthCancel];
//            default:
//                break;
//        }
    }
    //支付返回回调处理：
    if ([resp isKindOfClass:[PayResp class]]){
        [self payResponseParse:(PayResp*)resp];
        //0     成功    展示成功页面
        //-1 错误    可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
        //-2 用户取消    无需处理。发生场景：用户不支付了，点击取消，返回APP。
        //:如果支付成功则去后台查询支付结果再展示用户实际支付结果。注意    一定不能以客户端返回作为用户支付的结果，应以服务器端的接收的支付通知或查询API返回的结果为准。
    }
}

// 处理支付结果
- (void)payResponseParse:(PayResp*)payResp {
    ZZPayStatusCode payStatus;
    switch (payResp.errCode) {
        case WXSuccess:
            payStatus = ZZPayStatusCode_PaySuccess;
        case WXErrCodeUserCancel:
            payStatus = ZZPayStatusCode_PayErrCodeUserCancel;
        case WXErrCodeSentFail:
            payStatus = ZZPayStatusCode_PayErrSentFail;
        case WXErrCodeAuthDeny:
            payStatus = ZZPayStatusCode_PayErrAuthDeny;
        case WXErrCodeUnsupport:
            payStatus = ZZPayStatusCode_PayErrWxUnsupport;
        default:
            payStatus = ZZPayStatusCode_PayErrUnKnown;
    }
    !self.payCallBack?:self.payCallBack(payStatus, ZZPayChannel_weixin, payResp.returnKey);
}

#pragma mark - 从微信客户端返回
- (void) handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:self];
    }
}

@end
