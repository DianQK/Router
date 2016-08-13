//
//  GGRouter.swift
//  GGQ
//
//  Created by DianQK on 5/8/16.
//  Copyright © 2016 org.dianqk. All rights reserved.
//

import UIKit
import SwiftyJSON
import RouterX

func handleURL(url: NSURL) -> JSON {
    guard let query = url.query else {
        return JSON([:])
    }
    return JSON(query: query)
}

struct Router {
    private init() {}
    
    static let manager: RouterX.Router = RouterX.Router { (url, context) in
        print(url)
    }
    
    static var topRouter: Routerable? {
        return RouterManager.topRouterable()
    }
    
    static func register(pattern pattern: String, handler: MatchRouteHandler) {
        manager.registerRoutingPattern(pattern, handler: handler)
    }
    
    static func open(url url: NSURL) {
        manager.matchURLAndDoHandler(url)
    }
    
    static var topViewControler: UIViewController? {
        return RouterManager.topViewController()
    }
}

extension JSON {
    init(query: String) {
        let querys = query.componentsSeparatedByString("&")
        var parameters: [String: String] = [:]
        for query in querys {
            let parameter = query.componentsSeparatedByString("=")
            guard parameter.count >= 2 else {
                continue
            }
            parameters[parameter[0]] = parameter[1].stringByRemovingPercentEncoding
        }
        self.init(parameters)
    }
}

typealias RouterManager = UIApplication

extension RouterManager {

    class func sharedRouterManager() -> RouterManager {
        return sharedApplication()
    }

    class func topRouterable() -> Routerable? {
        if let topRouterable = topViewController() as? Routerable {
            return topRouterable
        } else {
//            Warning("\(topViewController()) not conform Routerable")
        }
        return nil
    }

    class func findRouterable(base: UIViewController? = UIApplication.sharedApplication().windows.first?.rootViewController, routingPattern: String) -> Routerable? {
        if let vc = base as? Routerable where vc.routingPattern == routingPattern {
            return vc
        }
        if let nav = base as? UINavigationController {
            if let vc = findRouterable(nav.viewControllers, routingPattern: routingPattern) {
                return vc
            }
        }
        if let tab = base as? UITabBarController, vcs = tab.viewControllers {
            if let vc = findRouterable(vcs, routingPattern: routingPattern) {
                return vc
            }
        }
        if let presented = base?.presentedViewController {
            if let vc = findRouterable(presented, routingPattern: routingPattern) {
                return vc
            }
        }
        return nil
    }

    private class func findRouterable(bases: [UIViewController], routingPattern: String) -> Routerable? {
        for base in bases {
            if let vc = base as? Routerable where vc.routingPattern == routingPattern {
                return vc
            }
            if let nav = base as? UINavigationController {
                if let vc = findRouterable(nav.viewControllers, routingPattern: routingPattern) {
                    return vc
                }
            }
            if let tab = base as? UITabBarController, let vcs = tab.viewControllers {
                if let vc = findRouterable(vcs, routingPattern: routingPattern) {
                    return vc
                }
            }
            if let presented = base.presentedViewController {
                if let vc = findRouterable(presented, routingPattern: routingPattern) {
                    return vc
                }
            }
        }
        return nil
    }

    func neverCareResultOpenURL(url: NSURL) {
        openURL(url)
    }

}

#if DEBUG
    extension UIViewController: Routerable {

        var routingPattern: String {
            return "404"
        }

        var routingIdentifier: String? {
            return nil
        }

    }
#endif

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension UINavigationController {
    func popTo(routingPattern routingPattern: String) -> Bool {
        let vc = viewControllers.flatMap { vc -> UIViewController? in
            if let routerable = vc as? Routerable where routerable.routingPattern == routingPattern {
                return vc
            } else {
                return nil
            }
        }.first
        if let vc = vc {
            popToViewController(vc, animated: true)
            return true
        } else {
            return false
        }
    }
    /**
     移除堆栈的 viewController ,移除 routingPattern 和 last 之间的 viewController

     - parameter routingPattern: 待移除到参数 viewController

     - returns: 是否移除成功
     */
    func remove(to routingPattern: String) -> Bool {
        let vc = viewControllers.flatMap { vc -> UIViewController? in
            if let routerable = vc as? Routerable where routerable.routingPattern == routingPattern {
                return vc
            } else {
                return nil
            }
            }.first
        // TODO: 越界以及未找到的处理
        if let vc = vc, index = viewControllers.indexOf(vc) {
            let range = index + 1 ..< viewControllers.endIndex - 1
            viewControllers.removeRange(range)
            return true
        } else {
            return false
        }
    }
}
