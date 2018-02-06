//
//  ZZPayUpOrder.h
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//银联支付处理model
@interface ZZPayUpOrder : NSObject

/// 订单id
@property(nonatomic, copy)NSString * tn;
/// URL types 下的 URL Scheme
@property(nonatomic, copy)NSString * appScheme;
/// 接入模式（00生产环境，01开发测试环境）
@property(nonatomic, copy)NSString * mode;
/// 视图控制器
@property(nonatomic, weak)UIViewController * viewController;


#pragma mark - 初始化方法
-(instancetype)initWith_tn:(NSString*)tn appScheme:(NSString*)appScheme mode:(NSString*)mode viewController:(UIViewController*)viewController;

@end
