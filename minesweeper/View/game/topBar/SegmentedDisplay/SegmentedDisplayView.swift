//
//  SegmentedDisplayView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 01..
//

import SwiftUI

struct SegmentedDisplayView: View {
    @ObservedObject var value: SegmentValueModel
    var body: some View {
        GeometryReader{ geo in
            HStack{
                SegmentedNumberView(value: value.first)
                SegmentedNumberView(value: value.second)
                SegmentedNumberView(value: value.third)
            }
            
            .background(Color(.black))
            
        }
    }
}

struct SegmentedDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedDisplayView(value: SegmentValueModel(value:"012"))
    }
}
