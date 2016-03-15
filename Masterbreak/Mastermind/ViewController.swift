//
//  ViewController.swift
//  Masterbreak
//
//  Created by Daniel Matias Ferrer on 05/01/16.
//  Copyright © 2016 Daniel Matias Ferrer. All rights reserved.
//

import UIKit

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

                    updateStats(numberBets: bets)
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

    func updateStats(numberBets bets:Int) {
        
        func calculateNewMean (stats: MBStats, bets: Int) -> Float {
            var newMean = Float(stats.num)*stats.mean
            newMean += Float(bets) + 1.0
            newMean /= Float(stats.num) + 1
            
            return newMean
        }
        
        guard let loadedData = NSUserDefaults.standardUserDefaults().dictionaryForKey("stats") as! [String:Float]? else {
            NSUserDefaults.standardUserDefaults().setObject(["mean": bets, "min": bets, "num": 1.0], forKey: "stats")
            NSUserDefaults.standardUserDefaults().synchronize()
            return
        }
        
        let oldStats = MBStats(mean: loadedData["mean"]!, min: Int(loadedData["min"]!), num: Int(loadedData["num"]!))
        let newMean = calculateNewMean(oldStats, bets: bets)
        let newMin = min(oldStats.min, bets)
        let newNum = oldStats.num + 1
        
        NSUserDefaults.standardUserDefaults().setObject(["mean": newMean, "min": Float(newMin), "num": Float(newNum)], forKey: "stats")
        
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

