//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

protocol AppConfiguration: class {

    func configure()
    func configureCommon()
    func configureImageList()
}

extension AppConfiguration {

    func configure() {

        configureCommon()
        configureImageList()
    }
}