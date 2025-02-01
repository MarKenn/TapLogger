//
//  LogsView.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import SwiftUI

struct LogsView: View {
    @State private var viewModel: LogsViewModel = Model()

    init(viewModel: LogsViewModel = Model()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                Text("All logs")
                    .font(.largeTitle)
                    .foregroundStyle(.teal)

                Spacer()

                Button(
                    action: { print("Download file") },
                    label: {
                        Image(systemName: "arrow.down.circle")
                            .foregroundColor(.teal)
                    }
                )
            }
            .padding(.horizontal)

            ScrollView {
                Group {
                    ForEach(viewModel.events, id: \.compositeId) { event in
                        EventLogView(
                            name: event.name,
                            date: event.formattedDate,
                            compositeId: event.compositeId)
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .onAppear {
                loadEvents()
            }
        }
    }
}

extension LogsView {
    func loadEvents() {
        Task {
            await viewModel.loadEvents()
        }
    }
}

#Preview {
    let events = [1,2,3,4].map { Event(name: $0.description, timestamp: Date() + $0, id: UUID().uuidString) }

    let viewModel = LogsView.Model()
    viewModel.events = events

    return LogsView(viewModel: viewModel)
}
