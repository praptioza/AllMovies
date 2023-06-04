//
//  AllMoviesApp.swift
//  AllMovies
//
//  Created by Prapti Oza on 4/9/23.
//

import SwiftUI
import FirebaseCore
@main
struct AllMoviesApp: App {
    init(){
            FirebaseApp.configure()
    }
//    let favorites = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
//            ContentView()
//                .environmentObject(favorites)
        }
    }
}
