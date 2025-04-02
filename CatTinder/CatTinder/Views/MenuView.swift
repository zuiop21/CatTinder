import SwiftUI
import FirebaseAuth

struct MenuView: View {
    @Binding var userIsLoggedIn: Bool
    @ObservedObject var viewModel = ViewModel.shared

    var body: some View {
        NavigationView {
            TabView {
                LikedView()
                    .tabItem {
                        Label("Liked", systemImage: "heart")
                    }
                
                SwipeView()
                    .tabItem {
                        Label("Swipe", systemImage: "rectangle.portrait")
                    }
            }
            .onAppear {
                UITabBar.appearance().backgroundColor = UIColor(named: "background")
                UITabBar.appearance().unselectedItemTintColor = UIColor(named: "unselected")
                UITabBar.appearance().barTintColor = UIColor(named: "background")
                    
            }
            .tint(Color("selected"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: signOut) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.title2)
                            .foregroundColor(Color("selected")) // A "selected" szín alkalmazása
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline) 
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    func signOut() {
        viewModel.likedCats.removeAll()
        viewModel.cats.removeAll()
        viewModel.cardsLeft=0

        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        userIsLoggedIn = false
        try? Auth.auth().signOut()
    }

}

struct MenuView_PreviewWrapper: View {
    @State private var userIsLoggedIn = true 
    
    var body: some View {
        MenuView(userIsLoggedIn: $userIsLoggedIn)
    }
}

#Preview {
    MenuView_PreviewWrapper()
}
