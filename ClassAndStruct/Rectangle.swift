//
//  Rectangle.swift
//  ClassAndStruct
//
//  Created by Jatin Arora on 29/05/16.
//  Copyright © 2016 JatinArora. All rights reserved.
//

import Foundation

/**
   Examples of good candidates for structures include:
 
 - The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.
 - A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.
 - A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.
 **/

struct Rectangle {
    
    var height: Int
    var width: Int
    
    func calculateArea() -> Int {
        return height * width
    }
}