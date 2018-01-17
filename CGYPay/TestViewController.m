//
//  TestViewController.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "TestViewController.h"
#import "ZZPayAliService.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//************************************ 支付宝支付 ************************************
-(void)aliPayHandler
{
    // 关于orderStr参数 https://doc.open.alipay.com/doc2/detail?treeId=59&articleId=103663&docType=1
    
//    let order = CGYPayAliPayOrder(partner: "商家id", seller_id: "商家支付宝账号", out_trade_no: "订单id", subject: "商品标题", body: "商品描述", total_fee: "总价格", notify_url: "url回调", sign: "签名", appScheme: "com.ccggyy.cgypay")
//
//    CGYPay.createPayment(channel: .aliPay(order: order)) { status in
//        switch status {
//        case .PaySuccess(_, let aliPayResult, _):
//            print("支付成功: \(aliPayResult)")
//        default:
//            print("支付失败")
//        }
//    }
//    ZZPayAliPayOrder_Old *order = [[ZZPayAliPayOrder_Old alloc] initWith_partner:@"商家id"
//                                                               seller_id:@"商家支付宝账号"
//                                                            out_trade_no:@"订单id"
//                                                                 subject:@"商品标题"
//                                                                    body:@"商品描述"
//                                                               total_fee:@"总价格"
//                                                              notify_url:@"url回调"
//                                                            payment_type:nil
//                                                                    sign:@"签名"
//                                                               appScheme: nil//@"com.ccggyy.cgypay"
//                               ];
//    //@weakify(self)
//    [ZZPay createPayment:ZZPayChannel_aliPay order:order callBack:^(ZZPayStatusCode payStatus, ZZPayChannel payChannel, id payResult) {
//        //@strongify(self)
//        switch (payStatus) {
//            case ZZPayStatusCode_PaySuccess:
//                NSLog(@"支付成功：%@",payResult);
//                break;
//            default:
//                NSLog(@"支付失败");
//                break;
//        }
//    }];
    
    
    //1:导入 #import "ZZPayAliService.h"
    //2:
    //新方法：增加直接传orderString方法
    NSString *orderStr = nil;
    //@weakify(self)
    [[ZZPayAliService sharedInstance] sendPay:ZZPayChannel_aliPay orderStr:orderStr fromScheme:nil callBack:^(ZZPayStatusCode payStatus, ZZPayChannel payChannel, id payResult) {
        //@strongify(self)
        switch (payStatus) {
            case ZZPayStatusCode_PaySuccess:
                NSLog(@"支付成功：%@",payResult);
                break;
            default:
                NSLog(@"支付失败");
                break;
        }
    }];
    
}

-(void)aliPayHandler_1
{
    NSString *appID = @"";
    
    //1:生成订单信息
    ZZPayAliPayOrder* order = ({
        ZZPayAliPayOrder* order = [ZZPayAliPayOrder new];
        
        // NOTE: app_id设置
        order.app_id = appID;
        
        // NOTE: 支付接口名称
        order.method = @"alipay.trade.app.pay";
        
        // NOTE: 参数编码格式
        order.charset = @"utf-8";
        
        // NOTE: 当前时间点
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        order.timestamp = [formatter stringFromDate:[NSDate date]];
        
        // NOTE: 支付版本
        order.version = @"1.0";
        
        // NOTE: sign_type 根据商户设置的私钥来决定
        order.sign_type = (order.rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
        
        // NOTE: 商品数据
        order.biz_content = [ZZPay_APBizContent new];
        order.biz_content.body = @"我是测试数据";
        order.biz_content.subject = @"1";
        order.biz_content.out_trade_no = [ZZPayAliPayOrder generateTradeNO]; //订单ID（由商家自行制定）
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
        order;
    });
    //2：注意一定要先订单签名
    order.sign = [ZZPay_APRSASigner getOrderSignString:order];
    //3:执行封装统一方法
    //@weakify(self)
    [ZZPay createPayment:ZZPayChannel_aliPay order:order callBack:^(ZZPayStatusCode payStatus, ZZPayChannel payChannel, id payResult) {
        //@strongify(self)
        switch (payStatus) {
            case ZZPayStatusCode_PaySuccess:
                NSLog(@"支付成功：%@",payResult);
                break;
            default:
                NSLog(@"支付失败");
                break;
        }
    }];
}



@end
