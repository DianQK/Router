//
//  LoginViewController.swift
//  Router
//
//  Created by DianQK on 8/13/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBAction func cancel(sender: AnyObject) {
        Router.topViewControler?.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension LoginViewController: Routerable {
    var routingPattern: String {
        return "/login"
    }
    
    func get(url: NSURL, sender: JSON?) {
        Router.topViewControler?.showDetailViewController(self, sender: nil)
    }
}
