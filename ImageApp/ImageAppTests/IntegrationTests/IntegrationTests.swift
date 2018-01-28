//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class IntegrationTests: XCTestCase {

    func testDefaultImageListInteractor_FetchImageList() {

        let expectation = XCTestExpectation(description: "FetchFlickrDataFeedOperation")

        let mockOutput = MockImageListInteractorOutput()
        mockOutput.executeOnCall.didFetch = {

            expectation.fulfill()
        }
		let mockImageCache = MockImageCache()
		let interactor = DefaultImageListInteractor(imageCache: mockImageCache)
        interactor.output = mockOutput

        interactor.fetchImageList()

        wait(for: [expectation], timeout: 10)

        guard mockOutput.recordedInvocations.didFetch.count == 1,
              let result = mockOutput.recordedInvocations.didFetch.first else {

            XCTFail("No result fetched")
            return
        }

        switch result {

            case .success:
                break
            case let .failure(error):
                XCTFail("Operation failed with error: \(error)")
        }
    }
}
