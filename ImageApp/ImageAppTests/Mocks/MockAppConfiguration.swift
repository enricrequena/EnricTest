//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

@testable import ImageApp

class MockAppConfiguration {

    struct Invocations {

        var configure = 0
        var configureCommon = 0
        var configureImageList = 0
    }
    var recordedInvocations = Invocations()
}

extension MockAppConfiguration: AppConfiguration {

    func configure() {

        recordedInvocations.configure += 1
    }

    func configureCommon() {

        recordedInvocations.configureCommon += 1
    }

    func configureImageList() {

        recordedInvocations.configureImageList += 1
    }
}