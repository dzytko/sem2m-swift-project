import SwiftUI


struct GameEndView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var offset = CGSize.zero

    var body: some View {
        VStack {
            viewModel.didPlayerWin ? Text("You won") : Text("You lost")
            Text("Your score: \(viewModel.score)")
        }
        .padding()
        .frame(width: 500, height: 1000)
        .background(.white)
        .edgesIgnoringSafeArea(.all)
        .offset(x: offset.width)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    offset = gesture.translation
                }
                .onEnded{ _ in
                    if offset.width > 50.0 {
                        viewModel.startGame(selection: -1)
                    }
                    if offset.width < -50.0 {
                        viewModel.setEndScreen(state: false)
                    }

                    offset = CGSize.zero
                }
        )
    }
}
