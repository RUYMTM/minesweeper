//
//  HalfFrame.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 04..
//

import SwiftUI

struct HalfFrame: Shape {
    @State var width: Float = 5.0
    @State var inner: Bool = false
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if inner {
            path.move(to: CGPoint(x: rect.minX + CGFloat(width), y: rect.minY + CGFloat(width)))
            path.addLine(to: CGPoint(x: rect.maxX - CGFloat(width), y: rect.minY + CGFloat(width)))
            path.addLine(to: CGPoint(x: rect.maxX - CGFloat(width), y: rect.maxY - CGFloat(width)))
            
            path.addLine(to: CGPoint(x: rect.maxX - CGFloat(width * 2), y: rect.maxY - CGFloat(width * 2)))
            path.addLine(to: CGPoint(x: rect.maxX - CGFloat(width * 2), y: rect.minY + CGFloat(width * 2)))
            path.addLine(to: CGPoint(x: rect.minX + CGFloat(width * 2), y: rect.minY + CGFloat(width * 2)))
        } else{
            path.move(to: CGPoint(x: rect.minX , y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.maxX - CGFloat(width), y: rect.maxY - CGFloat(width)))
            path.addLine(to: CGPoint(x: rect.maxX - CGFloat(width), y: rect.minY + CGFloat(width)))
            path.addLine(to: CGPoint(x: rect.minX + CGFloat(width), y: rect.minY + CGFloat(width)))
            
        }
        
        path.closeSubpath()
        
        return path
    }
}


struct HalfFrame_Previews: PreviewProvider {
    static var previews: some View {
        HalfFrame(inner: true)
    }
}
