//
//  TapsViewModelTests.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import XCTest
@testable import TapLogger

final class TapsViewModelTests: XCTestCase {
    var viewModel: TapsView.Model!

    var mockRepository = MockTapRepository()
    var testEventName = "test event name"
    var testEventTimestamp: Date!

    override func setUp() {
        testEventTimestamp = Date()
        mockRepository = MockTapRepository()
        viewModel = TapsView.Model(repository: mockRepository)
    }

    func testInitialState() {
        XCTAssert(viewModel.events.isEmpty)
        XCTAssert(viewModel.repository is MockTapRepository)
    }

    func testLogEventSuccess() async {
        XCTAssert(viewModel.events.isEmpty)
        XCTAssertFalse(mockRepository.didCallWrite)

        await viewModel.logEvent(testEventName, timestamp: testEventTimestamp)

        XCTAssert(mockRepository.didCallWrite)
        XCTAssertFalse(viewModel.events.isEmpty)
        XCTAssert(viewModel.events.contains(where: {
            $0.name == testEventName
            && $0.timestamp == testEventTimestamp
        }))
    }

    func testLogEventFail() async {
        XCTAssert(viewModel.events.isEmpty)
        XCTAssertFalse(mockRepository.didCallWrite)

        mockRepository.shouldSucceed = false
        await viewModel.logEvent(testEventName, timestamp: testEventTimestamp)

        XCTAssert(mockRepository.didCallWrite)
        XCTAssert(viewModel.events.isEmpty)
    }
}
