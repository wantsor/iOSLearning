//
//  UIViewController+Rotate.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/11/29.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController {
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return visibleViewController!.supportedInterfaceOrientations()
    }
    public override func shouldAutorotate() -> Bool {
        return visibleViewController!.shouldAutorotate()
    }
    
    
//    public override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
//        return visibleViewController!.preferredInterfaceOrientationForPresentation()
//    }
}
