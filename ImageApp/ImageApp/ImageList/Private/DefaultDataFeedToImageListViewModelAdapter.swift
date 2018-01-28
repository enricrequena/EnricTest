//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation

class DefaultDataFeedToImageListViewModelAdapter {

}

extension DefaultDataFeedToImageListViewModelAdapter: DataFeedToImageListViewModelAdapter {

    func convert(dataFeed: DataFeed, sortedBy: SortByType) -> ImageListViewModel {

        let title = dataFeed.feedTitle

        let dataFeedItemsSorted = sortDataFeedItems(dataFeed.items, by: sortedBy)

        let items = dataFeedItemsSorted.flatMap {

            makeItem(from: $0, for: sortedBy)
        }

        return ImageListViewModel(title: title, items: items)
    }

    private func sortDataFeedItems(_ items: [DataFeed.Item], by sortType: SortByType) -> [DataFeed.Item] {

        return items.sorted {

            switch sortType {

            case .dateTaken:

                return $0.dateTaken.compare($1.dateTaken) == .orderedDescending

            case .datePublished:

                return $0.published.compare($1.published) == .orderedDescending
            }
        }
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

    private func makeItem(from item: DataFeed.Item, for sortType: SortByType) -> ImageListViewModel.Item {

        let name = item.title
		let dateInfo = makeFormattedDate(from: item.published, for: sortType)
        let imageUrl = item.imageURL

        let item = ImageListViewModel.Item(
            name: name,
            dateInfo: dateInfo,
            imageUrl: imageUrl
        )

        return item
    }

    private func makeFormattedDate(from published: Date, for sortType: SortByType) -> String {

        let dateFormatter = ISO8601DateFormatter()

        dateFormatter.formatOptions = .withFullDate
		let dateString = dateFormatter.string(from: published)

		dateFormatter.formatOptions = .withFullTime
		let timeString = dateFormatter.string(from: published).dropLast()

        let prefix: String
        switch sortType {

            case .dateTaken:

                prefix = Strings.ImageListView.dateCreated

            case .datePublished:

                prefix = Strings.ImageListView.datePublished

        }
        return "\(prefix): \(dateString) \(timeString)"
    }
}
