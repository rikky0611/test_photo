//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 荒川陸 on 2016/02/25.
//  Copyright © 2016年 riku_arakawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @IBOutlet var photoImageView : UIImageView!
    var selectedImage = Image()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func precentPickerController(sourceType:UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.presentViewController(picker, animated:true, completion:nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        selectedImage.image = image
        photoImageView.image = selectedImage.image
    }
    
    @IBAction func selectButtonTapped(sender: UIButton){
        //選択肢の上に表示するアラート
        let alert = UIAlertController(title: "画像の取得先を選択",message: nil, preferredStyle: .ActionSheet)
        //選択肢設定
        let firstAction = UIAlertAction(title: "カメラ", style: .Default){
            action in
            self.precentPickerController(.Camera)
        }
        let secondAction = UIAlertAction(title: "アルバム", style: .Default){
            action in
            self.precentPickerController(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Default,handler : nil)
        
        //選択肢をアラートに登録
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        alert.addAction(cancelAction)
        
        //アラートを表示
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func resize(){
        selectedImage.image =  selectedImage.resize(selectedImage.image)
        photoImageView.image = selectedImage.image
        
    }
    
    @IBAction func cutInto9Pieces(){
        var imageArray = selectedImage.cutInto9Pieces(selectedImage.image)
        photoImageView.image = imageArray[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

