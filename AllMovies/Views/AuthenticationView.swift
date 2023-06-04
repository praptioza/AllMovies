//
//  AuthenticationView.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//


import SwiftUI

struct AuthenticationView: View {
    @State private var currentViewShowing: String = "login"
    var body: some View {
        if (currentViewShowing == "login"){
            LoginView(currentShowingView: $currentViewShowing)
        }
            else{
            RegisterView(currentViewShowing: $currentViewShowing)
                    .transition(.move(edge: .bottom))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
