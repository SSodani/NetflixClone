//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-28.
//

import Foundation



struct YoutybeSearchResponse: Codable {
    let items:[VideoElement]
}

struct VideoElement:Codable {
    let id: IdVideoElement
}

struct IdVideoElement:Codable {
    let kind: String
    let videoId: String
}
