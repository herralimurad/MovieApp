//
//  SampleData.swift
//  MovieAppTests
//
//  Created by Ali Murad on 21/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation

class SampleData {
    class func movieDetails() -> [String : Any]? {
        let jsonString = """
 {"adult":false,"backdrop_path":"/w2PMyoyLU22YvrGK3smVM9fW1jj.jpg","belongs_to_collection":null,"budget":152000000,"genres":[{"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":878,"name":"Science Fiction"}],"homepage":"https://www.marvel.com/movies/captain-marvel","id":299537,"imdb_id":"tt4154664","original_language":"en","original_title":"Captain Marvel","overview":"The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races. Set in the 1990s, Captain Marvel is an all-new adventure from a previously unseen period in the history of the Marvel Cinematic Universe.","popularity":243.105,"poster_path":"/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg","production_companies":[{"id":420,"logo_path":"/hUzeosd33nzE5MCNsZxCGEKTXaQ.png","name":"Marvel Studios","origin_country":"US"}],"production_countries":[{"iso_3166_1":"US","name":"United States of America"}],"release_date":"2019-03-06","revenue":1037980262,"runtime":124,"spoken_languages":[{"iso_639_1":"en","name":"English"}],"status":"Released","tagline":"Higher. Further. Faster.","title":"Captain Marvel","video":false,"vote_average":7.2,"vote_count":3939}
"""
        
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
        
    }
    
    
    
    class func movieList() -> [String : Any]? {
        let jsonString = """
        {"page":1,"total_results":19786,"total_pages":990,"results":[{"vote_count":164,"id":456740,"video":false,"vote_average":5.2,"title":"Hellboy","popularity":373.147,"poster_path":"","original_language":"en","original_title":"Hellboy","genre_ids":[28,12,14],"backdrop_path":"","adult":false,"overview":"Hellboy comes to England, where he must defeat Nimue, Merlin's consort and the Blood Queen. But their battle will bring about the end of the world, a fate he desperately tries to turn away.","release_date":"2019-04-10"},{"vote_count":1041,"id":287947,"video":false,"vote_average":7.3,"title":"Shazam!","popularity":325.111,"poster_path":"","original_language":"en","original_title":"Shazam!","genre_ids":[35,12,14],"backdrop_path":"","adult":false,"overview":"A boy is given the ability to become an adult superhero in times of need with a single magic word.","release_date":"2019-03-23"},{"vote_count":348,"id":537915,"video":false,"vote_average":6.5,"title":"After","popularity":299.895,"poster_path":"","original_language":"en","original_title":"After","genre_ids":[18,10749],"backdrop_path":"","adult":false,"overview":"A young woman falls for a guy with a dark secret and the two embark on a rocky relationship.","release_date":"2019-04-11"}]}

"""
        
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
        
    }
    
    
    
    
}
