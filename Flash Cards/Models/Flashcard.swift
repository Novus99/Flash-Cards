//
//  Flashcard.swift
//  Flash Cards
//
//  Created by Novus on 24/03/2025.
//

import Foundation

struct Flashcard: Codable{
    let id: UUID
    let word: String
    let translation: String
}
