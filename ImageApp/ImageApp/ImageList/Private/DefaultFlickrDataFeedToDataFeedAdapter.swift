//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

class DefaultFlickrDataFeedToDataFeedAdapter {
}

extension DefaultFlickrDataFeedToDataFeedAdapter: FlickrDataFeedToDataFeedAdapter {

    func convert(flickrDataFeed: FlickrDataFeed) -> DataFeed {

        let title = flickrDataFeed.title
        let items = makeDataFeedItems(from: flickrDataFeed)

        return DataFeed(feedTitle: title, items: items)
    }
}

// MARK: - Helpers

extension DefaultFlickrDataFeedToDataFeedAdapter {

    private func makeDataFeedItems(from flickrDataFeed: FlickrDataFeed) -> [DataFeed.Item] {

        return flickrDataFeed.items.flatMap {

            guard let published = makePublished(from: $0.published),
                  let link = makeURL(from: $0.link),
                  let imageURL = makeURL(from: $0.media.m) else {

                return nil
            }

            return DataFeed.Item(
                title: $0.title,
                published: published,
                link: link,
                imageURL: imageURL
            )
        }
    }

    private func makePublished(from dateString: String) -> Date? {

        let isoDateFormatter = ISO8601DateFormatter()

        return isoDateFormatter.date(from: dateString)
    }

    private func makeURL(from urlString: String) -> URL? {

        return URL(string: urlString)
    }
}
