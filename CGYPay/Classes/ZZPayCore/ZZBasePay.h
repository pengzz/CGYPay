//
//  ZZBasePay.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZPayConstant.h"//TO DO

//@class ZZBasePay;
@protocol ZZBasePayAble <NSObject>
@required
-(void)handleOpenURL:(NSURL*)url;
-(void)sendPay:(ZZPayChannel)channel order:(id)order callBack:(ZZPayCompleteBlock)callback;
@optional
-(void)registerWxAPP:(NSString*)appid;
@end

@interface ZZBasePay: NSObject<ZZBasePayAble>
//NSSingletonH(sharedInstance)
+ (instancetype)sharedInstance;
- (void)handleOpenURL:(NSURL *)url;
- (void)sendPay:(ZZPayChannel)channel order:(id)order callBack:(ZZPayCompleteBlock)callback;
@end

//#import <Foundation/Foundation.h>
//
//@interface ZZBasePay : NSObject
//+ (instancetype)sharedInstance;
//- (void)handleOpenURL:(NSURL *)url;
//- (void)sendPay:(ZZPayChannel)channel order:(id)order callBack:(ZZPayCompleteBlock)callback;
//@end


