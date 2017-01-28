//
//  VerticalScrollViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/3/11.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit

class VerticalScrollViewController: UIViewController,VerticalScrollViewDelegate {

    var scrollView : AIVerticalScrollView!
    var models : [IconServiceIntModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置了以后才不会默认为导航留出空间
        edgesForExtendedLayout = .None
        
        let frame = CGRect(x: UIScreen.mainScreen().bounds.width / 2, y: 60, width: 50, height: 300)
        scrollView = AIVerticalScrollView(frame: frame)
        scrollView.userInteractionEnabled = true
        scrollView.myDelegate = self
        //scrollView.backgroundColor = UIColor.blueColor()
        view.addSubview(scrollView)
        
        loadData()
        scrollView.loadData(models!)
    }
    
    func loadData(){
        models = [IconServiceIntModel(serviceInstId: 1, serviceIcon: "Seller_Warning", serviceInstStatus: 0, executeProgress: 2),
        IconServiceIntModel(serviceInstId: 1, serviceIcon: "Seller_Warning", serviceInstStatus: 0, executeProgress: 3),
        IconServiceIntModel(serviceInstId: 2, serviceIcon: "Seller_Warning", serviceInstStatus: 1, executeProgress: 4),
        IconServiceIntModel(serviceInstId: 3, serviceIcon: "Seller_Warning", serviceInstStatus: 1, executeProgress: 5),
        IconServiceIntModel(serviceInstId: 4, serviceIcon: "Seller_Warning", serviceInstStatus: 0, executeProgress: 6),
        IconServiceIntModel(serviceInstId: 5, serviceIcon: "Seller_Warning", serviceInstStatus: 1, executeProgress: 7),
        IconServiceIntModel(serviceInstId: 6, serviceIcon: "Seller_Warning", serviceInstStatus: 1, executeProgress: 8),
        IconServiceIntModel(serviceInstId: 7, serviceIcon: "Seller_Warning", serviceInstStatus: 0, executeProgress: 2),
        IconServiceIntModel(serviceInstId: 8, serviceIcon: "Seller_Warning", serviceInstStatus: 0, executeProgress: 2)]
        
        
    }
    
    func viewCellDidSelect(verticalScrollView : AIVerticalScrollView , index : Int , cellView : UIView){
        var message = ""
        
        for selectModel in verticalScrollView.getSelectedModels(){
            message += "\(selectModel.serviceInstId), "
        }
        let alert = UIAlertController(title: "info", message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}
