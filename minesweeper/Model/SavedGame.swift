//
//  SavedGame.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 06..
//

import Foundation

struct SavedGame: Codable{
    var rows: Int
    var columns: Int
    var bombs: Int
    var time: Int
    var flags: Int
    var minesweeperGrid: [[SavedCell]]
}
