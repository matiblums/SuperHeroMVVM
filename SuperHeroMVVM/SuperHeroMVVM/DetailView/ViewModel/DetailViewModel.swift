//
//  DetailViewModel.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 16/05/2021.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConnections = APIClient()
    private(set) weak var view: DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
//    func getMovieData(movieID: String) -> Observable<MovieDetail> {
//        return managerConnections.getDetailMovies(movideID: movieID)
//    }
//    
//    func getImageMovie(urlString: String) -> Observable<UIImage> {
//        return managerConnections.getImageFromServer(urlString: urlString)
//    }
}
