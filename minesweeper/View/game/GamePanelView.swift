//
//  GamePanelView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 27..
//

import SwiftUI

struct GamePanelView: View {
    
    @StateObject var gameModel: GameModel
    @EnvironmentObject var settings: GameSettings
    
    let frameSize: Float = 5.0
    var body: some View {
        GeometryReader{ geo in
            FrameView(width: frameSize){
                VStack(spacing: 5){
                    FrameView(firstColor: Color.gray, secondColor: Color.white,width: frameSize){
                        GamePanelTopBarView()
                    }
                    .frame(width: geo.size.width  - CGFloat(frameSize) * 6, height: geo.size.height * 1/10 - CGFloat(frameSize) * 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    FrameView(firstColor: Color.gray, secondColor: Color.white,width: frameSize){
                        GameGridView()
                    }
                    .frame(width: geo.size.width  - CGFloat(frameSize) * 6, height: geo.size.height * 9/10 - CGFloat(frameSize) * 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .onDisappear{
                        gameModel.onDisappear()
                    }
                    Spacer()
                }
                .padding(.top, CGFloat(frameSize) * 2 )
            }
            .padding(.leading, 1.0)
            .frame(width: geo.size.width-2.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .border(Color.black.opacity(0.4) )
            .environmentObject(gameModel)
        }
    }
    
}
