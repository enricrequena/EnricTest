//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class MockImageListView {

    struct Invocations {

        var loading = [(title: String, message: String)]()
        var update = [ImageListViewModel]()
        var updateFailed = [(title: String, errorMessage: String)]()
    }
    var recordedInvocations = Invocations()
}

extension MockImageListView: ImageListView {

    func loading(with title: String, and message: String) {

        recordedInvocations.loading.append((title, message))
    }

    func update(with viewModel: ImageListViewModel) {

        recordedInvocations.update.append(viewModel)
    }

    func updateFailed(with title: String, and errorMessage: String) {

        recordedInvocations.updateFailed.append((title, errorMessage))
    }
}