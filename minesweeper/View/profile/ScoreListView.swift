//
//  ScoreListView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 05..
//

import SwiftUI

struct ScoreListView: View {
    @State var scores: FetchedResults<OwnScore>
    var body: some View {
        VStack{
            Image(systemName: "rosette").resizable().aspectRatio(contentMode: .fit).frame(width: 80)
            HStack{
                Text("Scores")
                    .font(.system(.title, design: .rounded))
                    .bold()
            }
            List(){
                Section(header: HStack {
                    Text("Points")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Text("Time")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                
                .background(Color.blue)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0))
                ){
                    ForEach(scores.filter{
                        $0.points != 0
                    }){ score in
                        HStack{
                            Text(String(score.points))
                            Spacer()
                            Text(dateToString(score.timestamp!))
                                .padding(.leading)
                            Spacer()
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
        }
    }
    
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
