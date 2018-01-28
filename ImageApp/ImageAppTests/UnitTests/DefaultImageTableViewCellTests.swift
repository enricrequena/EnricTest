//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import XCTest
@testable import ImageApp

class DefaultImageTableViewCellTests: XCTestCase {

    var cell: DefaultImageTableViewCell!

    override func setUp() {

        super.setUp()

        let viewController = loadImageListViewController()

        viewController.loadViewIfNeeded()

        cell = viewController.tableView.dequeueReusableCell(
            withIdentifier: DefaultImageTableViewCell.reuseIdentifier
        ) as! DefaultImageTableViewCell
    }

    override func tearDown() {

        cell = nil

        super.tearDown()
    }

    // MARK: - Identifier

    func testIdentifier() {

        XCTAssertEqual(DefaultImageTableViewCell.reuseIdentifier, "DefaultImageTableViewCell")
    }

    // MARK: - ImageTableViewCell

    func testUpdateWithItem() {

        let publishedAt = "some string"
        let item = ImageListViewModel.Item.Builder()
            .withDateInfo(publishedAt)
            .build()

        cell.update(with: item)

        XCTAssertEqual(cell.publishedAt.text, publishedAt)
    }
}

extension DefaultImageTableViewCellTests {

    private func loadImageListViewController() -> ImageListViewController {

        let navigationController = UIStoryboard(
            name: "Main",
            bundle: .main
        ).instantiateInitialViewController() as! UINavigationController

        return navigationController.topViewController as! ImageListViewController
    }
}