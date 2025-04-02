import SwiftUI

struct LikedView: View {
    @ObservedObject var viewModel = ViewModel.shared

    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    if viewModel.likedCats.isEmpty {
                        Text("No liked cats yet!")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("background")
                                    .edgesIgnoringSafeArea(.all)
                            )
                    } else {
                        List(viewModel.likedCats, id: \.id) { cat in
                            ZStack {
                                NavigationLink(destination: ProfileView(cat: cat)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                HStack {
                                    CachedAsyncImage(url: cat.url)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(4)
                                    
                                    Text(cat.breeds?.first?.name ?? "Unknown Breed")
                                        .font(.headline)
                                        .foregroundColor(Color("selected"))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding()
                                .background(Color("listbg"))
                                .cornerRadius(8)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .scrollContentBackground(.hidden)
                        .background {
                            Color("background")
                                .edgesIgnoringSafeArea(.all)
                            Image("catpaws")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                    }
                }
                .padding(.top,1)
                .background(Color("background"))
                
            }
            .onAppear {
                viewModel.fetchLikedCats()
            }
        }
    }
}





#Preview {
    LikedView()
}
