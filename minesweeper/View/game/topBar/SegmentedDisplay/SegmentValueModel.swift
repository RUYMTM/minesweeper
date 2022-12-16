//
//  SegmentValueModel.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 03..
//

import Foundation

class SegmentValueModel: ObservableObject{
    
    @Published var value: (Character, Character, Character)
    
    var first: ObservableCharacterModel{
        get{
            return ObservableCharacterModel(value.0)
        }
    }
    
    var second: ObservableCharacterModel{
        get{
            return ObservableCharacterModel(value.1)
        }
    }
    
    var third: ObservableCharacterModel{
        get{
            return ObservableCharacterModel(value.2)
        }
    }
    
    init(value: String) {
        let charArray = Array(value)
        self.value = (charArray[0],charArray[1],charArray[2])
    }
}
