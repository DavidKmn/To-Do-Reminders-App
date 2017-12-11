//
//  DataManager.swift
//  To-Do-List App
//
//  Created by David on 11/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

public class DataManager {
    
    // get the doc directory
    
    fileprivate func getDocDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access document directory")
        }
    }
    
    // save any kind of codable object
    
    
    // load any kind of codable object
    
    
    // load data from a file
    
    // load all files from a doc directory
    
    // delete a file
}
