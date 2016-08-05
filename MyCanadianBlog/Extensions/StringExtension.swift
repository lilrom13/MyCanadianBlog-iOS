//
//  StringExtension.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 05/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import Foundation

extension String {
    func trunc(length: Int, trailing: String? = "...") -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}
