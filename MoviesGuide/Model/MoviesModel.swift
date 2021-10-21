//
//  MoviesModel.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 17/10/2021.
//

import Foundation

public struct MoviesModel: Codable {
    public var dates: Dates?
    public var page: Int?
    public var results: [Movies]?
    public var totalPages: Int?
    public var totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates = "dates"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    public init(dates: Dates?,
                page: Int?,
                results: [Movies]?,
                totalPages: Int?,
                totalResults: Int?) {
        self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: - Dates
public struct Dates: Codable {
    public var maximum: String?
    public var minimum: String?

    enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }

    public init(maximum: String?,
                minimum: String?) {
        self.maximum = maximum
        self.minimum = minimum
    }
}

// MARK: - Result
public struct Movies: Codable {
    public var adult: Bool?
    public var backdropPath: String?
    public var genreIDS: [Int]?
    public var id: Int?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var releaseDate: String?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    public init(adult: Bool?,
                backdropPath: String?,
                genreIDS: [Int]?,
                id: Int?,
                originalLanguage: String?,
                originalTitle: String?,
                overview: String?,
                popularity: Double?,
                posterPath: String?,
                releaseDate: String?,
                title: String?,
                video: Bool?,
                voteAverage: Double?,
                voteCount: Int?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
