//
//  PokemonListUIComposer.swift
//  Pokepedia-iOS-App
//
//  Created by Vasiliy Klyotskin on 5/28/23.
//

import Pokepedia_iOS
import Pokepedia
import Combine
import UIKit

public enum PokemonListUIComposer {
    private typealias PresentationAdapter = ResourceLoadingPresentationAdapter<Paginated<PokemonListItem>, PokemonListViewAdapter>
    
    public static func compose(
        loader: @escaping () -> AnyPublisher<Paginated<PokemonListItem>, Error>,
        imageLoader: @escaping (URL) -> AnyPublisher<ListPokemonItemImage, Error>,
        onItemSelected: @escaping (PokemonListItem) -> Void = { _ in }
    ) -> ListViewController {
        let loadingAdapter = PresentationAdapter(loader: loader)
        let listController = ListViewController(
            onRefresh: loadingAdapter.load,
            onViewDidLoad: PokemonListCells.register
        )
        let viewAdapter = PokemonListViewAdapter(
            listController: listController,
            imageLoader: imageLoader,
            onItemSelected: onItemSelected
        )
        loadingAdapter.presenter = .init(
            view: viewAdapter,
            loadingView: WeakProxy(listController),
            errorView: WeakProxy(listController)
        )
        listController.title = PokemonListPresenter.title
        return listController
    }
}
