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
        guard let url = URL(string: "https://dev.consultr.net/superhero.json") else { return }
        
        Alamofire.request(url).responseJSON { response in
            
            if let data = response.data {
                do {
                    self.dataArray = try JSONDecoder().decode(List.self, from: data)
                     
                }catch {
                    print("Parsing ranking from api fullError? ->> \(error)")
                }
            }
        }
        
    }
    
}
