//
//  MockTapRepository.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

@testable import TapLogger
import Foundation

class MockTapRepository: TapRepository {
    var didCallWrite = false
    var didCallRead = false
    var shouldSucceed: Bool = true
    var testEventData: [Event] = []

    var logProvider: LogProvider = MockLogProvider()

    func write(_ event: Event) async -> Result<Event, any Error> {
        didCallWrite = true

        return shouldSucceed
        ? .success(event)
        : .failure(MockError.mockTapRepository)
    }

    func read() async -> Result<[Event], any Error> {
        didCallRead = true

        return shouldSucceed
        ? .success(testEventData)
        : .failure(MockError.mockTapRepository)
    }
}
