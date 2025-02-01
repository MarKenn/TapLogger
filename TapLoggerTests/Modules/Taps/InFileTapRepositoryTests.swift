//
//  InFileTapRepositoryTests.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import XCTest
@testable import TapLogger

final class InFileTapRepositoryTests: XCTestCase {
    var repository: InFileTapRepository!

    var mockLogProvider = MockLogProvider()
    var testEvent = Event(name: "test event", timestamp: Date())
    var testEventsArray: [Event] = []

    override func setUp() {
        testEventsArray = (0...3).map { Event(name: "test event \($0)", timestamp: Date()) }
        mockLogProvider = MockLogProvider()
        mockLogProvider.testEventData = testEventsArray
        repository = InFileTapRepository(logProvider: mockLogProvider)
    }

    func testInitialState() {
        XCTAssert(repository.logProvider is MockLogProvider)
    }

    func testWriteSuccess() async {
        XCTAssertFalse(mockLogProvider.didCallLoad)

        let result = await repository.write(testEvent)

        XCTAssert(mockLogProvider.didCallLoad)
        if case let .success(value) = result {
            XCTAssertEqual(value.name, testEvent.name)
        } else {
            XCTAssert(false, "Expecting .success(Event) but got .failure(Error) instead")
        }
    }

    func testWriteFail() async {
        XCTAssertFalse(mockLogProvider.didCallLoad)

        mockLogProvider.shouldSucceed = false
        let result = await repository.write(testEvent)

        XCTAssert(mockLogProvider.didCallLoad)
        if case let .failure(error) = result {
            XCTAssert(error is MockError)
            XCTAssert((error as? MockError) == .mockLogProvider)
        } else {
            XCTAssert(false, "Expecting .failure(Error) but got .success(Event) instead")
        }
    }

    func testReadSuccess() async {
        XCTAssertFalse(mockLogProvider.didCallLoad)

        let result = await repository.read()

        XCTAssert(mockLogProvider.didCallLoad)
        if case let .success(value) = result {
            let testEventNames = testEventsArray.map(\.name)
            let testEventDates = testEventsArray.map(\.timestamp)
            XCTAssertEqual(value.map(\.name), testEventNames)
            XCTAssertEqual(value.map(\.timestamp), testEventDates)
        } else {
            XCTAssert(false, "Expecting .success([Event]) but got .failure(Error) instead")
        }
    }

    func testReadFail() async {
        XCTAssertFalse(mockLogProvider.didCallLoad)

        mockLogProvider.shouldSucceed = false
        let result = await repository.read()

        XCTAssert(mockLogProvider.didCallLoad)
        if case let .failure(error) = result {
            XCTAssert(error is MockError)
            XCTAssert((error as? MockError) == .mockLogProvider)
        } else {
            XCTAssert(false, "Expecting .failure(Error) but got .success([Event]) instead")
        }
    }
}
