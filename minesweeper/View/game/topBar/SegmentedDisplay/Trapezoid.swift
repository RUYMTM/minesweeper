//
//  Trapezoid.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 03..
//

import SwiftUI


struct Trapezoid: Shape {
    @State var percent: Double = 25.0
    @State var isVertical: Bool = false
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let edge = (isVertical ? rect.height : rect.width) * CGFloat(percent/100)
        if isVertical {
            path.move(to: CGPoint(x: rect.minX , y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + edge ))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - edge))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY ))
        } else {
            path.move(to: CGPoint(x: rect.minX + edge, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - edge, y: rect.minY ))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY ))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
       
        path.closeSubpath()
        return path
    }
}
