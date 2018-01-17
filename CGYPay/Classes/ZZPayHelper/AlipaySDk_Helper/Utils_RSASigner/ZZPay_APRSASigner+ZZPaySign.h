//
//  APRSASigner.h
//  AliSDKDemo
//
//  Created by antfin on 17-10-24.
//  Copyright (c) 2017年 AntFin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZPay_APRSASigner.h"
#import "ZZPayAliPayOrder.h"//订单对象

@interface ZZPay_APRSASigner (ZZPaySign)
+ (NSString *)getOrderSignString:(ZZPayAliPayOrder *)order;
@end
