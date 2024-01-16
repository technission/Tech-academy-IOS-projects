//
//  ViewController.swift
//  TicTacToe
//
//  Created by Steve on 1/16/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //need to declare to audio players here so the background music does not stop
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    @IBOutlet weak var Scoreboard: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    var count = 1
    var activePlayer = 1 //Cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var gameIsActive = true
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    //play again button
    @IBAction func playAgain(_ sender: Any) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        playAgainButton.isHidden = true
        Scoreboard.isHidden = true
        
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    //action to take when a button is clicked
    @IBAction func action(_ sender: AnyObject) {
        //play sound
        let pathToSound2 = Bundle.main.path(forResource: "click", ofType: "mp3")!
        let url2 = URL(fileURLWithPath: pathToSound2)
        
        do
        {
            audioPlayer2 = try AVAudioPlayer(contentsOf: url2)
            audioPlayer2?.play()
        }
        catch
        {
            print(error)
        }
        //end playing sound
        
        if (gameState[sender.tag-1] == 0 && gameIsActive == true) {
            gameState[sender.tag-1] = activePlayer
            if (activePlayer == 1) {
                sender.setImage(UIImage(named: "cross.png"), for: UIControl.State())
                
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "circle.png"), for: UIControl.State())
                activePlayer = 1
            }
        }
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                gameIsActive = false
                
                if gameState[combination[0]] == 1 {
                    Scoreboard.text = "Cross has won!"
                } else {
                    Scoreboard.text = "Circle has won!"
                }
                
                if gameIsActive == true {
                    for i in gameState {
                        count = i * count
                    }
                    if count != 0 {
                        Scoreboard.text = "It was a draw!"
                        Scoreboard.isHidden = false
                        playAgainButton.isHidden = false
                    }
                }
                playAgainButton.isHidden = false
                Scoreboard.isHidden = false
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // background music code start
        let pathToSound = Bundle.main.path(forResource: "bgMusic", ofType: "mp3")!
                let url = URL(fileURLWithPath: pathToSound)
        
                do
                {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                }
                catch
                {
                    print(error)
              }
        //background music code stop
        // Do any additional setup after loading the view.
    }


}

