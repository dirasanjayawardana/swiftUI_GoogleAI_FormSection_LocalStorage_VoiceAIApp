//
//  ElevenLabsService.swift
//  VoiceAI
//
//  Created by MACBOOK PRO on 25/04/24.
//

import Foundation

class ElevenLabsService {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func generateSpeech(for text: String) async throws -> Data {
        guard let url = URL(string: Constant.fullUrl(forVoice: .johnDoe)) else {
            print("Invalid URL")
            return Data()
        }
        print("you are using api key \(apiKey) for request to eleven labs")
        
        // request body
        let body: [String: Any] = [
            "model_id": "eleven_multilingual_2",
            "text": text,
            "voice_text": [
                "stability": 0.5,
                "similarity_boost": 0.8
            ]
        ]
        
        let requestBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // post data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "xi-aoi-key")
        request.httpBody = requestBody
        
        // Network request for POST Data
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Failed request: \(response)")
            return Data()
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Server returned status code \(httpResponse.statusCode)")
            return Data()
        }
        
        guard !data.isEmpty else {
            print("No data receive from response")
            return Data()
        }
        
        return data
    }
}
