//
//  GameGridData.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 26..
//

import Foundation

struct GameGridModel{
    
    let gameModel: [[Int]]
    
    init(numberOfRows: Int, numberOfColumns: Int, numberOfBombs: Int){
        let safeNumberOfBombs = min(numberOfBombs,numberOfRows*numberOfColumns)
        var array = Array(repeating: Array(repeating: 0, count: numberOfColumns), count: numberOfRows)
        (0..<safeNumberOfBombs).forEach{ _ in
            var i: Int
            var j: Int
            repeat {
                i = Int.random(in: 0..<numberOfRows)
                j = Int.random(in: 0..<numberOfColumns)
            } while array[i][j] != 0
            array[i][j] = -1
        }
        
        (0..<numberOfRows).forEach{ i in
            (0..<numberOfColumns).forEach{ j in
                if(array[i][j] == -1){
                    (-1...1).forEach{ k in
                        (-1...1).forEach{ l in
                            if( k+i >= 0 && l+j >= 0 && k+i < numberOfRows && l+j < numberOfColumns && array[i+k][j+l] != -1) {
                                array[i+k][j+l]+=1
                            }
                        }
                    }
                }
            }
        }
        
        self.gameModel = array
    }
}
