//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class MockDataFeedToImageListViewModelAdapter {

    struct Invocations {

		var convertDataFeed = [(dataFeed: DataFeed, sortedBy: SortByType)]()
        var convertError = [Error]()
    }
    var recordedInvocations = Invocations()

    struct Return {

        var convert: ImageListViewModel = ImageListViewModel.Builder().build()
        var convertError: String = "Error"
    }
    var returnValues = Return()

	func reset() {

		recordedInvocations = Invocations()
		returnValues = Return()
	}
}

extension MockDataFeedToImageListViewModelAdapter: DataFeedToImageListViewModelAdapter {

	func convert(dataFeed: DataFeed, sortedBy: SortByType) -> ImageListViewModel {

        recordedInvocations.convertDataFeed.append((dataFeed, sortedBy))

        return returnValues.convert
    }

    func convert(error: Error) -> String {

        recordedInvocations.convertError.append(error)

        return returnValues.convertError
    }
}
