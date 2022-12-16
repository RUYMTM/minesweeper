//
//  UserProfileView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 05..
//

import SwiftUI

struct UserProfileView: View {
    @State var scores: FetchedResults<OwnScore>
    @EnvironmentObject var settings: GameSettings
    var games : Int {
        get{
            return scores.count
        }
    }
    
    var gamesWonList : Array<OwnScore> {
        get{
            return scores.filter{
                $0.points != 0
            }
        }
    }
    
    var gamesWon : Int {
        get{
            return gamesWonList.count
        }
    }
    var winRate : Double {
        get{
            return games == 0 ? 0.0 : (Double(gamesWon) / Double(games))*100
        }
    }
    
    var bestScore : Int16? {
        get{
            return scores.max { a, b in a.points < b.points }?.points
                
        }
    }
    
    var averageScores : Double? {
        get{
            return games == 0 ? nil : Double(gamesWonList.map{$0.points}.reduce(0, +)) / Double(gamesWon)
                
        }
    }
    
    var body: some View {
        VStack{
            Image(systemName: "person.crop.circle.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 80)
            HStack{
                Text(settings.username)
                    .font(.system(.title, design: .rounded))
                    .bold()
            }
            List(){
                Section(header: HStack {
                    Text("Games")
                        .font(.headline)
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
                    
                    HStack{
                        VStack(alignment: .leading){
                            Image(systemName: "checkerboard.rectangle")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Games Started")
                                .font(.system(.body, design: .rounded))
                                .bold()
                        }
                        Spacer()
                        Text(String(games))
                            .font(.system(.subheadline, design: .rounded))
                            .bold()
                            .padding(.trailing)
                    }
                    .padding(.vertical)
                    
                    HStack{
                        VStack(alignment: .leading){
                            Image(systemName: "crown")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Games Won")
                                .font(.system(.body, design: .rounded))
                                .bold()
                        }
                        Spacer()
                        Text(String(gamesWon))
                            .font(.system(.subheadline, design: .rounded))
                            .bold()
                            .padding(.trailing)
                    }
                    
                    .padding(.vertical)
                    
                    HStack{
                        VStack(alignment: .leading){
                            Image(systemName: "percent")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Win Rate")
                                .font(.system(.body, design: .rounded))
                                .bold()
                        }
                        Spacer()
                        Text(String(format: "%.2f%", winRate))
                            .font(.system(.subheadline, design: .rounded))
                            .bold()
                            .padding(.trailing)
                    }
                    
                    .padding(.vertical)
                }
                Section(header: HStack {
                    Text("Scores")
                        .font(.headline)
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
                    HStack{
                        
                        VStack(alignment: .leading){
                            Image(systemName: "star")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Best Score")
                                .font(.system(.body, design: .rounded))
                                .bold()
                        }
                        Spacer()
                        Text(bestScore == nil ? "-" : String(bestScore!))
                            .font(.system(.subheadline, design: .rounded))
                            .bold()
                            .padding(.trailing)
                    }
                    
                    .padding(.vertical)
                    
                    HStack{
                        VStack(alignment: .leading){
                            Image(systemName: "line.horizontal.star.fill.line.horizontal")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Avarage Score")
                                .font(.system(.body, design: .rounded))
                                .bold()
                        }
                        Spacer()
                        Text(averageScores == nil ? "-" : String(format: "%.2f%", averageScores!))
                            .font(.system(.subheadline, design: .rounded))
                            .bold()
                            .padding(.trailing)
                    }
                    
                    .padding(.vertical)
                }
            }
            .listStyle(GroupedListStyle())

        }
    }
}
