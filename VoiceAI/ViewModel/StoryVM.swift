//
//  StoryVM.swift
//  VoiceAI
//
//  Created by MACBOOK PRO on 25/04/24.
//

import Foundation
import GoogleGenerativeAI

@MainActor
class StoryVM: ObservableObject {
    @Published var storyText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Generate Story
    func generateStory(topic: Topics, mood: Mood) async {
        isLoading = true
        defer { isLoading = false } // dijalankan sebelum function berakhir
        errorMessage = nil
        storyText = ""
        
        let apiKey = UserDefaults.standard.string(forKey: "GeminiAIKey") ?? ""
        
        guard !apiKey.isEmpty else {
            errorMessage = "API key is missing. Please set it in Settings page!"
            return
        }
        
        let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)
        let topicString = topic.rawValue
        let moodString = mood.rawValue
        
        let prompt = "Tuliskan lelucon indonesia tentang \(topicString) dengan emosi \(moodString). Maksimal terdiri dari 40 kata."
        
        do {
            let response = try await model.generateContent(prompt)
            if let text = response.text {
                storyText = text
            }
        } catch {
            errorMessage = "Failed to generate story: \(error.localizedDescription)"
        }
    }
}
