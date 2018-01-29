//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp
import Foundation

// MARK: - ImageListViewModel

extension ImageListViewModel {

    struct Builder {

        var title: String = "title"
        var items: [Item] = []

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withItems(_ items: [Item]) -> Builder {
            var builder = self
            builder.items = items
            return builder
        }

        func build() -> ImageListViewModel {

            return ImageListViewModel(
                title: self.title,
                items: self.items
            )
        }
    }
}

extension ImageListViewModel.Item {

    struct Builder {
        var name: String = "name"
        var dateInfo: String = "dateInfo"
        var imageUrl: URL = URL(string: "https://www.flickr.com")!
        var itemAction: ((ImageListViewModel.Item) -> Void)? = nil

        func withName(_ name: String) -> Builder {
            var builder = self
            builder.name = name
            return builder
        }

        func withDateInfo(_ dateInfo: String) -> Builder {
            var builder = self
            builder.dateInfo = dateInfo
            return builder
        }

        func withImageUrl(_ imageUrl: URL) -> Builder {
            var builder = self
            builder.imageUrl = imageUrl
            return builder
        }

        func withItemAction(_ itemAction: ((ImageListViewModel.Item) -> Void)?) -> Builder {
            var builder = self
            builder.itemAction = itemAction
            return builder
        }

        func build() -> ImageListViewModel.Item {
            return ImageListViewModel.Item(
                name: self.name,
                dateInfo: self.dateInfo,
                imageUrl: self.imageUrl,
                itemAction: self.itemAction
            )
        }
    }
}

extension EditTagsViewModel {

    struct Builder {

        var title: String = "title"
        var message: String = "message"
        var textFieldPlaceHolder: String = "textFieldPlaceHolder"
        var buttonTitle: String = "buttonTitle"
        var cancelButtonTitle: String = "cancelButtonTitle"
        var completion: ((String) -> Void)? = nil

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withMessage(_ message: String) -> Builder {
            var builder = self
            builder.message = message
            return builder
        }

        func withTextFieldPlaceHolder(_ textFieldPlaceHolder: String) -> Builder {
            var builder = self
            builder.textFieldPlaceHolder = textFieldPlaceHolder
            return builder
        }

        func withButtonTitle(_ buttonTitle: String) -> Builder {
            var builder = self
            builder.buttonTitle = buttonTitle
            return builder
        }

        func withCancelButtonTitle(_ cancelButtonTitle: String) -> Builder {
            var builder = self
            builder.cancelButtonTitle = cancelButtonTitle
            return builder
        }

        func withCompletion(_ completion: ((String) -> Void)?) -> Builder {
            var builder = self
            builder.completion = completion
            return builder
        }

        func build() -> EditTagsViewModel {
            return EditTagsViewModel(
                title: self.title,
                message: self.message,
                textFieldPlaceHolder: self.textFieldPlaceHolder,
                buttonTitle: self.buttonTitle,
                cancelButtonTitle: self.cancelButtonTitle,
                completion: self.completion)
        }
    }
}

extension ActionsViewModel {

    struct Builder {

        var title: String = "title"
        var message: String = "message"
        var actions: [Action] = []

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withMessage(_ message: String) -> Builder {
            var builder = self
            builder.message = message
            return builder
        }

        func withActions(_ actions: [Action]) -> Builder {
            var builder = self
            builder.actions = actions
            return builder
        }

        func build() -> ActionsViewModel {
            return ActionsViewModel(
                title: self.title,
                message: self.message,
                actions: self.actions)
        }
    }

}

// MARK: - DataFeed

extension DataFeed {

    struct Builder {
        var feedTitle: String = "feedTitle"
        var items: [Item] = []

        func withFeedTitle(_ feedTitle: String) -> Builder {
            var builder = self
            builder.feedTitle = feedTitle
            return builder
        }

        func withItems(_ items: [Item]) -> Builder {
            var builder = self
            builder.items = items
            return builder
        }

        func build() -> DataFeed {
            return DataFeed(
                feedTitle: self.feedTitle,
                items: self.items)
        }
    }
}

extension DataFeed.Item {

    struct Builder {

        var title: String = "title"
        var dateTaken: Date = ISO8601DateFormatter().date(from: "2018-01-24T19:27:33-08:00")!
        var published: Date = ISO8601DateFormatter().date(from: "2018-01-24T19:27:33-17:00")!
        var link: URL = URL(string: "https://www.flickr.com/223")!
        var imageURL: URL = URL(string: "https://www.flickr.com/4234")!

        func withTitle(_ title: String) -> Builder {
            var builder = self
            builder.title = title
            return builder
        }

        func withDateTaken(_ dateTaken: Date) -> Builder {
            var builder = self
            builder.dateTaken = dateTaken
            return builder
        }

        func withPublished(_ published: Date) -> Builder {
            var builder = self
            builder.published = published
            return builder
        }

        func withLink(_ link: URL) -> Builder {
            var builder = self
            builder.link = link
            return builder
        }

        func withImageURL(_ imageURL: URL) -> Builder {
            var builder = self
            builder.imageURL = imageURL
            return builder
        }

        func build() -> DataFeed.Item {
            return DataFeed.Item(
                title: self.title,
                dateTaken: self.dateTaken,
                published: self.published,
                link: self.link,
                imageURL: self.imageURL)
        }
    }
}
