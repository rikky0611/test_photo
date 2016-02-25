//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 荒川陸 on 2016/02/25.
//  Copyright © 2016年 riku_arakawa. All rights reserved.
//

import SpriteKit
import UIKit


class GameScene: SKScene {
   	
	let rotateEach = true;
		
    class clsPiece{
		var id: Int
        var row: Int
        var col: Int
        var angle: Int
        
		init(id_:Int,row_:Int,col_:Int,angle_:Int){
			self.id = id_
            self.row = row_
            self.col = col_
            self.angle = angle_
        }
	}
	
    var clsPieceList = [clsPiece]()
    var pieceList = [SKSpriteNode]()
	var pieceSideLength: Int = 133
	var pieceSideLengthOnDevice: CGFloat = 133.0
    var rowMax: Int = 3
    var colMax: Int = 3
    var tmpImageName = "1.png"
	var pieceScale: CGFloat = 1.0
	
	var buttonList = [UIButton]()
	
	
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //AppDelegateのインスタンスを取得

        let pieceTypes = appDelegate.imageArray
        NSLog("\(pieceTypes.count)")
		
		//ピースを並べる
		pieceScale = (CGFloat)(self.size.width/(CGFloat)((colMax+2)*pieceSideLength))
		pieceSideLengthOnDevice = (CGFloat)(pieceSideLength)*pieceScale
		
		for(var i=0; i<rowMax; i++){
			for(var j=0; j<colMax; j++){
				clsPieceList.append(clsPiece(id_: i*colMax+j, row_: i, col_: j, angle_: 0))
                //ピース生成
                pieceList.append(SKSpriteNode(texture: SKTexture(image: pieceTypes[self.clsPieceList[i*colMax + j].id])))
				pieceList[i*colMax + j].position = CGPoint(x: (CGFloat)(self.size.width/(CGFloat)(rowMax+2)*(CGFloat)(j+1))+pieceScale*(CGFloat)(pieceSideLength/2),y: (CGFloat)(self.size.height/(CGFloat)(colMax+2))+pieceScale*(CGFloat)(pieceSideLength/2)+pieceScale*(CGFloat)(pieceSideLength*i))
				pieceList[i*colMax + j].xScale = pieceScale
				pieceList[i*colMax + j].yScale = pieceScale
				addChild(pieceList[i*colMax + j])
			}
		}
		
		//回転ボタン
		
		for(var i=0; i<rowMax-1; i++){
			for(var j=0; j<colMax-1; j++){
				buttonList.append(UIButton())
				buttonList[i*(colMax-1) + j].frame = CGRectMake(0,0,30,30)
				buttonList[i*(colMax-1) + j].backgroundColor = UIColor.redColor();
				buttonList[i*(colMax-1) + j].layer.masksToBounds = true
				buttonList[i*(colMax-1) + j].setTitle("Add Block", forState: UIControlState.Normal)
				buttonList[i*(colMax-1) + j].setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
				buttonList[i*(colMax-1) + j].setTitle("Done", forState: UIControlState.Highlighted)
				buttonList[i*(colMax-1) + j].setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
				buttonList[i*(colMax-1) + j].layer.cornerRadius = 20.0
				buttonList[i*(colMax-1) + j].layer.position = CGPoint(x: (CGFloat)(self.size.width/(CGFloat)(rowMax+2)*(CGFloat)(j+2)), y: (CGFloat)(self.size.height)-((CGFloat)(self.size.height/(CGFloat)(colMax+2))+pieceScale*(CGFloat)(pieceSideLength*(i+1))))
                
				buttonList[i*(colMax-1) + j].tag = i*(colMax-1) + j
				buttonList[i*(colMax-1) + j].addTarget(self, action: "onClickRotationButton:", forControlEvents: .TouchUpInside)
				self.view!.addSubview(buttonList[i*(colMax-1) + j]);
			}
		}
		
        let originalImageView = UIImageView()
        originalImageView.frame = CGRectMake(0,0,133,133)
        originalImageView.image = appDelegate.originalImage
        self.view!.addSubview(originalImageView)
        
    }
	
	func onClickRotationButton(sender : UIButton!){
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //AppDelegateのインスタンスを取得
        let pieceTypes = appDelegate.imageArray
		
		for(var i = 0;i < rowMax*colMax; i++) {
			pieceList[i].removeFromParent()
		}
		pieceList = []
		//tag取得
		var buttonListTag: Int = 0
		buttonListTag = sender.tag
		let buttonRow: Int = buttonListTag/(colMax-1)
		let buttonCol: Int = buttonListTag%(colMax-1)
		
		//pieceの回転
		rotationPieces(&clsPieceList[buttonRow*colMax + buttonCol].id, id2: &clsPieceList[(buttonRow+1)*colMax + buttonCol].id, id3: &clsPieceList[(buttonRow+1)*colMax + buttonCol+1].id, id4: &clsPieceList[buttonRow*colMax + buttonCol+1].id, angle1:&clsPieceList[buttonRow*colMax + buttonCol].angle, angle2: &clsPieceList[(buttonRow+1)*colMax + buttonCol].angle, angle3: &clsPieceList[(buttonRow+1)*colMax + buttonCol+1].angle, angle4: &clsPieceList[buttonRow*colMax + buttonCol+1].angle)
		
		for(var i=0; i<rowMax; i++){
			for(var j=0; j<colMax; j++){
				//				tmpImageName = String(i*colMax + j) + ".png"
				pieceList.append(SKSpriteNode(texture: SKTexture(image: pieceTypes[clsPieceList[i*colMax + j].id])))
				pieceList[i*colMax + j].position = CGPoint(x: (CGFloat)(self.size.width/(CGFloat)(rowMax+2)*(CGFloat)(j+1))+pieceScale*(CGFloat)(pieceSideLength/2),y: (CGFloat)(self.size.height/(CGFloat)(colMax+2))+pieceScale*(CGFloat)(pieceSideLength/2)+pieceScale*(CGFloat)(pieceSideLength*i))
				pieceList[i*colMax + j].xScale = pieceScale
				pieceList[i*colMax + j].yScale = pieceScale
				pieceList[i*colMax + j].zRotation = (CGFloat)(clsPieceList[i*colMax + j].angle)/(CGFloat)(180.0)*(CGFloat)(M_PI)
				addChild(pieceList[i*colMax + j])
			}
		}
		
	}
	
	func rotationPieces(inout id1:Int,inout id2:Int,inout id3:Int,inout id4:Int, inout angle1:Int,inout angle2:Int,inout angle3:Int,inout angle4:Int){
		var tmpid : Int
		var tmpangle : Int
		tmpid = id4
		id4 = id3
		id3 = id2
		id2 = id1
		id1 = tmpid
		tmpangle = (angle4+270*Int(rotateEach))%360
		angle4 = (angle3+270*Int(rotateEach))%360
		angle3 = (angle2+270*Int(rotateEach))%360
		angle2 = (angle1+270*Int(rotateEach))%360
		angle1 = tmpangle
	}
	
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
