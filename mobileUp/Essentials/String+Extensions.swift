//
//  String+Extensions.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 19.08.24.
//

import Foundation

extension String {
    func convertToFormattedDate() -> String {
        let timeStamp = Double(self)
        guard let timeStamp = timeStamp else {return "invalid string"}
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: date)
        
        
    }
}

