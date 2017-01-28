//
//  CompositeAnimationViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 9/11/16.
//  Copyright © 2016 wantsor. All rights reserved.
//

import UIKit

class CompositeAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class AnimateService {
    var viewRect: CGRect!
    var progressPath: UIBezierPath!
    //关键帧
    var arrowStartPath: UIBezierPath!
    var arrowDownPath: UIBezierPath!
    var arrowMidPath: UIBezierPath!
    var arrowEndPath: UIBezierPath!
    
    var arrowWavePath: UIBezierPath!
    
    var verticalLineStartPath: UIBezierPath!
    var verticalLineEndPath:UIBezierPath!
    
    var succesPath:UIBezierPath!
}

class ArrowAnimateButton: UIControl {

}
