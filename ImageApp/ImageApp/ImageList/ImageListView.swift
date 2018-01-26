//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

protocol ImageListView: class {

	func loading(with title: String, and message: String)
    func update(with viewModel: ImageListViewModel)
    func updateFailed(with title: String, and errorMessage: String)
}
