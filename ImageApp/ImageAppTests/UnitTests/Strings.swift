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
        XCTAssertEqual(Strings.ImageListView.dateCreated, "Created")
        XCTAssertEqual(Strings.ImageListView.datePublished, "Published")

        XCTAssertEqual(Strings.ImageListView.EditTag.alertTitle, "Edit tag")
        XCTAssertEqual(Strings.ImageListView.EditTag.alertMessage, "Enter your new tags below")
        XCTAssertEqual(Strings.ImageListView.EditTag.textFieldPlaceHolder, "Eg: cat, funny, long hair")
        XCTAssertEqual(Strings.ImageListView.EditTag.buttonTitle, "Done")
        XCTAssertEqual(Strings.ImageListView.EditTag.cancelButtonTitle, "Cancel")

        XCTAssertEqual(Strings.Error.generalError, "An unexpected error occurred.")
        XCTAssertEqual(Strings.Error.errorOcurred, "An error occurred during your request")
    }
}
