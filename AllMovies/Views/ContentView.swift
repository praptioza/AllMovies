//
//  ContentView.swift
//  AllMovies
//
//  Created by Prapti Oza on 4/9/23.
//

import SwiftUI
import SDWebImageSwiftUI
struct ContentView: View {
    @ObservedObject var listViewModel = ListViewModel()
    @ObservedObject var vm = UserProfileDetailViewModel()
    @State private var isFav : Bool = false
    @AppStorage("uid") var userID : String = ""
    
    var body: some View {
        TabView{
            //popular
            NavigationView{
                //list of movies
                ZStack{
                    VStack{
                        ScrollView{
                            ForEach(listViewModel.popularmovies, id: \.id) { movie in
                                //navigation to movie's details view
                                NavigationLink(destination: MovieDetailView(movie: movie,listViewModel: listViewModel))
                                {
                                    MoviesListRow(movie: movie,listviewmodel: listViewModel)
                                }
                            }
                            
                        }
                    }//vstack
                }//zstack
                .navigationTitle("Popular Movies")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink(destination: UserProfileView(userID: userID )) {
                            HStack{
                                if vm.userDetails?.profileImageUrl != nil{
                                    WebImage(url : URL(string: vm.userDetails?.profileImageUrl ?? ""))
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                } else
                                {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                }
                                Text(vm.userDetails?.Fname ?? "Not Found")
                                    .font(.custom("bodyFont", size: 15)).bold()
                                
                            }
                        }
                   }
                }
                .environmentObject(listViewModel)
                
            }//nav view
            .tabItem{
                Label("Popular", systemImage: "globe")
            }
            .tag(0)
            //end of popular view
            .onAppear{
                listViewModel.fetchPopularMovies()
            }
            
            //toprated
            NavigationView{
                //list of movies
                ZStack{
                    VStack{
                        ScrollView{
                            ForEach(listViewModel.topratedmovies, id: \.id) { movie in
                                //navigation to movie's details view
                                NavigationLink(destination: MovieDetailView(movie: movie,listViewModel: listViewModel))
                                {
                                    HStack{
                                        MoviesListRow(movie: movie,listviewmodel: listViewModel)
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                    }//vstack
                }//zstack
                .navigationTitle("Top Rated Movies")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink(destination: UserProfileView(userID: userID )) {
                            HStack{
                                if vm.userDetails?.profileImageUrl != nil{
                                    WebImage(url : URL(string: vm.userDetails?.profileImageUrl ?? ""))
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                } else
                                {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                }
                                Text(vm.userDetails?.Fname ?? "Not Found")
                                    .font(.custom("bodyFont", size: 15)).bold()
                                
                            }
                        }
                   }
                }
                .environmentObject(listViewModel)
            }//nav view
            
            
            .tabItem{
                Label("Top Rated", systemImage: "star")
            }
            .tag(1)
            //end of top rated view
            .onAppear{
                listViewModel.fetchTopRatedMovies()
            }
            
            //nowplaying
            NavigationView{
                //list of movies
                ZStack{
                    VStack(){
                        ScrollView{
                            ForEach(listViewModel.nowplayingmovies, id: \.id) { movie in
                                //navigation to movie's details view
                                NavigationLink(destination: MovieDetailView(movie: movie,listViewModel: listViewModel))
                                {
                                    HStack{
                                        MoviesListRow(movie: movie,listviewmodel: listViewModel)
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                    }//vstack
                }//zstack
                .navigationTitle("Now Playing Movies")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink(destination: UserProfileView(userID: userID )) {
                            HStack{
                                if vm.userDetails?.profileImageUrl != nil{
                                    WebImage(url : URL(string: vm.userDetails?.profileImageUrl ?? ""))
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                } else
                                {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                }
                                Text(vm.userDetails?.Fname ?? "Not Found")
                                    .font(.custom("bodyFont", size: 15)).bold()
                                
                            }
                        }
                   }
                }
                .environmentObject(listViewModel)
            }//nav view
            .tabItem{
                Label("Now Playing", systemImage: "tv")
            }
            .tag(2)
            //end of now playing view
            .onAppear{
                listViewModel.fetchNowPlayingMovies()
            }
            
            
            NavigationView{
                //list of movies
                ZStack{
                    VStack(){
                        ScrollView{
                            ForEach(listViewModel.favorites, id: \.id) { movie in
                                //navigation to movie's details view
                                NavigationLink(destination: MovieDetailView(movie: movie,listViewModel: listViewModel))
                                {
                                    HStack{
                                        MoviesListRow(movie: movie,listviewmodel: listViewModel)
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                    }//vstack
                }//zstack
                .navigationTitle("Favorites Movies")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink(destination: UserProfileView(userID: userID )) {
                            HStack{
                                if vm.userDetails?.profileImageUrl != nil{
                                    WebImage(url : URL(string: vm.userDetails?.profileImageUrl ?? ""))
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                } else
                                {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                }
                                Text(vm.userDetails?.Fname ?? "Not Found")
                                    .font(.custom("bodyFont", size: 15)).bold()
                                
                            }
                        }
                   }
                }
                .environmentObject(listViewModel)
            }//nav view
            
            .tabItem{
                Label("Favorites", systemImage: "heart")
            }
            .tag(3)
            
            
        }//end of tabview
        .accentColor(.red)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


