//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

class DefaultImageListInteractor {

    weak var output: ImageListInteractorOutput?
    let imageCache: ImageCache

    private let operationQueue = OperationQueue()

    private var runningFetchDataFeedOperation: FetchFlickrDataFeedOperation? = nil
    private var runningOperations: [URL: Operation] = [:]


    init(imageCache: ImageCache) {

        self.imageCache = imageCache
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

    func cancelImage(from url: URL) {

        cancelOperation(at: url)
    }
}

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
