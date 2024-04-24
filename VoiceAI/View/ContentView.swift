//
//  ContentView.swift
//  VoiceAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StoriesView()
                .tabItem { Label("Generate", systemImage: "rectangle.and.pencil.and.ellipsis") }
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(.primary)
    }
}

#Preview {
    ContentView()
}
