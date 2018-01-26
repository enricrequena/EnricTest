//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageListWireframeTests: XCTestCase {

    var wireframe: DefaultImageListWireframe!
    var imageListViewController: ImageListViewController!

    override func setUp() {

        super.setUp()

        imageListViewController = ImageListViewController()
        wireframe = DefaultImageListWireframe(viewController: imageListViewController)
    }

    override func tearDown() {

        wireframe = nil
        imageListViewController = nil
        super.tearDown()
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
    }
}
