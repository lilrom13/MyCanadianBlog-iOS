//
//  SelectedCell.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 25/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import Foundation
import UIKit

class SelectedCell {
    
    let _cell: UITableViewCell
    let _section: Int
    var _color: UIColor
    var _featuredImage: UIImage?
    init(cell: UITableViewCell, section: Int, color: UIColor, featuredImage: UIImage?) {
        self._cell = cell
        self._section = section
        self._color = color
        self._featuredImage = featuredImage
    }
}