import SwiftUI
import SwiftUI

struct SwipeView: View {
    @ObservedObject var viewModel = ViewModel.shared
    @State private var hasAppeared = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                
                Image("catpaws")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                
                ForEach(viewModel.cats.reversed(), id: \.self) { cat in
                    CardView(cat: cat, viewModel: viewModel)
                }
            }
            .onAppear {
               
                if !hasAppeared {
                    viewModel.fetch() 
                    viewModel.fetchLikedCats()
                    hasAppeared = true
                }
            }

        }
    }
}


#Preview {
    SwipeView()
}

