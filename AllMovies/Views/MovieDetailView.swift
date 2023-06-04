//
//  MovieDetailView.swift
//  AllMovies
//
//  Created by Prapti Oza on 4/9/23.
//

import SwiftUI

import Foundation
import SwiftUI
import UIKit
import Firebase

struct MovieDetailView: View {
    var movie: Movie
    // let reviews: Review
    @ObservedObject var listViewModel = ListViewModel()
    var isFavorite: Bool{
        listViewModel.favorites.contains(where: {$0.id == movie.id})
    }
    
    func toggleFavorite(){
        if isFavorite{
            listViewModel.removeFavMovie(movie: movie)
        }
        else{
            listViewModel.addFavMovie(movie: movie)
        }
        
    }
    var body: some View {
        ZStack{
            ScrollView(.vertical,showsIndicators: false){
                Text(movie.title)
                    .font(.custom("Georgia", fixedSize: 25))
                    .bold()
                
                VStack(alignment: .trailing){
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        
                        HStack (spacing: 10){
                            carouselView(movie: movie.self)
                                .padding(.top)
                        }// End of HStack of Poster
                    }// End of Poster Scroll View
                }.padding()
                
                
                
                VStack(alignment: .leading, spacing: 30){
                    HStack{
                        if let releaseDate = movie.releaseDate{
                            Text("Released on: \(releaseDate)")
                                .font(.custom("Georgia", fixedSize: 18))
                        }
                        Spacer()
                        Button(action: toggleFavorite){
                            Image(systemName: isFavorite ? "heart.fill" : "heart").foregroundColor(.red)
                        }.padding()
                    }
                    
                    HStack{
                        Text("Rating:").font(.custom("Georgia", fixedSize: 13))
                        RatingView(rating: movie.rating)
                    }
                    
                    
                    if let popularity = movie.popularity{
                        let popularityInt = Int(popularity)
                        Text("Popularity: \(popularityInt)")
                            .font(.custom("Georgia", fixedSize: 18))
                    }
                    
                    Text(movie.overview)
                        .font(.custom("Georgia", fixedSize: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(nil)
                    
                    
                    if let review = listViewModel.reviews[movie.id]
                    {
                        HStack{
                            Text("Reviews: \(review.total_results)")
                                .bold() .font(.custom("Georgia", fixedSize: 22))
                            Spacer()
                            NavigationLink(
                                destination: PostReviewView(),
                                label: {
                                    Text("Write a review").foregroundColor(.red).underline()
                                })
                        }
                    }
                    else {
                        Text("Reviews: 0").bold() .font(.custom("Georgia", fixedSize: 22))
                    }

                    
                    Divider()
                    if let reviews = listViewModel.reviews[movie.id]
                    {
                        ForEach(reviews.results , id : \.id){review in
                            if let reviewauthor = review.author{
                                Text("Review by: ").bold().font(.custom("Georgia", fixedSize: 16))
                                Text("\(reviewauthor)").font(.custom("Georgia", fixedSize: 16))
                            }
                            else{
                                Text("Reviews: ").bold().font(.custom("Georgia", fixedSize: 16))
                                Text("None").font(.custom("Georgia", fixedSize: 16))
                            }

                            if let reviewcontent = review.content{
                                Text("Review: ").bold().font(.custom("Georgia", fixedSize: 16))
                                Text("\(reviewcontent)").font(.custom("Georgia", fixedSize: 16))
                                Divider()
                            }
                        }

                    }
                   
                }
                
            }.padding()
        }
    }
}



//view containing stars for ratings
struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack {
            ForEach(0..<10, id: \.self) { index in
                let stars = Double(index) + 1.0
                if stars <= rating {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else if stars - rating <= 0.5 {
                    Image(systemName: "star.leadinghalf.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}


struct carouselView: View{
    let movie: Movie
    var body: some View{
        if let posterpath = movie.posterPath{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w154\(posterpath)")){
                image in image.resizable()
                    .aspectRatio(contentMode: .fill)
            }
        placeholder: {
            Color.gray
                .frame(width:200, height: 250)
        }
        .frame(width: 200, height: 250)
        .cornerRadius(8)
        }
        
        if let backdroppath = movie.backdropPath{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w154\(backdroppath)")){
                image in image.resizable()
                    .aspectRatio(contentMode: .fill)
            }
        placeholder: {
            Color.gray
                .frame(width:200, height: 250)
        }
        .frame(width: 200, height: 250)
        .cornerRadius(8)
        }
        
        if let posterpath = movie.posterPath{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w154\(posterpath)")){
                image in image.resizable()
                    .aspectRatio(contentMode: .fill)
            }
        placeholder: {
            Color.gray
                .frame(width:200, height: 250)
        }
        .frame(width: 200, height: 250)
        .cornerRadius(8)
        }
        
        if let backdroppath = movie.backdropPath{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w154\(backdroppath)")){
                image in image.resizable()
                    .aspectRatio(contentMode: .fill)
            }
        placeholder: {
            Color.gray
                .frame(width:200, height: 250)
        }
        .frame(width: 200, height: 250)
        .cornerRadius(8)
        }
    }
}
