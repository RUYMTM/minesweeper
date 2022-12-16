//
//  ScoreboardModel.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 07..
//

import Foundation
import FirebaseDatabase

class ScoreboardModel: ObservableObject{
    @Published var scoresList: [Score] = []
    
    var topScoresList:[(Int,Score)] {
        get{
            var result :[(Int, Score)] = [ ]
            scoresList.sorted{ (a,b) in
                return a.points > b.points
            }.forEachWithIndex{
                result.append(($0+1, $1) )
            }
            return result
        }
    }
    
    init() {
        if let ref = FirebaseCommunication.instance.ref {
            ref.observeSingleEvent(of: .value){
                $0.children.forEach{
                    let snapshotValue = ($0 as? DataSnapshot)?.value as? [String: String]
                    if let valueDictionary = snapshotValue{
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy. MM. dd."
                        if let idString = valueDictionary ["id"],
                           let usernameString = valueDictionary ["username"],
                           let pointsString = valueDictionary["points"] == nil ? nil : Int(valueDictionary["points"]!),
                           let dateString = valueDictionary["date"] == nil ? nil : dateFormatter.date(from:valueDictionary["date"]!){
                            let score = Score(id: idString, username: usernameString, points: pointsString, date: dateString)
                            self.scoresList += [score]
                        }
                    }
                }
            }
        }
    }
}
