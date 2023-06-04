//
//  HomeView.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//


import SwiftUI

struct HomeView: View {
    @AppStorage("uid") var userID : String = ""
    let favorites = ListViewModel()
    var body: some View {
        if userID == ""{
            AuthenticationView()
        } else
        {
            ContentView()
                .environmentObject(favorites)
        }
    }
}
