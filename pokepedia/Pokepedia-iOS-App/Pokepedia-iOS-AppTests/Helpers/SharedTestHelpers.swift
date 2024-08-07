//
//  SharedTestHelpers.swift
//  Pokepedia-iOS-AppTests
//
//  Created by Vasiliy Klyotskin on 5/30/23.
//

import UIKit
import Pokepedia

func anyURL() -> URL {
    .init(string: "http://any-url.com")!
}

func anyData() -> Data {
    .init("any \(UUID().uuidString) data".utf8)
}

func anyDate() -> Date {
    .distantPast
}

func anyId() -> Int {
    232
}

func anyName() -> String {
    "name \(UUID().uuidString)"
}

func anyNSError() -> NSError {
    .init(domain: "any domain", code: 1)
}

func makeListPokemon(specialType: PokemonListItemType? = nil) -> PokemonListItem {
    .init(
        id: anyId(),
        name: anyName(),
        imageUrl: anyURL(),
        physicalType: itemType(),
        specialType: specialType
    )
}

func itemType() -> PokemonListItemType {
    .init(color: "any color", name: anyName())
}

extension UIView {
    public func isVisible() -> Bool {
        guard window != nil else { return false }
        var currentView: UIView = self
        while let superview = currentView.superview {
            if (superview.bounds).intersects(currentView.frame) == false {
                return false;
            }
            if currentView.isHidden {
                return false
            }
            currentView = superview
        }
        return true
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
