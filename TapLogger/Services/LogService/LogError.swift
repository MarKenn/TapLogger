//
//  LogError.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

enum LogError: Error {
    case missingEventObject, encodingError, decodingError, exampleErrorEvent, unknownError
}

extension LogError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingEventObject: return "Missing event object"
        case .encodingError: return "Encoding error"
        case .decodingError: return "Decoding error"
        case .exampleErrorEvent: return "exampleErrorEvent"
        default:
            return "Unknown error"
        }
    }
}
