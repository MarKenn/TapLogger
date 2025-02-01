//
//  DateFormatter.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

struct DateConverter {
    static let shared = DateConverter()

    private init() {}

    private let outputFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy h:mm a"
        df.locale = Locale(identifier: "en_US_POSIX")

        return df
    }()

    func format(_ date: Date) -> String {
        outputFormatter.string(from: date)
    }
}
