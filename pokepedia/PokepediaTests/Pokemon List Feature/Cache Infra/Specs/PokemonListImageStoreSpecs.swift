//
//  PokemonListImageStoreSpecs.swift
//  PokepediaTests
//
//  Created by Василий Клецкин on 8/6/23.
//

import XCTest
import Pokepedia

protocol PokemonListImageStoreSpecs {
    func test_retrieveImageData_deliversNotFoundWhenEmpty()
    func test_retrieveImageData_deliversNotFoundWhenStoredDataURLDoesNotMatch()
    func test_retrieveImageData_deliversFoundDataWhenThereIsAStoredImageDataMatchingURL()
    func test_retrieveImageData_deliversLastInsertedValue()
}

protocol FailableRetrievePokemonListImageStoreSpecs: PokemonListImageStoreSpecs {
    func test_retrieveImageData_deliversFailureOnRetrievalError()
}

protocol FailableInsertPokemonListImageStoreSpecs: PokemonListImageStoreSpecs {
    func test_insertImageData_deliversFailureOnInsertionError()
}

typealias FailablePokemonListImageStoreSpecs = FailableRetrievePokemonListImageStoreSpecs & FailableInsertPokemonListImageStoreSpecs