import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        VStack {
            Text("\(viewModel.score)")
            Button(action: {viewModel.addScore()})
//            Grid {
//                ForEach(0..<viewModel.getBoardSize().y, id:\.self) { y in
//                    GridRow {
//                        ForEach(0..<viewModel.getBoardSize().x, id:\.self) { x in
//                            Rectangle().fill(y == viewModel.getPlayerPos().y && x == viewModel.getPlayerPos().x ? .blue : .white).border(.black, width: 2)
//                                .onTapGesture {
//                                    viewModel.handleTileOnTap(position: Vector2(x: x, y: y))
//                                }
//                        }
//                    }
//                }
//            }
//            Text(viewModel.displayedMessage)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
