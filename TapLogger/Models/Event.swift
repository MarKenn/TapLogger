//
//  Event.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

struct Event: Codable {
    let name: String
    let timestamp: Date
    let id: String

    init(name: String, timestamp: Date, id: String? = nil) {
        self.name = name
        self.timestamp = timestamp
        self.id = id ?? UUID().uuidString
    }

    var compositeId: String {
        "\(id)-\(timestamp.timeIntervalSince1970)"
    }

    var log: String {
        "\(name) at \(formattedDate)"
    }

    var formattedDate: String {
        DateConverter.shared.format(timestamp)
    }
}
