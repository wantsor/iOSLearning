//
//  TimelineViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/3/3.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var timelineModels : [AITimelineModel]!
    var cachedCells = Dictionary<Int,AITimelineCellBaseView>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        initTable()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        timelineModels = [AITimelineModel(timestamp: 1457403751, id: 1, title: "title1 wantsor", desc: "content1 needreply",status: 0),
        AITimelineModel(timestamp: 1457403751, id: 1, title: "title2 wantsor", desc: "content2 needreply",status: 0),
        AITimelineModel(timestamp: 1457403751, id: 1, title: "title3 wantsor", desc: "content3 needreply",status: 1),
        AITimelineModel(timestamp: 1457403751, id: 1, title: "title4 wantsor", desc: "content4 needreply",status: 0)]
    }

    func initTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let backgroundImageView = UIImageView(frame: tableView.bounds)
        let backgroundImage = UIImage(named: "cell_background")
        backgroundImageView.image = backgroundImage
        tableView.backgroundView = backgroundImageView
    }
}

extension TimelineViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellView = getCellWithIndexPath(indexPath)
        return cellView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellView = getCellWithIndexPath(indexPath)
        return cellView.getContentHeight()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineModels.count
    }

    func getCellWithIndexPath(indexPath : NSIndexPath) -> AITimelineCellBaseView{
        if (cachedCells[indexPath.row] != nil) {
            return cachedCells[indexPath.row]!
        }
        else{
            let model = timelineModels[indexPath.row]
            let cellFrame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0)
            let cellView = AITimelineCellBaseView(frame: cellFrame)
            //如果是最后一个model，传入一个标志，view就不加下面的竖线
            var isLastModel = false
            if(indexPath.row == timelineModels.count - 1){
                isLastModel = true
            }
            cellView.setContent(model,isLast: isLastModel)
            cachedCells[indexPath.row] = cellView
            return cellView
        }
    }
}
