//
//  GameSettings.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 05..
//

import Foundation
import FirebaseDatabase

class GameSettings: ObservableObject{
    @Published private var numberOfRows = 10
    
    var rows: Int{
        get{
            return numberOfRows
        }
        set(value){
            if value>=10 && value<=20{
                numberOfRows = value
            }
        }
    }
    
    @Published private var numberOfColumns = 10
    var columns: Int{
        get{
            return numberOfColumns
        }
        set(value){
            if value>=10 && value<=20{
                numberOfColumns = value
            }
        }
    }
    
    @Published private var numberOfBombs = 10
    var bombs: Int{
        get{
            return numberOfBombs
        }
        set(value){
            if value>=10 && value<=((numberOfRows-1)*(numberOfColumns-1)){
                numberOfBombs = value
            }
        }
    }
    
    @Published private var nameOfThePlayes: String
    var username: String{
        get{
            return nameOfThePlayes
        }
        set(value){
            if value != "" {
                UserDefaults.standard.set(value, forKey: "username")
                nameOfThePlayes = value
                if let ref = FirebaseCommunication.instance.ref {
                    let id = ref.childByAutoId().key!
                    UserDefaults.standard.set(id, forKey: "userId")
                }
            }
        }
    }
    
    @Published var isUsernameSetted : Bool
    
    @Published var listOfUsernames: [String] = []
    
    init(){
        let value = UserDefaults.standard.value(forKey: "username") as? String
        if value == nil {
            nameOfThePlayes =  ""
            isUsernameSetted = false
        } else {
            nameOfThePlayes = value!
            isUsernameSetted = true
        }
        if let ref = FirebaseCommunication.instance.ref {
            ref.observeSingleEvent(of: .value){
                $0.children.forEach{
                    let snapshotValue = ($0 as? DataSnapshot)?.value as? [String: String]
                    if let valueDictionary = snapshotValue{
                        if let usernameString = valueDictionary ["username"]{
                            self.listOfUsernames += [usernameString]
                        }
                    }
                }
            }
        }
    }
    
}
