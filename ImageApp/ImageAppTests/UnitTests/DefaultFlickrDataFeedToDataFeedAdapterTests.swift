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

    func testConvert_ValidExample() {

        let example = makeValidExample()

        let dataFeed = adapter.convert(flickrDataFeed: example.flickrDataFeed)

        XCTAssertEqual(dataFeed, example.expectedDataFeed)
    }

    func testConvert_InvalidExample_WrongLink() {

        let example = makeInvalidExample_WrongLink()

        let dataFeed = adapter.convert(flickrDataFeed: example.flickrDataFeed)

        XCTAssertEqual(dataFeed, example.expectedDataFeed)
    }

    func testConvert_InvalidExample_WrongDateTaken() {

        let example = makeInvalidExample_WrongDateTaken()

        let dataFeed = adapter.convert(flickrDataFeed: example.flickrDataFeed)

        XCTAssertEqual(dataFeed, example.expectedDataFeed)
    }

    func testConvert_InvalidExample_WrongPublished() {

        let example = makeInvalidExample_WrongPublished()

        let dataFeed = adapter.convert(flickrDataFeed: example.flickrDataFeed)

        XCTAssertEqual(dataFeed, example.expectedDataFeed)
    }

    func testConvert_InvalidExample_WrongImageURL() {

        let example = makeInvalidExample_WrongImageURL()

        let dataFeed = adapter.convert(flickrDataFeed: example.flickrDataFeed)

        XCTAssertEqual(dataFeed, example.expectedDataFeed)
    }
}

// MARK: - Helpers

extension DefaultFlickrDataFeedToDataFeedAdapterTests {

    private func makeValidExample() -> (flickrDataFeed: FlickrDataFeed, expectedDataFeed: DataFeed) {

        let flickrDataFeed = makeFlickrDataFeed()

        let expectedDataFeed = makeExpectedDataFeed(from: flickrDataFeed)

        return (flickrDataFeed, expectedDataFeed)
    }

    private func makeFlickrDataFeed() -> FlickrDataFeed {

        let dateTaken1String = ISO8601DateFormatter().string(from: Date())
        let publishedItem1String = ISO8601DateFormatter().string(from: Date().addingTimeInterval(2334))
        let item1 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 1 title")
            .withPublished(dateTaken1String)
            .withPublished(publishedItem1String)
            .withLink("https://www.flickr.com/link/1")
            .withMedia(
                FlickrDataFeed.Item.Media.Builder()
                    .withM("https://www.flickr.com/1")
                    .build()
            )
            .build()

        let dateTakenItem2String = ISO8601DateFormatter().string(from: Date().addingTimeInterval(573))
        let publishedItem2String = ISO8601DateFormatter().string(from: Date().addingTimeInterval(71324))
        let item2 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 2 title")
            .withDate_taken(dateTakenItem2String)
            .withPublished(publishedItem2String)
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

            guard let dateTaken = dateFormatter.date(from: $0.published),
                  let publishedDate = dateFormatter.date(from: $0.published),
                  let linkURL = URL(string: $0.link),
                  let imageURL = URL(string: $0.media.m) else {

                return nil
            }

            let item = DataFeed.Item.Builder()
                .withTitle($0.title)
                .withDateTaken(dateTaken)
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

    private func makeExpectedDataFeed_WithNoItems(from flickrDataFeed: FlickrDataFeed) -> DataFeed {

        let dataFeed = DataFeed.Builder()
            .withFeedTitle(flickrDataFeed.title)
            .withItems([])
            .build()

        return dataFeed
    }

    private func makeInvalidExample_WrongLink() -> (flickrDataFeed: FlickrDataFeed, expectedDataFeed: DataFeed) {

        let dateItem1String = ISO8601DateFormatter().string(from: Date())
        let item1 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 1 title")
            .withPublished(dateItem1String)
            .withLink("")
            .withMedia(
                FlickrDataFeed.Item.Media.Builder()
                    .withM("https://www.flickr.com/1")
                    .build()
            )
            .build()

        let flickrDataFeed = FlickrDataFeed.Builder()
            .withTitle("This is a title different")
            .withItems([item1])
            .build()

        let expectedDataFeed = makeExpectedDataFeed_WithNoItems(from: flickrDataFeed)
        return (flickrDataFeed, expectedDataFeed)
    }

    private func makeInvalidExample_WrongImageURL() -> (flickrDataFeed: FlickrDataFeed, expectedDataFeed: DataFeed) {

        let dateItem1String = ISO8601DateFormatter().string(from: Date())
        let item1 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 1 title")
            .withPublished(dateItem1String)
            .withLink("https://www.flickr.com/1")
            .withMedia(
                FlickrDataFeed.Item.Media.Builder()
                    .withM("")
                    .build()
            )
            .build()

        let flickrDataFeed = FlickrDataFeed.Builder()
            .withTitle("This is a ti")
            .withItems([item1])
            .build()

        let expectedDataFeed = makeExpectedDataFeed_WithNoItems(from: flickrDataFeed)
        return (flickrDataFeed, expectedDataFeed)
    }

    private func makeInvalidExample_WrongDateTaken() -> (flickrDataFeed: FlickrDataFeed, expectedDataFeed: DataFeed) {

        let item1 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 1 title")
            .withDate_taken("55")
            .withLink("https://www.flickr.com/1")
            .withMedia(
                FlickrDataFeed.Item.Media.Builder()
                    .withM("")
                    .build()
            )
            .build()

        let flickrDataFeed = FlickrDataFeed.Builder()
            .withTitle("This is a title 532")
            .withItems([item1])
            .build()

        let expectedDataFeed = makeExpectedDataFeed_WithNoItems(from: flickrDataFeed)
        return (flickrDataFeed, expectedDataFeed)

    }

    private func makeInvalidExample_WrongPublished() -> (flickrDataFeed: FlickrDataFeed, expectedDataFeed: DataFeed) {

        let item1 = FlickrDataFeed.Item.Builder()
            .withTitle("Item 1 title")
            .withPublished("55")
            .withLink("https://www.flickr.com/1")
            .withMedia(
                FlickrDataFeed.Item.Media.Builder()
                    .withM("")
                    .build()
            )
            .build()

        let flickrDataFeed = FlickrDataFeed.Builder()
            .withTitle("This is a title 532")
            .withItems([item1])
            .build()

        let expectedDataFeed = makeExpectedDataFeed_WithNoItems(from: flickrDataFeed)
        return (flickrDataFeed, expectedDataFeed)

    }

}
