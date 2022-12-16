//
//  GameGridCell.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 26..
//

import Foundation

class GameGridCell: ObservableObject{
    let value: Int
    let pozX: Int
    let pozY: Int
    @Published var isBomb: Bool
    @Published var isRevealed: Bool
    @Published var isClicked: Bool
    @Published var isFlagged: Bool
    
    init(savedCell: SavedCell){
        self.pozX = savedCell.pozX
        self.pozY = savedCell.pozY
        self.value = savedCell.value
        self.isBomb = savedCell.isBomb
        self.isRevealed = savedCell.isRevealed
        self.isClicked = savedCell.isClicked
        self.isFlagged = savedCell.isFlagged
    }
    
    func toSavedCell() -> SavedCell{
        return SavedCell(value: value, pozX: pozX, pozY: pozY, isBomb: isBomb, isRevealed: isRevealed, isClicked: isClicked, isFlagged: isFlagged)
    }
    
    init(pozX: Int, pozY: Int, value: Int){
        self.pozX = pozX
        self.pozY = pozY
        self.value = value
        self.isBomb = value == -1
        self.isRevealed = false
        self.isClicked = false
        self.isFlagged = false
    }
    
    
    
    var getImageResource: String{
        get{
            if(isFlagged){
                if(isRevealed && !isBomb){
                    return "flag_notbomb"
                } else{
                    return "flag"
                }
            } else{
                if(isRevealed && isBomb && !isClicked){
                    return "bomb_normal"
                } else{
                    if(isClicked){
                        if(isBomb){
                            return "bomb_exploded"
                        } else{
                            return getNumberImageResource()
                        }
                    } else {
                        return "button"
                    }
                }
            }
        }
    }
    
    private func getNumberImageResource() -> String{
        return "number_\(value)"
    }
    
    func setClicked(){
        if(!self.isFlagged && !self.isClicked){
            self.isClicked = true
            setRevealed()
        }
        if(self.isFlagged){
            self.isFlagged = false
        }
    }
    
    func setRevealed(){
        self.isRevealed = true
    }
    
    func setFlagged(){
        self.isFlagged = !self.isFlagged
    }
    
}

