//
//  ZZPayUpOrder.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZPayUpOrder.h"

@implementation ZZPayUpOrder

-(instancetype)initWith_tn:(NSString*)tn appScheme:(NSString*)appScheme mode:(NSString*)mode viewController:(UIViewController*)viewController {
    if(self = [super init]){
        self.tn = tn;
        self.appScheme = appScheme;
        self.mode = mode;
        self.viewController = viewController;
    }
    return self;
}

@end
