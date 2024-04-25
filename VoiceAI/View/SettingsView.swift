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
                        .onAppear{
                            geminiAIKey = UserDefaults.standard.string(forKey: "GeminiAIKey") ?? ""
                        }
                    TextField("ElevenLabs Key", text: $elevenLabsKey)
                        .padding(.vertical, 8)
                        .onAppear{
                            elevenLabsKey = UserDefaults.standard.string(forKey: "ElevenLabsAPIKey") ?? ""
                        }
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
                    handleSaveKey()
                }, label: {
                    Text("Save")
                })
                .padding(.trailing, 8)
                .disabled(geminiAIKey.isEmpty || elevenLabsKey.isEmpty)
            })
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    func handleSaveKey() {
        UserDefaults.standard.set(geminiAIKey, forKey: "GeminiAIKey")
        UserDefaults.standard.set(elevenLabsKey, forKey: "ElevenLabsAPIKey")
    }
}
