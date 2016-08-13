//
//  Config.swift
//  Router
//
//  Created by DianQK on 8/13/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import RouterX
import SwiftyJSON

private let host = "router://qing.com"

enum Path {
    case search(String)
    case profile
    case login
    case timeline
    
    var url: NSURL {
        switch self {
        case .search(let text):
            return NSURL(string: host + "/search" + "/" + text)!
        case .profile:
            return NSURL(string: host + "/profile")!
        case .login:
            return NSURL(string: host + "/login")!
        case .timeline:
            return NSURL(string: host + "/timeline")!
        }
    }
    
    var pattern: String {
        switch self {
        case .search:
            return "/search/:text"
        case .profile:
            return "/profile"
        case .login:
            return "/login"
        case .timeline:
            return "/timeline"
        }
    }
    
    var handler: MatchRouteHandler {
        return { (url, parameters, _) in
            switch self {
            case .search:
                let search = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SearchViewController") as! SearchViewController
                search.get(url, sender: JSON(parameters))
            case .profile:
                let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
                profile.get(url, sender: JSON(parameters))
            case .login:
                let login = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                login.get(url, sender: JSON(parameters))
            case .timeline:
                let timeline = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TimelineViewController") as! TimelineViewController
                timeline.get(url, sender: JSON(parameters))
            }
        }
        
    }
}

extension Router {
    static func open(path path: Path) {
        open(url: path.url)
    }
    
    static func register(path path: Path) {
        register(pattern: path.pattern, handler: path.handler)
    }
}
