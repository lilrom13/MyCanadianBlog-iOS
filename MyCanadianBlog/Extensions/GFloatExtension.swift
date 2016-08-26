//
//  GFloatExtension.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 24/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}