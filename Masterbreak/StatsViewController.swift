//
//  StatsViewController.swift
//  Masterbreak
//
//  Created by Daniel Matias Ferrer on 03/02/16.
//  Copyright © 2016 Daniel Matias Ferrer. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {


    @IBOutlet weak var textStats: UITextView!
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        
        guard (averageBets != nil) && (numberGames != nil) && (minimumBets != nil) else {
            textStats.text = "Stats not available"
            super.viewWillAppear(animated)
            return
        }
        
        textStats.text = String.localizedStringWithFormat("Number of games won: \(numberGames!)\nAverage number of bets: %.2f\nMinimum number of bets: \(minimumBets!)", averageBets!)
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
