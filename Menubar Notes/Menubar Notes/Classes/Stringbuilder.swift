//
//  Stringbuilder.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation

/**
     let stringArray1 = ["Hello", " ", "Swift"]
     let stringArray2 = ["Concatenation", " ", "Example"]

     var stringBuilder = StringBuilder()
     for string in stringArray1 {
         stringBuilder.append(string)
     }
     let concatenatedString1 = stringBuilder.toString()
     print(concatenatedString1) // Output: "Hello Swift"

     // Clear the buffer to start a new concatenation process
     stringBuilder.clear()

     for string in stringArray2 {
         stringBuilder.append(string)
     }
     let concatenatedString2 = stringBuilder.toString()
     print(concatenatedString2) // Output: "Concatenation Example"
 */
class StringBuilder {
    private var buffer = String()

    func append(_ string: String) {
        buffer.append(contentsOf: string)
    }

    func toString() -> String {
        return buffer
    }

    func clear() {
        buffer = ""
    }
}
