//
//  GameGridCellView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 26..
//

import SwiftUI

struct GameGridCellView: View {
    @ObservedObject var cell: GameGridCell
    @EnvironmentObject var gameModel: GameModel
    
    var body: some View {
        Button(action: {}) {
            Image(cell.getImageResource)
                .resizable()
                .aspectRatio(contentMode: .fill )
        }
        .simultaneousGesture(LongPressGesture().onChanged { _ in
            gameModel.isPressed = true
        })
        .simultaneousGesture(LongPressGesture().onEnded { _ in
            longClick()
            gameModel.isPressed = false
        })
        .simultaneousGesture(TapGesture().onEnded {
            click()
            gameModel.isPressed = false
        })
    }
    
    private func click(){
        gameModel.click(x: cell.pozX, y: cell.pozY)
    }
    
    private func longClick(){
        gameModel.flag(x: cell.pozX, y: cell.pozY)
    }
}

struct GameGridCellView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridCellView(cell:GameGridCell(pozX: 0, pozY:0, value: -1))
    }
}
