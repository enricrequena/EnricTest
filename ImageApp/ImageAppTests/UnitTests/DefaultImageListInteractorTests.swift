//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageListInteractorTests: XCTestCase {

    var interactor: DefaultImageListInteractor!
    var mockImageListInteractorOutput: MockImageListInteractorOutput!
	var mockImageCache: MockImageCache!
	var mockImageLibrary: MockImageLibrary!

    override func setUp() {

        super.setUp()

        mockImageListInteractorOutput = MockImageListInteractorOutput()
		mockImageCache = MockImageCache()
        mockImageLibrary = MockImageLibrary()
		interactor = DefaultImageListInteractor(imageCache: mockImageCache, imageLibrary: mockImageLibrary)
        interactor.output = mockImageListInteractorOutput
    }

    override func tearDown() {

        interactor = nil
        mockImageListInteractorOutput = nil
		mockImageCache = nil
        mockImageLibrary = nil
        super.tearDown()
    }

	func testInit() {

        XCTAssert(interactor.imageCache === mockImageCache)
        XCTAssert(interactor.imageLibrary === mockImageLibrary)
    }

    func testSaveToLibrary() {

        let image = UIImage()
        var executedWithError: Error? = nil

        let errorExpected = SystemGalleryError.userNotAuthorisedToSavePhotos
        mockImageLibrary.returnValues.save = errorExpected
        let completion: (Error?) -> Void = {
            error in
            executedWithError = error
        }

        interactor.saveToLibrary(image, completion: completion)

        XCTAssertEqual(mockImageLibrary.recordedInvocations.save.count, 1)
        XCTAssert(mockImageLibrary.recordedInvocations.save.first?.image === image)
        XCTAssertEqual(executedWithError as? SystemGalleryError, errorExpected)
    }
}
