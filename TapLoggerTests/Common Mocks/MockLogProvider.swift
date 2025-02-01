//
//  MockLogProvider.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

@testable import TapLogger
import Foundation

class MockLogProvider: LogProvider {
    var didCallLoad = false
    var shouldSucceed: Bool = true

    var testEventData: [Event] = []

    func load<ModelType: Codable>(_ operation: LogOperation) async -> Result<ModelType, Error> {
        didCallLoad = true

        switch operation {
        case .read:
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            guard let data = try? encoder.encode(testEventData) else  {
                return .failure(MockError.mockLogProviderCantEncodeData)
            }
            guard let responseObject = try? JSONDecoder().decode(ModelType.self, from: data) else {
                return .failure(MockError.mockLogProviderCantDecodeData)
            }

            return shouldSucceed ? .success(responseObject) : .failure(MockError.mockLogProvider)
        case .write:
            guard let body = operation.body as? ModelType else {
                return .failure(MockError.mockLogProviderMissingBody)
            }

            return shouldSucceed ? .success(body) : .failure(MockError.mockLogProvider)
        }
    }
}
