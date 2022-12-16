//
//  OptionsView.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 04..
//

import SwiftUI

struct OptionsView: View {

    @EnvironmentObject var settings: GameSettings
    @ObservedObject var model: OptionsViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(){
            VStack(alignment: .leading) {
                Text("Rows")
                    .font(.callout)
                    .bold()
                TextField("Row", text: $model.numberOfRows)
                    .padding(7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke( model.validRows ? Color.black.opacity(0.1) : Color.red , lineWidth: 1)
                    )
            }.padding()
            VStack(alignment: .leading) {
                Text("Columns")
                    .font(.callout)
                    .bold()
                TextField("Columns", text: $model.numberOfColumns)
                    .padding(7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke( model.validColumns ? Color.black.opacity(0.1) : Color.red , lineWidth: 1)
                    )
            }.padding()
            VStack(alignment: .leading) {
                Text("Bombs")
                    .font(.callout)
                    .bold()
                TextField("Bombs", text: $model.numberOfBombs)
                    .padding(7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke( model.validBombs ? Color.black.opacity(0.1) : Color.red , lineWidth: 1)
                    )
            }.padding()
            Button(action: save) {
                Text("Save")
            }
            .padding()
            .background((model.validColumns && model.validRows && model.validBombs) ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .disabled(!(model.validColumns && model.validRows && model.validBombs))
            
        }
        .padding()
    }
    func save(){
        settings.bombs = Int(model.numberOfBombs)!
        settings.rows = Int(model.numberOfRows)!
        settings.columns = Int(model.numberOfColumns)!
        self.presentationMode.wrappedValue.dismiss()
    }
}

