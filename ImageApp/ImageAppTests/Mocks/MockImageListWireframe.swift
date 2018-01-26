//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class MockImageListWireframe {

    struct Invocations {

        var present = 0
    }
    var recordedInvocations = Invocations()
}

extension MockImageListWireframe: ImageListWireframe {

    func present() {

        recordedInvocations.present += 1
    }
}
