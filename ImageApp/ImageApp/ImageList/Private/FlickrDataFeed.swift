//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

struct FlickrDataFeed: Codable {

    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [Item]

    struct Item: Codable {

        let title: String
        let link: String
        let media: Media
        let date_taken: String
        let description: String
        let published: String
        let author: String
        let author_id: String

        struct Media: Codable {

            let m: String
        }
    }
}

// MARK: - Equatable extensions

extension FlickrDataFeed: Equatable {

    static func ==(lhs: FlickrDataFeed, rhs: FlickrDataFeed) -> Bool {
        return lhs.title == rhs.title &&
            lhs.link == rhs.link &&
            lhs.description == rhs.description &&
            lhs.modified == rhs.modified &&
            lhs.generator == rhs.generator &&
            lhs.items == rhs.items
    }
}

extension FlickrDataFeed.Item: Equatable {

    static func ==(lhs: FlickrDataFeed.Item, rhs: FlickrDataFeed.Item) -> Bool {
        return lhs.title == rhs.title &&
        lhs.link == rhs.link &&
        lhs.media == rhs.media &&
        lhs.date_taken == rhs.date_taken &&
        lhs.description == rhs.description &&
        lhs.published == rhs.published &&
        lhs.author == rhs.author &&
        lhs.author_id == rhs.author_id
    }
}

extension FlickrDataFeed.Item.Media: Equatable {

    static func ==(lhs: FlickrDataFeed.Item.Media, rhs: FlickrDataFeed.Item.Media) -> Bool {
        return lhs.m == rhs.m
    }
}