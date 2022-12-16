//
//  FrameView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 03..
//

import SwiftUI

struct FrameView <Content: View>: View {
    @State var firstColor: Color = Color.white
    @State var secondColor: Color = Color.gray
    @State var backgroundColor: Color = Color(red: 0.75, green: 0.75, blue: 0.75)
    @State var width: Float = 5.0
    @State var inner: Bool = false
    var content: () -> Content
    
    var body: some View {
        GeometryReader{ geo in
        ZStack{

            HalfFrame(width: width, inner: inner).fill(firstColor)
            HalfFrame(width: width, inner: inner).rotation(Angle(degrees: 180)).fill(secondColor)
            content()
                .frame(width: geo.size.width - CGFloat(width)*2 < 0.0 ? 0.0 : geo.size.width - CGFloat(width)*2 , height: geo.size.height - CGFloat(width)*2  < 0.0 ? 0.0 : geo.size.height - CGFloat(width)*2 , alignment: .center)
                
        }
        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        .background(backgroundColor)
        }
    }
}


