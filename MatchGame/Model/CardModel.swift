//
//  CardModel.swift
//  MatchGame
//
//  Created by Page Kallop on 12/4/20.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        var generatedCardArray = [Card]()
        
        for _ in 1...8 {
            
            let randomNumber = Int.random(in: 0...13)
            
            print(randomNumber)
            
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            generatedCardArray.append(cardOne)
       
        
        let cardTwo = Card()
        cardTwo.imageName = "card\(randomNumber)"
        
        generatedCardArray.append(cardTwo)
        }
        return generatedCardArray
    }
}
