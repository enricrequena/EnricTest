//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageListInteractorTests: XCTestCase {

    var interactor: DefaultImageListInteractor!
    var mockImageListInteractorOutput: MockImageListInteractorOutput!
	var mockImageCache: MockImageCache!

    override func setUp() {

        super.setUp()

        mockImageListInteractorOutput = MockImageListInteractorOutput()
		mockImageCache = MockImageCache()
		interactor = DefaultImageListInteractor(imageCache: mockImageCache)
        interactor.output = mockImageListInteractorOutput
    }

    override func tearDown() {

        interactor = nil
        mockImageListInteractorOutput = nil
		mockImageCache = nil
        super.tearDown()
    }

	func testInit() {

        XCTAssert(interactor.imageCache === mockImageCache)
    }
}
