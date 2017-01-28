//
//  CircleProgressView.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/3/10.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit

class AICircleProgressView: UIView {
    
    var backLayer: CAShapeLayer!
    var fontLayer: CAShapeLayer!
    var strokWidth: CGFloat = 10
    var circlePadding: CGFloat = 1
    var isSelect: Bool = false
    //取值为0-1
    var progress: CGFloat?
    var delegate: CircleProgressViewDelegate?
    
    var backLayerColor = UIColor(rgba: "#0b0c38")
    var frontLayerColor = UIColor.greenColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    init(frame: CGRect, strokWidth: CGFloat, circlePadding: CGFloat, backLayerColor: UIColor, frontLayerColor: UIColor) {
        self.strokWidth = strokWidth
        self.circlePadding = circlePadding
        self.backLayerColor = backLayerColor
        self.frontLayerColor = frontLayerColor
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUp() {
        backLayer = CAShapeLayer()
        backLayer.fillColor = UIColor.clearColor().CGColor
        backLayer.frame = self.bounds
        backLayer.lineWidth = strokWidth
        backLayer.backgroundColor = UIColor.clearColor().CGColor
        
        fontLayer = CAShapeLayer()
        fontLayer.fillColor = UIColor.clearColor().CGColor
        
        fontLayer.frame = self.bounds
        fontLayer.lineWidth = strokWidth
        fontLayer.lineCap = kCALineCapRound
        fontLayer.lineJoin = kCALineJoinRound
        
        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(fontLayer)
        
        setCircleLayer()
    }
    
    private func setCircleLayer() {
        makeGradientColor()
        bindTapEvent()
        
        let frame = CGRect(x: -(strokWidth + circlePadding) / 2, y:-(strokWidth + circlePadding) / 2, width: self.bounds.width + strokWidth + circlePadding, height: self.bounds.height + strokWidth + circlePadding)
        let path = UIBezierPath(roundedRect: frame, cornerRadius: frame.width / 2)
        backLayer.path = path.CGPath
        backLayer.strokeColor = backLayerColor.CGColor
    }
    
    func refreshProgress(progress: CGFloat) {
        self.progress = progress
        let centerPoint = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        let radius = (CGRectGetWidth(self.bounds) + strokWidth + circlePadding) / 2
        let endAngle = CGFloat(2*M_PI)*progress - CGFloat(M_PI_2)
        let path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: endAngle, clockwise: true)
        fontLayer.path = path.CGPath
        //fontLayer.strokeEnd = 0
        startAnimation()
    }
    
    private func startAnimation() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = NSNumber(float: 0)
        animation.toValue = NSNumber(float: 1)
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = true
        animation.duration = 0.5 + Double((self.progress ?? 0) / 10) //Default Value: 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        fontLayer.addAnimation(animation, forKey: "strokeEnd")
    }
    
    private func makeGradientColor() {
        
//        let frame = CGRect(x: -(strokWidth + circlePadding) / 2, y:-(strokWidth + circlePadding) / 2, width: self.bounds.width + strokWidth + circlePadding, height: self.bounds.height + strokWidth + circlePadding + 10)
        
//        frontLayerColor = UIColor.colorWithGradientStyle(UIGradientStyle.UIGradientStyleTopToBottom, frame: frame, colors: [UIColor(rgba: "#2477e8"), UIColor(rgba: "#e30ab2"), UIColor(rgba: "#7B40D3"), UIColor(rgba: "#2477e8")])
        fontLayer.strokeColor = frontLayerColor.CGColor
        fontLayer.setNeedsDisplay()
        
    }
    //设置选中还是未选中状态
    private func changeSelect(isSelect: Bool) {
        self.isSelect = isSelect
        //因为半径已经变了，所以frame不再从0开始
        let frame = CGRect(x: -(strokWidth + circlePadding) / 2, y:-(strokWidth + circlePadding) / 2, width: self.bounds.width + strokWidth + circlePadding, height: self.bounds.height + strokWidth + circlePadding)
        let path = UIBezierPath(roundedRect: frame, cornerRadius: frame.width / 2)
        //需要remove吗
        fontLayer.removeAllAnimations()
        if isSelect {
            
            //改变颜色时不需要动画，用这个禁用
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            fontLayer.path = path.CGPath
            fontLayer.strokeColor = UIColor(rgba: "0f86e8").CGColor
            CATransaction.commit()
            
        } else {
            let progressCurrent = progress ?? 0
            if progressCurrent > 0 {
                
                makeGradientColor()
                refreshProgress(progressCurrent)
            } else {
                //改变颜色时不需要动画，用这个禁用
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                fontLayer.path = path.CGPath
                fontLayer.strokeColor = UIColor.clearColor().CGColor
                CATransaction.commit()
            }
        }
    }
    
    func bindTapEvent() {
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(AICircleProgressView.selectAction(_:)))
        self.addGestureRecognizer(tapGuesture)
    }
    
    @objc private func selectAction(sender: UIGestureRecognizer) {
        isSelect = !isSelect
        //触发delegate
        if let delegate = delegate {
            delegate.viewDidSelect(self)
        }
        changeSelect(isSelect)
        
    }
}

//MARK: - delegate，处理选中事件
@objc
protocol CircleProgressViewDelegate {
    
    func viewDidSelect(circleView: AICircleProgressView)
}
