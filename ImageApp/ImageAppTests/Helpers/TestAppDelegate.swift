//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import UIKit

@testable import ImageApp

class TestAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        TestAppConfiguration().configure()
        TestObserver.start()

        return true
    }
}
