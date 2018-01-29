//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

protocol ImageListView: class {

	func loading(with title: String, and message: String, sortType: SortByType)
    func update(with viewModel: ImageListViewModel)
    func updateFailed(with title: String, and errorMessage: String)
    func presentAlert(with viewModel: EditTagsViewModel, animated: Bool)
    func presentActions(with viewModel: ActionsViewModel, animated: Bool)
	func presentToast(with message: String, and color: UIColor)
}
