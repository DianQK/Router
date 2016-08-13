//
//  SearchViewController.swift
//  Router
//
//  Created by DianQK on 8/13/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var _searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = _searchText
        HUD.show("ssss")
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        Router.topViewControler?.dismissViewControllerAnimated(true, completion: nil)
    }

}

extension SearchViewController: Routerable {
    var routingPattern: String {
        return "/search/:text"
    }
    
    var routingIdentifier: String? {
        if let searchText = searchBar?.text {
            return "/search/" + searchText
        }
        return nil
    }
    
    func get(url: NSURL, sender: JSON?) {
        guard let searchText = sender?["text"].string else {
            return
        }

        if let topRouter = Router.topRouter where topRouter.routingIdentifier == routingIdentifier {
            print("打开了完全一样的搜索页面")
            return
        }

        if let topRouter = Router.topRouter where topRouter.routingPattern == searchText {
            print("仍然打开了搜索页面，这里不展示新页面，更新搜索内容")
//            topRouter.post(NSURL(string: "")!, sender: JSON(["text": searchText]))
            return
        }
        _searchText = searchText
        Router.topViewControler?.showDetailViewController(self, sender: nil)
    }
    
    func post(url: NSURL, sender: JSON?) {
        searchBar.text = sender?["text"].string
    }
}