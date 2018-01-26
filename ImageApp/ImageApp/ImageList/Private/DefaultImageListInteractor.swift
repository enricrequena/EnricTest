//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

class DefaultImageListInteractor {

    weak var output: ImageListInteractorOutput?

    private let operationQueue = OperationQueue()

    private var runningOperations: [URL: Operation] = [:]
}

extension DefaultImageListInteractor: ImageListInteractor {

    func fetchImageList() {

        let fetchDataFeedOperation = FetchFlickrDataFeedOperation {

            (result) in

            DispatchQueue.main.async {

                self.output?.didFetch(result: result)
            }
        }

        operationQueue.addOperation(fetchDataFeedOperation)
    }

    func loadImage(from url: URL, with completion: @escaping (UIImage) -> Void) {

        guard !operationAlreadyRunning(for: url) else {

            return
        }

        let downloadImageOperation = ImageDownloadOperation(url: url) {

            [weak self] image in

            self?.releaseOperation(at: url)

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
