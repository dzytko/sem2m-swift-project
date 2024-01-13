import SwiftUI


class GameViewModel: ObservableObject {
//    var x = 3
//
    private static func createGameModel() -> GameModel {
        return GameModel()
    }
    
    @Published private var gameModel = createGameModel()
//
//    var displayedMessage: String {
//        return gameModel.displayedMessage
//    }
//
//    init() {
//        gameModel.reset()
//    }
//
//    public func getPlayerPos() -> Vector2 {
//        return gameModel.playerPosition
//    }
//
//    public func getBoardSize() -> Vector2 {
//        return gameModel.boardSize
//    }
//
//    public func handleTileOnTap(position: Vector2) {
//        print(gameModel.score)
//        x = 5353
//        gameModel.handleTileOnTap(position: position)
//    }
    
    var score: Int {
        print("sfsdfsdf")
        return gameModel.score
    }
    
    func addScore() {
        print(gameModel.score)
        gameModel.score = gameModel.score + 10
    }
}
