//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageListWireframeFactoryTests: XCTestCase {

    var factory: DefaultImageListWireframeFactory!
    var mockImageCache: MockImageCache!
    var mockImageLibrary: MockImageLibrary!

    override func setUp() {

        super.setUp()
        mockImageCache = MockImageCache()
        mockImageLibrary = MockImageLibrary()
        factory = DefaultImageListWireframeFactory(imageCache: mockImageCache, imageLibrary: mockImageLibrary)
    }

    override func tearDown() {

        factory = nil
        mockImageCache = nil
        mockImageLibrary = nil
        super.tearDown()
    }

	// MARK: - init

	func testInit() {

		XCTAssert(factory.imageCache === mockImageCache)
		XCTAssert(factory.imageLibrary === mockImageLibrary)
	}

    // MARK: - makeWireframe

    func testMakeWireframe() {

        let viewController = ImageListViewController()

        let wireframe = factory.makeWireframe(with: viewController)

        guard let defaultWireframe = wireframe as? DefaultImageListWireframe else {

            XCTFail("DefaultImageListWireframe not found")
            return
        }

        XCTAssert(defaultWireframe.viewController === viewController)
        XCTAssert(defaultWireframe.imageCache === mockImageCache)
        XCTAssert(defaultWireframe.imageLibrary === mockImageLibrary)
    }
}
