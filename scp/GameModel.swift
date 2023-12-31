import Foundation

class Vector2 {
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
    
    func length() -> Double{
        return sqrt(Double(self.x * self.x) + Double(self.y + self.y))
    }
    
    func distance(other: Vector2) -> Double {
        return (self - other).length()
    }
}

struct WinnerEntry {
    var name: String
    var score: Int
}


class GameModel {
    let boardWidth: Int = 8
    let boardHight: Int = 10
    
    var winners: [WinnerEntry] = []
    
    var playerPosition: Vector2 = Vector2(x: -1, y: -1)
    var monsterPosition: Vector2 = Vector2(x: -1, y: -1)
    var lastShotPosition: Vector2 = Vector2(x: -1, y: -1)
    
    var score: Int = 0
    
    func spawnPlayer() {
        playerPosition = Vector2(x: Int.random(in: 0..<boardWidth), y: boardHight - 1)
    }
    
    func spawnMonster() {
        monsterPosition = Vector2(x: Int.random(in: 0..<boardWidth), y: 0)
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
    
    func takeShot(tile: Vector2) -> Double {
        lastShotPosition = tile
        let distance = monsterPosition.distance(other: tile)
        if (distance == 0) {
            spawnMonster()
            score += 10
        }
        
        return distance
    }
    
    func canMonsterKillPlayer() -> Bool {
        return playerPosition.distance(other: monsterPosition) == 1
    }
    
    func checkAndMakeMove(tile: Vector2) -> Bool {
        if (lastShotPosition.distance(other:tile) != 1) {
            return false
        }
        playerPosition = tile
        
        return true
    }
    
    func monsterTurn() {
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
        if abs(delta.x) < abs(delta.y) {
            return Vector2(x: delta.x.signum(), y: 0)
        }
        else {
            return Vector2(x: 0, y: delta.y.signum())
        }
    }

    func saveScore(entry: WinnerEntry) {
        winners.append(entry)
    }
    
    func reset() {
        score = 0
        spawnMonster()
        spawnPlayer()
        lastShotPosition = Vector2(x: -1, y: -1)
        
    }
}
