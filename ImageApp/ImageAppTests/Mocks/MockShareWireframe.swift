//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

import Foundation

class MockShareWireframe {

    struct Invocations {

        var presentActivityController = [(context: ShareContext, animated: Bool)]()
    }
    var recordedInvocations = Invocations()

}

extension MockShareWireframe: ShareWireframe {

    func presentActivityController(context: ShareContext, animated: Bool) {

        recordedInvocations.presentActivityController.append((context, animated))
    }
}
