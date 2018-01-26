//
//  Copyright © 2018 ERT Limited. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var imageListWireframeFactory: ImageListWireframeFactory = DefaultImageListWireframeFactory()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

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
