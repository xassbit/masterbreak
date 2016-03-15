//
//  ViewController.swift
//  Masterbreak
//
//  Created by Daniel Matias Ferrer on 05/01/16.
//  Copyright © 2016 Daniel Matias Ferrer. All rights reserved.
//

import UIKit

//key-value setup

let kNumberGames = "games"
var numberGames : Int?

let kAverageBets = "average"
var averageBets : Float?

let kMinimumBets = "minimum"
var minimumBets : Int?

class ViewController: UIViewController {
    
    var key = MBKey.masterKey
    let again = "Try Again"
    var bets = 0
    


    @IBOutlet weak var betField: UILabel!
    @IBOutlet weak var labelWrong: UILabel!
    @IBOutlet weak var labelRight: UILabel!
    @IBOutlet weak var previousBets: UITextView!
    @IBOutlet weak var numberBets: UILabel!
    
    //custom keyboard
    
    @IBAction func button0(sender: AnyObject) {
        if betField.text! != again {
            betField.text! += "0"
        } else {
            betField.text = "0"
        }
    }
    @IBAction func button1(sender: AnyObject) {
        if betField.text! != again {
            betField.text! += "1"
        } else {
            betField.text = "1"
        }
    }
    @IBAction func button2(sender: AnyObject) {
        if betField.text! != again {
            betField.text! += "2"
        } else {
            betField.text = "2"
        }
    }
    @IBAction func button3(sender: AnyObject) {
        if betField.text! != again {
            betField.text! += "3"
        } else {
            betField.text = "3"
        }
    }
    @IBAction func button4(sender: AnyObject) {
        if betField.text! != again {
            betField.text! += "4"
        } else {
            betField.text = "4"
        }
    }
    @IBAction func backspace(sender: AnyObject) {
        if betField.text! != again {
            if betField.text!.characters.count != 0 {
                betField.text!.removeAtIndex(betField.text!.endIndex.predecessor())
            }
        } else {
            betField.text = ""
        }
    }
    
    //action buttons
    
    @IBAction func buttonNew(sender: AnyObject) {
        clearFields()
    }
    
    @IBAction func buttonGo(sender: AnyObject) {
        
        if betField.text! != again {
            //let bet = stringToArrayOfInts(betField.text!)
            let bet = MBBet(codeString: betField.text!)
            if key.code.isEmpty {
                key.update()
        }
            if bet.code.count == 6 {
                let result = bet.verifyBet()
                let newText = "\(betField.text!) \(result.1)-\(result.0)\n"
                
                betField.text = ""
                labelRight.text = "\(result.0)"
                labelWrong.text = "\(result.1)"
                previousBets.text = newText + previousBets.text!
                previousBets.textAlignment = betField.textAlignment
                previousBets.font = betField.font
                
                bets += 1
                numberBets.text = "#bets: \(bets)"
                
                if result.0 == 6 {
                    let alertController = UIAlertController(title: "You did it!", message:
                        "You won after \(bets) bets.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    addToStats(numberBets: bets)
                    clearFields()
                }
                
            } else {
                betField.text = again
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let loadedData = NSUserDefaults.standardUserDefaults().integerForKey(kNumberGames) as Int? {
            numberGames = loadedData
        }
        
        if let loadedData = NSUserDefaults.standardUserDefaults().floatForKey(kAverageBets) as Float? {
            averageBets = loadedData
        }
        
        if let loadedData = NSUserDefaults.standardUserDefaults().integerForKey(kMinimumBets) as Int? {
            minimumBets = loadedData
        }
    }
    
    func addToStats(numberBets bets: Int) {
        if let loadedData = NSUserDefaults.standardUserDefaults().integerForKey(kNumberGames) as Int? {
            numberGames = loadedData
        }
        
        if let loadedData = NSUserDefaults.standardUserDefaults().floatForKey(kAverageBets) as Float? {
            averageBets = loadedData
        }
        
        if let loadedData = NSUserDefaults.standardUserDefaults().integerForKey(kMinimumBets) as Int? {
            minimumBets = loadedData
        } else {
            minimumBets = 0
        }
        
        if (numberGames != nil) {
            if (averageBets != nil) {
                let newAverage = ((Float(numberGames!) * averageBets!) + Float(bets)) / (Float(numberGames!) + 1)
                averageBets = newAverage
                NSUserDefaults.standardUserDefaults().setFloat(averageBets!, forKey: kAverageBets)
            }
            numberGames! += 1
            NSUserDefaults.standardUserDefaults().setInteger(numberGames!, forKey: kNumberGames)
        }
        
        if bets < minimumBets! {
            minimumBets = bets
            NSUserDefaults.standardUserDefaults().setInteger(minimumBets!, forKey: kMinimumBets)
        } else if minimumBets == 0 {
            minimumBets = bets
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func clearFields() {
        betField.text = ""
        labelRight.text = "0"
        labelWrong.text = "0"
        previousBets.text = ""
        numberBets.text = "#bets: 0"
        bets = 0
        key.update()
    }

}

