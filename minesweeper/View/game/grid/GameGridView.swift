//
//  GameGridView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 26..
//

import SwiftUI

struct GameGridView: View {
    @EnvironmentObject var settings: GameSettings
    
    @State var hTop = 0
    @State var vTop = 0
    let frameSize: Float = 5.0
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 0){
                if settings.rows > 15 {
                    FrameView(width: frameSize){
                        Button(action: {
                            if vTop>0{
                                vTop-=1
                            }
                        }){
                            Image(systemName: "arrow.up.to.line")
                                .foregroundColor(Color.black.opacity(0.9))
                        }
                    }
                        .frame(width:geo.size.width  , height: geo.size.width  * 1/12 )
                }
                HStack(spacing: 0){
                    if settings.columns > (settings.columns>10 ? 8 :  10){
                        FrameView(width: frameSize){
                            Button(action: {
                                if hTop>0{
                                    hTop-=1
                                }
                            }){
                                Image(systemName: "arrow.left.to.line")
                                    .foregroundColor(Color.black.opacity(0.9))
                            }
                        }
                            .frame(width:geo.size.width * 1/10, height: geo.size.height - (settings.rows > 15 ? geo.size.width * 2/12 : 0))
                    }

                    GameGridWindowView(x: $vTop, y: $hTop)
                    if settings.columns > (settings.columns>10 ? 8 :  10){
                        FrameView(width: frameSize){
                            Button(action: {
                                if hTop<settings.columns-(settings.columns>10 ? 8 :  10){
                                    hTop+=1
                                }
                            }){
                                Image(systemName: "arrow.right.to.line")
                                    .foregroundColor(Color.black.opacity(0.9))
                            }
                        }
                        .frame(width:geo.size.width * 1/10, height: geo.size.height - (settings.rows > 15 ? geo.size.width * 2/12 : 0))
                    }
                }
                if settings.rows > 15{
                    FrameView(width: frameSize){
                        Button(action: {
                            if vTop < settings.rows - 15{
                                vTop+=1
                            }
                        }){
                            Image(systemName: "arrow.down.to.line")
                                .foregroundColor(Color.black.opacity(0.9))
                        }
                    }
                        .frame(width:geo.size.width  , height: geo.size.width  * 1/12 )
                }
                
            }
        }
    }
}

struct GameGridView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridView()
    }
}
