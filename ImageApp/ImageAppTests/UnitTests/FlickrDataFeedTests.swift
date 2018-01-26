//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class FlickrDataFeedTests: XCTestCase {

    // MARK: - Equatability JSONFlickrFeed

    func testJSONFlickrFeed_Equal() {

        let a = FlickrDataFeed.Builder().build()
        let b = FlickrDataFeed.Builder().build()
        XCTAssertEqual(a, b)
    }

    func testJSONFlickrFeed_Different_title() {

        let a = FlickrDataFeed.Builder()
            .withTitle("a")
            .build()
        let b = FlickrDataFeed.Builder()
            .withTitle("b")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testJSONFlickrFeed_Different_link() {

        let a = FlickrDataFeed.Builder()
            .withLink("a")
            .build()
        let b = FlickrDataFeed.Builder()
            .withLink("b")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testJSONFlickrFeed_Different_description() {

        let a = FlickrDataFeed.Builder()
            .withDescription("a")
            .build()
        let b = FlickrDataFeed.Builder()
            .withDescription("b")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testJSONFlickrFeed_Different_modified() {

        let a = FlickrDataFeed.Builder()
            .withModified("a")
            .build()
        let b = FlickrDataFeed.Builder()
            .withModified("b")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testJSONFlickrFeed_Different_generator() {

        let a = FlickrDataFeed.Builder()
            .withGenerator("a")
            .build()
        let b = FlickrDataFeed.Builder()
            .withGenerator("b")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testJSONFlickrFeed_Different_items() {

        let a = FlickrDataFeed.Builder()
            .withItems([])
            .build()
        let item = FlickrDataFeed.Item.Builder().build()
        let b = FlickrDataFeed.Builder()
            .withItems([item])
            .build()
        XCTAssertNotEqual(a, b)
    }

    // MARK: - Equatability JSONFlickrFeed.Item && JSONFlickrFeed.Item.Media


    func testJSONFlickrFeedItem_Equal() {

        let a = FlickrDataFeed.Item.Builder().build()
        let b = FlickrDataFeed.Item.Builder().build()
        XCTAssertEqual(a, b)
    }

    func testJSONFlickrFeedItem_Different_title() {

        let a = FlickrDataFeed.Item.Builder()
            .withTitle("som")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withTitle("someth")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testJSONFlickrFeedItem_Different_link() {

        let a = FlickrDataFeed.Item.Builder()
            .withLink("91")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withLink("931")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testJSONFlickrFeedItem_Different_media() {

        let media1 = FlickrDataFeed.Item.Media.Builder()
            .withM("a")
            .build()
        let a = FlickrDataFeed.Item.Builder()
            .withMedia(media1)
            .build()
        let media2 = FlickrDataFeed.Item.Media.Builder()
            .withM("42")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withMedia(media2)
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testJSONFlickrFeedItem_Different_date_taken() {

        let a = FlickrDataFeed.Item.Builder()
            .withDate_taken("481asd")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withDate_taken("481")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testJSONFlickrFeedItem_Different_description() {

        let a = FlickrDataFeed.Item.Builder()
            .withDescription("23sdf ")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withDescription("23sdf ASDF ")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testJSONFlickrFeedItem_Different_published() {

        let a = FlickrDataFeed.Item.Builder()
            .withPublished("asdf")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withPublished("asd 3412f")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testJSONFlickrFeedItem_Different_author() {

        let a = FlickrDataFeed.Item.Builder()
            .withAuthor("o83 ")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withAuthor("o83DASD  ")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testJSONFlickrFeedItem_Different_author_id() {

        let a = FlickrDataFeed.Item.Builder()
            .withAuthor_id("41234")
            .build()
        let b = FlickrDataFeed.Item.Builder()
            .withAuthor_id("412332 4")
            .build()
        XCTAssertNotEqual(a, b)
    }
}
