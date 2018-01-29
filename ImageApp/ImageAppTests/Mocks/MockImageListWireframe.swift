//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

import UIKit

class MockImageListWireframe {

    struct Invocations {

        var present = 0
        var navigateToShare = [UIImage]()
    }
    var recordedInvocations = Invocations()
}

extension MockImageListWireframe: ImageListWireframe {

    func present() {

        recordedInvocations.present += 1
    }

    func navigateToShare(with image: UIImage) {

        recordedInvocations.navigateToShare.append(image)
    }
}
