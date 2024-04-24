//
//  Constant.swift
//  VoiceAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import Foundation

struct Constant {
    static let baseURL = "https://api.elevenlabs.io"
    static let appVersion = "v1"
    
    enum Endpoint: String {
        case textToSpeech = "text-to-speech"
        case speechToSpeech = "speech-to-speech"
    }
    
    enum VoiceID: String {
        case johnDoe = "7fbQ7yJuEo56rYjrYaEh"
        case bambang = "IMaRqUzeNVCT6ks9SI4Y"
    }
    
    static func fullUrl(forVoice voice: VoiceID) -> String {
        let jointUrl = baseURL + "/" + appVersion + "/" + Endpoint.textToSpeech.rawValue + "/" + voice.rawValue
        return jointUrl
    }
}
