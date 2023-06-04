//
//  ListViewModel.swift
//  AllMovies
//
//  Created by Prapti Oza on 4/9/23.
//

import Foundation
import SwiftUI

class ListViewModel : ObservableObject{
    //using property wrappers to automatically notify other views of nay changes
    @Published var popularmovies = [Movie]()
    @Published var topratedmovies = [Movie]()
    @Published var nowplayingmovies = [Movie]()
    @Published var reviews : [Int : Review] = [:]
    @Published var favorites: [Movie] = []
    
    
    init(){
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchNowPlayingMovies()
        
    }
    
    func fetchPopularMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4cc907f17d6cd1052288d9d4c2a150f9&language=en-US&page=1")else{
            fatalError("Invalid URL")
        }
        //to get popular movies using request and using JSONDecoder to decode the data
        URLSession.shared.dataTask(with:url) { data,response,error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            //getting the data into an array
            if let data = data{
                print("Data: \(data)")
                do{
                    let movieList = try JSONDecoder().decode(MovieList.self, from:data)
                    print("Decoded movie list: \(movieList)")
                    DispatchQueue.main.async{
                        self.popularmovies = movieList.results
                        
                        //review count for each movie
                        for movie in movieList.results{
                            self.fetchMovieReviews(movieID: movie.id)
                        }
                        
                    }
                }
                catch{
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    } //end of fetchPopularMovies
    
    //fetching top rated movies
    func fetchTopRatedMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=4cc907f17d6cd1052288d9d4c2a150f9&language=en-US&page=1")else{
            fatalError("Invalid URL")
        }
        //to get popular movies using request and using JSONDecoder to decode the data
        URLSession.shared.dataTask(with:url) { data,response,error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            //getting the data into an array
            if let data = data{
                print("Data: \(data)")
                do{
                    let movieList = try JSONDecoder().decode(MovieList.self, from:data)
                    print("Decoded movie list: \(movieList)")
                    DispatchQueue.main.async{
                        self.topratedmovies = movieList.results
                        
                        //review count for each movie
                        for movie in movieList.results{
                            self.fetchMovieReviews(movieID: movie.id)
                        }
                        
                    }
                }
                catch{
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }// end of top rated movies
    
    //fetching nowplaying movies
    func fetchNowPlayingMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=4cc907f17d6cd1052288d9d4c2a150f9&language=en-US&page=1")else{
            fatalError("Invalid URL")
        }
        //to get popular movies using request and using JSONDecoder to decode the data
        URLSession.shared.dataTask(with:url) { data,response,error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            //getting the data into an array
            if let data = data{
                print("Data: \(data)")
                do{
                    let movieList = try JSONDecoder().decode(MovieList.self, from:data)
                    print("Decoded movie list: \(movieList)")
                    DispatchQueue.main.async{
                        self.nowplayingmovies = movieList.results
                        
                        //review count for each movie
                        for movie in movieList.results{
                            self.fetchMovieReviews(movieID: movie.id)
                        }
                    }
                }
                catch{
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }//end of nowplaying movies
    
    
    func fetchMovieReviews(movieID : Int){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=4cc907f17d6cd1052288d9d4c2a150f9&language=en-US&total_results")else{
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with:url) {data, response, error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            if let data = data{
                do{
                    let moviereviews = try JSONDecoder().decode(Review.self, from:data)
                    print("Decoded reviews : \(moviereviews)")
                    DispatchQueue.main.async {
                        self.reviews[movieID] = moviereviews
                    }
                } catch{
                    print("Data Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    //function to add movies to favorites
    
    func addFavMovie(movie: Movie){
        if !favorites.contains(where: {$0.id == movie.id}){
            favorites.append(movie)
        }
        
    }
    
    func removeFavMovie(movie: Movie){
        if let index = favorites.firstIndex(where: {$0.id == movie.id}){
            favorites.remove(at: index)
        }
    }
    
}
