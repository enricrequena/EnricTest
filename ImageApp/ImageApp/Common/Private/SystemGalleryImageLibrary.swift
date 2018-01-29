//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit
import Photos

enum SystemGalleryError: Error {

	case userNotAuthorisedToSavePhotos
}

class SystemGalleryImageLibrary: NSObject {

	private var imageToSave: UIImage? = nil
    private var completionBlock: ((Error?) -> Void)? = nil
}

extension SystemGalleryImageLibrary: ImageLibrary {

    func save(image: UIImage, completion: ((Error?) -> Void)?) {

		self.imageToSave = image
		self.completionBlock = completion

		guard userHasPermitionToSavePhotosToLibrary() else {

			completionBlock?(SystemGalleryError.userNotAuthorisedToSavePhotos)
			return
		}

		UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}

extension SystemGalleryImageLibrary {

	private func userHasPermitionToSavePhotosToLibrary() -> Bool {

		switch PHPhotoLibrary.authorizationStatus() {
		case .authorized:

			return true

		case .notDetermined:

			requestAuthorizationToUser()

		default:
			return false
		}
		return PHPhotoLibrary.authorizationStatus() == .authorized
	}

	private func requestAuthorizationToUser() {

		PHPhotoLibrary.requestAuthorization {

			[weak self] (status) in

			guard let strongSelf = self,
				let image = strongSelf.imageToSave,
				let completion = strongSelf.completionBlock else {

					return
			}

			strongSelf.save(image: image, completion: completion)
		}
	}
}

extension SystemGalleryImageLibrary {

	@objc private func image(
		_ image: UIImage,
		didFinishSavingWithError error: Error?,
		contextInfo: UnsafeRawPointer) {

		imageToSave = nil

		completionBlock?(error)

		completionBlock = nil
	}
}
