//
//  SoundManager.swift
//  MatchGame
//
//  Created by Page Kallop on 12/5/20.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        case shuffle
        case match
        case noMatch
    }
    
    
    func playSound(effect: SoundEffect){
        var soundFilename = ""
        // Determine sound effect and set filename
        switch effect {
        case .flip:
            soundFilename = "cardflip"
        case.shuffle:
            soundFilename = "shuffle"
        case .match:
            soundFilename = "dingcorrect"
        case.noMatch:
            soundFilename = "dingwrong"
        }
        // Get path to sound file
       let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("couldn't find sound file")
            return
        }
        // Creat a URL object
        
        let soundURL = URL(fileURLWithPath: bundlePath!)
        // Create audio player object
        do{
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
           
            //Play sound 
            audioPlayer?.play()
        } catch{
            print("Failed creating audio object")
        }
    }
}
