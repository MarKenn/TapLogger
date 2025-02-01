//
//  ButtonView.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 2/1/25.
//

import SwiftUI

struct ButtonView: View {
    var id: String
    var action: (String, Date) -> Void

    var body: some View {
        Button {
            action("Button \(id) tapped", Date())
        } label: {
            Text("Button \(id)")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.accent)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    ButtonView(id: "1") { (id, date) in
        print("Button \(id) tapped at \(date)")
    }
    VStack(spacing: 20) {
        ButtonView(id: "1") { (id, date) in
            print("Button \(id) tapped at \(date)")
        }
        ButtonView(id: "1") { (id, date) in
            print("Button \(id) tapped at \(date)")
        }
        ButtonView(id: "1") { (id, date) in
            print("Button \(id) tapped at \(date)")
        }
        ButtonView(id: "1") { (id, date) in
            print("Button \(id) tapped at \(date)")
        }
    }
    .cornerRadius(10)
    .padding(.horizontal, 20)
}
