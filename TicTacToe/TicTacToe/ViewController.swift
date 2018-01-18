//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jimmy Auldridge on 4/5/16.
//  Copyright © 2016 Jimmy Auldridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var activePlayer = 1
    var gameState = [0,0,0,0,0,0,0,0,0]
    let winningCombo = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var gameActive = true
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var yourTurn: UILabel!
    @IBOutlet weak var winningLabel: UILabel!
    
    @IBOutlet weak var playAgainLabel: UIButton!
    @IBAction func playAgain(sender: AnyObject) {
        yourTurn.text = "O's turn"
        gameState = [0,0,0,0,0,0,0,0,0]
        activePlayer = 1
        gameActive = true
        winningLabel.hidden = true
        winningLabel.center = CGPointMake(winningLabel.center.x - 500, winningLabel.center.y)
        playAgainLabel.hidden = true
        var buttonClean : UIButton
        for i in 0 ..< 9 {
            buttonClean = view.viewWithTag(i) as! UIButton
            buttonClean.setImage(nil, forState: .Normal)
        }
    }
    @IBAction func buttonPressed(sender: AnyObject) {
        if (gameState[sender.tag] == 0 && gameActive == true){
            gameState[sender.tag] = activePlayer
        if activePlayer == 1 {
            yourTurn.text = "X's turn"
        sender.setImage(UIImage(named: "nought.png"), forState: .Normal)
            activePlayer = 2
        } else{
            yourTurn.text = "O's turn"
            sender.setImage(UIImage(named: "cross.png"), forState: .Normal)
            activePlayer = 1
        }
            for combination in winningCombo {
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                    gameActive = false
                    if gameState[combination[0]] == 1 {
                        winningLabel.text = "Circles won!"
                    } else {
                        winningLabel.text = "X's have won!"
                    }
                    endGame()
                }
                
            }
            if gameActive == true {
            gameActive = false
            for buttonState in gameState {
                if buttonState == 0 {
                    gameActive = true
                }
            }
            if gameActive == false {
                winningLabel.text = "It's a draw!"
                endGame()
            }
            }
        }
    }
    func endGame () {
        winningLabel.hidden = false
        playAgainLabel.hidden = false
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.winningLabel.center = CGPointMake(self.winningLabel.center.x + 500, self.winningLabel.center.y)
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        winningLabel.hidden = true
        winningLabel.center = CGPointMake(winningLabel.center.x - 500, winningLabel.center.y)
        playAgainLabel.hidden = true
        yourTurn.text = "O's turn"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

