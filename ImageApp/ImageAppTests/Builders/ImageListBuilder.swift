//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp
import Foundation

// MARK: - ImageListViewModel

extension ImageListViewModel {

    struct Builder {

        var title: String = "title"
        var items: [Item] = []

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withItems(_ items: [Item]) -> Builder {
            var builder = self
            builder.items = items
            return builder
        }

        func build() -> ImageListViewModel {

            return ImageListViewModel(
                title: self.title,
                items: self.items
            )
        }
    }
}

extension ImageListViewModel.Item {

    struct Builder {
        var name: String = "name"
        var publishedAt: String = "publishedAt"
        var imageUrl: URL = URL(string: "https://www.flickr.com")!

        func withName(_ name: String) -> Builder {
            var builder = self
            builder.name = name
            return builder
        }

        func withPublishedAt(_ publishedAt: String) -> Builder {
            var builder = self
            builder.publishedAt = publishedAt
            return builder
        }

        func withImageUrl(_ imageUrl: URL) -> Builder {
            var builder = self
            builder.imageUrl = imageUrl
            return builder
        }

        func build() -> ImageListViewModel.Item {
            return ImageListViewModel.Item(
                name: self.name,
                publishedAt: self.publishedAt,
                imageUrl: self.imageUrl)
        }
    }
}

// MARK: - DataFeed

extension DataFeed {

    struct Builder {
        var feedTitle: String = "feedTitle"
        var items: [Item] = []

        func withFeedTitle(_ feedTitle: String) -> Builder {
            var builder = self
            builder.feedTitle = feedTitle
            return builder
        }

        func withItems(_ items: [Item]) -> Builder {
            var builder = self
            builder.items = items
            return builder
        }

        func build() -> DataFeed {
            return DataFeed(
                feedTitle: self.feedTitle,
                items: self.items)
        }
    }
}

extension DataFeed.Item {

    struct Builder {

        var title: String = "title"
        var published: Date = ISO8601DateFormatter().date(from: "2018-01-24T19:27:33-08:00")!
        var link: URL = URL(string: "https://www.flickr.com/223")!
        var imageURL: URL = URL(string: "https://www.flickr.com/4234")!

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withPublished(_ published: Date) -> Builder {
            var builder = self
            builder.published = published
            return builder
        }

        func withLink(_ link: URL) -> Builder {
            var builder = self
            builder.link = link
            return builder
        }

        func withImageURL(_ imageURL: URL) -> Builder {
            var builder = self
            builder.imageURL = imageURL
            return builder
        }

        func build() -> DataFeed.Item {
            return DataFeed.Item(
                title: self.title,
                published: self.published,
                link: self.link,
                imageURL: self.imageURL)
        }
    }
}