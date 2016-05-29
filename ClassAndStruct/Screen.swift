//
//  Screen.swift
//  ClassAndStruct
//
//  Created by Jatin Arora on 29/05/16.
//  Copyright © 2016 JatinArora. All rights reserved.
//

import Foundation

class Screen {
    
    /**
     All structures have an automatically-generated memberwise initializer,
     which you can use to initialize the member properties of new structure instances.
    **/
    var myRectangle = Rectangle(height:0, width:0)
    
    /**
     You can't have uninitialised properties in swift
     Try removing the = 0 and you shall see the compiler complaining that the class does not have a initiliaser
    **/
    let pixelsPerInch: Int = 500
    
    init(height: Int, width: Int) {
        
        myRectangle.height = height
        myRectangle.width = width
        
    }
    
    func calculateTotalPixels() -> Int {
        
        return myRectangle.calculateArea() * pixelsPerInch
        
    }
}

