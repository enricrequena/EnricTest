//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class NetworkErrorTests: XCTestCase {

    func testNetworkError_Equal() {

        XCTAssertEqual(
            NetworkError.failedToLoadData(message: "hellow"),
            NetworkError.failedToLoadData(message: "hellow")
        )
    }

    func testNetworkError_Different() {

        XCTAssertNotEqual(
            NetworkError.failedToLoadData(message: "hellow"),
            NetworkError.failedToLoadData(message: "hellow1")
        )
    }
}
