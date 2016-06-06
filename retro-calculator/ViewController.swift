//
//  ViewController.swift
//  retro-calculator
//
//  Created by Kyle Johannsen on 6/3/16.
//  Copyright © 2016 Kyle Johannsen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outPutLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outPutLbl.text = "Calculate!"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func buttonPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outPutLbl.text = runningNumber
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        reset()
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty && leftValStr != "" {
            //Do the math here
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                
                outPutLbl.text = result
            }
                
            currentOperation = op
            
        } else {
            //This is the first time the operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func reset() {
        outPutLbl.text = "0"
        currentOperation = Operation.Empty
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        result = ""
    }
    
}

