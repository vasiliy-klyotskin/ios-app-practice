//
//  StoreMock.swift
//  PokepediaTests
//
//  Created by Василий Клецкин on 5/19/23.
//

import Foundation
import Pokepedia

final class StoreMock: LocalLoaderStore, LocalSaverStore, LocalValidatorStore {
    typealias Key = String
    typealias Timestamp = Date
    
    enum Message: Equatable {
        case retrieve(Key)
        case delete(Key)
        case insert(LocalStub, Timestamp, Key)
    }
    
    var messages: [Message] = []
    var retrieveStubs = [Key: Result<LocalRetrieval<LocalStub>?, Error>]()
    
    func retrieve(for key: String) -> LocalRetrieval<LocalStub>? {
        messages.append(.retrieve(key))
        return try? retrieveStubs[key]!.get()
    }
    
    func retrieveTimestamp(for key: Key) -> Timestamp? {
        let retrieval: LocalRetrieval<LocalStub>? = retrieve(for: key)
        return retrieval.map { $0.timestamp }
    }
    
    func delete(for key: Key) {
        messages.append(.delete(key))
    }
    
    func insert(_ data: LocalInserting<LocalStub>, for key: Key) {
        messages.append(.insert(data.local, data.timestamp, key))
    }
    
    func stubRetrieve(result: Result<LocalRetrieval<LocalStub>?, Error>, for key: String) {
        retrieveStubs[key] = result
    }
}

struct LocalStub: Equatable {
    let id: UUID = .init()
}
struct ModelStub: Equatable {
    let id: UUID = .init()
}
