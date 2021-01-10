//
//  Constants.swift
//  MarveleduardofulgencioApi
//
//  Created by eduardo fulgencio on 08/01/2021.
//  Copyright © 2021 Eduardo Fulgencio. All rights reserved.
//


let URL_BASE = "https://gateway.marvel.com:443/v1/public/"

enum Constants: String {
    case publicKey = "46996a2c4fafc17be9ee1914774decd5"
}

enum ApiCharacter: String {
    case urlList = "%@characters?ts=1&apikey=%@&hash=2e6171c282cbca87032d394cf4c64f90"
    case urlDetall = "%@characters/%@?ts=1&apikey=%@&hash=2e6171c282cbca87032d394cf4c64f90"
}

// Path json

enum PathJson: String {
   case dataResult = "data.result"
   case thumbnailPath = "thumbnail.path"
   case characterId = "id"
   case characterName = "name"
}
