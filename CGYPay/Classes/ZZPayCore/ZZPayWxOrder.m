//
//  ZZPayWxOrder.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayWxOrder.h"

@implementation ZZPayWxOrder

-(instancetype)initWith_partnerId:(NSString *)partnerId
                         prepayId:(NSString *)prepayId
                          package:(NSString *)package
                         nonceStr:(NSString *)nonceStr
                        timeStamp:(NSString *)timeStamp
                             sign:(NSString *)sign
                            appid:(NSString *)appid//!
                 wechatPartnerKey:(NSString *)wechatPartnerKey//!
{
    if (self = [super init]) {
        _partnerId        = partnerId;
        _prepayId          = prepayId;
        _package           = package;
        _nonceStr          = nonceStr;
        _timeStamp         = timeStamp;
        _sign              = sign;
        //注意没有传入sign时需传入最后面两个key作签名处理
        _appid             = appid;
        _wechatPartnerKey  = wechatPartnerKey;
        
        if(1){
            _package =_package!=nil?_package:@"Sign=WXPay";
            //_nonceStr = _nonceStr!=nil?_nonceStr:[NSString randomKey];
            
            _timeStamp = ({
                //时间戳:标准北京时间，时区为东八区，自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
                NSString *timeStampStr = _timeStamp;
                if(_timeStamp==nil){
                    NSDate *datenow = [NSDate date];
                    timeStampStr = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                }
                timeStampStr;
            });
            
            // 签名加密
            if(_sign==nil){
                _sign = [self createMD5SingForPay:_appid
                                        partnerid:_partnerId
                                         prepayid:_prepayId
                                          package:_package
                                         noncestr:_nonceStr
                                        timestamp:[_timeStamp intValue]
                                 wechatPartnerKey:_wechatPartnerKey];
            }
        }
    }
    return self;
}

//创建发起支付时的SIGN签名(二次签名)
-(NSString *)createMD5SingForPay:(NSString *)appid_key
                       partnerid:(NSString *)partnerid_key
                        prepayid:(NSString *)prepayid_key
                         package:(NSString *)package_key
                        noncestr:(NSString *)noncestr_key
                       timestamp:(UInt32)timestamp_key
                wechatPartnerKey:(NSString *)wechatPartnerKey
{
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];
    [signParams setObject:noncestr_key forKey:@"noncestr"];
    [signParams setObject:package_key forKey:@"package"];
    [signParams setObject:partnerid_key forKey:@"partnerid"];
    [signParams setObject:prepayid_key forKey:@"prepayid"];
    [signParams setObject:[NSString stringWithFormat:@"%u",(unsigned int)timestamp_key] forKey:@"timestamp"];
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段
    [contentString appendFormat:@"key=%@", wechatPartnerKey];
    //md5
    NSString *result = [contentString MD5];
    return result;
}

@end




#pragma mark -==============================================================================
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
@implementation NSString (ZZ_MD5)
- (NSString *)MD5 {
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (uint32_t)strlen(ptr), md5Buffer);
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    return output;
}
@end
#pragma mark -==============================================================================

