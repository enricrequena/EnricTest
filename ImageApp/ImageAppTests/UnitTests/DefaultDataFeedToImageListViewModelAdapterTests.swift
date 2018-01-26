//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultDataFeedToImageListViewModelAdapterTests: XCTestCase {

    var adapter: DefaultDataFeedToImageListViewModelAdapter!

    override func setUp() {

        super.setUp()
        adapter = DefaultDataFeedToImageListViewModelAdapter()
    }

    override func tearDown() {

        adapter = nil
        super.tearDown()
    }

    // MARK: - DataFeedToImageListViewModelAdapter

    func testConvertDataFeed() {

        let example = makeExample()

        let imageListViewModel = adapter.convert(dataFeed: example.dataFeed)

        XCTAssertEqual(imageListViewModel, example.expectedImageListViewModel)
    }

	func testConvertError_NetworkError() {

		let error = NetworkError.failedToLoadData(message: "something")

		let errorMessage = adapter.convert(error: error)

		XCTAssertEqual(errorMessage, "\(Strings.Error.errorOcurred):\nsomething")
	}

	func testConvertError_GeneralMessage() {

		let error = GeneralError()

		let errorMessage = adapter.convert(error: error)

		XCTAssertEqual(errorMessage, (Strings.Error.generalError))
	}
}

// MARK: - Helpers

extension DefaultDataFeedToImageListViewModelAdapterTests {

    private func makeExample() -> (dataFeed: DataFeed, expectedImageListViewModel: ImageListViewModel) {

        let dataFeed = makeDataFeed()

        let expectedImageListViewModel = makeExpectedImageListViewModel(from: dataFeed)

        return (dataFeed, expectedImageListViewModel)
    }

    private func makeDataFeed() -> DataFeed {

        let feedTitle = "This is a title"

        let item1Title = "First item title"
        let item1Published = ISO8601DateFormatter().date(from: "2018-01-25T6:27:33-08:00")!
        let item1ImageUrl = URL(string: "https://www.flickr.com/1")!
        let item1 = DataFeed.Item.Builder()
            .withTitle(item1Title)
            .withPublished(item1Published)
            .withImageURL(item1ImageUrl)
            .build()

        let item2Title = "Second item title"
        let item2Published = ISO8601DateFormatter().date(from: "2018-01-25T6:27:33-08:00")!
        let item2ImageUrl = URL(string: "https://www.flickr.com/2")!
        let item2 = DataFeed.Item.Builder()
            .withTitle(item2Title)
            .withPublished(item2Published)
            .withImageURL(item2ImageUrl)
            .build()

        let dataFeed = DataFeed.Builder()
            .withFeedTitle(feedTitle)
            .withItems([item1, item2])
            .build()

        return dataFeed
    }

    private func makeExpectedImageListViewModel(from dataFeed: DataFeed) -> ImageListViewModel {

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withFullDate

        let items: [ImageListViewModel.Item] = dataFeed.items.flatMap {

            let publishedAt = dateFormatter.string(from: $0.published)

            let item = ImageListViewModel.Item.Builder()
                .withName($0.title)
                .withPublishedAt(publishedAt)
                .withImageUrl($0.imageURL)
                .build()

            return item
        }

        let imageListViewModel = ImageListViewModel.Builder()
            .withTitle(dataFeed.feedTitle)
            .withItems(items)
            .build()

        return imageListViewModel
    }
}

private struct GeneralError: Error {

}
