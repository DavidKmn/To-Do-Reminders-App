//
//  DataManager.swift
//  To-Do-List App
//
//  Created by David on 11/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation


public class FileStorageManager {
    
    // get the doc directory
    static fileprivate func getDocDirectory() -> URL {

        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access document directory")
        }
    }
    
    // save any kind of codable object
    static func save<T: Encodable> (_ object: T, with fileName: String) {
        let url = getDocDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let encodingErr {
            fatalError("Could not encode the object: \(encodingErr.localizedDescription)")
        }
    }
    
    // load any kind of codable object
    static func load<T: Decodable> (_ filename: String, with type: T.Type) -> T {
        let url = getDocDirectory().appendingPathComponent(filename, isDirectory: false)
        
        if !(FileManager.default.fileExists(atPath: url.path)) {
            fatalError("File not found at path: \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let modelObject = try JSONDecoder().decode(type, from: data)
                return modelObject
            } catch {
                fatalError("Could not load the decode the data: \(error.localizedDescription)")
            }
            
        } else {
            fatalError("Data is unavailable at the specified path: \(url.path)")
        }
    }
    
    // load data from a file
    static func loadData(_ filename: String) -> Data? {
        let url = getDocDirectory().appendingPathComponent(filename, isDirectory: false)
        
        if !(FileManager.default.fileExists(atPath: url.path)) {
            fatalError("File not found at path: \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
           return data
        } else {
            fatalError("Data is unavailable at the specified path: \(url.path)")
        }
    }
    
    // load all files from a doc directory
    static func loadAll <T:Decodable> (_ type: T.Type) -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocDirectory().path)
            
            var modelObjects = [T]()
            
            files.forEach({ (fileName) in
                modelObjects.append(load(fileName, with: type))
            })
            
            return modelObjects
            
        } catch {
            fatalError("Could not load any files")
        }
    }
    
    static func deleteAll() {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocDirectory().path)
            
            files.forEach({ (fileName) in
                delete(fileName)
            })
        } catch {
            fatalError("Could not delete all Files")
        }
    }
    
    // delete a file
    static func delete (_ fileName: String) {
        let url = getDocDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError("Could not delete the file: \(error.localizedDescription)")
            }
        }
    }
}










