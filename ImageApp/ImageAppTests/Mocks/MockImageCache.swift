//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

@testable import ImageApp

class MockImageCache {

    struct Invocations {

        var cache = [(UIImage, URL)]()
        var findImage = [URL]()
    }
    var recordedInvocations = Invocations()

    struct Return {

        var findImage: UIImage? = nil
    }
    var returnValues = Return()
}

extension MockImageCache: ImageCache {

    func cache(image: UIImage, at url: URL) {

        recordedInvocations.cache.append((image, url))
    }

    func findImage(for url: URL) -> UIImage? {

        recordedInvocations.findImage.append(url)

        return returnValues.findImage
    }
}
