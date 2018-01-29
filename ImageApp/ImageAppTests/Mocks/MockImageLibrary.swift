//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

import UIKit

class MockImageLibrary {

    struct Invocations {

        var save = [(image: UIImage, completion: ((Error?) -> Void)?)]()
    }
    var recordedInvocations = Invocations()

    struct Return {

        var save: Error? = nil
    }
    var returnValues = Return()
}

extension MockImageLibrary: ImageLibrary {

    func save(image: UIImage, completion: ((Error?) -> Void)?) {

        recordedInvocations.save.append((image, completion))

        completion?(returnValues.save)
    }
}