//
//  GamePanelTopBarView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 27..
//

import SwiftUI

struct GamePanelTopBarView: View {
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var gameModel: GameModel
    
    var body: some View {
        GeometryReader{ geo in
           
                HStack{
                    SegmentedDisplayView(value: gameModel.bombsRemaining)
                        .frame(width: geo.size.height*1.5, height: geo.size.height*0.8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button(action: {
                        gameModel.newGame()
                        gameModel.isPressed = false
                    }) {
                        Image(gameModel.isPressed ? "o_smiley" : gameModel.isEnded ? gameModel.isWon ? "sunglass_smiley" : "dead_smiley" : "smiley")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .simultaneousGesture(LongPressGesture().onChanged { _ in
                        gameModel.isPressed = true
                    })
                    .simultaneousGesture(LongPressGesture(minimumDuration: 999).onEnded { _ in
                        gameModel.isPressed = false
                    })
                    
                    .frame(width: geo.size.height*0.8, height: geo.size.height*0.8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    SegmentedDisplayView(value: gameModel.timeString)
                        .frame(width: geo.size.height*1.5, height: geo.size.height*0.8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                }
                .padding(.top, geo.size.height*0.1)
                .padding(.horizontal ,geo.size.height*0.1)
                
            }
        }
    
}

struct GamePanelTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        GamePanelTopBarView()
    }
}
