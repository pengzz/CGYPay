//
//  CGYPayUPService.swift
//  CGYPay
//
//  Created by Chakery on 16/3/28.
//  Copyright © 2016年 Chakery. All rights reserved.
//
//  银联支付

import Foundation

public class CGYPayUPService: BaseCGYPay {
    private var payCallBack: CGYPayCompletedBlock?
    private static let _sharedInstance = CGYPayUPService()
    override public class var sharedInstance: CGYPayUPService {
        return _sharedInstance
    }
    
    //override
    public func sendPay(channel: CGYPayChannel, callBack: @escaping CGYPayCompletedBlock) {
        payCallBack = callBack
        if case .upPay(let order) = channel {
            UPPaymentControl.default().startPay(order.tn, fromScheme: order.appScheme, mode: order.mode, viewController: order.viewController)
        }
    }
    
    override public func handleOpenURL(url: NSURL) {
        guard "uppayresult" == url.host else { return }
        UPPaymentControl.default().handlePaymentResult(url as URL!) { [unowned self] stringCode, resultDic in
            switch stringCode! {//pzz加！
            case "success":
                self.payCallBack?(CGYPayStatusCode.PaySuccess(wxPayResult: nil, aliPayResult: nil, upPayResult: resultDic as! [String:AnyObject]?))
            case "cancel":
                self.payCallBack?(CGYPayStatusCode.PayErrCodeUserCancel)
            case "fail":
                self.payCallBack?(CGYPayStatusCode.PayErrPayFail)
            default:
                self.payCallBack?(CGYPayStatusCode.PayErrUnKnown)
            }
        }
    }
    
}
