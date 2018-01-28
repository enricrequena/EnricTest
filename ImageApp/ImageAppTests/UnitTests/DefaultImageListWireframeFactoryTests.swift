//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageListWireframeFactoryTests: XCTestCase {

    var factory: DefaultImageListWireframeFactory!
    var mockImageCache: MockImageCache!

    override func setUp() {

        super.setUp()
        mockImageCache = MockImageCache()
        factory = DefaultImageListWireframeFactory(imageCache: mockImageCache)
    }

    override func tearDown() {

        factory = nil
        mockImageCache = nil
        super.tearDown()
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
    }
}
