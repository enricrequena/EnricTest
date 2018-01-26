//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

protocol FlickrDataFeedToDataFeedAdapter: class {

    func convert(flickrDataFeed: FlickrDataFeed) -> DataFeed
}
