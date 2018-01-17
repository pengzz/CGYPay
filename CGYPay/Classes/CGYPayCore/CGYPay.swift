//
//  CGYPay.swift
//  CGYPay
//
//  Created by Chakery on 16/3/26.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import Foundation
public class CGYPay: NSObject {
    /**
     调起支付
     
     - parameter channel:  支付渠道
     - parameter callBack: 支付回调
     */
    public class func createPayment(channel: CGYPayChannel, callBack: CGYPayCompletedBlock) {
        switch channel {
        case .weixin:
            if let wxPay = wxPay {
                wxPay.sendPay(channel: channel, callBack: callBack)
            } else {
                callBack(.PayErrSDKNotFound)
            }
        case .aliPay:
            if let aliPay = aliPay {
                aliPay.sendPay(channel: channel, callBack: callBack)
            } else {
                callBack(.PayErrSDKNotFound)
            }
        case .upPay:
            if let upPay = upPay {
                upPay.sendPay(channel: channel, callBack: callBack)
            } else {
                callBack(.PayErrSDKNotFound)
            }
        }
    }
    
    /**
     从APP返回时执行的回调
     
     - parameter url: url
     
     - returns: 
     */
    public class func handlerOpenURL(url: NSURL) -> Bool {
        if let wxPay = wxPay {
            wxPay.handleOpenURL(url: url)
        }
        if let aliPay = aliPay {
            aliPay.handleOpenURL(url: url)
        }
        if let upPay = upPay {
            upPay.handleOpenURL(url: url)
        }
        return true
    }
    
    /**
     注册微信
     
     - parameter appid: appid
     */
    public class func registerWxAPP(appid: String) {
        if let wxPay = wxPay {
            wxPay.registerWxAPP(appid: appid)
        }
    }
    
    // 银联支付
    private static var upPay: BaseCGYPay? = {
        let upPayType = NSObject.cgy_classFromString(className: "CGYPayUPService") as? BaseCGYPay.Type
        return upPayType?.sharedInstance
    }()
    // 微信支付
    private static var wxPay: BaseCGYPay? = {
        let wxPayType = NSObject.cgy_classFromString(className: "CGYPayWxService") as? BaseCGYPay.Type
        return wxPayType?.sharedInstance
    }()
    // 支付宝支付
    private static var aliPay: BaseCGYPay? = {
        let aliPayType = NSObject.cgy_classFromString(className: "CGYPayAliService") as? BaseCGYPay.Type
        return aliPayType?.sharedInstance
    }()
}
