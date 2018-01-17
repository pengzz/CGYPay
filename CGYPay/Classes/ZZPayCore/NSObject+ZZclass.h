//
//  NSObject+ZZClass.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZZClass)
//字符串转换成Class对象
+(Class)zz_classFromString:(NSString*)className;
@end
