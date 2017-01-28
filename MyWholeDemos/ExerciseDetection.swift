//
//  ExcerciseDetection.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/11/25.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import Foundation
import CoreMotion


//下蹲动作结构
enum SquatCycleEnum: Int {
    case Init = 0, DownAcc, DownDeceAndUpAcc, UpDece, Finished
    
    static func nextStep(model: Int) -> Int {
        let newValue = model + 1
        return newValue
    }
}
//俯卧撑动作结构
enum PushUpCycleEnum: Int {
    case Init = 0, Down, Up, Finished
}
//仰卧起坐动作结构
enum SitUpCycleEnum: Int {
    case Init = 0, Up, Down, Finished
}

//运动检测类型定义
enum ExerciseType: Int {
    case Squat = 1,PushUp,SitUp
}

typealias valuesClosure = (x: Double, y: Double, z: Double) -> ()

class ExerciseDetection: NSObject {
    
    let manager = CMMotionManager()
    var delegate: ExcerciseDetectionDelegate?
    var isStart = false
    var exerciseCycle: Int = 0
    var completeCount: Int = 0
    var baseValue: (x: Double, y: Double, z: Double)?
    private(set) var type: ExerciseType!
    var queue = NSOperationQueue.currentQueue()
    
    
    init(type: ExerciseType) {
        self.type = type
        NSLog("ExcerciseDetection has been initialised successfully")
    }
    
    func detectExerciseBegin(countIncreaseHandle: (() -> Void)?) {
        
        switch type! {
        case .PushUp:
            countSitUpCycle(countIncreaseHandle)
        case .SitUp:
            countSitUpCycle(countIncreaseHandle)
        case .Squat:
            countSquatCycle(countIncreaseHandle)
        }
        if let delegate = delegate {
            delegate.detectDidStart(detection: self)
        }
    }

    func detectExerciseEnd() {
        if manager.accelerometerActive {
            manager.stopAccelerometerUpdates()
        }
        if manager.gyroActive {
            manager.stopGyroUpdates()
        }
        if manager.magnetometerActive {
            manager.stopMagnetometerUpdates()
        }
        isStart = false
        completeCount = 0
        exerciseCycle = 0
        if let delegate = delegate {
            delegate.detectDidStop(detection: self)
        }
    }
    //MARK: -> 探测数据方法
    func detectOneSquatCycle(accelerData: CMAcceleration, squatModel: Int) -> Int{
        var newValue: Int = squatModel
        let squatEnum = SquatCycleEnum(rawValue: squatModel)
        if accelerData.y > 0.3 {
            if squatEnum == .Init || squatEnum == .DownDeceAndUpAcc {
                newValue = SquatCycleEnum.nextStep(squatModel)
            }
        } else if accelerData.y < -0.3 {
            if squatEnum == .DownAcc {
                newValue = SquatCycleEnum.nextStep(squatModel)
            }
        } else {
            if squatEnum == .UpDece {
                newValue = SquatCycleEnum.nextStep(squatModel)
            }
        }
        return newValue
    }
    
    //测试一次仰卧起坐完成过程
    func detectOneSitUpCycle(rotateData: CMRotationRate, sitUpModel: Int) -> Int {
        var newValue: Int = sitUpModel
        let sitUpEnum = SitUpCycleEnum(rawValue: sitUpModel)
        if rotateData.x < -1 {
            if sitUpEnum == .Init {
                newValue += 1
            }
        } else if rotateData.x > 1 {
            if sitUpEnum == .Up {
                newValue += 1
            }
        } else {
            if sitUpEnum == .Down {
                newValue += 1
            }
        }
        return newValue
    }
    
    //仰卧起坐计数
    func countSitUpCycle(countIncreaseHandle: (() -> Void)?) {
        if !isStart {
            getOneGyroValue({ (x1, y1, z1) in
                //获取初始参考值
                self.baseValue = (x1, y1, z1)
                //开始定时接收数据
                self.getGyroValues(0.1) {[weak self] (x, y, z) in
                    let logValue = CMRotationRate(x: (x - self!.baseValue!.x), y: (y - self!.baseValue!.y), z: (z - self!.baseValue!.z))
                    NSLog("x:\(logValue.x),y:\(logValue.y),z:\(logValue.z)")
                    self!.exerciseCycle = self!.detectOneSitUpCycle(logValue, sitUpModel: self!.exerciseCycle)
                    self!.isStart = true
                    //全部处理完后在主线程更新类成员变量和更新UI
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        
                        let squatEnum = SitUpCycleEnum(rawValue: self!.exerciseCycle)
                        if squatEnum == SitUpCycleEnum.Finished {
                            self!.exerciseCycle = 0
                            self!.completeCount = self!.completeCount + 1
                        }
                        if let delegate = self?.delegate {
                            delegate.exerciseCountDidIncrease(detection: self!, count: self!.completeCount)
                        }
                        if countIncreaseHandle != nil {
                            countIncreaseHandle!()
                        }
                    })
                }
            })
        }
    }
    //下蹲计数
    func countSquatCycle(countIncreaseHandle: (() -> Void)?) {
        if !isStart {
            getOneAccelerometerValue({(x1, y1, z1) in
                //获取初始参考值
                self.baseValue = (x1, y1, z1)
                //开始定时接收数据
                self.getAccelerometerValues(0.1) {[weak self] (x, y, z) in
                    let logValue = CMAcceleration(x: (x - self!.baseValue!.x), y: (y - self!.baseValue!.y), z: (z - self!.baseValue!.z))
                    NSLog("x:\(logValue.x),y:\(logValue.y),z:\(logValue.z)")
                    self!.exerciseCycle = self!.detectOneSquatCycle(logValue, squatModel: self!.exerciseCycle)
                    self!.isStart = true
                    //全部处理完后在主线程更新类成员变量和更新UI
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        
                        let squatEnum = SquatCycleEnum(rawValue: self!.exerciseCycle)
                        if squatEnum == SquatCycleEnum.Finished {
                            self!.exerciseCycle = 0
                            self!.completeCount = self!.completeCount + 1
                        }
                        if let delegate = self?.delegate {
                            delegate.exerciseCountDidIncrease(detection: self!, count: self!.completeCount)
                        }
                        if countIncreaseHandle != nil {
                            countIncreaseHandle!()
                        }
                    })
                }
            })
        }
    }

    //MARK: -> CoreMotion原始数据加载
    
    /*
     *  getAccelerometerValues:interval:values:
     *
     *  Discussion:
     *   Starts accelerometer updates, providing data to the given handler through the given queue.
     *   Note that when the updates are stopped, all operations in the
     *   given NSOperationQueue will be cancelled. You can access the retrieved values either by a
     *   Trailing Closure or through a Delgate.
     */
    private func getAccelerometerValues (interval: NSTimeInterval = 0.1, values: valuesClosure? ){
        var valX: Double!
        var valY: Double!
        var valZ: Double!
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = interval
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: {
                (data, error) in
                
                if let isError = error {
                    NSLog("Error: %@", isError)
                }
                valX = data!.acceleration.x
                valY = data!.acceleration.y
                valZ = data!.acceleration.z
                
                if values != nil{
                    values!(x: valX,y: valY,z: valZ)
                }
            })
        } else {
            NSLog("The Accelerometer is not available")
        }
    }
    
    /*
     *  getGyroValues:interval:values:
     *
     *  Discussion:
     *   Starts gyro updates, providing data to the given handler through the given queue.
     *   Note that when the updates are stopped, all operations in the
     *   given NSOperationQueue will be cancelled. You can access the retrieved values either by a
     *   Trailing Closure or through a Delegate.
     */
    private func getGyroValues (interval: NSTimeInterval = 0.1, values: valuesClosure? ) {
        var valX: Double!
        var valY: Double!
        var valZ: Double!
        if manager.gyroAvailable{
            manager.gyroUpdateInterval = interval
            manager.startGyroUpdatesToQueue(NSOperationQueue(), withHandler: {
                (data, error) in
                
                if let isError = error{
                    NSLog("Error: %@", isError)
                }
                valX = data!.rotationRate.x
                valY = data!.rotationRate.y
                valZ = data!.rotationRate.z
                
                if values != nil{
                    values!(x: valX, y: valY, z: valZ)
                }
            })
            
        } else {
            NSLog("The Gyroscope is not available")
        }
    }
    
    private func getOneGyroValue(value: valuesClosure) {
        getGyroValues(0.5) { (x, y, z) in
            value(x: x, y: y, z: z)
            self.manager.stopGyroUpdates()
        }
    }
    
    private func getOneAccelerometerValue(value: valuesClosure) {
        getAccelerometerValues(0.5) { (x, y, z) in
            self.manager.stopAccelerometerUpdates()
            value(x: x, y: y, z: z)
            
        }
    }

    deinit {
        if manager.accelerometerActive {
            manager.stopAccelerometerUpdates()
        }
        if manager.gyroActive {
            manager.stopGyroUpdates()
        }
        if manager.magnetometerActive {
            manager.stopMagnetometerUpdates()
        }
    }
}


protocol ExcerciseDetectionDelegate: NSObjectProtocol {
    //完成一次动作触发一次
    func exerciseCountDidIncrease(detection detection: ExerciseDetection, count: Int)
    //侦测动作结束
    func detectDidStop(detection detection: ExerciseDetection)
    //侦测动作开始
    func detectDidStart(detection detection: ExerciseDetection)
}
