//
//  ZZPayConstant.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

//#import <Foundation/Foundation.h>

#ifndef ZZPay_Constant_h
#define ZZPay_Constant_h

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#pragma mark -单位处理代码
// .h文件
#define NSSingletonH(name) + (instancetype)shared##name;
// .m文件
#define NSSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}



/**
 支付通道
 - weixin: 微信支付
 - aliPay: 支付宝支付
 - upPay:  银联支付
 */
typedef NS_ENUM(NSUInteger, ZZPayChannel) {
    /**
     *  微信支付
     *
     *  @param CGYPayWxOrder 订单
     */
    ZZPayChannel_weixin = 0,
    /**
     *  支付宝
     *
     *  @param CGYPayAliPayOrder 订单
     */
    ZZPayChannel_aliPay = 1,
    /**
     *  银联支付
     *
     *  @param CGYPayUpOrder 订单
     */
    ZZPayChannel_upPay = 2,
};

/**
 支付状态码
 - PaySuccess:           支付成功
 - PayProcessing:        正在处理
 - PayErrCodeUserCancel: 用户取消支付
 - PayErrSentFail:       发送失败
 - PayErrAuthDeny:       授权失败
 - PayErrPayFail:        支付失败
 - PayErrWxUnsupport:    微信不支持
 - PayErrWxUnInstall:    微信未安装
 - PayErrNetWorkFail:    网络错误
 - PayErrSDKNotFound:    SDK没有导入
 - PayErrUnKnown:        未知错误
 */
typedef NS_ENUM(NSUInteger, ZZPayStatusCode) {
    /**
     *  支付成功
     *
     *  @param wxPayResult  微信支付结果
     *  @param aliPayResult 支付宝支付结果
     *  @param upPayResult  银联支付结果
     *
     *  @return 返回支付结果
     */
    ZZPayStatusCode_PaySuccess = 0,//(wxPayResult: String?, aliPayResult: String?, upPayResult: [String:AnyObject]?)
    /// 正在处理
    ZZPayStatusCode_PayProcessing,
    /// 用户取消支付
    ZZPayStatusCode_PayErrCodeUserCancel,
    /// 发送失败
    ZZPayStatusCode_PayErrSentFail,
    /// 授权失败
    ZZPayStatusCode_PayErrAuthDeny,
    /// 支付失败
    ZZPayStatusCode_PayErrPayFail,
    /// 微信不支持
    ZZPayStatusCode_PayErrWxUnsupport,
    /// 未安装微信
    ZZPayStatusCode_PayErrWxUnInstall,
    /// 网络错误
    ZZPayStatusCode_PayErrNetWorkFail,
    /// 没有导入相应的SDK
    ZZPayStatusCode_PayErrSDKNotFound,
    /// 未知错误
    ZZPayStatusCode_PayErrUnKnown,
};

/// 支付回调（微信与支付宝payResult为字符串类型，upPay为字典类型）
typedef void(^ZZPayCompleteBlock)(ZZPayStatusCode payStatus, ZZPayChannel payChannel, id payResult);


//#import <Foundation/Foundation.h>
//#import "ZZSingleton.h"

////引入一些头文件
//#import "ZZSingleton.h"
//#import "ZZBasePay.h"
//#import "NSObject+ZZclass.h"
//#import "ZZPay.h"
//#import "ZZPayAliPayOrder.h"
//#import "ZZPayUpOrder.h"
//#import "ZZPayWxOrder.h"
////
//#import "ZZPayAliService.h"
//#import "ZZPayUPService.h"
//#import "ZZPayWxService.h"






#endif
