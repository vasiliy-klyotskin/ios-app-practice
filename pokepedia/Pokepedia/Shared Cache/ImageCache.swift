//
//  ImageCache.swift
//  Pokepedia
//
//  Created by Василий Клецкин on 8/17/23.
//

import Foundation

public protocol ImageCache {
    func save(_ data: Data, for url: URL) throws
}
