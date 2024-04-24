//
//  SettingsView.swift
//  VoiceAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var geminiAIKey: String = ""
    @State private var elevenLabsKey: String = ""
    
    let signUpGemini = "https://ai.google.dev"
    let signUpElevenLabs = "https://elevenlabs.io/api"
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(content: {
                    TextField("Gemini AI Key", text: $geminiAIKey)
                        .padding(.vertical, 8)
                    TextField("ElevenLabs Key", text: $elevenLabsKey)
                        .padding(.vertical, 8)
                }, header: {
                    Text("API KEYS")
                }, footer: {
                    Text("Please input your API key")
                })
                
                Section(content: {
                    Link("GET API KEY GEMINI AI", destination: URL(string: signUpGemini)!)
                        .padding(.vertical, 8)
                    Link("GET API KEY ElevenLabs", destination: URL(string: signUpElevenLabs)!)
                        .padding(.vertical, 8)
                }, header: {
                    Text("Don't have api key")
                }, footer: {
                    Text("Sign up to get your own api key via link above")
                })
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button(action: {
                    
                }, label: {
                    Text("Save")
                })
                .tint(.primary)
            })
        }
    }
}

#Preview {
    SettingsView()
}
