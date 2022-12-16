//
//  SegmentedNumberView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 01..
//

import SwiftUI

struct SegmentedNumberView: View {
    
    @ObservedObject var value: ObservableCharacterModel
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(spacing: 0){
                ZStack{
                    VStack(spacing: 0){
                        Trapezoid()
                            .foregroundColor("02356789".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .rotationEffect(Angle(degrees: 180))
                            .padding([.trailing, .leading],geo.size.width*0.01)
                            .frame(width: geo.size.width , height: geo.size.height/8, alignment: .center)
                            
                        Spacer()
                        Trapezoid(percent: 12.5)
                            .foregroundColor("2345689".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .padding([.trailing, .leading],geo.size.width*0.01)
                            .frame(width: geo.size.width , height: geo.size.height/16, alignment: .center)
                    }
                    HStack{
                        Trapezoid(isVertical: true)
                            .foregroundColor("045689".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .padding([.bottom, .top],geo.size.width*0.01)
                            .frame(width: geo.size.height/8, height:geo.size.width  , alignment: .center)
                        Spacer()
                        Trapezoid(isVertical: true)
                            .foregroundColor("01234789".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .rotationEffect(Angle(degrees: 180))
                            .padding([.bottom, .top],geo.size.width*0.01)
                            .frame(width: geo.size.height/8, height:geo.size.width  , alignment: .center)
                    }
                    
                }
                ZStack{
                    VStack(spacing: 0){
                        Trapezoid(percent: 12.5)
                            .foregroundColor("2345689".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .rotationEffect(Angle(degrees: 180))
                            .padding([.trailing, .leading],geo.size.width*0.01)
                            .frame(width: geo.size.width , height: geo.size.height/16, alignment: .center)
                        Spacer()
                        Trapezoid()
                            .foregroundColor("0235689".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .padding([.trailing, .leading],geo.size.width*0.01)
                            .frame(width: geo.size.width , height: geo.size.height/8, alignment: .center)
                    }
                    HStack{
                        Trapezoid(isVertical: true)
                            .foregroundColor("0268".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .padding([.bottom, .top],geo.size.width*0.01)
                            .frame(width: geo.size.height/8, height:geo.size.width  , alignment: .center)
                        Spacer()
                        Trapezoid(isVertical: true)
                            .foregroundColor("013456789".contains(value.char) ? .red : Color.red.opacity(0.27))
                            .rotationEffect(Angle(degrees: 180))
                            .padding([.bottom, .top],geo.size.width*0.01)
                            .frame(width: geo.size.height/8, height:geo.size.width  , alignment: .center)
                    }
                }
                
            }

        }
    }
}
struct SegmentedNumberView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedNumberView(value:ObservableCharacterModel(Array("2")[0]))
    }
}
