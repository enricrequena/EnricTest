//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class StringsTests: XCTestCase {

    func testStrings() {

        XCTAssertEqual(Strings.ImageListView.titleForError, "Oops, something failed")
        XCTAssertEqual(Strings.ImageListView.titleForLoading, "Loading ...")
        XCTAssertEqual(Strings.ImageListView.messageForLoading, "Loading feed, please wait, won't be long.")

        XCTAssertEqual(Strings.Error.generalError, "An unexpected error occurred.")
        XCTAssertEqual(Strings.Error.errorOcurred, "An error occurred during your request")
    }
}
