//
//  Photo.swift
//  WizTest
//
//  Created by Yael Bilu Eran on 14/12/2020.
//

import Foundation

class Photo {
    
     var id : Int?
     var pageURL : String?
     var type : String?
     var tags : String?
     var previewURL : String?
     var previewWidth : Int?
     var previewHeight : Int?
     var webformatURL : String?
     var webformatWidth : Int?
     var webformatHeight : Int?
     var largeImageURL : String?
     var fullHDURL : String?
     var imageURL : String?
     var imageWidth : Int?
     var imageHeight : Int?
     var imageSize : Int?
     var views : Int?
     var downloads : Int?
     var favorites : Int?
     var likes : Int?
     var comments : Int?
     var user_id : Int?
     var user : String?
     var userImageURL : String?
    
    init(with attributes: [String:Any]) {
        id = attributes["id"] as? Int
        pageURL = attributes["pageURL"] as? String
        type = attributes["type"] as? String
        tags = attributes["tags"] as? String
        previewURL = attributes["previewURL"] as? String
        previewWidth = attributes["previewWidth"] as? Int
        previewHeight = attributes["previewHeight"] as? Int
        webformatURL = attributes["webformatURL"] as? String
        webformatWidth = attributes["webformatWidth"] as? Int
        webformatHeight = attributes["webformatHeight"] as? Int
        largeImageURL = attributes["largeImageURL"] as? String
        fullHDURL = attributes["fullHDURL"] as? String
        imageURL = attributes["imageURL"] as? String
        imageWidth = attributes["imageWidth"] as? Int
        imageHeight = attributes["imageHeight"] as? Int
        imageSize = attributes["imageSize"] as? Int
        views = attributes["views"] as? Int
        downloads = attributes["downloads"] as? Int
        favorites = attributes["favorites"] as? Int
        likes = attributes["likes"] as? Int
        comments = attributes["comments"] as? Int
        user_id = attributes["user_id"] as? Int
        user = attributes["user"] as? String
        userImageURL = attributes["userImageURL"] as? String
    }
}
