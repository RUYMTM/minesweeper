//
//  FirebaseCommunication.swift
//  minesweeper
//
//  Created by mac mini on 2022. 12. 07..
//

import Foundation
import FirebaseCore
import FirebaseDatabase

class FirebaseCommunication{
    static var instance = FirebaseCommunication()
    
    var ref: DatabaseReference!
    
    private init(){
        FirebaseApp.configure()
        ref = Database.database().reference().child("profile")
    }
}
