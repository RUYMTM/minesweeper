//
//  ScoreboardView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 07..
//

import SwiftUI

struct ScoreboardView: View {
    @StateObject var scoreboardModel = ScoreboardModel()
    var body: some View {
        VStack{
            ZStack{
                Image(systemName:
                        "graduationcap").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            }
            
            
            HStack{
                Text("Scoreboard")
                    .font(.system(.title, design: .rounded))
                    .bold()
            }
            List(){
                Section(header: HStack {
                    Text("Place")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Text("Name")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Text("Points")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    
                }
                
                .background(Color.blue)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0))
                ){
                    ForEach(scoreboardModel.topScoresList, id: \.0 ){ (place, score) in
                        HStack{
                            Text(String(place)+".")
                            Spacer()
                            Text(score.username)
                            Spacer()
                            Text(String(score.points))
                                .padding(.trailing)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
        }
    }
    
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}
