//
//  LogsView.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import SwiftUI

struct LogsView: View {
    @State private var viewModel: LogsViewModel = Model()

    var body: some View {
        VStack {
            HStack {
                Text("All logs").font(.title)

                Spacer()

                Button(
                    action: { print("Download file") },
                    label: {
                        Image(systemName: "arrow.down.circle")
                            .foregroundColor(.gray)
                    }
                )
            }
            .padding(.horizontal)

            List(viewModel.events, id: \.name) { event in
                VStack(alignment: .leading) {
                    Text(event.name)
                    Text("\(event.timestamp)")
                }
            }.onAppear {
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
    LogsView()
}
