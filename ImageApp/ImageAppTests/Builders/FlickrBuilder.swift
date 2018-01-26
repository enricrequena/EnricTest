//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

extension FlickrDataFeed {

    struct Builder {

        var title: String = "title"
        var link: String = "link"
        var description: String = "description"
        var modified: String = "modified"
        var generator: String = "generator"
        var items: [Item] = []

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withLink(_ link: String) -> Builder {
            var builder = self
            builder.link = link
            return builder
        }

        func withDescription(_ description: String) -> Builder {
            var builder = self
            builder.description = description
            return builder
        }

        func withModified(_ modified: String) -> Builder {
            var builder = self
            builder.modified = modified
            return builder
        }

        func withGenerator(_ generator: String) -> Builder {
            var builder = self
            builder.generator = generator
            return builder
        }

        func withItems(_ items: [Item]) -> Builder {
            var builder = self
            builder.items = items
            return builder
        }

        func build() -> FlickrDataFeed {
            return FlickrDataFeed(
                title: self.title,
                link: self.link,
                description: self.description,
                modified: self.modified,
                generator: self.generator,
                items: self.items)
        }
    }
}

extension FlickrDataFeed.Item {

    struct Builder {

        var title: String = "title"
        var link: String = "https://www.flickr.com"
        var media: Media = FlickrDataFeed.Item.Media.Builder().build()
        var date_taken: String = "date_taken"
        var description: String = "description"
        var published: String = "published"
        var author: String = "author"
        var author_id: String = "author_id"

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withLink(_ link: String) -> Builder {
            var builder = self
            builder.link = link
            return builder
        }

        func withMedia(_ media: Media) -> Builder {
            var builder = self
            builder.media = media
            return builder
        }

        func withDate_taken(_ date_taken: String) -> Builder {
            var builder = self
            builder.date_taken = date_taken
            return builder
        }

        func withDescription(_ description: String) -> Builder {
            var builder = self
            builder.description = description
            return builder
        }

        func withPublished(_ published: String) -> Builder {
            var builder = self
            builder.published = published
            return builder
        }

        func withAuthor(_ author: String) -> Builder {
            var builder = self
            builder.author = author
            return builder
        }

        func withAuthor_id(_ author_id: String) -> Builder {
            var builder = self
            builder.author_id = author_id
            return builder
        }

        func build() -> FlickrDataFeed.Item {
            return FlickrDataFeed.Item(
                title: self.title,
                link: self.link,
                media: self.media,
                date_taken: self.date_taken,
                description: self.description,
                published: self.published,
                author: self.author,
                author_id: self.author_id)
        }

    }
}

extension FlickrDataFeed.Item.Media {

    struct Builder {

        var m: String = "https://www.flickr.com"

        func withM(_ m: String) -> Builder {
            var builder = self
            builder.m = m
            return builder
        }

        func build() -> FlickrDataFeed.Item.Media {
            return FlickrDataFeed.Item.Media(
                m: self.m)
        }
    }

}