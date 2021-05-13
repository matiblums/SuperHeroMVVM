//
//  HomeView.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 13/05/2021.
//

import UIKit

class HomeView: UIViewController {
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        viewModel.bind(view: self, router: router)
        
        configureView()
        bind()
        initCollectionView()
    }

    private func configureView() {
        activity.isHidden = false
        activity.startAnimating()
        viewModel.retriveDataList()
    }
    
    private func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.activity.stopAnimating()
                self?.activity.isHidden = true
            }
        }
    }
    
    private func initCollectionView() {
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.dataSource = self
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.dataArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HomeCollectionViewCell
        //let cell : HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HomeCollectionViewCell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as!  HomeCollectionViewCell
        
         
        let object = viewModel.dataArray[indexPath.row]
        
        
        cell.nameLabel.text = object.name
        cell.heightLabel.text = object.appearance.height[1]
        cell.weightLabel.text = object.appearance.weight[1]
        
        return cell
        
    }
}

