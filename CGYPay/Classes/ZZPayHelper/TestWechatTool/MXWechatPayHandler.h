/**
 @@create by 刘智援 2016-11-28
 
 @简书地址:    http://www.jianshu.com/users/0714484ea84f/latest_articles
 @Github地址: https://github.com/lyoniOS
 @return MXWechatPayHandler（微信调用工具类）
 */

#import <Foundation/Foundation.h>
#import "MXWechatConfig.h"

@interface MXWechatPayHandler : NSObject
+ (void)jumpToWxPay;
@end

//例：
//发起微信支付
//[MXWechatPayHandler jumpToWxPay];
