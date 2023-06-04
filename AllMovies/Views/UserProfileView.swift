//
//  UserProfileView.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//


import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct UserDetails{
    let uid, email, profileImageUrl,Fname,Lname: String
}

class UserProfileDetailViewModel: ObservableObject{
    @Published var errorMsg = ""
    @Published var userDetails : UserDetails?
    init(){
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        
        guard let uid = UserManager.shared.auth.currentUser?.uid
        else{
            self.errorMsg = "Could Not Found uid"
            return
        }
        
        UserManager.shared.firestore.collection("users").document(uid).getDocument{snapshot , error in
            if let error = error{
                print("Failed to fetch current user:", error)
                return
            }
            
            self.errorMsg = "\(uid)"
            guard let data = snapshot?.data()else {
                self.errorMsg="No data found"
                return
            }
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageUrl = data["profileImageUrl"] as? String ?? ""
            let Fname = data["Fname"] as? String ?? ""
            let Lname = data["Lname"] as? String ?? ""
            
            self.userDetails = UserDetails(uid: uid, email:email, profileImageUrl: profileImageUrl, Fname: Fname, Lname: Lname)
            
//            self.errorMsg = userDetails.profileImageUrl
        }
    }
    
    
}

struct UserProfileView: View {
    @AppStorage("uid") var userID : String = ""
    @ObservedObject private var vm = UserProfileDetailViewModel()
    var body: some View {
        
        
        VStack{
            
            Text("Profile").font(.title)
                .padding(10)
            
            VStack{
                Text("Profile Photo").font(.body)
                if vm.userDetails?.profileImageUrl != nil{
                    WebImage(url : URL(string: vm.userDetails?.profileImageUrl ?? ""))
                        .resizable()
                        .frame(width: 128, height: 128)
                        .scaledToFill()
                        .cornerRadius(64)
                } else
                {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 128, height: 128)
                        .scaledToFill()
                        .cornerRadius(64)
                }
                
            }.padding(10)
            
            
            VStack(alignment: .leading){
                
                HStack{
                    Text("FirstName: \(vm.userDetails?.Fname ?? "Not present")") .padding(.leading,10)
                    
                }
                
            }.padding(10)
            VStack(alignment: .leading){
                
                HStack{
                    Text("LastName: \(vm.userDetails?.Lname ?? "Not present")") .padding(.leading,10)
                    
                }
                
            }.padding(10)
            
            VStack(alignment: .leading){
                
                HStack{
                    Text("Email: \(vm.userDetails?.email ?? "Not present")") .padding(.leading,10)
                    
                }
                
            }.padding(10)
            
            Button(action:{}){Text("Edit Profile")}
                .padding()
            Button(action: {
                let firebaseAuth = Auth.auth()
                do{
                    try firebaseAuth.signOut()
                    withAnimation{
                        userID = ""
                    }
                }
                catch let signOutError as NSError{
                    print("Error signing out: %@",signOutError)
                }
            }){
                Text("Log Out")
            }
            Spacer()
        }.padding()
            
            
       
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
