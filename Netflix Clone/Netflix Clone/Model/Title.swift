//
//  Movie.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-17.
//

import Foundation

struct TrendingTitleResponse:Codable {
    let results : [Title]
}

struct Title : Codable {
    let id : Int
    let media_type:String?
    let original_name:String?
    let original_language:String?
    let original_title:String?
    let poster_path:String?
    let overview:String?
    let vote_count:Int
    let release_date:String?
    let vote_average:Double
}


/*
 adult = 0;
 "backdrop_path" = "/aTovumsNlDjof7YVoU5nW2RHaYn.jpg";
 "genre_ids" =             (
     27,
     53
 );
 id = 616820;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = "Halloween Ends";
 overview = "Four years after the events of Halloween in 2018, Laurie has decided to liberate herself from fear and rage and embrace life. But when a young man is accused of killing a boy he was babysitting, it ignites a cascade of violence and terror that will force Laurie to finally confront the evil she can\U2019t control, once and for all.";
 popularity = "2776.437";
 "poster_path" = "/3uDwqxbr0j34rJVJMOW6o8Upw5W.jpg";
 "release_date" = "2022-10-12";
 title = "Halloween Ends";
 video = 0;
 "vote_average" = "7.04";
 "vote_count" = 329;
 */
