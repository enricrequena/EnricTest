//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

import UIKit

class MockImageListView {

    struct Invocations {

        var loading = [(title: String, message: String, sortType: SortByType)]()
        var update = [ImageListViewModel]()
        var updateFailed = [(title: String, errorMessage: String)]()
        var presentAlert = [(viewModel: EditTagsViewModel, animated: Bool)]()
        var presentActions = [(viewModel: ActionsViewModel, animated: Bool)]()
        var presentToast = [(message: String, color: UIColor)]()
    }
    var recordedInvocations = Invocations()

    func reset() {

        recordedInvocations = Invocations()
    }
}

extension MockImageListView: ImageListView {

    func loading(with title: String, and message: String, sortType: SortByType) {

        recordedInvocations.loading.append((title, message, sortType))
    }

    func update(with viewModel: ImageListViewModel) {

        recordedInvocations.update.append(viewModel)
    }

    func updateFailed(with title: String, and errorMessage: String) {

        recordedInvocations.updateFailed.append((title, errorMessage))
    }

    func presentAlert(with viewModel: EditTagsViewModel, animated: Bool) {

        recordedInvocations.presentAlert.append((viewModel, animated))
    }

    func presentActions(with viewModel: ActionsViewModel, animated: Bool) {

        recordedInvocations.presentActions.append((viewModel, animated))
    }

    func presentToast(with message: String, and color: UIColor) {

        recordedInvocations.presentToast.append((message, color))
    }
}