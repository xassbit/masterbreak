//
//  MBKey.swift
//  Masterbreak
//
//  Created by Daniel Matias Ferrer on 16/02/16.
//  Copyright © 2016 Daniel Matias Ferrer. All rights reserved.
//

import Foundation

public class MBKey {
    public static let masterKey = MBKey()
    public var code = [Int]()
    
    private init() {    }
    
    public func update() {
        var newCode = [Int]()
        for _ in 0..<6 {
            let newInt = Int(arc4random_uniform(5))
            newCode.append(newInt)
        }
        code = newCode
    }
    
}