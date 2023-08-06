//
//  InMemoryPokemonListStoreTests.swift
//  PokepediaTests
//
//  Created by Василий Клецкин on 8/6/23.
//

import XCTest
import Pokepedia

final class InMemoryPokemonListStore: PokemonListStore {
    
    var cache: CachedPokemonList?
    
    func retrieve() throws -> CachedPokemonList? {
        cache
    }
    
    func delete() throws {
        
    }
    
    func insert(local: LocalPokemonList, timestamp: Date) throws {
        cache = .init(local: local, timestamp: timestamp)
    }
}

final class InMemoryPokemonListStoreTests: XCTestCase, PokemonListStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSut()
        
        assertThatRetrieveDeliversEmptyOnEmptyCache(sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSut()
        
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(sut)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSut()
        
        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSut()
        
        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(sut)
    }
    
    func test_insert_deliversNoErrorOnEmptyCache() {
        let sut = makeSut()
        
        assertThatInsertDeliversNoErrorOnEmptyCache(sut)
    }
    
    func test_insert_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSut()
    }
    
    func test_insert_overridesPreviouslyInsertedCacheValues() {
        let sut = makeSut()
    }
    
    func test_delete_deliversNoErrorOnEmptyCache() {
        let sut = makeSut()
    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSut()
    }
    
    func test_delete_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSut()
    }
    
    func test_delete_emptiesPreviouslyInsertedCache() {
        let sut = makeSut()
    }
    
    // MARK: - Helpers
    
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> InMemoryPokemonListStore {
        let sut = InMemoryPokemonListStore()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
