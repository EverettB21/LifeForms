//
//  PrettyPrintedData.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/3/23.
//

import Foundation

extension Data {
    func prettyPrinted() {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let string = String(data: data, encoding: .utf8) else {
            print("failed to print data string")
            return
        }
        print(string)
    }
}
