//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class MockImageListWireframeFactory {

    struct Invocations {

        var makeWireframe = [ImageListViewController]()
    }
    var recordedInvocations = Invocations()

    struct Return {

        var makeWireframe = MockImageListWireframe()
    }
    var returnValues = Return()
}

extension MockImageListWireframeFactory: ImageListWireframeFactory {

    func makeWireframe(with viewController: ImageListViewController) -> ImageListWireframe {

        recordedInvocations.makeWireframe.append(viewController)

        return returnValues.makeWireframe
    }
}