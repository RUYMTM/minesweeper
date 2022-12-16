//
//  UserNameVIew.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 04..
//


import SwiftUI

struct UsernameView: View {
    @EnvironmentObject var settings: GameSettings
    @State var input = ""
    var body: some View {
        VStack{

            VStack(alignment: .leading) {
                Text("Username")
                    .font(.callout)
                    .bold()

                TextField("", text: $input)
                    .padding(7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(input.count > 1 && !settings.listOfUsernames.contains(input) ? Color.black.opacity(0.1) : Color.red , lineWidth: 1)
                    )
                    
                    
               
            }.padding()
            Button("Save"){
                settings.username = input
                print(settings.username)
                settings.isUsernameSetted = true
            }
            .padding()
            .background((input.count > 1 && !settings.listOfUsernames.contains(input) ) ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .disabled(!(input.count > 1 && !settings.listOfUsernames.contains(input) ))

        }
        
       
    }
}
