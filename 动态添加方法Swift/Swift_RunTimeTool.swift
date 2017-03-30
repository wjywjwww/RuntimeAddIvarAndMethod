//
//  Swift_RunTimeTool.swift
//  动态添加方法Swift
//
//  Created by sks on 17/2/28.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class Swift_RunTimeTool: NSObject {
    
    /// 获取全局变量
    ///
    /// - Parameter object: 需要获取的类
    class func getVarList(object : AnyClass){
        var count:UInt32 = 0
        let ivars = class_copyIvarList(object, &count)
        for index in 0 ..< Int(count){
            let name = ivar_getName(ivars?[index])
            if let ivarName = String.init(validatingUTF8: name!){
                print("\(object) 变量名是：\(ivarName)")
            }
        }
    }
    
    /// 获取属性名
    ///
    /// - Parameter object: 需要获取的类
    class func getPropertyList(object : AnyClass){
        var count : UInt32 = 0
        let propertys = class_copyPropertyList(object, &count)
        for index in 0 ..< Int(count){
            let name = property_getName(propertys?[index])
            if let propertyName = String.init(validatingUTF8: name!){
                print("\(object) 属性名是：\(propertyName)")
            }
        }
    }
    
    /// 获取类的方法列表
    ///
    /// - Parameter object: 需要获取的类
    class func getMethodList(object : AnyClass){
        var count : UInt32 = 0
        let methods = class_copyMethodList(object, &count)
        for index in 0 ..< Int(count){
            let method = sel_getName(method_getName(methods?[index]))
            if let methodName = String.init(validatingUTF8: method!){
                let argument = method_getNumberOfArguments(methods?[index])
                print("\(object)的方法名:\(methodName)"+"参数个数:\(Int(argument))" )
            }
        }
    }
    
    /// 获取类的遵循代理列表
    ///
    /// - Parameter object: 需要获取的类
    class func getProtocolList(object : AnyClass){
        var count : UInt32 = 0
        let protocols = class_copyProtocolList(object, &count)
        for index in 0 ..< Int(count){
            let protocolTemp = protocol_getName(protocols?[index])
            if let protocolName = String.init(validatingUTF8: protocolTemp!){
                print("\(object)的遵循的代理:\(protocolName)")
            }
        }
    }
}
