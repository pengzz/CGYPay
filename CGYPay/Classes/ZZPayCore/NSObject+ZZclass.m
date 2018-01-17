//
//  NSObject+ZZClass.m
//  CGYPay
//
//  Created by PengZhiZhong on 2018/1/16.
//  Copyright © 2018年 Chakery. All rights reserved.
//

#import "NSObject+ZZclass.h"

@implementation NSObject (ZZclass)
/**
 swift中把字符串转换成Class对象
 
 - parameter className: 需要转换的字符串
 
 - returns: 如果转换成功，返回AnyClass，否则返回nil
 */
//class func zz_classFromString(className: String) -> AnyClass? {
//    //if  let appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
//    //let classStringName = "_TtC\(appName!.characters.count)\(appName!)\(className.characters.count)\(className)"
//    //let  cls: AnyClass? = NSClassFromString(classStringName)
//    //return cls
//    //}
//
//    let appName = "CGYPay"
//    let classStringName = "_TtC\(appName.characters.count)\(appName)\(className.characters.count)\(className)"
//    let  cls: AnyClass? = NSClassFromString(classStringName)
//    return cls
//}

+(Class)zz_classFromString:(NSString*)className
{
    Class pkClass=NSClassFromString(className);//@"PKAddPassesViewController");
    if (pkClass) {
        //NSLog(@"available");
        // 如果可以使用，我们可以使用passkit的一些功能
    }else{
        //NSLog(@"unavailable");
       //如果不可以，我们就要提示用户，或者进行一些其他的处理
    }
    return pkClass;
}

@end
