//
//  OptionsViewModel.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 05..
//

import Foundation

class OptionsViewModel: ObservableObject{
    @Published var numberOfRows: String
    @Published var numberOfColumns: String
    @Published var numberOfBombs: String
    
    init(numberOfRows: Int, numberOfColumns: Int, numberOfBombs: Int){
        self.numberOfRows = String(numberOfRows)
        self.numberOfColumns = String(numberOfColumns)
        self.numberOfBombs = String(numberOfBombs)
    }
    var validRows : Bool {
        get{
            Int(numberOfRows) != nil ? Int(numberOfRows)!>=10 && Int(numberOfRows)!<=20 : false
        }
    }
    var validColumns  : Bool {
        get{
            Int(numberOfColumns) != nil ? Int(numberOfColumns)!>=10 && Int(numberOfColumns)!<=20 : false
        }
    }
    var validBombs  : Bool {
        get{
            Int(numberOfColumns) != nil ? Int(numberOfRows) != nil ? Int(numberOfBombs) != nil ? Int(numberOfBombs)! >= 10 &&
                Int(numberOfBombs)! <= ((Int(numberOfRows)! - 1) * (Int(numberOfColumns)! - 1)) : false : false : false
        }
    }
}
