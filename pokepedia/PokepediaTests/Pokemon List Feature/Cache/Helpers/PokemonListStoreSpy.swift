//
//  PokemonListStoreMock.swift
//  PokepediaTests
//
//  Created by Vasiliy Klyotskin on 7/31/23.
//

import Foundation
import Pokepedia

final class PokemonListStoreSpy {
    enum Message: Equatable {
        case retrieval
        case deletion
        case insertion(timestamp: Date, local: LocalPokemonList)
    }
    
    var retrieveResult: Result<CachedPokemonList?, Error> = .failure(anyNSError())
    var deletionResult: Result<Void, Error> = .failure(anyNSError())
    var insertionResult: Result<Void, Error> = .failure(anyNSError())
    var receivedMessages: [Message] = []
    
    func stubRetrieve(with error: Error) {
        retrieveResult = .failure(error)
    }
    
    func stubRetrieveWith(local: LocalPokemonList, timestamp: Date) {
        retrieveResult = .success(.init(local: local, timestamp: timestamp))
    }
    
    func stubEmptyRetrieve() {
        retrieveResult = .success(nil)
    }
    
    func stubDeletion(with error: Error) {
        deletionResult = .failure(error)
    }
    
    func stubDeletionWithSuccess() {
        deletionResult = .success(())
    }
    
    func stubInsertion(with error: Error) {
        insertionResult = .failure(error)
    }
    
    func stubInsertionWithSuccess() {
        insertionResult = .success(())
    }
}

extension PokemonListStoreSpy: PokemonListStore {
    func retrieve() throws -> CachedPokemonList? {
        receivedMessages.append(.retrieval)
        return try retrieveResult.get()
    }
    
    func delete() throws {
        receivedMessages.append(.deletion)
        try deletionResult.get()
    }
    
    func insert(local: LocalPokemonList, timestamp: Date) throws {
        receivedMessages.append(.insertion(timestamp: timestamp, local: local))
        try insertionResult.get()
    }
}
