//
//  Foundation+Extension.swift
//  DigiCatch
//
//  Created by Marius Gutoi on 24/11/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Foundation

extension String {
    public func contains(find: String) -> Bool {
        return range(of: find) != nil
    }
    
    public func containsIgnoringCase(find: String) -> Bool {
        return range(of: find, options: .caseInsensitive) != nil
    }
}

extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    public func appendingQueryItems(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
}
