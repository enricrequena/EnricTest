//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultFlickrDataFeedToDataFeedAdapterTests: XCTestCase {

    var adapter: DefaultFlickrDataFeedToDataFeedAdapter!

    override func setUp() {

        super.setUp()
        adapter = DefaultFlickrDataFeedToDataFeedAdapter()
    }

    override func tearDown() {

        adapter = nil
        super.tearDown()
    }

    // MARK: - FlickrDataFeedToDataFeedAdapter

    func testConvert() {

        let example = makeExample()

        let dataFeed = adapter.convert(flickrDataFeed: example.flickrDataFeed)

        XCTAssertEqual(dataFeed, example.expectedDataFeed)
    }
}

// MARK: - Helpers

extension DefaultFlickrDataFeedToDataFeedAdapterTests {

    private func makeExample() -> (flickrDataFeed: FlickrDataFeed, expectedDataFeed: DataFeed) {

        let flickrDataFeed = makeFlickrDataFeed()

        let expectedDataFeed = makeExpectedDataFeed(from: flickrDataFeed)

        return (flickrDataFeed, expectedDataFeed)
    }

    private func makeFlickrDataFeed() -> FlickrDataFeed {

        let dateItem1String = ISO8601DateFormatter().string(from: Date())
        let item1 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 1 title")
            .withPublished(dateItem1String)
            .withLink("https://www.flickr.com/link/1")
            .withMedia(
                FlickrDataFeed.Item.Media.Builder()
                    .withM("https://www.flickr.com/1")
                    .build()
            )
            .build()

        let dateItem2String = ISO8601DateFormatter().string(from: Date().addingTimeInterval(1324))
        let item2 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 2 title")
            .withPublished(dateItem2String)
            .withLink("https://www.flickr.com/link/1")
            .withMedia(
                FlickrDataFeed.Item.Media.Builder()
                    .withM("https://www.flickr.com/2")
                    .build()
            )
            .build()

        let flickrDataFeed = FlickrDataFeed.Builder()
            .withTitle("This is a title")
            .withItems([item1, item2])
            .build()

        return flickrDataFeed
    }

    private func makeExpectedDataFeed(from flickrDataFeed: FlickrDataFeed) -> DataFeed {

        let dateFormatter = ISO8601DateFormatter()

        let items: [DataFeed.Item] = flickrDataFeed.items.flatMap {

            guard let publishedDate = dateFormatter.date(from: $0.published),
                  let linkURL = URL(string: $0.link),
                  let imageURL = URL(string: $0.media.m) else {

                return nil
            }

            let item = DataFeed.Item.Builder()
                .withTitle($0.title)
                .withPublished(publishedDate)
                .withImageURL(imageURL)
                .withLink(linkURL)
                .build()

            return item
        }

        let dataFeed = DataFeed.Builder()
            .withFeedTitle(flickrDataFeed.title)
            .withItems(items)
            .build()

        return dataFeed
    }
}
