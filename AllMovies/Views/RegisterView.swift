//
//  RegisterView.swift
//  AllMovies
//
//  Created by user232715 on 4/30/23.
//

import SDWebImageSwiftUI
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
struct RegisterView: View {
//    @State var shouldShowImagePicker = false
    @Binding var currentViewShowing: String
    @State private var email : String = ""
    @State private var pwd: String = ""
    @State private var username : String = ""


    
    var body: some View {
        ZStack{
            VStack{
                Text("SIGN UP").font(.title)
//                    .padding(.bottom, 54)
                    
                    CredentialsView()
                VStack{
//                    Spacer()
                    Button(action: {
                        withAnimation{
                            self.currentViewShowing = "login"
                        }
                    }){
                        Text("Already have an account?")
                            .opacity(0.7)
                    }
                    
                }
                }.padding()
                
                Spacer()
                
                    
            }.padding()
                .frame(width: 303.22,height: 900)
                
        }
    }



struct CredentialsView: View{
    @State var shouldShowImagePicker = false
    @AppStorage("uid") var userID : String = ""
    @State private var email: String = ""
    @State private var pwd: String = ""
    @State var image: UIImage?
    @State var loginStatusMsg = ""
    @State private var fname: String = ""
    @State private var lname: String = ""

    private func isValidPassword(_ pwd: String)-> Bool{
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&? ]).*")
        
        return passwordRegex.evaluate(with: pwd)
    }

    var body: some View{
        VStack{
            Button(action:{
                shouldShowImagePicker.toggle()
            },
                   label: {
                
                VStack{
                    if let image = self.image{
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 128, height: 128)
                            .scaledToFill()
                            .cornerRadius(64)
                    } else
                    {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            })
            
            VStack(alignment: .leading){
                            Text("FirstName").font(.body)
                            HStack{
                                TextField("  Enter FirstName Here",text: $fname) .padding(.leading,10)
                                
                            }.frame(width: 300, height: 35)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .opacity(0.2))
                            
                        }.padding(.bottom,20)
                        
                        VStack(alignment: .leading){
                            Text("LastName").font(.body)
                            HStack{
                                TextField("  Enter LastName Here",text: $lname) .padding(.leading,10)
                                
                            }.frame(width: 300, height: 35)
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.red)
                                    .opacity(0.2))
                            
                        }.padding(.bottom,20)

            VStack(alignment: .leading){
                Text("Email").font(.body)
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
                
            }.padding(.bottom,20) // End of Email
            
            
            // Begin Password
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
            }.padding(.bottom,15)
            // End of Password Block
            
            Button{
                createNewAccount()
            } label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .font(.body)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.red).opacity(0.7))
            }.padding(.top,20)
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
                    ImagePicker(image: $image)
                }
        }
    }
    
    private func createNewAccount(){
        UserManager.shared.auth.createUser(withEmail: email, password: pwd) { authResult, error in
            if let error = error{
                print(error)
                self.loginStatusMsg = "Failed to create user : \(error)"
                return
            }
            print("succesfully login : \(authResult?.user.uid ?? "" )")
            if let authResult = authResult{
                print(authResult.user.uid)
                userID = authResult.user.uid

            }
            self.persistImageToStorage()
            
        }
        
    }
    private func persistImageToStorage(){
//        let filename = UUID().uuidString
        guard let uid = UserManager.shared.auth.currentUser?.uid
        else{return}
        let ref = UserManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else{return}
        ref.putData(imageData, metadata: nil){
            metaData, err in
            if let err=err{
                print("Error to push image to storage \(err)")
                return
            }
            
            ref.downloadURL{url, err in
                if let err=err{
                    self.loginStatusMsg = "Error to "
                    return
                }
                print("Succesfully stored \(url?.absoluteString)")
                guard let url = url else{return}
                                self.storeUserInformation(imageProfileUrl: url)
            }
            
        }
        
    }
    private func storeUserInformation(imageProfileUrl: URL){
            guard let uid = UserManager.shared.auth.currentUser?.uid else{
                return
            }
            let userData = ["email": self.email, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString, "Fname" : self.fname, "Lname": self.lname]
            UserManager.shared.firestore.collection("users")
                .document(uid).setData(userData){
                    err in
                    if let err = err {
                        print(err)
                        self.loginStatusMsg = "\(err)"
                        return
                    }
                }
        }
}
