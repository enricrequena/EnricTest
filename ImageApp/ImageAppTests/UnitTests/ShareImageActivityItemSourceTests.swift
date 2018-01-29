//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class ShareImageActivityItemSourceTests: XCTestCase {

    var itemSource: ShareImageActivityItemSource!
    var image: UIImage!

    override func setUp() {

        super.setUp()
        image = UIImage()
        itemSource = ShareImageActivityItemSource(image: image)
    }

    override func tearDown() {

        itemSource = nil
        image = nil
        super.tearDown()
    }

    // MARK: - Init

    func testInit() {

        XCTAssert(itemSource.image === image)
    }

    // MARK: - UIActivityItemSource

    func testActivityViewControllerPlaceholderItem() {

        let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: nil)

        let placeholder = itemSource.activityViewControllerPlaceholderItem(activityViewController) as? UIImage

        XCTAssert(placeholder === image)
    }

    func testActivityViewControllerItemForActivify() {

        let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: nil)

        let item = itemSource.activityViewController(activityViewController, itemForActivityType: .message) as? UIImage

        XCTAssert(item === image)
    }
}
