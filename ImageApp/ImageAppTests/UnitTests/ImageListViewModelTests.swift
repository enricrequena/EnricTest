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

    func testImageListViewModelItem_Different_DateInfo() {

        let a = ImageListViewModel.Item.Builder()
            .withDateInfo("2oij")
            .build()
        let b = ImageListViewModel.Item.Builder()
            .withDateInfo("2oasdfij")
            .build()
        XCTAssertNotEqual(a, b)
    }

    // MARK: - Equatable EditTagsViewModel

    func testEditTagsViewModel_Equal() {

        let a = EditTagsViewModel.Builder().build()
        let b = EditTagsViewModel.Builder().build()
        XCTAssertEqual(a, b)
    }

    func testEditTagsViewModel_DifferentTitle() {

        let a = EditTagsViewModel.Builder()
            .withTitle("dks")
            .build()
        let b = EditTagsViewModel.Builder()
            .withTitle("ds")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testEditTagsViewModel_DifferentMessage() {

        let a = EditTagsViewModel.Builder()
            .withMessage("a")
            .build()
        let b = EditTagsViewModel.Builder()
            .withMessage("b")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testEditTagsViewModel_DifferentPlaceholderTextField() {

        let a = EditTagsViewModel.Builder()
            .withTextFieldPlaceHolder("a")
            .build()
        let b = EditTagsViewModel.Builder()
            .withTextFieldPlaceHolder("b")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testEditTagsViewModel_DifferentButtonTitle() {

        let a = EditTagsViewModel.Builder()
            .withButtonTitle("a")
            .build()
        let b = EditTagsViewModel.Builder()
            .withButtonTitle("b")
            .build()
        XCTAssertNotEqual(a, b)
    }
    func testEditTagsViewModel_DifferentCancelButtonTitle() {

        let a = EditTagsViewModel.Builder()
            .withCancelButtonTitle("52")
            .build()
        let b = EditTagsViewModel.Builder()
            .withCancelButtonTitle("52a")
            .build()
        XCTAssertNotEqual(a, b)
    }
}
