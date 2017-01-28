//
//  MainTableViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 15/11/12.
//  Copyright © 2015年 wantsor. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var classes: [(String, String)] {
        get {
            return [
                ("Transform", "Transform Demo"),
                ("Timeline", "Timeline Demo"),
                ("AnimationLine", "AnimationLine Demo"),
                ("RotateView", "RotateView Demo"),
                ("CircleProgress", "Use circle express progress"),
                ("VerticalScroll", "VerticalScroll Demo"),
                ("PickerViewDemo", "PickerViewDemo"),
                ("PhotoInfoDemo", "get system photos alums info"),
                ("BaiduMap", "BaiduMap Demo"),
                ("CATransformLayer", "Draw 3D structures"),
                ("CAEmitterLayer", "Render animated particles"),
                ("CompositeAnimation", "a composite animated demo"),
                ("CoreMotion", "a coremotion demo"),
                ("Carousel","Carousel demo"),
                ("ICarousel","ICarousel exercise demo")
            ]
        }
    }
    
    func makeRotateBack() {
        //UIViewController.attemptRotationToDeviceOrientation()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        makeRotateBack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return classes.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClassCell", forIndexPath : indexPath) as UITableViewCell
        let row = indexPath.row
        cell.textLabel!.text = classes[row].0
        cell.detailTextLabel!.text = classes[row].1

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let identifier = classes[indexPath.row].0
        performSegueWithIdentifier(identifier, sender: nil)
    }



}
