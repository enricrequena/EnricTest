//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

class DefaultImageListInteractor {

    weak var output: ImageListInteractorOutput?
    let imageCache: ImageCache
    let imageLibrary: ImageLibrary

    private let operationQueue = OperationQueue()

    private var runningFetchDataFeedOperation: FetchFlickrDataFeedOperation? = nil
    private var runningOperations: [URL: Operation] = [:]


    init(imageCache: ImageCache, imageLibrary: ImageLibrary) {

        self.imageCache = imageCache
        self.imageLibrary = imageLibrary
    }
}

extension DefaultImageListInteractor: ImageListInteractor {

    func fetchImageList() {

        fetchImageList(with: "puppies")
    }

    func fetchImageList(with tags: String) {

        guard runningFetchDataFeedOperation == nil else {

            return
        }

        runningFetchDataFeedOperation = FetchFlickrDataFeedOperation(tags: tags) {

            (result) in

            self.runningFetchDataFeedOperation = nil

            DispatchQueue.main.async {

                self.output?.didFetch(result: result)
            }
        }

        operationQueue.addOperation(runningFetchDataFeedOperation!)
    }

	func loadImage(from url: URL, with completion: @escaping (UIImage) -> Void) {

        let cachedImage = imageCache.findImage(for: url)

        guard cachedImage == nil else {

            completion(cachedImage!)
            return
        }

        fetchImage(with: url, and: completion)
    }

    func cancelImage(from url: URL) {

        cancelOperation(at: url)
    }

    func saveToLibrary(_ image: UIImage, completion: ((Error?) -> Void)?) {

        imageLibrary.save(image: image, completion: completion)
    }
}

// MARK: - Image Fetching

extension DefaultImageListInteractor {

    private func fetchImage(with url: URL, and completion: @escaping (UIImage) -> Void) {

        guard !operationAlreadyRunning(for: url) else {

            return
        }

        let downloadImageOperation = ImageDownloadOperation(url: url) {

            [weak self] image in

            guard let strongSelf = self else {

                return
            }

            strongSelf.releaseOperation(at: url)
            strongSelf.imageCache.cache(image: image, at: url)

            completion(image)

        }

        runningOperations[url] = downloadImageOperation

        operationQueue.addOperation(downloadImageOperation)
    }
}

// MARK: - Operation Management

extension DefaultImageListInteractor {

    private func operationAlreadyRunning(for url: URL) -> Bool {

        guard let operation = runningOperations[url] else {

            return false
        }

        guard operation.isExecuting else {

            return false
        }

        return true
    }

	private func releaseOperation(at url: URL) {

		guard let operation = runningOperations[url] else {

			return
		}

		// make sure is cancelled
		operation.cancel()

		runningOperations[url] = nil
	}

    private func cancelOperation(at url: URL) {

        guard let operation = runningOperations[url] else {

            return
        }

		guard operation.isExecuting else {

			return
		}

        operation.cancel()
    }

}
