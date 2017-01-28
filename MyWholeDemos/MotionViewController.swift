//
//  MotionViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/11/23.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit
import CoreMotion

//一次下蹲需要完成的动作检测, 先下降加速，然后下降减速和上升加速，然后上升减速
struct SquatCycleModel {
    var isDownAcc = false
    var isDownDeceAndUpAcc = false
    var isUpDece = false
}



class MotionViewController: UIViewController {
    
    let manager = CMMotionManager()
    let device = UIDevice.currentDevice()
    
    var squatDetection = ExerciseDetection(type: ExerciseType.Squat)
    var situpDetection = ExerciseDetection(type: ExerciseType.SitUp)
    
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var countButton2: UIButton!
    @IBOutlet weak var countButton3: UIButton!
    
    //俯卧撑开始按钮
    @IBAction func countAction2(sender: AnyObject) {
        if !situpDetection.isStart {
            situpDetection.detectExerciseBegin(nil)
        } else {
            situpDetection.detectExerciseEnd()
        }

    }
    
    //仰卧起坐开始按钮
    @IBAction func countAction3(sender: AnyObject) {
        if !situpDetection.isStart {
            situpDetection.detectExerciseBegin(nil)
        } else {
            situpDetection.detectExerciseEnd()
        }
    }
    
    
    @IBAction func countAction(sender: UIButton) {
        if !squatDetection.isStart {
            squatDetection.detectExerciseBegin(nil)
        } else {
            squatDetection.detectExerciseEnd()
        }
    }
    
//    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
//        return .LandscapeLeft
//    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        makeRotate()
    }
    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        makeRotateBack()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MotionViewController.sensorStateChange(_:)), name: UIDeviceProximityStateDidChangeNotification, object: nil)
        // Do any additional setup after loading the view.
        squatDetection.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        NSLog("direction: \(toInterfaceOrientation.rawValue)")
    }
    
    func makeRotate() {
//        UIView.animateWithDuration(0.5) {
//            self.view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
//        }
        if UIDevice.currentDevice().respondsToSelector(Selector("setOrientation:")) {
            UIDevice.currentDevice().performSelector(Selector("setOrientation:"), withObject: UIInterfaceOrientationMask.LandscapeRight.rawValue)
        }
    }
    
    func makeRotateBack() {
        if UIDevice.currentDevice().respondsToSelector(Selector("setOrientation:")) {
            UIDevice.currentDevice().performSelector(Selector("setOrientation:"), withObject: UIInterfaceOrientationMask.Portrait.rawValue)
        }
    }
    
    func sensorStateChange(notification: NSNotificationCenter) {
        if device.proximityState {
            NSLog("close to user")
            //completeCount2 += 1
            updateCountUI()
        } else {
            NSLog("far to user")
        }
    }
    
    
    func updateCountUI() {
        xLabel.text = String(squatDetection.completeCount)
        yLabel.text = String(situpDetection.completeCount)
        zLabel.text = String(situpDetection.completeCount)
        
        countButton.setTitle(squatDetection.isStart == true ? "停 止" : "开 始", forState: UIControlState.Normal)
        countButton2.setTitle(situpDetection.isStart == true ? "停 止" : "开 始", forState: UIControlState.Normal)
        countButton3.setTitle(situpDetection.isStart == true ? "停 止" : "开 始", forState: UIControlState.Normal)
    }
    
    
    func setupViews() {
        
    }

}

extension MotionViewController: ExcerciseDetectionDelegate {
    
    //完成一次动作触发一次
    func exerciseCountDidIncrease(detection detection: ExerciseDetection, count: Int) {
        updateCountUI()
    }
    //侦测动作结束
    func detectDidStop(detection detection: ExerciseDetection) {
        updateCountUI()
    }
    //侦测动作开始
    func detectDidStart(detection detection: ExerciseDetection) {
        updateCountUI()
    }
}
