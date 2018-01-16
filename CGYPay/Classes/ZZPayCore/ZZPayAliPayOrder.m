//
//  ZZPayAliPayOrder.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayAliPayOrder.h"

@implementation ZZPayAliPayOrder

-(instancetype)initWith_partner:(NSString*)partner
                      seller_id:(NSString*)seller_id
                   out_trade_no:(NSString*)out_trade_no
                        subject:(NSString*)subject
                           body:(NSString*)body
                      total_fee:(NSString*)total_fee
                     notify_url:(NSString*)notify_url
                   payment_type:(NSString*)payment_type//String = "1",
                           sign:(NSString*)sign
                      appScheme:(NSString*)appScheme {
    self = [super init];
    if(payment_type==nil){
        payment_type = @"1";
    }
    self.partner = partner;
    self.seller_id = seller_id;
    self.out_trade_no = out_trade_no;
    self.subject = subject;
    self.body = body;
    self.total_fee = total_fee;
    self.notify_url = notify_url;
    self.service = @"mobile.securitypay.pay";
    self.payment_type = payment_type;
    self.input_charset = @"utf-8";
    self.sign = sign;
    self.sign_type = @"RSA";
    self.appScheme = appScheme;
    return self;
}

//extension CGYPayAliPayOrder {
/**
 把参数拼接成订单字符串
 
 - returns: 调起支付的订单字符串
 */
-(NSString*)toOrderString{
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendString:[NSString stringWithFormat:@"partner=%@",_partner]];
    [mStr appendString:[NSString stringWithFormat:@"&seller_id=%@",_seller_id]];
    [mStr appendString:[NSString stringWithFormat:@"&out_trade_no=%@",_out_trade_no]];
    [mStr appendString:[NSString stringWithFormat:@"&subject=%@",_subject]];
    [mStr appendString:[NSString stringWithFormat:@"&body=%@",_body]];
    [mStr appendString:[NSString stringWithFormat:@"&total_fee=%@",_total_fee]];
    [mStr appendString:[NSString stringWithFormat:@"&notify_url=%@",_notify_url]];
    [mStr appendString:[NSString stringWithFormat:@"&service=%@",_service]];
    [mStr appendString:[NSString stringWithFormat:@"&payment_type=%@",_payment_type]];
    [mStr appendString:[NSString stringWithFormat:@"&_input_charset=%@",_input_charset]];//?
    [mStr appendString:[NSString stringWithFormat:@"&sign=%@",_sign]];
    [mStr appendString:[NSString stringWithFormat:@"&sign_type=%@",_sign_type]];
    //
    if(1){
        if(_it_b_pay){
            [mStr appendString:[NSString stringWithFormat:@"&it_b_pay=%@",_it_b_pay]];
        }
        if(_app_id){
            [mStr appendString:[NSString stringWithFormat:@"&app_id=%@",_app_id]];
        }
        if(_appenv){
            [mStr appendString:[NSString stringWithFormat:@"&appenv=%@",_appenv]];
        }
        if(_goods_type){
            [mStr appendString:[NSString stringWithFormat:@"&goods_type=%@",_goods_type]];
        }
        if(_rn_check){
            [mStr appendString:[NSString stringWithFormat:@"&rn_check=%@",_rn_check]];
        }
        if(_extern_token){
            [mStr appendString:[NSString stringWithFormat:@"&extern_token=%@",_extern_token]];
        }
        if(_out_context){
            [mStr appendString:[NSString stringWithFormat:@"&out_context=%@",_out_context]];
        }
    }
    
    //以下略
//    var orderstring = "partner=\"\(partner)\
//    "&seller_id=\"\(seller_id)\
//    "&out_trade_no=\"\(out_trade_no)\
//    "&subject=\"\(subject)\
//    "&body=\"\(body)\
//    "&total_fee=\"\(total_fee)\
//    "&notify_url=\"\(notify_url)\
//    "&service=\"\(service)\
//    "&payment_type=\"\(payment_type)\
//    "&_input_charset=\"\(_input_charset)\
//    "&sign=\"\(sign)\
//    "&sign_type=\"\(sign_type)\""
    
//    if let it_b_pay = it_b_pay {
//        orderstring += "&it_b_pay=\"\(it_b_pay)\""
//    }
//    if let app_id = app_id {
//        orderstring += "&app_id=\"\(app_id)\""
//    }
//    if let appenv = appenv {
//        orderstring += "&appenv=\"\(appenv)\""
//    }
//    if let goods_type = goods_type {
//        orderstring += "&goods_type=\"\(goods_type)\""
//    }
//    if let rn_check = rn_check {
//        orderstring += "&rn_check=\"\(rn_check)\""
//    }
//    if let extern_token = extern_token {
//        orderstring += "&extern_token=\"\(extern_token)\""
//    }
//    if let out_context = out_context {
//        orderstring += "&out_context=\"\(out_context)\""
//    }
    
    return mStr;
}




#pragma mark - 222222222222222222222222222222222222

- (NSString *)orderInfoEncoded:(BOOL)bEncoded {
    if (_app_id.length <= 0) {
        return nil;
    }
    
    // NOTE: 增加不变部分数据
    NSMutableDictionary *tmpDict = [NSMutableDictionary new];
    [tmpDict addEntriesFromDictionary:@{@"partner":_partner,
                                        @"method":_seller_id,
                                        @"out_trade_no":_out_trade_no,
                                        @"subject":_subject,
                                        @"body":_body,
                                        @"total_fee":_total_fee,
                                        @"notify_url":_notify_url,
                                        @"service":_service,
                                        @"payment_type":_payment_type,
                                        @"_input_charset":_input_charset?:@"utf-8",
                                        @"sign":_sign,
                                        @"sign_type":_sign_type?:@"RSA"
                                        }];
    
    if(1){
        if(_it_b_pay){
            [tmpDict setValue:_it_b_pay forKey:@"it_b_pay"];
        }
        if(_app_id){
            [tmpDict setValue:_app_id forKey:@"app_id"];
        }
        if(_appenv){
            [tmpDict setValue:_appenv forKey:@"appenv"];
        }
        if(_goods_type){
            [tmpDict setValue:_goods_type forKey:@"goods_type"];
        }
        if(_rn_check){
            [tmpDict setValue:_rn_check forKey:@"rn_check"];
        }
        if(_extern_token){
            [tmpDict setValue:_extern_token forKey:@"extern_token"];
        }
        if(_out_context){
            [tmpDict setValue:_out_context forKey:@"out_context"];
        }
    }
    
//    // NOTE: 增加可变部分数据
//    if (_format.length > 0) {
//        [tmpDict setObject:_format forKey:@"format"];
//    }
//
//    if (_return_url.length > 0) {
//        [tmpDict setObject:_return_url forKey:@"return_url"];
//    }
//
//    if (_notify_url.length > 0) {
//        [tmpDict setObject:_notify_url forKey:@"notify_url"];
//    }
//
//    if (_app_auth_token.length > 0) {
//        [tmpDict setObject:_app_auth_token forKey:@"app_auth_token"];
//    }
    
    // NOTE: 排序，得出最终请求字串
    NSArray* sortedKeyArray = [[tmpDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (NSString* key in sortedKeyArray) {
        NSString* orderItem = [self orderItemWithKey:key andValue:[tmpDict objectForKey:key] encoded:bEncoded];
        if (orderItem.length > 0) {
            [tmpArray addObject:orderItem];
        }
    }
    return [tmpArray componentsJoinedByString:@"&"];
}

- (NSString*)orderItemWithKey:(NSString*)key andValue:(NSString*)value encoded:(BOOL)bEncoded
{
    if (key.length > 0 && value.length > 0) {
        if (bEncoded) {
            value = [self encodeValue:value];
        }
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    return nil;
}

- (NSString*)encodeValue:(NSString*)value
{
    NSString* encodedValue = value;
    if (value.length > 0) {
        encodedValue = (__bridge_transfer  NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)value, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    }
    return encodedValue;
}


@end
