//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class AppDelegateTests: XCTestCase {

    var appDelegate: AppDelegate!
    var mockAppConfiguration: MockAppConfiguration!

    override func setUp() {

        super.setUp()

        mockAppConfiguration = MockAppConfiguration()
        appDelegate = AppDelegate()
        appDelegate.appConfiguration = mockAppConfiguration
    }
    
    override func tearDown() {

        appDelegate = nil
        mockAppConfiguration = nil

        super.tearDown()
    }

    func testApplicationDidFinishLaunchingWithOptions() {

        guard let mockImageListWireframeFactory = ServiceDirectory.ImageList.factory as? MockImageListWireframeFactory else {

            XCTFail("MockImageListWireframeFactory not configured")
            return
        }

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
        XCTAssertEqual(mockAppConfiguration.recordedInvocations.configure, 1)
    }
}
