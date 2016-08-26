//
//  Utils.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 24/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    static func getRandomColor() -> UIColor{
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: Constants.mainAlpha)
        
    }
}