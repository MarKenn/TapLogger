//
//  LogsViewModelTests.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import XCTest
@testable import TapLogger

final class LogsViewModelTests: XCTestCase {
    var viewModel: LogsView.Model!

    var mockRepository = MockTapRepository()
    var testEventName = "test event name"
    var testEventTimestamp: Date!
    var testEventsArray: [Event] = []

    override func setUp() {
        testEventsArray = (0...3).map { Event(name: "test event \($0)", timestamp: Date()) }
        testEventTimestamp = Date()
        mockRepository = MockTapRepository()
        viewModel = LogsView.Model(repository: mockRepository)
    }

    func testInitialState() {
        XCTAssert(viewModel.events.isEmpty)
        XCTAssert(viewModel.repository is MockTapRepository)
    }

    func testLogEventEmpty() async {
        XCTAssert(viewModel.events.isEmpty)
        XCTAssertFalse(mockRepository.didCallRead)

        await viewModel.loadEvents()

        XCTAssert(mockRepository.didCallRead)
        XCTAssert(viewModel.events.isEmpty)
    }

    func testLogEventSuccess() async {
        XCTAssert(viewModel.events.isEmpty)
        XCTAssertFalse(mockRepository.didCallRead)

        mockRepository.testEventData = testEventsArray
        await viewModel.loadEvents()

        XCTAssert(mockRepository.didCallRead)
        XCTAssertFalse(viewModel.events.isEmpty)
        let testEventNames = testEventsArray.map(\.name)
        let testEventDates = testEventsArray.map(\.timestamp)
        XCTAssertEqual(viewModel.events.map(\.name), testEventNames)
        XCTAssertEqual(viewModel.events.map(\.timestamp), testEventDates)
    }

    func testLogEventFail() async {
        XCTAssert(viewModel.events.isEmpty)
        XCTAssertFalse(mockRepository.didCallRead)

        mockRepository.shouldSucceed = false
        await viewModel.loadEvents()

        XCTAssert(mockRepository.didCallRead)
        XCTAssert(viewModel.events.isEmpty)
    }
}
