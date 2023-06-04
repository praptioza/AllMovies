//
//  String.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//

import Foundation

extension String{
    func isValidEmail() -> Bool{
        
        let regex = try! NSRegularExpression(pattern: "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
}
