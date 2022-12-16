//
//  Score.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 07..
//

import Foundation
import FirebaseDatabase

struct Score{
    let id: String
    let username: String
    let points: Int
    let date: Date
}
