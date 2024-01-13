import SwiftUI


class GameViewModel: ObservableObject {
    private static func createGameModel() -> GameModel {
        return GameModel()
    }
    
    @Published private var gameModel = createGameModel()

    var displayedMessage: String {
        return gameModel.displayedMessage
    }

    var score: Int {
        return gameModel.score
    }
    
    var gameInProgress: Bool {
        return gameModel.gameInProgress
    }
    
    var didPlayerWin: Bool {
        return gameModel.didPlayerWin()
    }
    
    var endScreen: Bool {
        return gameModel.endScreen
    }
    
    init() {
        gameModel.reset()
    }
    
    public func setBoardSize(size: Vector2) {
        gameModel.setBoardSize(size: size)
    }

    public func getPlayerPos() -> Vector2 {
        return gameModel.playerPosition
    }
    public func getMonsterPos() -> Vector2 {
        return gameModel.monsterPosition
    }

    public func getBoardSize() -> Vector2 {
        return gameModel.boardSize
    }

    public func handleTileOnTap(position: Vector2) {
        gameModel.handleTileOnTap(position: position)
    }
    
    public func startGame(selection: Int) {
        if (selection == 1) {
            setBoardSize(size: Vector2(x: 8, y: 10))
        }
        else if (selection == 2) {
            setBoardSize(size: Vector2(x: 12, y: 16))
        }
        gameModel.reset()
        gameModel.setGameInProgress(gameStatus: true)
    }
    
    func getColorForPosition(position: Vector2) -> Color{
        if (position == gameModel.playerPosition) {
            return .blue
        }
//        if (position == gameModel.monsterPosition) {
//            return .pink
//        }
        if (gameModel.wasMonsterHitThisTurn && position == gameModel.lastShotPosition) {
            return .red
        }
        if (!gameModel.wasMonsterHitThisTurn && position == gameModel.lastShotPosition) {
            return .gray
        }
//        if (
//            gameModel.currentStage == .playerMove &&
//            gameModel.lastShotPosition.distance(other: gameModel.monsterPosition) ==
//                gameModel.lastShotPosition.distance(other: position) &&
//            !gameModel.wasMonsterHitThisTurn
//        ) {
//            return .yellow
//        }
        if (gameModel.currentStage == .playerMove && gameModel.playerPosition.distance(other: position) == 1) {
            return .green
        }
        return .white
    }
    
    func setEndScreen(state: Bool) {
        gameModel.endScreen = state
    }
}
