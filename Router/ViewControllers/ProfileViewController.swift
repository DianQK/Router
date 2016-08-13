//
//  ProfileViewController.swift
//  Router
//
//  Created by DianQK on 8/13/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBAction func back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}

extension ProfileViewController: Routerable {
    var routingPattern: String {
        return "/profile"
    }
}
