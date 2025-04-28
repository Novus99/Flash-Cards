//
//  Constants.swift
//  Flash Cards
//
//  Created by Novus on 21/03/2025.
//

struct K {
    
    static let appName = "Flash Cards"
    
    struct Navigation {
        static let registerSegue = "RegisterToHome"
        static let loginSegue = "LoginToHome"
        static let collectionsToCollectionFormSegue = "CollectionsToCollectionForm"
        static let collectionFormToCollectionSegue = "CollectionFormToCollection"
    }
    
    struct CustomCells {
        static let reusableWordTranslationCell = "ReusableWordTranslationCell"
        static let wordTranslationCell = "WordTranslationCell"
        static let reusableCollectionCell = "ReusableCollectionCell"
        static let collectionCell = "CollectionCell"
    }
    
    struct FStore {
        static let collectionName = "Collections"
        static let dateField = "createdAt"
        static let collectionTitle = "title"
        static let collectionID = "id"
    }
}
