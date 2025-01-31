//
//  InFileTapRepository.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//


protocol TapRepository {
    func write(_ event: Event) async -> Result<Event, Error>
    func read() async -> Result<[Event], Error>
}

class InFileTapRepository: TapRepository {
    var logProvider: LogProvider

    init(logProvider: LogProvider = LogService()) {
        self.logProvider = logProvider
    }

    func write(_ event: Event) async -> Result<Event, Error> {
        await logProvider.load(.write(event))
    }

    func read() async -> Result<[Event], Error> {
        await logProvider.load(.read)
    }
}
