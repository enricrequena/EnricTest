//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

struct ImageListViewModel {

    let title: String
    let items: [Item]

    struct Item {

        let name: String
        let publishedAt: String
        let imageUrl: URL
    }
}

// MARK: - Equatable extension

extension ImageListViewModel: Equatable {

    static func ==(lhs: ImageListViewModel, rhs: ImageListViewModel) -> Bool {
        return lhs.title == rhs.title &&
        lhs.items == rhs.items
    }
}

extension ImageListViewModel.Item: Equatable {

    static func ==(lhs: ImageListViewModel.Item, rhs: ImageListViewModel.Item) -> Bool {
        return lhs.name == rhs.name &&
            lhs.publishedAt == rhs.publishedAt &&
            lhs.imageUrl == rhs.imageUrl
    }
}

