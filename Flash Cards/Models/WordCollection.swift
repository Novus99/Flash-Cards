//
//  WordCollection.swift
//  Flash Cards
//
//  Created by Novus on 24/03/2025.
//
import Foundation

struct WordCollection: Codable{
    
    var id: UUID
    let owner: String?
    let title: String
    let createdAt: Double?
    var words: [Flashcard]?
    
}
