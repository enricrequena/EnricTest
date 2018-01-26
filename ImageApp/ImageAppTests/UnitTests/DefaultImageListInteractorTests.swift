//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageListInteractorTests: XCTestCase {

    var interactor: DefaultImageListInteractor!
    var mockImageListInteractorOutput: MockImageListInteractorOutput!

    override func setUp() {

        super.setUp()

        mockImageListInteractorOutput = MockImageListInteractorOutput()
        interactor = DefaultImageListInteractor()
        interactor.output = mockImageListInteractorOutput
    }

    override func tearDown() {

        interactor = nil
        mockImageListInteractorOutput = nil
        super.tearDown()
    }

    // NOTE: fetchImageList method tested through integration tests
}
