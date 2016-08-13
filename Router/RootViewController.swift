//
//  RootViewController.swift
//  Router
//
//  Created by DianQK on 8/13/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!

    @IBAction func search(sender: AnyObject) {
        guard let searchText = searchTextField.text else {
            print("=。= 并没有搜索内容")
            return
        }
        Router.open(path: Path.search(searchText))
    }

    @IBAction func showProfile(sender: AnyObject) {
        Router.open(path: Path.profile)
    }
    @IBAction func login(sender: AnyObject) {
        Router.open(path: Path.login)
    }
    
    @IBAction func showTimeline(sender: AnyObject) {
        Router.open(path: Path.timeline)
    }
    
}
