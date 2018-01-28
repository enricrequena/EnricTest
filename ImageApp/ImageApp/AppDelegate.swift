//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var appConfiguration: AppConfiguration = DefaultAppConfiguration()

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        appConfiguration.configure()

        configureInitialModule()

        return true
    }
}

// MARK: - Configuration

extension AppDelegate {

    private func configureInitialModule() {

        makeKeyWindow()

        guard let imageListWireframe = makeImageListWireframe() else {

            return
        }
        imageListWireframe.present()
    }

    private func makeKeyWindow() {

		guard let window = UIApplication.shared.windows.first else {

			return
		}

		window.makeKeyAndVisible()

		self.window = window
    }

    private func makeImageListWireframe() -> ImageListWireframe? {

        guard let imageViewViewController = findImageListViewController() else {

            return nil
        }

		let imageListWireframeFactory = ServiceDirectory.ImageList.factory!

        return imageListWireframeFactory.makeWireframe(with: imageViewViewController)
    }

    private func findImageListViewController() -> ImageListViewController? {

        guard let rootViewController = window?.rootViewController as? UINavigationController else {

            return nil
        }

        guard rootViewController.viewControllers.count == 1,
              let imageViewController = rootViewController.topViewController as? ImageListViewController else {

            return nil
        }

        return imageViewController
    }
}
