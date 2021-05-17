//
//  HomeViewModel.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 13/05/2021.
//

import Foundation
import UIKit
import Alamofire
import RxSwift

class HomeViewModel {
    
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var managerConnections = APIClient()
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
    var refreshData = { () -> () in}
    
    var dataArray: List = [] {
        didSet {
            refreshData()
        }
    }
    
    func retriveDataListAlamofire() {
        APIClient.sharedInstance.retriveDataListAlamofire(completionHandler: { [weak self ] (datos, error) in
            
            self?.dataArray = datos!
            
        }, errorHandler: { (errorDescription) in
            print("error")
        })
        
    }
    
    func retriveDataListURLSession() {
        APIClient.sharedInstance.retriveDataListURLSession(completionHandler: { [weak self ] (datos, error) in
            
            self?.dataArray = datos!
            
        }, errorHandler: { (errorDescription) in
            print("error")
        })
        
    }
    
    func retriveDataListRxSwift() -> Observable<List> {
        return managerConnections.retriveDataListRxSwift()
    }
    
    func makeDetailView(movieID: String) {
        router?.navigateToDetailView(movieID: movieID)
    }
}
