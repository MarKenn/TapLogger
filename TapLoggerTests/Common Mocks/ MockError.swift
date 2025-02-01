//
//   MockError.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

enum MockError: Error, LocalizedError {
    case mockTapRepository
    case mockLogProvider
    case mockLogProviderMissingBody
    case mockLogProviderCantEncodeData
    case mockLogProviderCantDecodeData
    case unknown

    public var errorDescription: String? {
        switch self {
        case .mockTapRepository: "Errors for MockTapRepository"
        case .mockLogProvider: "Errors for MockLogProvider"
        case .mockLogProviderMissingBody: "Errors for MockLogProviderMissingBody"
        case .mockLogProviderCantEncodeData: "Errors for MockLogProviderCantEncodeData"
        case .mockLogProviderCantDecodeData: "Errors for MockLogProviderCantDecodeData"
        default: "Mock error for tests"
        }
    }
}
