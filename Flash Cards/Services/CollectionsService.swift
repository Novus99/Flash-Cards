import Foundation
import FirebaseFirestore
import FirebaseAuth

class CollectionsService {
    private let db = Firestore.firestore()

    func fetchCollections(completion: @escaping ([WordCollection]) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("Brak zalogowanego użytkownika.")
            completion([])
            return
        }

        db.collection(userEmail)
            .order(by: K.FStore.dateField, descending: true)
            .addSnapshotListener { snapshot, error in
                var collections: [WordCollection] = []

                if let error = error {
                    print("Błąd podczas pobierania kolekcji: \(error)")
                    completion([])
                    return
                }

                if let documents = snapshot?.documents {
                    for doc in documents {
                        do {
                            let collection = try doc.data(as: WordCollection.self)
                            collections.append(collection)
                        } catch {
                            print("Błąd podczas dekodowania dokumentu: \(error)")
                        }
                    }
                }

                completion(collections)
            }
    }

    func deleteCollection(id: UUID, completion: @escaping (Bool) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            completion(false)
            return
        }

        db.collection(userEmail).document(id.uuidString).delete { error in
            if let error = error {
                print("Błąd podczas usuwania dokumentu: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func saveCollection(_ collection: WordCollection, completion: @escaping (Bool) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            completion(false)
            return
        }

        do {
            try db.collection(userEmail).document(collection.id.uuidString).setData(from: collection)
            completion(true)
        } catch {
            print("Błąd podczas zapisywania kolekcji: \(error)")
            completion(false)
        }
    }
}
