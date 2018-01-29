//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import UIKit

class DefaultShareWireframe {

	let viewController: UIViewController

	init(viewController: UIViewController) {

		self.viewController = viewController
	}
}

extension DefaultShareWireframe: ShareWireframe {

	func presentActivityController(context: ShareContext, animated: Bool) {

		let activityViewController = UIActivityViewController(
			activityItems: context.activityItems, applicationActivities: []
		)

		viewController.present(activityViewController, animated: animated, completion: nil)
	}
}

