//
//  Track.swift
//  Rock Tracks
//
//  Created by shikha  on 09/03/18.
//  Copyright © 2018 shikha . All rights reserved
//

import Foundation

class Track {
    var trackName: String!
    var artworkUrl100: String!
    var trackPrice: NSNumber!
    var artistName: String!
    var releaseDate: String!
    var trackViewUrl: String!

    init(_ parameters: Dictionary<String, Any>) {
        
        trackName = parameters["trackName"] as! String
        trackPrice = parameters["trackPrice"] as! NSNumber
        artistName = parameters["artistName"] as! String
        artworkUrl100 =  parameters["artworkUrl100"] as! String
        releaseDate =  parameters["releaseDate"] as! String
        trackViewUrl =  parameters["trackViewUrl"] as! String

    }
}



