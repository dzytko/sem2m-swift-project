import SwiftUI


struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
            Grid {
                ForEach(0..<viewModel.getBoardSize().y, id:\.self) { y in
                    GridRow {
                        ForEach(0..<viewModel.getBoardSize().x, id:\.self) { x in
                            Rectangle().fill(viewModel.getColorForPosition(position: Vector2(x: x, y: y))).border(.black, width: 2)
                                .onTapGesture {
                                    viewModel.handleTileOnTap(position: Vector2(x: x, y: y))
                                }
                           
                        }
                    }
                }
            }
            Text(viewModel.displayedMessage)
        }.padding()
    }
}

