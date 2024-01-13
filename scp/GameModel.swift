import SwiftUI

struct Vector2 {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    static func -(lhs: Vector2, rhs: Vector2) -> Vector2{
        return Vector2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func +(lhs: Vector2, rhs: Vector2) -> Vector2{
        return Vector2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    
    static func ==(lhs: Vector2, rhs: Vector2) -> Bool{
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func length() -> Double{
        return sqrt(Double(self.x * self.x) + Double(self.y * self.y))
    }
    
    func distance(other: Vector2) -> Double {
        return (self - other).length()
    }
}

enum Stage {
    case playerShot
    case playerMove
    case monsterMove
}

struct Test: Identifiable {
    var id: String
    var val: Int
}

struct GameModel {
    var boardSize = Vector2(x: 8, y: 10)

    var currentStage = Stage.playerShot
    var displayedMessage = ""

    var playerPosition: Vector2 = Vector2(x: -1, y: -1)
    var monsterPosition: Vector2 = Vector2(x: -1, y: -1)
    var lastShotPosition: Vector2 = Vector2(x: -1, y: -1)
    
    var score: Int = 0
    var wasMonsterHitThisTurn = false
    var gameInProgress = false
    var endScreen = false
    
    mutating func setBoardSize(size: Vector2) {
        boardSize = size
        reset()
    }
    
    mutating func spawnPlayer() {
        playerPosition = Vector2(x: Int.random(in: 0..<boardSize.x), y: boardSize.y - 1)
    }

    mutating func spawnMonster() {
        monsterPosition = Vector2(x: Int.random(in: 0..<boardSize.x), y: 0)
    }

    func canPlayerShootTile(tile: Vector2) -> Bool{
        if (tile.y >= 2) {
            return true
        }
        if (playerPosition.y <= 2) {
            return true
        }
        return false
    }

    mutating func takeShot(tile: Vector2) -> Double {
        wasMonsterHitThisTurn = false
        lastShotPosition = tile
        let distance = monsterPosition.distance(other: tile)
        if (distance == 0) {
            wasMonsterHitThisTurn = true
            spawnMonster()
            score += 10
        }

        return distance
    }

    func canMonsterKillPlayer() -> Bool {
        return playerPosition.distance(other: monsterPosition) == 1
    }

    mutating func checkAndMakeMove(tile: Vector2) -> Bool {
        if (playerPosition.distance(other:tile) != 1) {
            return false
        }
        
        if ((playerPosition - tile).y > 0) {
            score += 1
        }
        else if ((playerPosition - tile).y < 0) {
            score -= 2
        }
        playerPosition = tile

        return true
    }

    mutating func monsterTurn() {
        if (canMonsterKillPlayer()) {
            playerPosition = Vector2(x: -1, y: -1)
            return
        }
        monsterPosition = monsterPosition + getBestMonsterMove()
    }

    func didPlayerWin() -> Bool {
        return playerPosition.y == 0
    }

    func isPlayerAlive() -> Bool {
        return playerPosition.x != -1 && playerPosition.y != -1
    }

    func getBestMonsterMove() -> Vector2 {
        let delta = playerPosition - monsterPosition
        if abs(delta.x) > abs(delta.y) {
            return Vector2(x: delta.x.signum(), y: 0)
        }
        else {
            return Vector2(x: 0, y: delta.y.signum())
        }
    }

    mutating func reset() {
        score = 0
        spawnMonster()
        spawnPlayer()
        lastShotPosition = Vector2(x: -1, y: -1)
        endScreen = false
        displayedMessage = "Make a move"
    }

    mutating func advanceStage() {
        switch (currentStage) {
            case .playerShot:
                currentStage = .playerMove
            case .playerMove:
                currentStage = .monsterMove
            case .monsterMove:
                currentStage = .playerShot
        }
    }

    mutating public func handleTileOnTap(position: Vector2) {
        switch (currentStage) {
        case .playerShot:
            if (!canPlayerShootTile(tile: position)) {
                displayedMessage = "You cannot shoot that tile"
                return
            }

            let distance = takeShot(tile: position)
            if (distance == 0) {
                displayedMessage = "You've hit the monster"
            }
            else {
                displayedMessage = "Distance to monster: \(Int(round(distance)))"
            }

        case .playerMove:
            let moved = checkAndMakeMove(tile: position)
            if (!moved) {
                displayedMessage = "You cannot move here"
                return
            }
            advanceStage()
            monsterTurn()
        default:
            break;
        }
        advanceStage()

        if (didPlayerWin()) {
            displayedMessage = "You won"
            endScreen = true
            gameInProgress = false
        }
        else if (!isPlayerAlive()) {
            displayedMessage = "You lost"
            endScreen = true
            gameInProgress = false
        }
    }
    
    mutating func setGameInProgress(gameStatus: Bool) {
        gameInProgress = gameStatus
    }
}
