import FirebaseAuth
import FirebaseFirestore

class ViewModel: ObservableObject {
    static let shared = ViewModel()
    let db = Firestore.firestore()
    let apiKey = "live_Dbq5AiMmUbixet2GiNAGokZleNtK4RM9vp2rXWVFhYbNT8ryf8U0QEadjJaw3fG5"

    @Published var cardsLeft = 0
    @Published var likedCats: [Cat] = []
    @Published var cats: [Cat] = []

    private init() {}

    func addLikedCat(_ cat: Cat) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        addLikedCatToFirestore(cat, userId: userId)
        
        if !likedCats.contains(where: { $0.id == cat.id }) {
            likedCats.append(cat)
        }
    }

    func fetch() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10&has_breeds=1&order=RAND&api_key=\(apiKey)") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let fetchedCats = try JSONDecoder().decode([Cat].self, from: data)
                DispatchQueue.main.async {
                    self?.cats.append(contentsOf: fetchedCats)
                    self?.cardsLeft = fetchedCats.count
                }
            } catch {
                print("Error decoding cats: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    func decrementCardsLeft() {
        cardsLeft -= 1
        if cardsLeft == 3 {
            fetch()
        }
    }

    func addLikedCatToFirestore(_ cat: Cat, userId: String) {
        let documentId = "\(cat.id)\(userId)"
        
        var catWithUser = cat
        catWithUser.userId = userId

        do {
            try db.collection("Cats").document(documentId).setData(from: catWithUser)
            print("Cat added to Firestore with id: \(documentId)")
        } catch {
            print("Error adding cat to Firestore: \(error.localizedDescription)")
        }
    }

    func fetchLikedCats() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Cats")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching liked cats: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else { return }

                DispatchQueue.main.async {
                    self.likedCats = documents.compactMap { doc in
                        try? doc.data(as: Cat.self)
                    }
                }
            }
    }
}
