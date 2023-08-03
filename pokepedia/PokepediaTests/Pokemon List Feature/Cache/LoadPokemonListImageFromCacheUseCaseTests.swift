//
//  LoadPokemonListImageFromCacheUseCaseTests.swift
//  PokepediaTests
//
//  Created by Василий Клецкин on 8/3/23.
//

import XCTest
import Pokepedia

final class PokemonListImageLoader {
    private let store: PokemonListImageStoreSpy

    init(store: PokemonListImageStoreSpy) {
        self.store = store
    }
    
    public enum LoadError: Error {
        case failed
        case notFound
    }
    
    func loadImageData(from url: URL) throws -> Data {
        if let data = try store.retrieveImage(for: url) {
            return data
        } else {
            throw LoadError.notFound
        }
    }
}

final class LoadPokemonListImageFromCacheUseCaseTests: XCTestCase {
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSut()
        
        XCTAssertTrue(store.receivedMessages.isEmpty)
    }
    
    func test_load_requestsStoredDataForURL() {
        let (sut, store) = makeSut()
        let url = anyURL()
        
        _ = try? sut.loadImageData(from: url)
        
        XCTAssertEqual(store.receivedMessages, [.retrieve(dataFor: url)])
    }
    
    func test_loadImageDataFromURL_failsOnStoreError() {
        let (sut, store) = makeSut()
        let retrieveError = anyNSError()
        store.stubRetrieveWith(error: retrieveError)
        
        expect(sut, toCompleteWith: .failure(retrieveError))
    }
    
    func test_loadImageDataFromURL_deliversNotFoundErrorOnNotFound() {
        let (sut, store) = makeSut()
        store.stubRetrieveWithEmpty()
        
        expect(sut, toCompleteWith: .failure(PokemonListImageLoader.LoadError.notFound))
    }
    
    func test_loadImageDataFromURL_deliversStoredDataOnFoundData() {
        let (sut, store) = makeSut()
        let foundData = anyData()
        store.stubRetrievalWith(data: foundData)
        
        expect(sut, toCompleteWith: .success(foundData))
    }
    
    // MARK: - Helpers
    
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (PokemonListImageLoader, PokemonListImageStoreSpy) {
        let store = PokemonListImageStoreSpy()
        let sut = PokemonListImageLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(
        _ sut: PokemonListImageLoader,
        toCompleteWith expectedResult: Result<Data, Error>,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let receivedResult = Result { try sut.loadImageData(from: anyURL()) }
        switch (receivedResult, expectedResult) {
        case let (.success(receivedData), .success(expectedData)):
            XCTAssertEqual(receivedData, expectedData, file: file, line: line)
        case (.failure(let receivedError as NSError),
              .failure(let expectedError as NSError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)
        default:
            XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
}

final class PokemonListImageStoreSpy {
    enum Message: Equatable {
        case retrieve(dataFor: URL)
    }
    
    var receivedMessages: [Message] = []
    var retrieveResult: Result<Data?, Error> = .failure(anyNSError())
    
    func retrieveImage(for url: URL) throws -> Data? {
        receivedMessages.append(.retrieve(dataFor: url))
        return try retrieveResult.get()
    }
    
    func stubRetrieveWith(error: Error) {
        retrieveResult = .failure(error)
    }
    
    func stubRetrieveWithEmpty() {
        retrieveResult = .success(nil)
    }
    
    func stubRetrievalWith(data: Data) {
        retrieveResult = .success(data)
    }
}
