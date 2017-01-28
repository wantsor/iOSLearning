//
//  PhotoInfoViewController.swift
//  MyWholeDemos
//
//  Created by 刘先 on 16/4/11.
//  Copyright © 2016年 wantsor. All rights reserved.
//

import UIKit
import Photos

class PhotoInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let asset = getLastPhotoAsset()
        getImageFromPHAsset(asset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func getLastPhotoAsset() -> PHAsset{
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let assetsFetchResults = PHAsset.fetchAssetsWithOptions(options)
        return assetsFetchResults.firstObject as! PHAsset
    }

    func getImageFromPHAsset(asset : PHAsset) {
        let options = PHContentEditingInputRequestOptions()
        options.networkAccessAllowed = true
        asset.requestContentEditingInputWithOptions(options) { (contentEditingInput : PHContentEditingInput?, _) in
            let fullImage = CIImage(contentsOfURL: contentEditingInput!.fullSizeImageURL!)
            print(fullImage?.properties)
        }
        
//        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSize(width: 300, height: 300), contentMode: PHImageContentMode.Default, options: nil) { (image, info) -> Void in
//            if let isFullImageKey = info!["PHImageResultIsDegradedKey"] as? Int{
//                if isFullImageKey == 0{
//                    //let cgImageRef = image?.CGImage
//                    //let data = UIImageJPEGRepresentation(image!, 0)
//                    let data = UIImagePNGRepresentation(image!)
//                    let cfData = CFDataCreate(kCFAllocatorDefault, UnsafePointer<UInt8>(data!.bytes), data!.length)
//                    let cgImageSource = CGImageSourceCreateWithData(cfData, nil)
//                    let properties = NSDictionary(dictionary: CGImageSourceCopyProperties(cgImageSource!, nil)!)
//                    print("photo properties: \(properties)")
//                }
//            }
//            
//        }
    }
}
