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

    var log: String {
        "\(name) at \(timestamp)"
    }
}
