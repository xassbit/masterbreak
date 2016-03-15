//
//  MBBet.swift
//  Masterbreak
//
//  Created by Daniel Matias Ferrer on 16/02/16.
//  Copyright © 2016 Daniel Matias Ferrer. All rights reserved.
//

import Foundation

class MBBet {
    let code : [Int]
    
    init(_ code: [Int]) {
        self.code = code
    }
    
    convenience init(codeString: String) {
        var codeArray = [Int]()
        var oneInt : Int
        for char in codeString.characters {
            oneInt = Int(String(char))!
            codeArray.append(oneInt)
        }
        self.init(codeArray)
    }
    
    func codeToString() -> String {
        var myString = ""
        for element in code {
            myString += String(element)
        }
        return myString
    }
    
    func verifyBet () -> (right: Int, wrong: Int) {
        
        var right : Int = 0
        var wrong : Int = 0
        var bet = MBKey.masterKey.code
        var key = code
        
        //Determine how many elements exist in right position
        var i : Int = 0
        while i < key.count {
            if key[i] == bet[i] {
                right++
                key.removeAtIndex(i)
                bet.removeAtIndex(i)
            } else {
                i++
            }
        }
        
        //Determine how many elements exist in wrong position
        var found : Bool
        i = 0
        while i < bet.count {
            found = false
            for j in 0..<key.count {
                if bet[i] == key[j] {
                    wrong++
                    bet.removeAtIndex(i)
                    key.removeAtIndex(j)
                    found = true
                    break
                }
            }
            if found {
                continue
            } else {
                i++
            }
        }
        
        return (right, wrong)
    }
}