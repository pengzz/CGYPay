//
//  WXAPIService.swift
//  CGYPay
//
//  Created by Chakery on 16/3/25.
//  Copyright © 2016年 Chakery. All rights reserved.
//
//  微信支付

import Foundation

public class CGYPayWxService: BaseCGYPay, WXApiDelegate {
    var payCallBack: CGYPayCompletedBlock?
    private static let _sharedInstance = CGYPayWxService()
    override public class var sharedInstance: CGYPayWxService {
        return _sharedInstance
    }
    
    public func onReq(_ req: BaseReq!) {
        
    }
    
    public func onResp(_ resp: BaseResp!) {
        // 微信支付
        if resp is PayResp {
            payResponseParse(payResp: resp as! PayResp)
        }
        // 其他微信的响应, 可以在这里添加...
    }
    
    // 发送微信支付
    //override
    public func sendPay(channel: CGYPayChannel, callBack: @escaping CGYPayCompletedBlock) {
        if case .weixin(let order)  = channel {
            guard WXApi.isWXAppInstalled() else {
                callBack(.PayErrWxUnInstall)
                return
            }
            let req = PayReq()
            req.partnerId = order.partnerId
            req.prepayId = order.prepayid
            req.nonceStr = order.nonceStr
            req.timeStamp = order.timeStamp
            req.package = order.package
            req.sign = order.sign
            WXApi.send(req)
            payCallBack = callBack
        }
    }
    
    /**
     从微信客户端返回
     
     - parameter url: url
     */
    override public func handleOpenURL(url: NSURL) {
        guard "pay" == url.host else { return }
        WXApi.handleOpen(url as URL!, delegate: self)
    }
    
    /**
     注册微信
     
     - parameter appid: appid
     */
    override public func registerWxAPP(appid: String) {
        WXApi.registerApp(appid)
    }
    
    // 处理支付结果
    private func payResponseParse(payResp: PayResp) {
        var payStatus: CGYPayStatusCode
        switch WXErrCode(payResp.errCode) {
        case WXSuccess:
            payStatus = CGYPayStatusCode.PaySuccess(wxPayResult: payResp.returnKey, aliPayResult: nil, upPayResult: nil)
        case WXErrCodeUserCancel:
            payStatus = CGYPayStatusCode.PayErrCodeUserCancel
        case WXErrCodeSentFail:
            payStatus = CGYPayStatusCode.PayErrSentFail
        case WXErrCodeAuthDeny:
            payStatus = CGYPayStatusCode.PayErrAuthDeny
        case WXErrCodeUnsupport:
            payStatus = CGYPayStatusCode.PayErrWxUnsupport
        default:
            payStatus = CGYPayStatusCode.PayErrUnKnown
        }
        payCallBack?(payStatus)
    }
}
