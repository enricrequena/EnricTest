//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DataFeedTests: XCTestCase {

    // MARK: - DataFeed

    func testDataFeed_Equal() {

        let a = DataFeed.Builder().build()
        let b = DataFeed.Builder().build()
        XCTAssertEqual(a, b)
    }

    func testDataFeed_Different_FeedTitle() {

        let a = DataFeed.Builder()
            .withFeedTitle("di")
            .build()
        let b = DataFeed.Builder()
            .withFeedTitle("diasdf")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testDataFeed_Different_Items() {

        let a = DataFeed.Builder()
            .withItems([])
            .build()
        let item = DataFeed.Item.Builder().build()
        let b = DataFeed.Builder()
            .withItems([item])
            .build()
        XCTAssertNotEqual(a, b)
    }

    // MARK: - DataFeed.Item

    func testDataFeedItem_Equal() {

        let a = DataFeed.Item.Builder().build()
        let b = DataFeed.Item.Builder().build()
        XCTAssertEqual(a, b)
    }

    func testDataFeedItem_Different_Title() {

        let a = DataFeed.Item.Builder()
            .withTitle("daf")
            .build()
        let b = DataFeed.Item.Builder()
            .withTitle("523daf")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testDataFeedItem_Different_DateTaken() {

        let a = DataFeed.Item.Builder()
            .withDateTaken(Date())
            .build()
        let b = DataFeed.Item.Builder()
            .withDateTaken(Date().addingTimeInterval(8001))
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testDataFeedItem_Different_Published() {

        let a = DataFeed.Item.Builder()
            .withPublished(Date())
            .build()
        let b = DataFeed.Item.Builder()
            .withPublished(Date().addingTimeInterval(8001))
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testDataFeedItem_Different_Link() {

        let a = DataFeed.Item.Builder()
            .withLink(URL(string: "https://www.flickr.com/1")!)
            .build()
        let b = DataFeed.Item.Builder()
            .withLink(URL(string: "https://www.flickr.com/2")!)
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testDataFeedItem_Different_ImageURL() {

        let a = DataFeed.Item.Builder()
            .withImageURL(URL(string: "https://www.flickr.com/1")!)
            .build()
        let b = DataFeed.Item.Builder()
            .withImageURL(URL(string: "https://www.flickr.com/2")!)
            .build()
        XCTAssertNotEqual(a, b)
    }
}
