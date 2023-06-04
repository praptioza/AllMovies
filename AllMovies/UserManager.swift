//
//  UserManager.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import FirebaseAuth
import FirebaseStorage
class UserManager: NSObject{
  
    let firestore : Firestore
    let auth: Auth
    let storage: Storage
    
    static let shared = UserManager()
    override init() {
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        super.init()
        
    }
    
    
}
