//
//  UIPickerDemoViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/3/21.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit

class UIPickerDemoViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataArray1,pickerDataArray2 : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func loadData(){
        pickerDataArray1 = ["1","2","3"]
        pickerDataArray2 = ["1","2","3","4"]
    }
}


extension UIPickerDemoViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerDataArray1.count
        }
        else {
            return pickerDataArray2.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return pickerDataArray1[row]
        }
        else{
            return pickerDataArray2[row]
        }
    }
}