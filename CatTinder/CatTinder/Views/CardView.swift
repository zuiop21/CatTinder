import SwiftUI
import AVFoundation

struct CardView: View {
    var cat: Cat
    @ObservedObject var viewModel = ViewModel.shared

    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 320, height: 420)
                .border(.white, width: 6.0)
                .cornerRadius(4.0)
                .foregroundColor(color.opacity(0.99))

            VStack {
                if let url = URL(string: cat.url) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 300, height: 300)
                    }
                }

                Text(cat.breeds?.first?.name ?? "Unknown Breed")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding()
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                    }
                }
        )
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            print("\(cat.id) removed")
            playSound(of: "angry-cat-meow")
            offset = CGSize(width: -500, height: 0)
            viewModel.decrementCardsLeft()
        case 150...(500):
            print("\(cat.id) added")
            playSound(of: "happy-cat-meow")
            offset = CGSize(width: 500, height: 0)
            viewModel.addLikedCat(cat)
            viewModel.decrementCardsLeft()
        default:
            offset = .zero
        }
    }

    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...(500):
            color = .green
        default:
            color = .black
        }
    }

    func playSound(of action: String) {
        guard let soundURL = Bundle.main.url(forResource: action, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
}
