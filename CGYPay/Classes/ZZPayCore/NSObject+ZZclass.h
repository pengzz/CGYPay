//
//  NSObject+ZZClass.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZZClass)

+(Class)zz_classFromString:(NSString*)className;
//class func zz_classFromString(className: String) -> AnyClass? {
@end
