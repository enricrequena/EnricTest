//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageListWireframeTests: XCTestCase {

    var wireframe: DefaultImageListWireframe!
    var imageListViewController: ImageListViewController!
    var mockImageCache: MockImageCache!
    var mockImageLibrary: MockImageLibrary!

    override func setUp() {

        super.setUp()

        imageListViewController = ImageListViewController()
        mockImageCache = MockImageCache()
        mockImageLibrary = MockImageLibrary()
        wireframe = DefaultImageListWireframe(
            viewController: imageListViewController,
            imageCache: mockImageCache,
            imageLibrary: mockImageLibrary
        )
    }

    override func tearDown() {

        wireframe = nil
        imageListViewController = nil
        mockImageCache = nil
        mockImageLibrary = nil
        super.tearDown()
    }

	// MARK: - init

	func testInit() {

		XCTAssert(wireframe.viewController === imageListViewController)
		XCTAssert(wireframe.imageCache === mockImageCache)
		XCTAssert(wireframe.imageLibrary === mockImageLibrary)
	}

    // MARK: - ImageListWireframe

    func testPresent() {

        wireframe.present()

        guard let presenter = imageListViewController.presenter as? DefaultImageListPresenter else {

            XCTFail("DefaultImageListPresenter not found")
            return
        }
        guard let interactor = presenter.interactor as? DefaultImageListInteractor else {

            XCTFail("DefaultImageListInteractor not found")
            return
        }
        XCTAssert(presenter.view === imageListViewController)
        XCTAssert(presenter.wireframe === wireframe)
        XCTAssert(interactor.output === presenter)
        XCTAssert(interactor.imageCache === mockImageCache)
        XCTAssert(interactor.imageLibrary === mockImageLibrary)
    }
}
