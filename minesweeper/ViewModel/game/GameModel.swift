//
//  GameModel.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 05..
//

import Foundation
import CoreData
import FirebaseDatabase

class GameModel: ObservableObject{
    private let viewContext: NSManagedObjectContext
    private let rows: Int
    private let columns: Int
    private let bombs: Int
    private var timer: Timer?
    private var maxPoint: Int = 0
    
    var point: Int{
        get{
            return Int(ceil(
                        Double(1000 - time + bombs + rows + columns) * (Double(bombs) / Double(rows * columns))))
        }
    }
    
    var bombsRemaining: SegmentValueModel{
        get{
            let remaining = bombs-flags
            return SegmentValueModel(value: String(format: "%03d", remaining >= 0 ? remaining : 0))
        }
    }
    
    @Published var isEnded: Bool = false
    @Published var isWon: Bool = false
    @Published var isPressed: Bool = false
    @Published private var flags: Int = 0
    @Published private var time: Int = 0
    @Published var minesweeperGrid: [[GameGridCell]]
    
    var timeString: SegmentValueModel{
        get{
            return SegmentValueModel(value: String(format: "%03d", time))
        }
    }
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(timerTask), userInfo: nil, repeats: true)
    }
    @objc func timerTask() {
        saveGame()
        time += 1
        if time == 999 {
            gameLost()
        }
    }
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    init(context: NSManagedObjectContext ,numberOfRows:Int, numberOfColumns: Int, numberOfBombs: Int){
        self.viewContext = context
        self.rows = numberOfRows
        self.columns = numberOfColumns
        self.bombs = numberOfBombs
        let gameModel = GameGridModel(numberOfRows:self.rows, numberOfColumns: self.columns, numberOfBombs: self.bombs).gameModel
        minesweeperGrid = gameModel.mapWithIndex { (x, row) in
            row.mapWithIndex { (y, element) in
                return GameGridCell(pozX: x, pozY: y, value: element)
            }
        }
        getMaxPoint()
    }
    
    init(context: NSManagedObjectContext, savedGame: SavedGame){
        self.viewContext = context
        self.rows = savedGame.rows
        self.columns = savedGame.columns
        self.bombs = savedGame.bombs
        self.time = savedGame.time
        self.flags = savedGame.flags
        self.minesweeperGrid = savedGame.minesweeperGrid.map{ row in row.map { element in GameGridCell(savedCell: element) }
        }
        getMaxPoint()
    }
    
    private func getMaxPoint(){
        if let ref = FirebaseCommunication.instance.ref {
            var userId: String
            if let id = UserDefaults.standard.value(forKey: "userId") as? String{
                userId = id
            } else {
                let id = ref.childByAutoId().key!
                UserDefaults.standard.set(id, forKey: "userId")
                userId = id
            }

            ref.child(userId).observeSingleEvent(of: .value){
                let snapshotValue = $0.value as? [String: String]
                if let valueDictionary = snapshotValue{
                    if let pointsString = valueDictionary["points"] == nil ? nil : Int(valueDictionary["points"]!){
                        self.maxPoint = pointsString
                        print(self.maxPoint)
                    }
                }
            }
        }
    }
    
    func newGame(){
        let gameModel = GameGridModel(numberOfRows:self.rows, numberOfColumns: self.columns, numberOfBombs: self.bombs).gameModel
        minesweeperGrid = gameModel.mapWithIndex { (x, row) in
            row.mapWithIndex { (y, element) in
                return GameGridCell(pozX: x, pozY: y, value: element)
            }
        }
        killTimer()
        self.isPressed = false
        self.isEnded = false
        self.isWon = false
        self.time = 0
        self.flags = 0
        
    }
    
    func click(x:Int,y:Int){
        if timer == nil {startTimer()}
        if !isEnded {
            if x < rows && y < columns{
                if x>=0 && y>=0 && x<rows && y<columns {
                    let cell = minesweeperGrid[x][y]
                    if !cell.isClicked && !cell.isFlagged {
                        cell.setClicked()
                        if cell.value == 0 {
                            click(x: x-1, y: y)
                            click(x: x, y: y+1)
                            click(x: x+1, y: y)
                            click(x: x, y: y-1)
                        }
                        if cell.isBomb {
                            gameLost()
                        }
                    }
                    checkEnd()
                }
            }
        }
    }
    
    func flag(x: Int, y: Int){
        if !isEnded {
            if x < rows && y < columns{
                let cell = minesweeperGrid[x][y]
                if !cell.isRevealed{
                    cell.setFlagged()
                    if cell.isFlagged {
                        flags+=1
                    } else{
                        flags-=1
                    }
                    checkEnd()
                } else{
                    cell.isFlagged=false
                }
            }
        }
    }
    
    private func checkEnd(){
        var bombFound = 0
        var notRevealed = rows*columns
        minesweeperGrid.forEach { row in
            row.forEach { cell in
                if cell.isRevealed {
                    notRevealed-=1
                }
                if cell.isFlagged && cell.isBomb {
                    bombFound+=1
                }
            }
        }
        
        if notRevealed == bombs || (bombFound == bombs && flags == bombs){
            minesweeperGrid.forEach { row in
                row.forEach { cell in
                    if !cell.isFlagged && cell.isBomb {
                        cell.setFlagged()
                        flags+=1
                    }
                }
            }
            gameWon()
        }
    }
    
    private func gameWon(){
        isWon = true
        endGame()
    }
    
    private func gameLost(){
        minesweeperGrid.forEach { row in
            row.forEach { element in
                element.setRevealed()
            }
        }
        endGame()
    }
    
    private func endGame(){
        saveScore()
        UserDefaults.standard.set(nil, forKey: "savedGame")
        isEnded=true
        killTimer()
    }
    func getCellAt(x:Int, y: Int)->GameGridCell{
        return minesweeperGrid[x][y]
    }
    
    private func saveScore() {
        let newOwnScore = OwnScore(context: viewContext)
        newOwnScore.timestamp = Date()
        newOwnScore.points = isWon ? Int16(self.point) : 0
        if isWon {
            upsertScore()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func upsertScore(){
        if point > maxPoint{
            self.maxPoint = point
            if let ref = FirebaseCommunication.instance.ref {
                var userId: String
                if let id = UserDefaults.standard.value(forKey: "userId") as? String{
                    userId = id
                } else {
                    let id = ref.childByAutoId().key!
                    UserDefaults.standard.set(id, forKey: "userId")
                    userId = id
                }

                let username = UserDefaults.standard.value(forKey: "username") as! String

                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy. MM. dd."
                let date = formatter.string(from: Date())
                let dictionary = [
                    "id": userId,
                    "username": username,
                    "date": date,
                    "points": String(point)
                ]
                ref.child(userId).setValue(
                    dictionary
                )
            }
        }
        
    }
    
    private func saveGame(){
        let save = SavedGame(rows: rows, columns: columns, bombs: bombs, time: time, flags: flags, minesweeperGrid: minesweeperGrid.map{ row in row.map { element in element.toSavedCell() }})
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(save) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedGame")
        }
    }
    
    func onDisappear(){
        killTimer()
        saveGame()
    }
}

extension Array {
    
    public func mapWithIndex<T> (f: (Int, Element) -> T) -> [T] {
        return zip((self.startIndex ..< self.endIndex), self).map(f)
    }
    
    public func forEachWithIndex (f: (Int, Element) -> ()) -> () {
        return zip((self.startIndex ..< self.endIndex), self).forEach(f)
    }
}
