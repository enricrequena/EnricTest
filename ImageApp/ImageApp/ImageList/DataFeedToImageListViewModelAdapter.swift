//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

protocol DataFeedToImageListViewModelAdapter: class {

    func convert(
        dataFeed: DataFeed,
        sortedBy: SortByType,
        itemAction: @escaping (ImageListViewModel.Item) -> Void) -> ImageListViewModel
    func convert(error: Error) -> String
}
