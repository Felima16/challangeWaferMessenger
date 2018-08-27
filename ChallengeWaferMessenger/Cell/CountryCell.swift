//
//  CountryCell.swift
//  ChallengeWaferMessenger
//
//  Created by Fernanda de Lima on 22/08/2018.
//  Copyright © 2018 FeLima. All rights reserved.
//

import UIKit

enum Direction{
    case Left
    case Right
    case Up
    case Down
}


class CountryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var cellStackView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func actionDeleteButton(_ sender: Any) {
        //delete cell
        NotificationCenter.default.post(name: Notification.Name("deleteCell"), object: nil, userInfo: indexDataDict)
    }
    
    var showButton = false
    var xInitialView: CGFloat = 0.0
    var initialProgress: CGFloat = 0.0
    var indexDataDict:[String: IndexPath] = [:]
    var index:IndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        xInitialView = cellStackView.layer.position.x
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlerPan(pan:)))
//        cellStackView.addGestureRecognizer(pan)
    }
    
  /*  override func didMoveToWindow() {
        super.didMoveToWindow()
        //send index to delete on the table
        indexDataDict = ["index": index]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch \(indexDataDict)")
        NotificationCenter.default.post(name: Notification.Name("selectedCell"), object: nil, userInfo: indexDataDict)
    }
    
    @objc private func handlerPan(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: cellStackView)
        
        var progress = calculateProgress(translationInView: translation, viewBounds: cellStackView.bounds, direction: .Left)
        progress = progress + initialProgress
        
        if (pan.velocity(in: cellStackView).x < -4000){
            NotificationCenter.default.post(name: Notification.Name("deleteCell"), object: nil, userInfo: indexDataDict)
            return
        }
        
        switch pan.state {
        case .began:
            initialProgress = showButton ? 0.2 : 0.0
        case .changed:
            cellStackView.layer.position.x = calculatePosition(progress)
            if progress <= 0.2{
                deleteButton.layer.position.x = cellStackView.layer.position.x + cellStackView.frame.width/2 + deleteButton.frame.width/2
            }
            showButton = progress < 0.2 ? false : true
        case .ended:
            autoAnimation(progress)
        default:
            break
        }
    }
    
    private func calculatePosition(_ progress:CGFloat) -> CGFloat{
        let invProgress = 1.0 - progress
        let pointOriginView = cellStackView.frame.width/2
        let widthWithProgress = cellStackView.frame.width * invProgress
        return widthWithProgress - pointOriginView
    }
    
    private func autoAnimation(_ progress: CGFloat){
        if progress <= 0.2 {
            
            UIView.animate(withDuration: 0.25) {
                self.cellStackView.layer.position.x = self.xInitialView
                self.deleteButton.layer.position.x = self.cellStackView.layer.position.x + self.cellStackView.frame.width/2 + self.deleteButton.frame.width/2
            }
        }
        
        if (progress > 0.2) && (progress < 0.8){
            UIView.animate(withDuration: 0.25) {
                self.cellStackView.layer.position.x = self.calculatePosition(0.2)
            }
        }
        
        if progress >= 0.8 {
            UIView.animate(withDuration: 0.2, animations: {
                self.cellStackView.layer.position.x = -200
            }) { (completion) in
                NotificationCenter.default.post(name: Notification.Name("deleteCell"), object: nil, userInfo: self.indexDataDict)
            }
        }
    }
    

    private func calculateProgress(translationInView: CGPoint, viewBounds:CGRect, direction: Direction) -> CGFloat{
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        
        switch direction {
        case .Up, .Down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .Left, .Right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        
        let movementOnAxis = pointOnAxis/axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        
        switch direction {
        case .Right,.Down: //positive
            positiveMovementOnAxis = fmax(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .Left, .Up: //negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmax(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }*/
}
    

