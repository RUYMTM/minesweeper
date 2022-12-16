//
//  ContentView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 11. 26..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \OwnScore.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<OwnScore>
    
    
    @StateObject var settings = GameSettings()
    @StateObject var savedData = SavedGameModel()
    
    var body: some View {
        ZStack{
            if settings.isUsernameSetted {
                NavigationView{
                    VStack(spacing: 40) {
                        NavigationLink("Continue", destination: GamePanelView(gameModel: GameModel(context: viewContext, savedGame: savedData.savedGame!)))
                            .simultaneousGesture(TapGesture().onEnded {
                                settings.bombs = savedData.savedGame!.bombs
                                settings.rows = savedData.savedGame!.rows
                                settings.columns = savedData.savedGame!.columns
                            })
                            .disabled(savedData.savedGame == nil)
                            .onAppear {
                                savedData.update()
                            }
                        NavigationLink("New Game", destination: GamePanelView(gameModel: GameModel(context: viewContext, numberOfRows: settings.rows , numberOfColumns: settings.columns, numberOfBombs: settings.bombs)))
                            .simultaneousGesture(TapGesture().onEnded {
                                UserDefaults.standard.set(nil, forKey: "savedGame")
                            })
                        NavigationLink("Options", destination: OptionsView(model: OptionsViewModel(numberOfRows: settings.rows, numberOfColumns: settings.columns, numberOfBombs: settings.bombs)))
                        NavigationLink("Profile", destination: ProfileView())
                        NavigationLink("Scoreboard", destination: ScoreboardView())
                    }
                }
            } else{
                UsernameView()
            }
        }
        .environmentObject(settings)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
