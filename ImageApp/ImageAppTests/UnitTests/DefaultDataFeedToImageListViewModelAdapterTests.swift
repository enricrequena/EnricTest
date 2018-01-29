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

		let sortType = SortByType.datePublished
        var itemActionExecutedWithItem: ImageListViewModel.Item? = nil
        let itemAction: (ImageListViewModel.Item) -> Void = {
            item in
            itemActionExecutedWithItem = item
        }

		let example = makeExample(sortType: sortType)

		let imageListViewModel = adapter.convert(dataFeed: example.dataFeed, sortedBy: sortType, itemAction: itemAction)

        XCTAssertEqual(imageListViewModel, example.expectedImageListViewModel)

        imageListViewModel.items.forEach {
            item in

            item.itemAction?(item)
            XCTAssertEqual(item, itemActionExecutedWithItem)
        }
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

    private func makeExample(sortType: SortByType) -> (dataFeed: DataFeed, expectedImageListViewModel: ImageListViewModel) {

        let dataFeed = makeDataFeed()

        let expectedImageListViewModel = makeExpectedImageListViewModel(from: dataFeed, sortType: sortType)

        return (dataFeed, expectedImageListViewModel)
    }

    private func makeDataFeed() -> DataFeed {

        let feedTitle = "This is a title"

        let item1Title = "First item title"
        let item1DateTaken = ISO8601DateFormatter().date(from: "2018-01-25T6:27:33-08:00")!
        let item1Published = ISO8601DateFormatter().date(from: "2018-01-25T6:27:33-15:00")!
        let item1ImageUrl = URL(string: "https://www.flickr.com/1")!
        let item1 = DataFeed.Item.Builder()
            .withTitle(item1Title)
            .withDateTaken(item1DateTaken)
            .withPublished(item1Published)
            .withImageURL(item1ImageUrl)
            .build()

        let item2Title = "Second item title"
        let item2DateTaken = ISO8601DateFormatter().date(from: "2018-01-24T6:27:33-08:00")!
        let item2Published = ISO8601DateFormatter().date(from: "2018-01-24T6:27:33-15:00")!
        let item2ImageUrl = URL(string: "https://www.flickr.com/2")!
        let item2 = DataFeed.Item.Builder()
            .withTitle(item2Title)
            .withDateTaken(item2DateTaken)
            .withPublished(item2Published)
            .withImageURL(item2ImageUrl)
            .build()

        let dataFeed = DataFeed.Builder()
            .withFeedTitle(feedTitle)
            .withItems([item1, item2])
            .build()

        return dataFeed
    }

	private func makeExpectedImageListViewModel(from dataFeed: DataFeed, sortType: SortByType) -> ImageListViewModel {

        let items: [ImageListViewModel.Item] = dataFeed.items.flatMap {

            let dateInfo = makeFormattedDateInfo(from: $0.published, sortType: sortType)

            let item = ImageListViewModel.Item.Builder()
                .withName($0.title)
                .withDateInfo(dateInfo)
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

	private func makeFormattedDateInfo(from published: Date, sortType: SortByType) -> String {

        let dateFormatter = ISO8601DateFormatter()

        dateFormatter.formatOptions = .withFullDate
        let dateString = dateFormatter.string(from: published)

        dateFormatter.formatOptions = .withFullTime
        let timeString = dateFormatter.string(from: published).dropLast()

        let prefix: String
        switch sortType {

        case .dateTaken:

            prefix = Strings.ImageListView.dateCreated

        case .datePublished:

            prefix = Strings.ImageListView.datePublished

        }
        return "\(prefix): \(dateString) \(timeString)"
    }
}

private struct GeneralError: Error {

}
