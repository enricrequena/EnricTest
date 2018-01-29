//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
import UIKit
@testable import ImageApp

class DefaultShareWireframeTests: XCTestCase {

    var wireframe: DefaultShareWireframe!
    private var mockViewController: MockUIViewController!

    override func setUp() {

        super.setUp()

        mockViewController = MockUIViewController()
        wireframe = DefaultShareWireframe(viewController: mockViewController)
    }

    override func tearDown() {

        wireframe = nil
        mockViewController = nil
        super.tearDown()
    }

    // MARK: - Init

    func testInit() {

        XCTAssert(wireframe.viewController === mockViewController)
    }

    // MARK: - Present

    func testPresent() {

        let image = UIImage()
        let shareImageSource = ShareImageActivityItemSource(image: image)
        let shareContext = ShareContext.Builder()
            .withActivityItems([shareImageSource])
            .build()
        let animated = false

        wireframe.presentActivityController(context: shareContext, animated: animated)

        XCTAssertEqual(mockViewController.recordedInvocations.present.count, 1)
        guard let activityViewController = mockViewController.recordedInvocations.present.first?.viewControllerToPresent
            as? UIActivityViewController else {

            XCTFail("No UIActivityViewController presented")
            return
        }
        XCTAssertEqual(mockViewController.recordedInvocations.present.first?.flag, animated)
    }
}

private class MockUIViewController: UIViewController {

    struct Invocations {

        var present = [(viewControllerToPresent: UIViewController, flag: Bool)]()
    }
    var recordedInvocations = Invocations()

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {

        recordedInvocations.present.append((viewControllerToPresent, flag))
    }
}