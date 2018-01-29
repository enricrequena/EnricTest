//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

import XCTest
@testable import ImageApp

class DefaultAppConfigurationTests: XCTestCase {

    var appConfiguration: DefaultAppConfiguration!

    override func setUp() {

        super.setUp()
        appConfiguration = DefaultAppConfiguration()
    }

    override func tearDown() {

        appConfiguration = nil
        super.tearDown()
    }

    // MARK: - AppConfiguration

    func testConfiguration() {

        appConfiguration.configure()

        // Common
        XCTAssert(ServiceDirectory.Common.imageCache is MemoryImageCache)
        XCTAssert(ServiceDirectory.Common.imageLibrary is SystemGalleryImageLibrary)

        // ImageList
        guard let imageListFactory = ServiceDirectory.ImageList.factory as? DefaultImageListWireframeFactory else {

            XCTFail("DefaultImageListFactory not found")
            return
        }
        XCTAssert(imageListFactory.imageCache === ServiceDirectory.Common.imageCache)
        XCTAssert(imageListFactory.imageLibrary === ServiceDirectory.Common.imageLibrary)
    }
}
