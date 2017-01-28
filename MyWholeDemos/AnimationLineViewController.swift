//
//  AnimationLineViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/3/3.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit

class AnimationLineViewController: UIViewController {
    
    var lineView : BezierPathLineView!
    var shapeLayerLineView : ShapeLayerLineView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //lineView = BezierPathLineView(frame: self.view.bounds)
        //lineView.buildMenuIcons(2)
        
        shapeLayerLineView = ShapeLayerLineView(frame: self.view.bounds)
        shapeLayerLineView.buildMenuIcons(3)
        let testView = shapeLayerLineView.menuIcons[0]
        UIView.animateWithDuration(1, animations: { () -> Void in
            var frame = testView.frame
            frame.size.height = 100
            testView.frame = frame
        })
        
        
        self.view.addSubview(shapeLayerLineView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - 用UIBezierPath构造的view
class BezierPathLineView : UIView {
    
    var menuIcons:[UIView] = []
    
    override func drawRect(rect: CGRect) {
        buildLine()
    }
    
    //构造菜单图标列表
    func buildMenuIcons(amount : Int){
        let iconSize : CGFloat = 50
        let middleX = (UIScreen.mainScreen().bounds.width - iconSize) / 2
        for index in 0 ... amount {
            let y = CGFloat(100 * index + 100)
            let frame = CGRectMake(middleX, y, iconSize, iconSize)
            let iconView = UIView(frame: frame)
            iconView.backgroundColor = UIColor.blueColor()
            iconView.layer.cornerRadius = 10
            iconView.layer.masksToBounds = true
            menuIcons.append(iconView)
            self.addSubview(iconView)
        }
    }
    
    func buildLine(){
        let color = UIColor.redColor()
        color.set()
        let aPath = UIBezierPath()
        aPath.lineWidth = 1
        
        let startPoint : CGPoint = CGPointMake(menuIcons[0].frame.origin.x + 25, menuIcons[0].frame.origin.y + 25)
        aPath.moveToPoint(startPoint)
        
        let endPoint : CGPoint = CGPointMake(menuIcons[1].frame.origin.x + 25, menuIcons[1].frame.origin.y + 25)
        aPath.addLineToPoint(endPoint)
        aPath.stroke()
    }
}

// MARK: - 用ShapeLayer构造的view
class ShapeLayerLineView : UIView {
    
    let iconTopMargin : CGFloat = 100
    let iconSize : CGFloat = 50
    let cornerRadius : CGFloat = 15
    
    var menuIcons:[UIView] = []
    var shapeLayerLines:[CAShapeLayer] = []
    
    //构造菜单图标列表
    func buildMenuIcons(amount : Int){
        
        let middleX = (UIScreen.mainScreen().bounds.width - iconSize) / 2
        for index in 1 ... amount {
            let y = iconTopMargin * CGFloat(index)
            let frame = CGRectMake(middleX, y, iconSize, iconSize)
            let iconView = UIView(frame: frame)
            iconView.backgroundColor = UIColor.blueColor()
            iconView.layer.cornerRadius = cornerRadius
            iconView.layer.masksToBounds = true
            //增加事件
            bindTouchEvent(iconView)
            menuIcons.append(iconView)
            
            self.addSubview(iconView)
            //划线从第二个view开始划1,2view之间的线
            if(index > 1){
                let lastView = menuIcons[index - 2]
                buildLine(iconView, toView: lastView)
            }
        }
    }
    
    func bindTouchEvent(iconView : UIView){
        let touchEvent = UITapGestureRecognizer(target: iconView, action: #selector(ShapeLayerLineView.iconViewTapAction(_:)))
        iconView.addGestureRecognizer(touchEvent)
    }
    
    func iconViewTapAction(target:UIView){
//        menuIcons.filter { (view) -> Bool in
//            
//        }
    }
    
    func buildLine(fromView : UIView, toView : UIView){
        let startPoint = CGPoint(x: CGRectGetMidX(fromView.frame), y: CGRectGetMidY(fromView.frame))
        let endPoint = CGPoint(x: CGRectGetMidX(toView.frame), y: CGRectGetMidY(toView.frame))
        let linePath = createLinePath(startPoint, endPoint: endPoint)
        let shapeLayerLine = createShapeLayer(linePath)
        shapeLayerLines.append(shapeLayerLine)
        self.layer.insertSublayer(shapeLayerLine, atIndex: 0)
    }
    
    func createShapeLayer(path : CGPathRef) -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.fillColor = nil
        shapeLayer.fillRule = kCAFillRuleNonZero
        shapeLayer.lineCap = kCALineCapButt
        shapeLayer.lineDashPattern = nil
        shapeLayer.lineDashPhase = 0.0
        shapeLayer.lineJoin = kCALineJoinMiter
        shapeLayer.lineWidth = CGFloat(1)
        shapeLayer.miterLimit = 4.0
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        return shapeLayer
    }
    
    func createLinePath(startPoint : CGPoint,endPoint : CGPoint) -> CGPathRef{
        let openPath = UIBezierPath()
        openPath.moveToPoint(startPoint)
        openPath.addLineToPoint(endPoint)
        return openPath.CGPath
    }
}

