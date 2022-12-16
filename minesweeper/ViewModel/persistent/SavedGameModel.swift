//
//  SavedGameModel.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 07..
//

import Foundation

class SavedGameModel : ObservableObject{
    @Published var savedGame: SavedGame?
    
    func update() {
        let data = UserDefaults.standard.object(forKey: "savedGame") as? Data
       if data == nil {
           savedGame = nil
       } else {
           let decoder = JSONDecoder()
           if let loadedData = try? decoder.decode(SavedGame.self, from: data!) {
               savedGame = loadedData
           } else {
               savedGame = nil
           }
       }
    }
}
