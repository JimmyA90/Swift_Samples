//
//  ViewController.swift
//  RetroCalc
//
//  Created by Jimmy Auldridge on 10/10/16.
//  Copyright © 2016 Jimmy Auldridge. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftVal = ""
    var rightVal = ""
    var result = ""
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
                print(err.debugDescription)
        }
    }
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(operation: currentOperation )
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightVal = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVal)! * (Double(rightVal))!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVal)! / (Double(rightVal))!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVal)! - (Double(rightVal))!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVal)! + (Double(rightVal))!)"
                }
                
                leftVal = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

