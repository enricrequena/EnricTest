//
// Copyright (c) 2018 ERT Limited. All rights reserved.
//

import Foundation
import ReachabilitySwift

class FetchFlickrDataFeedOperation: Operation {

    private let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json")!
    private let tags: String
    private let completion: ((Result<DataFeed>) -> Void)

    init(tags: String, completion: @escaping (Result<DataFeed>) -> Void) {

        self.tags = tags
        self.completion = completion

        super.init()
    }

    override func main() {

        guard !isCancelled else {

            return
        }

		guard Reachability()?.isReachable == true else {

			completion(.failure(NetworkError.failedToLoadData(message: "No internet connection, please check your network settings.")))
			return
		}

        let url = makeURL(with: tags)

        guard let data = try? Data(contentsOf: url) else {

            completion(.failure(NetworkError.failedToLoadData(message: "No data from URL.")))
            return
        }

        guard !isCancelled else {

            return
        }

        guard let modifiedData = removeFlickrFunctionAndMakeValidJSONData(from: data) else {

            completion(.failure(NetworkError.failedToLoadData(message: "Failed to modify Flickr JSON data.")))
            return
        }

        guard !isCancelled else {

            return
        }

        guard let flickDataFeed = try? JSONDecoder().decode(FlickrDataFeed.self, from: modifiedData) else {

            completion(.failure(NetworkError.failedToLoadData(message: "Could not parse JSONFlickrFeed.")))
            return
        }

        guard !isCancelled else {

            return
        }

        let flickrDataAdapter = DefaultFlickrDataFeedToDataFeedAdapter()
        let dataFeed = flickrDataAdapter.convert(flickrDataFeed: flickDataFeed)

        guard !isCancelled else {

            return
        }

        completion(.success(dataFeed))
    }

    private func makeURL(with tags: String) -> URL {

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {

            return url
        }

        let urlQueryItem = URLQueryItem(name: "tags", value: tags)

        urlComponents.queryItems?.append(urlQueryItem)

        guard let urlWithTags = urlComponents.url else {

            return url
        }

        return urlWithTags
    }
}

extension FetchFlickrDataFeedOperation {

    private func removeFlickrFunctionAndMakeValidJSONData(from data: Data) -> Data? {

        guard let string = String(data: data, encoding: .utf8) else {

            return nil
        }

        // Flickr API wraps the JSON response in a function called 'jsonFlickrFeed()'.
        // This causes our parser to fail so we will remove it manually.

        // Step 1 - Remove 'jsonFlickrFeed('
        let functionName = "jsonFlickrFeed("
        var modifiedString = string.dropFirst(functionName.count)

        // Step 2 - Remove function clousure at the end ')'
        modifiedString = modifiedString.dropLast()

        guard let data = String(modifiedString).data(using: .utf8) else {

            return nil
        }

        return data
    }
}
