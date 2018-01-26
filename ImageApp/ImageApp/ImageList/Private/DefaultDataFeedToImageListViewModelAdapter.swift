//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

class DefaultDataFeedToImageListViewModelAdapter {

}

extension DefaultDataFeedToImageListViewModelAdapter: DataFeedToImageListViewModelAdapter {

    func convert(dataFeed: DataFeed) -> ImageListViewModel {

        let title = dataFeed.feedTitle
        let items = dataFeed.items.flatMap {

            makeItem(from: $0)
        }

        return ImageListViewModel(title: title, items: items)
    }

    func convert(error: Error) -> String {

        guard let networkError = error as? NetworkError else {

            return Strings.Error.generalError
        }

        switch networkError {

            case let .failedToLoadData(message):

                return "\(Strings.Error.errorOcurred):\n\(message)"
        }
    }
}

// MARK: - Helpers

extension DefaultDataFeedToImageListViewModelAdapter {

    private func makeItem(from item: DataFeed.Item) -> ImageListViewModel.Item {

        let name = item.title
        let publishedAt = makeFormattedDate(from: item.published)
        let imageUrl = item.imageURL

        let item = ImageListViewModel.Item(
            name: name,
            publishedAt: publishedAt,
            imageUrl: imageUrl
        )

        return item
    }

    private func makeFormattedDate(from published: Date) -> String {

        let dateFormatter = ISO8601DateFormatter()

        dateFormatter.formatOptions = .withFullDate

        return dateFormatter.string(from: published)
    }
}
