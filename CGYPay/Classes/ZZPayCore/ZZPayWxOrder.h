//
//  ZZPayWxOrder.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>
//微信支付处理model
@interface ZZPayWxOrder : NSObject
/// 商家id
@property(nonatomic, copy)NSString * partnerId;
/// 订单id
@property(nonatomic, copy)NSString * prepayId;
/// 扩展字段
@property(nonatomic, copy)NSString * package;
/// 随机字符串
@property(nonatomic, copy)NSString * nonceStr;
/// 时间戳
@property(nonatomic, copy)NSString * timeStamp;
/// 签名
@property(nonatomic, copy)NSString * sign;

///微信开放平台审核通过的应用APPID
@property(nonatomic, copy)NSString * appid;
///平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
@property(nonatomic, copy)NSString * wechatPartnerKey;


#pragma mark - 初始化方法
//注意没有传入sign时需传入最后面两个key作签名处理
-(instancetype)initWith_partnerId:(NSString *)partnerId
                         prepayId:(NSString *)prepayId
                          package:(NSString *)package
                         nonceStr:(NSString *)nonceStr
                        timeStamp:(NSString *)timeStamp
                             sign:(NSString *)sign
                            appid:(NSString *)appid//!
                 wechatPartnerKey:(NSString *)wechatPartnerKey;//!

///创建发起支付时的SIGN签名(二次签名)
- (NSString *)createMD5SingForPay:(NSString *)appid_key
                        partnerid:(NSString *)partnerid_key
                         prepayid:(NSString *)prepayid_key
                          package:(NSString *)package_key
                         noncestr:(NSString *)noncestr_key
                        timestamp:(UInt32)timestamp_key
                 wechatPartnerKey:(NSString *)wechatPartnerKey;
@end


#pragma mark -==============================================================================
#pragma mark - MD5
@interface NSString (ZZ_MD5)
- (NSString *)MD5;
@end
#pragma mark -==============================================================================
