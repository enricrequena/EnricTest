//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp
import UIKit

class MockImageListPresenter {

    struct Invocations {

        var viewDidLoad = 0
        var refreshTable = 0
        var willDisplayImage = [(url: URL, completion: (UIImage) -> Void)]()
        var endDisplayingImage = [URL]()
        var editTagsRequest = 0
        var sortBy = [SortByType]()
    }
    var recordedInvocations = Invocations()

    func reset() {

        recordedInvocations = Invocations()
    }
}

extension MockImageListPresenter: ImageListPresenter {

    func viewDidLoad() {

        recordedInvocations.viewDidLoad += 1
    }

    func refreshTable() {

        recordedInvocations.refreshTable += 1
    }

    func willDisplayImage(from url: URL, with completion: @escaping (UIImage) -> Void) {

        recordedInvocations.willDisplayImage.append((url, completion))
    }

    func endDisplayingImage(from url: URL) {

        recordedInvocations.endDisplayingImage.append(url)
    }

    func editTagsRequest() {

        recordedInvocations.editTagsRequest += 1
    }

	func sortBy(_ type: SortByType) {

        recordedInvocations.sortBy.append(type)
    }
}
