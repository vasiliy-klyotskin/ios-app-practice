//
//  DetailPokemonPresenterTests.swift
//  PokepediaTests
//
//  Created by Vasiliy Klyotskin on 7/25/23.
//

import XCTest
@testable import Pokepedia

final class DetailPokemonPresenterTests: XCTestCase {
    func test_abilitiesTitle_isLocalized() {
        let expected = localized(
            "POKEMON_DETAILS_ABILITIES_TITLE",
            table: "PokemonDetail",
            bundleType: DetailPokemonPresenter.self
        )
        
        let actual = DetailPokemonPresenter.abilitiesTitle
        
        XCTAssertEqual(actual, expected)
    }
    
    func test_mapInfo_deliversDetailPokemonInfoViewModel() {
        let (viewModel, model) = makeInfoItem()
        
        let result = DetailPokemonPresenter.mapInfo(model: model)
        
        XCTAssertEqual(viewModel, result)
    }
    
    func test_mapAbilities_deliversDetailPokemonAbilitiesViewModel() {
        let (viewModel, model) = makeAbilitiesItem()
        
        let result = DetailPokemonPresenter.mapAbilities(model: model, colorMapping: Color.init)
        
        XCTAssertEqual(viewModel, result)
    }
    
    // MARK: - Helpers
    
    private func makeInfoItem() -> (DetailPokemonInfoViewModel, DetailPokemonInfo) {
        let imageUrl = anyURL()
        let viewModel: DetailPokemonInfoViewModel = .init(
            imageUrl: imageUrl,
            id: "0002",
            name: "name",
            genus: "genus",
            flavorText: "flavorText"
        )
        let model: DetailPokemonInfo = .init(
            imageUrl: imageUrl,
            id: 2,
            name: "name",
            genus: "genus",
            flavorText: "flavorText"
        )
        return (viewModel, model)
    }
    
    private func makeAbilitiesItem() -> (DetailPokemonAbilitiesViewModel<Color>, DetailPokemonAbilities) {
        let viewModel: DetailPokemonAbilitiesViewModel<Color> =
        [
            .init(
                title: "title",
                subtitle: "subtitle",
                damageClass: "class",
                damageClassColor: Color(value: "class color"),
                type: "type",
                typeColor: Color(value: "type color")
            )
        ]
        let model: DetailPokemonAbilities = [
            .init(
                title: "title",
                subtitle: "subtitle",
                damageClass: "class",
                damageClassColor: "class color",
                type: "type",
                typeColor: "type color"
            )
        ]
        return (viewModel, model)
    }
    
    private struct Color: Equatable, Hashable {
        let value: String
    }
}
