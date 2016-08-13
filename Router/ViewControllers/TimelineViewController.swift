//
//  TimelineViewController.swift
//  Router
//
//  Created by DianQK on 8/13/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import SwiftyJSON

class TimelineViewController: UIViewController {

}

extension TimelineViewController: Routerable {
    var routingPattern: String {
        return "/timeline"
    }
    
    func get(url: NSURL, sender: JSON?) {
        HUD.show("亲，还没登录哦")
        Router.open(path: Path.login)
    }
}
