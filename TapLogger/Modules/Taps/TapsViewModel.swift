//
//  TapsViewModel.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

protocol TapsViewModel {
    var repository: TapRepository { get set }
    var events: [Event] { get set }
    var eventConsoleLogs: [String] { get set }

    func logEvent(_ name: String, timestamp: Date) async
}

extension TapsView {
    @Observable
    class Model: TapsViewModel {
        var repository: TapRepository
        var events: [Event] = [] {
            didSet {
                print(events)
                eventConsoleLogs = events.map { $0.log }
            }
        }
        var eventConsoleLogs: [String] = []

        init(repository: TapRepository =  InFileTapRepository()) {
            self.repository = repository
        }

        func logEvent(_ name: String, timestamp: Date) async {
            let newEvent = Event(name: name, timestamp: timestamp)
            switch await repository.write(newEvent) {
            case .success(let event):
                events.append(event)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
