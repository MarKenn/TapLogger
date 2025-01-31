//
//  LogsViewModel.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import Foundation

protocol LogsViewModel {
    var repository: TapRepository { get set }
    var events: [Event] { get set }

    func loadEvents() async
}

extension LogsView {
    @Observable
    class Model: LogsViewModel {
        var repository: TapRepository
        var events: [Event] = []

        init(repository: TapRepository =  InFileTapRepository()) {
            self.repository = repository
        }

        func loadEvents() async {
            switch await repository.read() {
            case .success(let events):
                self.events = events
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
