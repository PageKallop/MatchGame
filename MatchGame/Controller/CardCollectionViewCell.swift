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
        
        //Track card that got passed in
        
        self.card = card
        // Make match card view invisible
        
        if card.isMatched == true {
            
            backImage.alpha = 0
            frontImage.alpha = 0
        } else {
            // Make non-match card view visible
            backImage.alpha = 1
            frontImage.alpha = 1
        }
        
        frontImage.image = UIImage(named: card.imageName)
        // Determine if card is flipped up or down state
        
        if card.isFlipped == true {
            // FrontView is on top
            UIView.transition(from: backImage, to: frontImage, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: frontImage, to: backImage, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            }
    }
    
    func flipCard(){
        
        UIView.transition(from: backImage, to: frontImage, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews],  completion: nil)
    }
    
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImage, to: self.backImage, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews],  completion: nil)
           }
            
        }
        
   
    
    // Remove card from display
    
    func remove() {
        
        backImage.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImage.alpha = 0
        }, completion: nil)
            
       
        
        
    }
    

}
