//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

protocol DataFeedToImageListViewModelAdapter: class {

    func convert(dataFeed: DataFeed, sortedBy: SortByType) -> ImageListViewModel
    func convert(error: Error) -> String
}
