//
//  PopularMoviesList.swift
//  AllMovies
//
//  Created by Prapti Oza on 4/9/23.
//

import SwiftUI


struct MoviesListRow : View {
    
    var movie: Movie
    @ObservedObject var listviewmodel = ListViewModel()
    var isFavorite: Bool{
        listviewmodel.favorites.contains(where: {$0.id == movie.id})
    }
    
    func toggleFavorite(){
        if isFavorite{
            listviewmodel.removeFavMovie(movie: movie)
        }
        else{
            listviewmodel.addFavMovie(movie: movie)
        }
        
    }
    
    var body: some View {
        HStack{
            if let posterPath = movie.posterPath{
                AsyncImage(url:URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath)")){
                    image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                        .frame(width:60, height:85)
                }.frame(width:60, height:85)
                    .cornerRadius(10)
                    .padding(.trailing)
            }else{
                Color.gray
                    .frame(width:60, height:85)
                    .cornerRadius(10)
                    .padding(.trailing)
            }
            VStack(alignment:.leading, spacing: 17){
                Text(movie.title)
                    .font(.custom("Georgia", fixedSize: 16)).foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                if let review = listviewmodel.reviews[movie.id]
                {
                    Text("Reviews: \(review.total_results)")
                        .font(.custom("Georgia", fixedSize: 14)).foregroundColor(.black)
                }	
                else {
                    Text("Reviews: 0").font(.custom("Georgia", fixedSize: 14)).foregroundColor(.black)
                }
                
            } .onAppear {
                // fetch movie reviews when view appears
                listviewmodel.fetchMovieReviews(movieID: movie.id)
                
            }
            Spacer()
            Button(action: toggleFavorite){
                Image(systemName: isFavorite ? "heart.fill" : "heart").foregroundColor(.red)
            }.padding()
            
        }//end of HStack
        .padding()
        
    }
    
}

struct MoviesListRow_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(id: 1, title: "Movie Title", overview: "Movie Overview", posterPath: nil, backdropPath: nil, releaseDate: nil, rating: 8.0, popularity: 9.0)
        
        MoviesListRow(movie: movie)
        
    }
}
