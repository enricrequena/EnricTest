//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
import Foundation

@testable import ImageApp

class TestObserver: NSObject, XCTestObservation {

    static func start() {

        XCTestObservationCenter.shared.addTestObserver(TestObserver())
    }

    func testCaseWillStart(_ testCase: XCTestCase) {

        TestAppConfiguration().configure()
    }
}
