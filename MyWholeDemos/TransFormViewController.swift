//
//  TransFormViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 15/11/12.
//  Copyright © 2015年 wantsor. All rights reserved.
//

import UIKit

class TransFormViewController: UIViewController {
    
    
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var rotateSilder: UISlider!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rotateSilder.addTarget(self, action: #selector(TransFormViewController.slideAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        secondView.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        backgroundView.transform = CGAffineTransformMakeRotation(0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideAction(target:UISlider){
        
        backgroundView.transform = CGAffineTransformMakeRotation(CGFloat(target.value))
    }

        //MARK: - Actions
    @IBAction func AnimatiedAction(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.backgroundView.transform = CGAffineTransformMakeRotation(0)
            }, completion: {
                (finished) -> Void in
                //self.backgroundView.transform = CGAffineTransformMakeRotation(0)
        })
    }
    
    @IBAction func transitionAction(sender: UIButton) {
        UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlUp, animations: {
            self.secondView.hidden = !self.secondView.hidden
            self.backgroundView.hidden = !self.backgroundView.hidden
            }, completion: nil)
    }

}
