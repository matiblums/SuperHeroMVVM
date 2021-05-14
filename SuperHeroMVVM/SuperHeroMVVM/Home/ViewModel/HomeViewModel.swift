//
//  HomeViewModel.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 13/05/2021.
//

import Foundation
import UIKit
import Alamofire

class HomeViewModel {
    
    private weak var view: HomeView?
    private var router: HomeRouter?
    
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
    
    func retriveDataList() {
        APIClient.sharedInstance.retriveDataList(completionHandler: { [weak self ] (datos, error) in
            
            self?.dataArray = datos!
            
        }, errorHandler: { (errorDescription) in
            print("error")
        })
        
    }
    
}
