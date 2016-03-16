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
        
        let stats = getStats()
        
        textStats.text = String.localizedStringWithFormat("Number of games won: \(stats.num)\nAverage number of bets: %.2f\nMinimum number of bets: \(stats.min)", stats.mean)
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "dismiss:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func getStats () -> MBStats {
        guard let loadedData = NSUserDefaults.standardUserDefaults().dictionaryForKey("stats") as! [String:Float]? else {
            let stats = MBStats(mean: 0.0, min: 0, num: 0)
            return stats
        }
        
        let stats = MBStats(mean: loadedData["mean"]!, min: Int(loadedData["min"]!), num: Int(loadedData["num"]!))
        return stats
    }
}
