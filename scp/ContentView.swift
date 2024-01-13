import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        if (viewModel.gameInProgress) {
            GameView(viewModel: viewModel)
        }
        else {
            if (viewModel.endScreen) {
                GameEndView(viewModel: viewModel)
            }
            else {
                HomeScreenView(viewModel: viewModel)
            }
        }
    }
}

