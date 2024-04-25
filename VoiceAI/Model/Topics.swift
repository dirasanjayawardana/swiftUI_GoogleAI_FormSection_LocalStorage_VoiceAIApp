//
//  TopicsModel.swift
//  VoiceAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import Foundation

enum Topics: String, CaseIterable, Identifiable {
    var id: Topics { self }
    case persahabatan = "Persahabatan"
    case petualangan = "Petualangan"
    case motivasi = "Motivasi"
    case horor = "Horor"
}

enum Mood: String, CaseIterable , Identifiable{
    var id: Mood { self }
    case bahagia = "Bahagia"
    case sedih = "Sedih"
}
