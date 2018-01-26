//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class AppDelegateTests: XCTestCase {

    var appDelegate: AppDelegate!
    
    override func setUp() {

        super.setUp()

        appDelegate = AppDelegate()
    }
    
    override func tearDown() {

        super.tearDown()

        appDelegate = nil
    }

    func testImageListWireframeFactory() {

        XCTAssertTrue(appDelegate.imageListWireframeFactory is DefaultImageListWireframeFactory)
    }

    func testApplicationDidFinishLaunchingWithOptions() {

        let mockImageListWireframeFactory = MockImageListWireframeFactory()
        appDelegate.imageListWireframeFactory = mockImageListWireframeFactory

        let application = UIApplication.shared
        let options: [UIApplicationLaunchOptionsKey: Any]? = nil

        let result = appDelegate.application(application, didFinishLaunchingWithOptions: options)
        XCTAssertTrue(result)

        guard let navigationViewController = appDelegate.window?.rootViewController as? UINavigationController,
              navigationViewController.viewControllers.count == 1,
              let imageViewController = navigationViewController.topViewController as? ImageListViewController else {

            XCTFail("ImageListViewController not found")
            return
        }

        XCTAssertEqual(mockImageListWireframeFactory.recordedInvocations.makeWireframe.count, 1)
        XCTAssert(mockImageListWireframeFactory.recordedInvocations.makeWireframe.first! === imageViewController)
        XCTAssertEqual(mockImageListWireframeFactory.returnValues.makeWireframe.recordedInvocations.present, 1)
    }
}
