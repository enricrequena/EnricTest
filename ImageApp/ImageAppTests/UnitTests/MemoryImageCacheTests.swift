//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class MemoryImageCacheTests: XCTestCase {

    var cache: MemoryImageCache!

    override func setUp() {

        super.setUp()
        cache = MemoryImageCache()
    }

    override func tearDown() {

        cache = nil
        super.tearDown()
    }

    // MARK: - ImageCache

    func testCacheImage() {

        let url1 = URL(string: "https://www.flickr.com/image/1")!
        let image1 = UIImage()
        cache.cache(image: image1, at: url1)

        let url2 = URL(string:"https://www.flickr.com/image/2")!
        let image2 = UIImage()
        cache.cache(image: image2, at: url2)

        let url3 = URL(string: "https://www.flickr.com/image/3")!

        XCTAssert(cache.findImage(for: url1) === image1)
        XCTAssert(cache.findImage(for: url2) === image2)
        XCTAssert(cache.findImage(for: url2) === image2)
        XCTAssertNil(cache.findImage(for: url3))
    }
}
