//
//  HomeView.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import SwiftUI

struct TapsView: View {
    @State private var viewModel: TapsViewModel = Model()

    let eventIds: [String] = ["1","2","3","4"]

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 20) {
                ForEach(eventIds, id: \.self) { eventId in
                    ButtonView(id: eventId) { (event, timestamp) in
                        logEvent(event, timestamp: timestamp)
                    }
                }
            }
            .cornerRadius(10)

            VStack {
                Text("Session console").foregroundStyle(.teal)

                ScrollView {
                    ForEach(viewModel.eventConsoleLogs, id: \.self) { log in
                        Text(log)
                            .foregroundStyle(.green)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            .padding(.vertical)
            .padding(.horizontal, 8)
            .background(.black)
            .frame(height: 200)
        }
        .padding(.horizontal, 20)
    }
}

extension TapsView {
    func logEvent(_ event: String, timestamp: Date) {
        Task {
            await viewModel.logEvent(event, timestamp: timestamp)
        }
    }
}

#Preview {
    TapsView()
}
