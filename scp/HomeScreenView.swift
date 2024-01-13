import SwiftUI


struct HomeScreenView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var selection = 1

    var body: some View {
        VStack {
            Text("Game name").font(.system(size:36))
            Text("Select board size")
            HStack {
                Picker("Board size", selection: $selection) {
                    Text("8x10").tag(1)
                    Text("12x16").tag(2)
                }.pickerStyle(.segmented).padding()
            }
            Button(action: {viewModel.startGame(selection: selection)}) {
                Text("Start game")
            }.buttonStyle(.bordered)
        }
    }
}
