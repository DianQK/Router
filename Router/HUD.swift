//
//  HUD.swift
//  Router
//
//  Created by DianQK on 8/13/16.
//  Copyright © 2016 T. All rights reserved.
//

import Foundation
import MBProgressHUD

struct HUD {
    static func show(_ text: String) {
        let hud = MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().keyWindow, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = text
        hud.removeFromSuperViewOnHide = true
        hud.userInteractionEnabled = false
        hud.hide(true, afterDelay: 1)
    }
}
