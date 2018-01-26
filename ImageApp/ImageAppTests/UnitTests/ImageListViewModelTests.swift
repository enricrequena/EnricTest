//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class ImageListViewModelTests: XCTestCase {

    // MARK: - Equatable ImageListViewModel

    func testImageListViewModel_Equal() {

        let a = ImageListViewModel.Builder().build()
        let b = ImageListViewModel.Builder().build()
        XCTAssertEqual(a, b)
    }

    func testImageListViewModel_Different_title() {

        let a = ImageListViewModel.Builder()
            .withTitle("aoisdf")
            .build()
        let b = ImageListViewModel.Builder()
            .withTitle("ao44isdf")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testImageListViewModel_Different_item() {

        let a = ImageListViewModel.Builder()
            .withItems([])
            .build()
        let item = ImageListViewModel.Item.Builder().build()
        let b = ImageListViewModel.Builder()
            .withItems([item])
            .build()
        XCTAssertNotEqual(a, b)
    }

    // MARK: - Equatable ImageListViewModel.Item

    func testImageListViewModelItem_Different_Name() {

        let a = ImageListViewModel.Item.Builder()
            .withName("asdfas")
            .build()
        let b = ImageListViewModel.Item.Builder()
            .withName("asa2dfas")
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testImageListViewModelItem_Different_ImageURL() {

        let a = ImageListViewModel.Item.Builder()
            .withImageUrl(URL(string: "http://www.flickr.com/a")!)
            .build()
        let b = ImageListViewModel.Item.Builder()
            .withImageUrl(URL(string: "http://www.flickr.com/b")!)
            .build()
        XCTAssertNotEqual(a, b)
    }

    func testImageListViewModelItem_Different_PublishedAt() {

        let a = ImageListViewModel.Item.Builder()
            .withPublishedAt("2oij")
            .build()
        let b = ImageListViewModel.Item.Builder()
            .withPublishedAt("2oasdfij")
            .build()
        XCTAssertNotEqual(a, b)
    }
}
