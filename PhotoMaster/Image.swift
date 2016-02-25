//
//  Image.swift
//  PhotoMaster
//
//  Created by 荒川陸 on 2016/02/25.
//  Copyright © 2016年 riku_arakawa. All rights reserved.
//

import Foundation
import UIKit

class Image : UIImage {
    var image : UIImage!
    
    func resize(var image:UIImage)->UIImage{
        if image.size.width != image.size.height{
            //リサイズ
            let size = CGSize(width: 399, height: 399)
            UIGraphicsBeginImageContext(size)
            image.drawInRect(CGRectMake(0, 0, size.width, size.height))
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image
    }
    
    func cutInto9Pieces(image:UIImage)->[UIImage]{
        var imageArray : [UIImage] = []
        // イメージの解像度に従いrectも換算
        //let scale = image.scale
        //一辺の長さ
        let length = image.size.width/3
        for var i=0;i<3;i++ {
            for var j=0;j<3;j++ {
                let cropRect : CGRect = CGRectMake(length*CGFloat(i),length*CGFloat(j),length,length)
                // 指定された範囲を切り抜いたCGImageRefを生成しUIImageとする
                
                let cropRef   = CGImageCreateWithImageInRect(image.CGImage, cropRect)
                
                let cropImage = UIImage(CGImage: cropRef!)
                imageArray.append(cropImage)
            }
        }
        return imageArray
    }
    
}
