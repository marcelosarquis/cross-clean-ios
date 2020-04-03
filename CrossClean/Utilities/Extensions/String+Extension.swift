//
//  String+Extension.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 03.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

extension String {
    
    var numeric: String {
        return components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
    }
}
