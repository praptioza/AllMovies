//
//  LoginView.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//


import SwiftUI
import FirebaseAuth
struct LoginView: View {
    @AppStorage("uid") var userID : String = ""
    @Binding var currentShowingView: String
    @State private var email: String = ""
    @State private var pwd: String = ""
    
    private func isValidPassword(_ pwd: String)-> Bool{
        let pwdregex = NSPredicate(format: "SELF MATCHES %@", "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&? ]).*")
        
        return pwdregex.evaluate(with: pwd)
    }
    
    private func loginUser(){
        UserManager.shared.auth.signIn(withEmail: email, password: pwd){authResult, error in
            if let error = error{
                print(error)
            }
            if let authResult = authResult{
                print(authResult.user.uid)
                withAnimation{
                    userID = authResult.user.uid
                }
                
            }
        }
    }
    
    var body: some View {
        ZStack{
            
            VStack{
                Text("LOG-IN").font(.title)
                
                VStack(alignment: .leading){
                    Text("Enter Email:").font(.body)
                    
                    
                    HStack{
                        TextField("  Enter Email Here",text: $email) .padding(.leading,10)
                        if(email.count != 0){
                            Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(email.isValidEmail() ? .green : .red)
                                .padding()
                        }
                    }.frame(width: 300, height: 35)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.red)
                            .opacity(0.2))
                    
                }.padding(.bottom,36)
                
                VStack(alignment: .leading){
                    Text("Password").font(.body)
                    HStack{
                        SecureField("  Enter Password Here",text: $pwd)
                            .padding(.leading,10)
                        if(pwd.count != 0){
                            Image(systemName: isValidPassword(pwd) ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(isValidPassword(pwd) ? .green : .red)
                                .padding()
                        }
                    }.frame(width: 300, height: 35)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.red)
                            .opacity(0.2))
                    
                    
                }
                Button{
                    loginUser()
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.body)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10).foregroundColor(.red).opacity(0.7))
                }.padding(.top,50)
                
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation{
                            self.currentShowingView = "signup"
                        }
                    }){
                        Text("Sign Up").foregroundColor(.red)
                            .opacity(0.7)
                    }
                    Spacer()
                }.padding(.top,40)
            }
            
        }
        .padding()
        .frame(width: 303.22,height: 688)
    }
}
