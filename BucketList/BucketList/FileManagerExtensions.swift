//
//  FileManagerExtensions.swift
//  BucketList
//
//  Created by Radu Dan on 19/10/2020.
//

import Foundation

extension FileManager {
    static var documentsDirectoryURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func write(text: String,
                      to url: URL = documentsDirectoryURL,
                      fileName: String,
                      atomically: Bool = true,
                      encoding: String.Encoding = .utf8) throws {
        let writeURL = url.appendingPathComponent(fileName)
        try text.write(to: writeURL, atomically: atomically, encoding: encoding)
    }
    
    static func read(from url: URL = documentsDirectoryURL,
                     fileName: String) throws -> String {
        let readURL = url.appendingPathComponent(fileName)
        return try String(contentsOf: readURL)
    }
    
    static func readData(from url: URL = documentsDirectoryURL,
                     fileName: String) throws -> Data {
        let readURL = url.appendingPathComponent(fileName)
        return try Data(contentsOf: readURL)
    }
}
