//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

enum Strings {

    enum  ImageListView {

        static let titleForError = "Oops, something failed"
        static let titleForLoading = "Loading ..."
        static let messageForLoading = "Loading feed, please wait, won't be long."
        static let dateCreated = "Created"
        static let datePublished = "Published"

        enum EditTag {

            static let alertTitle = "Edit tag"
            static let alertMessage = "Enter your new tags below"
            static let textFieldPlaceHolder = "Eg: cat, funny, long hair"
            static let buttonTitle = "Done"
            static let cancelButtonTitle = "Cancel"
        }

        enum Action {

            static let alertTitle = "Actions"
            static let alertMessage = "Please select one of the actions below"
            static let saveToLibraryButtonTitle = "Save image to library"
            static let openImageInBrowserButtonTitle = "Open image in Safari"
            static let cancelButtonTitle = "Cancel"
            static let successImageSavedToastMessage = "Image saved successfully"
            static let failureSavingImageToastMessage = "Failed to save image"
        }
    }

    enum Error {

        static let generalError = "An unexpected error occurred."
        static let errorOcurred = "An error occurred during your request"
    }
}
