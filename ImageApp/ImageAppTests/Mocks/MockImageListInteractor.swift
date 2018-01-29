//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp
import UIKit

class MockImageListInteractor {

    struct Invocations {

        var fetchImageList = 0
        var fetchImageListWithTags = [String]()
        var loadImage = [(url: URL, completion: ((UIImage) -> Void))]()
        var cancelImage = [URL]()
		var save = [(image: UIImage, completion: ((Error?) -> Void)?)]()
    }
    var recordedInvocations = Invocations()
}

extension MockImageListInteractor: ImageListInteractor {

    func fetchImageList() {

        recordedInvocations.fetchImageList += 1
    }

    func fetchImageList(with tags: String) {

        recordedInvocations.fetchImageListWithTags.append(tags)
    }

    func loadImage(from url: URL, with completion: @escaping (UIImage) -> Void) {

        recordedInvocations.loadImage.append((url, completion))
    }

    func cancelImage(from url: URL) {

        recordedInvocations.cancelImage.append(url)
    }

    func saveToLibrary(_ image: UIImage, completion: ((Error?) -> Void)?) {

        recordedInvocations.save.append((image, completion))
    }
}
