//
//  Routerable.swift
//  GGQ
//
//  Created by DianQK on 16/4/22.
//  Copyright © 2016年 org.dianqk. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Body {
    static var json = JSON.null
}

protocol Routerable {
    /// unique path , 用于判断是否为完全相同页面
    var routingIdentifier: String? { get }
    /// path ， 用于判断是否为相同页面
    var routingPattern: String { get }
    /// GET 方法，一般用来展示新页面
    func get(url: NSURL, sender: JSON?)
    /// POST 方法，一般用来更新数据
    func post(url: NSURL, sender: JSON?)
}

extension Routerable {
    func post(url: NSURL, sender: JSON?) {
//        Warning("未实现 POST")
    }

    func get(url: NSURL, sender: JSON?) {
//        Warning("未实现 GET")
    }

    var routingIdentifier: String? {
        return nil
    }
}

extension Routerable where Self: UIViewController {

    var routingIdentifier: String? {
        return routingPattern
    }

    func get(url: NSURL, sender: JSON?) {
        guard RouterManager.topRouterable()?.routingPattern != routingPattern else {
            HUD.show("多次打开 \(url)")
            return
        }
        hidesBottomBarWhenPushed = true
        RouterManager.topViewController()?.showViewController(self, sender: nil)
    }
}
