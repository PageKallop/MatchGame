//
//  CardModel.swift
//  MatchGame
//
//  Created by Page Kallop on 12/4/20.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        var generatedNumberArray = [Int]()
        
        var generatedCardArray = [Card]()
        
        // Generate pairs of cards
        
        while generatedNumberArray.count < 8 {
            
            // Get random number
            
            let randomNumber = Int.random(in: 1...13)
            
            // Ensures no repeating numbers
            if generatedNumberArray.contains(randomNumber) == false {
             
                print(randomNumber)
                
                generatedNumberArray.append(randomNumber)
                
                // First card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardArray.append(cardOne)
                // Second card object
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardArray.append(cardTwo)
            }
            
          
        }
        for i in 0...generatedCardArray.count - 1{
            
            
        // Find random index to swap
        let randomNumber = Int(arc4random_uniform(UInt32(generatedCardArray.count)))
        // Swap cards
        let temporaryStorage = generatedCardArray[i]
        generatedCardArray[i] = generatedCardArray[randomNumber]
        generatedCardArray[randomNumber] = temporaryStorage
            
        }
        // return array
        return generatedCardArray
    }
}
