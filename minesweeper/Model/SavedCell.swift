//
//  SavedCell.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 06..
//

import Foundation


struct SavedCell: Codable{
    let value: Int
    let pozX: Int
    let pozY: Int
    var isBomb: Bool
    var isRevealed: Bool
    var isClicked: Bool
    var isFlagged: Bool
}
