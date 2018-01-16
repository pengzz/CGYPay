//
//  ZZBasePay.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "ZZBasePay.h"

@implementation ZZBasePay
//NSSingletonM(Instance)
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ZZBasePay *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (void)handleOpenURL:(NSURL *)url {
    //<#code#>
}

- (void)sendPay:(ZZPayChannel)channel order:(id)order callBack:(ZZPayCompleteBlock)callback {
    //<#code#>
}

@end
