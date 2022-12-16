//
//  GameGridWindowView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 04..
//

import SwiftUI

struct GameGridWindowView: View {
    @EnvironmentObject var gameModel: GameModel
    @EnvironmentObject var settings: GameSettings
    @Binding var x: Int
    @Binding var y: Int
    
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 0){
                ForEach(0..<15 ) { row in
                    HStack(spacing: 0){
                        ForEach(0..<(settings.columns>10 ? 8 :  10)) { column in
                            if row+x < settings.rows && column+y < settings.columns {
                                GameGridCellView(cell:gameModel.getCellAt(x: row+x, y: column+y))
                                    .frame(width:geo.size.width * 1/(settings.columns>10 ? 8 :  10), height: geo.size.height * 1/15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .animation(.easeInOut)
                            }
                        }
                    }
                    
                }
            }
            
            
        }
    }
}

