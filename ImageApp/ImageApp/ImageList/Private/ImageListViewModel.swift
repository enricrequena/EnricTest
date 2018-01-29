//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

struct ImageListViewModel {

    let title: String
    let items: [Item]

    struct Item {

        let name: String
        let dateInfo: String
        let imageUrl: URL
        let itemAction: ((ImageListViewModel.Item) -> Void)?
    }
}

struct EditTagsViewModel {

    let title: String
    let message: String
    let textFieldPlaceHolder: String
    let buttonTitle: String
    let cancelButtonTitle: String
    let completion: ((String) -> Void)?
}

struct ActionsViewModel {

    let title: String
    let message: String
    let actions: [Action]
}

// MARK: - Equatable extension

extension ImageListViewModel: Equatable {

    static func ==(lhs: ImageListViewModel, rhs: ImageListViewModel) -> Bool {
        return lhs.title == rhs.title &&
        lhs.items == rhs.items
    }
}

extension ImageListViewModel.Item: Equatable {

    static func ==(lhs: ImageListViewModel.Item, rhs: ImageListViewModel.Item) -> Bool {
        return lhs.name == rhs.name &&
            lhs.dateInfo == rhs.dateInfo &&
            lhs.imageUrl == rhs.imageUrl
    }
}

extension EditTagsViewModel: Equatable {

    static func ==(lhs: EditTagsViewModel, rhs: EditTagsViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.message == rhs.message &&
            lhs.textFieldPlaceHolder == rhs.textFieldPlaceHolder &&
            lhs.buttonTitle == rhs.buttonTitle &&
            lhs.cancelButtonTitle == rhs.cancelButtonTitle
    }
}

extension ActionsViewModel: Equatable {

    static func ==(lhs: ActionsViewModel, rhs: ActionsViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.message == rhs.message &&
            lhs.actions == rhs.actions
    }
}
