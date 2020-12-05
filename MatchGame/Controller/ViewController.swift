//
//  ViewController.swift
//  MatchGame
//
//  Created by Page Kallop on 12/3/20.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    
    var model = CardModel()
    
    var cardArray = [Card]()
    
    var firstCardIsFlipped: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
      
        
        cardArray = model.getCards()
    }
    
    //MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
       
        let card = cardArray[indexPath.row]
        
        cell.setImage(card) 
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let cell =  collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            cell.flipCard()
            
            card.isFlipped = true
            
            if firstCardIsFlipped == nil {
                firstCardIsFlipped = indexPath
            } else {
                print("flippy")
            }
        
        }
        
        
    }
    
    func checkForMatches(_ secondFlippedCard: IndexPath) {
        
        let cardOneCell = cardCollectionView.cellForItem(at: firstCardIsFlipped!) as? CardCollectionViewCell
        
    }


}

