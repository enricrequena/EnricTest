//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp
import UIKit

class MockImageListInteractor {

    struct Invocations {

        var fetchImageList = 0
        var loadImage = [(url: URL, completion: ((UIImage) -> Void))]()
        var cancelImage = [URL]()
    }
    var recordedInvocations = Invocations()
}

extension MockImageListInteractor: ImageListInteractor {

    func fetchImageList() {

        recordedInvocations.fetchImageList += 1
    }

    func loadImage(from url: URL, with completion: @escaping (UIImage) -> Void) {

        recordedInvocations.loadImage.append((url, completion))
    }

    func cancelImage(from url: URL) {

        recordedInvocations.cancelImage.append(url)
    }
}