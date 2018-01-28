//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

struct DataFeed {

    let feedTitle: String
    let items: [Item]

    struct Item {

        let title: String
        let dateTaken: Date
        let published: Date
        let link: URL
        let imageURL: URL
    }
}

// MARK: - Equatable Extensions

extension DataFeed: Equatable {

    static func ==(lhs: DataFeed, rhs: DataFeed) -> Bool {
        return lhs.feedTitle == rhs.feedTitle &&
        lhs.items == rhs.items
    }
}

extension DataFeed.Item: Equatable {

    static func ==(lhs: DataFeed.Item, rhs: DataFeed.Item) -> Bool {
        return lhs.title == rhs.title &&
            lhs.dateTaken == rhs.dateTaken &&
            lhs.published == rhs.published &&
            lhs.link == rhs.link &&
            lhs.imageURL == rhs.imageURL
    }
}

