//
//  CoreDataPokemonListImageDataStoreTests.swift
//  PokepediaTests
//
//  Created by Василий Клецкин on 8/4/23.
//

import XCTest
import Pokepedia
import CoreData

final class CoreDataPokemonListImageDataStoreTests: XCTestCase {
    func test_retrieveImageData_deliversNotFoundWhenEmpty() {
        let sut = makeSut()
        
        expect(sut, toCompleteRetrievalWith: notFound(), for: anyURL())
    }
    
    // MARK: - Helpers
    
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> PokemonListImageStore {
        let storeURL = URL(fileURLWithPath: "/dev/null")
        let sut = CoreDataLocalPokemonListStore(storeUrl: storeURL)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func notFound() -> Result<Data?, Error> {
        return .success(.none)
    }
    
    private func expect(_ sut: PokemonListImageStore, toCompleteRetrievalWith expectedResult: Result<Data?, Error>, for url: URL,  file: StaticString = #filePath, line: UInt = #line) {
        let receivedResult = Result { try sut.retrieveImage(for: url) }

        switch (receivedResult, expectedResult) {
        case let (.success( receivedData), .success(expectedData)):
            XCTAssertEqual(receivedData, expectedData, file: file, line: line)
            
        default:
            XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
}
