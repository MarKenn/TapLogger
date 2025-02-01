//
//  EventLogView.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import SwiftUI

struct EventLogView: View {
    let name: String
    let date: String
    let compositeId: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Event name: \(name)")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundStyle(.teal)
            Divider()
            Text("Timestamp: \(date)")
                .font(.footnote)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    let ids = [1,2,3,4]
    ScrollView {
        Group {
            ForEach(ids, id: \.self) { event in
                EventLogView(name: "Event 1", date: "10/10/2020 12:00 AM", compositeId: "399F26DB-360E-4817-9693-BF832545065B")
            }
        }.padding(.horizontal)

    }
    .background(.gray)
}
