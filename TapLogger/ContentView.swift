//
//  ContentView.swift
//  TapLogger
//
//  Created by Mark Kenneth Bayona on 1/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .taps

    enum Tab {
        case taps
        case logs
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            TapsView()
                .tabItem {
                    Label("Taps", systemImage: "hand.tap")
                }
                .tag(Tab.taps)

            LogsView()
                .tabItem {
                    Label("Logs", systemImage: "list.bullet")
                }
                .tag(Tab.logs)
        }
        .tint(.teal)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

#Preview {
    ContentView()
}
