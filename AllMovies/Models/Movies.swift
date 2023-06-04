//
//  Movies.swift
//  AllMovies
//
//  Created by Prapti Oza on 4/9/23.
//

import Foundation
import SwiftUI

//structure containing all the required data in the app
struct Movie: Decodable, Identifiable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?
    var rating: Double
    var popularity: Double?
    
    enum CodingKeys: String, CodingKey{
        case id, title, overview, popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
        
    }
    
}

//making an array of all the movies from Movie struct
struct MovieList: Decodable{
    var results: [Movie]
}

struct Review : Decodable{
    let total_results: Int
    let results : [ReviewDetails]
}


struct ReviewDetails : Decodable,Identifiable{
    let id : String?
    let author: String?
    let content : String?
}



