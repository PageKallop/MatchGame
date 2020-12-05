//
//  CardCollectionViewCell.swift
//  MatchGame
//
//  Created by Page Kallop on 12/4/20.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
   
    
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    var card: Card?
    
    func setImage(_ card: Card) {
        
        self.card = card
        
        frontImage.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            UIView.transition(from: backImage, to: frontImage, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: frontImage, to: backImage, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            }
    }
    
    func flipCard(){
        
        UIView.transition(from: backImage, to: frontImage, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews],  completion: nil)
    }
    
    func flipBack(){
        
        UIView.transition(from: frontImage, to: backImage, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews],  completion: nil) 
        
    }
    

}
