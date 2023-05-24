//
//  InMemoryStore.swift
//  Pokepedia
//
//  Created by Василий Клецкин on 5/23/23.
//

import Foundation

public final class InMemoryStore<Local> {
    public typealias Key = String
    private typealias Timestamp = Date
    private typealias Cache = (local: Local, timestamp: Timestamp)
    
    public init() {}
    
    private var stored = [Key: Cache]()
    
    public func retrieve(for key: Key) -> StoreRetrieval<Local>? {
        stored[key].map { .init(local: $0.local, timestamp: $0.timestamp) }
    }
    
    public func insert(_ data: LocalInserting<Local>, for key: Key) {
        stored[key] = (data.local, data.timestamp)
    }
    
    public func delete(for key: Key) {
        stored[key] = nil
    }
}
