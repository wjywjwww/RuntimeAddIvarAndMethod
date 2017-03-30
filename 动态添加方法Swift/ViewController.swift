//
//  ViewController.swift
//  动态添加方法Swift
//
//  Created by sks on 17/2/27.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var bookName = "邓小平传"
    static let bookName = UnsafeRawPointer.init(bitPattern: "bookName".hashValue)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let p = Person()
        //这里是Runtime添加方法
        print("没添加方法前方法列表输出")
        Swift_RunTimeTool.getMethodList(object: Person.self)
        let method = class_getInstanceMethod(ViewController.self, #selector(ViewController.readBook))
        //下面连个语句都是添加方法，第一个语句是添加能直接取到Sel的方法，后面的参数以及返回值是通过现有方法取出
        let _ = class_addMethod(object_getClass(p),  #selector(ViewController.readBook), class_getMethodImplementation(object_getClass(self), #selector(ViewController.readBook)), method_getTypeEncoding(method))
        //这个语句是添加取不到Sel的方法，添加一个目前不存在的方法名的方法，后面方法参数返回值是直接字符串给出
        let _ = class_addMethod(object_getClass(p),  Selector(("findBook")), class_getMethodImplementation(object_getClass(self), #selector(ViewController.readBook)), "v@:")
        print("添加方法后方法列表输出")
        Swift_RunTimeTool.getMethodList(object: Person.self)
        //方法的调用需要时这种，没办法直接调用
        p.perform(Selector(("findBook")))
        
        //这里是添加属性的调用
        p.bookName = "邓小平传"
        print(p.bookName ?? "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func readBook(){
        print("I LOVE ReadBook")
    }
}
class Person : NSObject{
    
}


//这里是runtime添加属性
extension Person{
    var bookName: String? {
        set {
            objc_setAssociatedObject(self, ViewController.bookName, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, ViewController.bookName) as? String
        }
    }
}
class some{
    
}
