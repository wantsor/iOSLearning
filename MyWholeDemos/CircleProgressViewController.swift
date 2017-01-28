//
//  CircleProgressViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/3/10.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit

class CircleProgressViewController: UIViewController {
    
    
    @IBOutlet weak var demoView3: UIView!
    @IBOutlet weak var demoView2: UIView!
    @IBOutlet weak var demoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        demoView.layer.cornerRadius = demoView.frame.width / 2
        demoView2.layer.cornerRadius = demoView.frame.width / 2
        demoView3.layer.cornerRadius = demoView.frame.width / 2
        demoView.backgroundColor = UIColor.clearColor()
        demoView2.backgroundColor = UIColor.clearColor()
        demoView3.backgroundColor = UIColor.clearColor()
        
        demoView3.hidden = true
        demoView.hidden = true
        
        let circleProgressView = AICircleProgressView(frame: demoView.bounds)
        circleProgressView.refreshProgress(0.5)
        demoView.addSubview(circleProgressView)
        
        let circleProgressView22 = AICircleProgressView(frame: demoView.bounds, strokWidth: 10, circlePadding: 30, backLayerColor: UIColor.grayColor(), frontLayerColor: UIColor.redColor())
        circleProgressView22.refreshProgress(0.3)
        demoView2.addSubview(circleProgressView22)
        
        let circleProgressView2 = AICircleProgressView(frame: demoView.bounds)
        circleProgressView2.refreshProgress(0.9)
        demoView2.addSubview(circleProgressView2)
        
        let circleProgressView3 = AICircleProgressView(frame: demoView.bounds)
        circleProgressView3.refreshProgress(0.0)
        demoView3.addSubview(circleProgressView3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
