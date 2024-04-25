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
    @Published var animatedStoryText = "" // display typewriting effect
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var timer: Timer?
    
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
        
        let prompt = "Tuliskan kutipan indonesia tentang \(topicString) dengan emosi \(moodString). Maksimal terdiri dari 40 kata."
        
        do {
            let response = try await model.generateContent(prompt)
            if let text = response.text {
                storyText = text
                showAnimateTypeWriter2()
            }
        } catch {
            errorMessage = "Failed to generate story: \(error.localizedDescription)"
        }
    }
    
//    func showAnimateTypeWriter() {
//        animatedStoryText = ""
//        var charIndex = 0
//        
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
//            guard charIndex < self.storyText.count else {
//                timer.invalidate()
//                return
//            }
//            
//            DispatchQueue.main.async {
//                let index = self.storyText.index(self.storyText.startIndex, offsetBy: charIndex)
//                self.animatedStoryText += String(self.storyText[index])
//                charIndex += 1
//            }
//        })
//    }
    
    func showAnimateTypeWriter2() {
        animatedStoryText = ""
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                var charIndex = self.animatedStoryText.count
                guard charIndex < self.storyText.count else {
                    self.timer?.invalidate()
                    self.timer = nil
                    return
                }
                
                DispatchQueue.main.async {
                    let index = self.storyText.index(self.storyText.startIndex, offsetBy: charIndex)
                    self.animatedStoryText += String(self.storyText[index])
                    charIndex += 1
                }
            }
        })
    }
}
