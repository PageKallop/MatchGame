//
//  ViewController.swift
//  MatchGame
//
//  Created by Page Kallop on 12/3/20.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    
    var model = CardModel()
    
    var cardArray = [Card]()
    
    var firstCardIsFlipped: IndexPath?
    
    var timer: Timer?
    
    var millisecond: Float = 30 * 1000
    
    var soundManager = SoundManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardArray = model.getCards()
      
         // Create timer
       timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        soundManager.playSound(effect: .shuffle)
    }
    
    // Mark:- Timer Methods
    
    @objc func timerElapsed() {
        
        millisecond -= 1
        
       let seconds = String(format: "%.2f", millisecond/1000)
        
        timerLabel.text = "Time Remaining: \(seconds)"
        
        if millisecond <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            // Check if there are remainning cards
            checkGameEnded()
        }
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
        
        if millisecond <= 0 {
            return 
        }
        
       let cell =  collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            cell.flipCard()
            
            soundManager.playSound(effect: .flip)
            
            card.isFlipped = true
            
            if firstCardIsFlipped == nil {
                firstCardIsFlipped = indexPath
            } else {
               checkForMatches(indexPath)
            }
        
        }
        
        
    }
    
    //MARK:- Compares card cells to identify a match 
    
    func checkForMatches(_ secondFlippedCard: IndexPath) {
        
        // Get card flipped cells
        
        let cardOneCell = cardCollectionView.cellForItem(at: firstCardIsFlipped!) as? CardCollectionViewCell
        
        let cardTwoCell = cardCollectionView.cellForItem(at: secondFlippedCard) as? CardCollectionViewCell
        
        // Get cards that were flipped
        
        let cardOne = cardArray[firstCardIsFlipped!.row]
        let cardTwo = cardArray[secondFlippedCard.row]
        
        // Compare cards
        
        if cardOne.imageName == cardTwo.imageName {
            
            soundManager.playSound(effect: .match)
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            // Remove card from grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()
        }
        else {
            
            soundManager.playSound(effect: .noMatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        // If card is nil reload the cell of the first card
        if cardOneCell == nil {
            cardCollectionView.reloadItems(at: [firstCardIsFlipped!])
        }
        
        // Reset tracking of first card flipped 
        firstCardIsFlipped = nil
        
    }
    // Determine if there are cards unmatched
    func checkGameEnded(){
        var isWon = true
       
        for card in cardArray {
            if card.isMatched == false {
            isWon = false
            break
        }
    }
        var title = ""
        var message = ""
    
        if isWon == true {
            
            if millisecond > 0 {
                timer?.invalidate()
            }
            title = "Congratulations!"
            message = "You've Won"
        } else {
            if millisecond > 0 {
                return
            }
            title = "Game Over"
            message = "You Loose"
        }
        showAlert(title, message)
    }
       
       //MARK:-  Create won/lost alert
        func showAlert(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler:
                                            {action -> Void in self.resetGame()})
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func resetGame() {
        cardArray = [Card]()
        cardArray = model.getCards()
        millisecond = 30 * 1000
        soundManager.playSound(effect: .shuffle)
        timerLabel.textColor = UIColor.black
        cardCollectionView.reloadData()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
         
         RunLoop.main.add(timer!, forMode: .common)
        
    }

}

