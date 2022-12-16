//
//  ObservableCharacterModel.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 03..
//

import Foundation
class ObservableCharacterModel: ObservableObject{
    @Published var char: Character
    
    init(_ char: Character) {
        self.char = char
    }
}
