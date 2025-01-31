//
//  LogOperation.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

enum LogOperation {
    case write(Event)
    case read

    var url: URL { Constant.apiBaseURL.appendingPathComponent("events.json") }

    var body: (any Codable)? {
        switch self {
        case .write(let event):
            return event
        default:
            return nil
        }
    }
}
