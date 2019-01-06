//
//  Optional+ExpectationFail.swift
//  metal tutorial
//
//  Created by Dan Pashchenko on 1/4/19.
//  Copyright © 2019 ios-engineer.com. All rights reserved.
//

import Foundation

extension Optional {
    
    var valOrExpFail: Wrapped? {
        switch self {
        case .none: expectationFail(); return nil
        case .some(let val): return val
        }
    }
}
