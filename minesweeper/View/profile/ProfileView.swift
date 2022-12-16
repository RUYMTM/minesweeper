//
//  ProfileView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 05..
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \OwnScore.points, ascending: false)],
        animation: .default)
    var scores: FetchedResults<OwnScore>
    
    var body: some View {
        TabView {
            UserProfileView(scores: scores)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            ScoreListView(scores: scores)
                .tabItem {
                    Label("Scores", systemImage: "list.bullet")
                }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
