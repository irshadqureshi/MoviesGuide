//
//  Constant.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 16/10/2021.
//

import Foundation
import CoreGraphics

class Constants: NSObject {
    
    struct WebService{
        static let accessKey                    =  "api_key=d247e7402a0c2256a15a48ff0dcc968f"
        static let baseUrl                      =  "https://api.themoviedb.org/3"
        static let popularAPI                   =  "/discover/movie"
        static let topRatedAPI                  =  "/movie/top_rated"
        static let upcomingAPI                  =  "/movie/upcoming"
        
        
        private static let imageUrl             = "https://image.tmdb.org/t/p"
        private static let small                = "/w200"
        private static let large                = "/w400"

        static var largeImage: String {
            return imageUrl + large
        }
    }
    
    struct QueryParameter{
        static let page                         =  "page=1"
    }
    
    struct CellIdentifiers{
        static let dashboardCell                =  "DashboardCell"
    }
    
    struct OffsetSpeed{
        static let yOffsetSpeed: CGFloat        = 150.0
        static let xOffsetSpeed: CGFloat        = 100.0
    }
    
    struct HexCode{
        static let navBarColor                  =  "00A0C3"
    }
    
    struct ScreenTitles{
        static let dashboardDropDownList        =  ["Popular", "Top Rated", "Upcoming"]
    }
    
    struct Font{
        static let fontType                     =  "Avenir-Heavy"
    }

    struct ErrorResponse{
        static let message                      =  "Something went wrong"
    }
    
    struct MovieRating{
        static let text                         =  "Rating -"
    }
    
    struct ImageName{
        static let placeholder                  =  "placeholder.png"
    }
}




