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
    @IBOutlet weak var cellStackView: UIStackView!
    
    let menuWidth: CGFloat = 0.8
    let percentThreshold: CGFloat = 0.3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlerPan(pan:)))
        cellStackView.addGestureRecognizer(pan)
    }
    
    @objc private func handlerPan(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: cellStackView)
        
        let progress = calculateProgress(translationInView: translation, viewBounds: cellStackView.bounds, direction: .Left)
        
        if progress > 0.8 {
            print("delete cell")
        }
        
        print(translation)
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
    }
}
    

