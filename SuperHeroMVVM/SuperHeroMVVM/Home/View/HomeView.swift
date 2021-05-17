//
//  HomeView.swift
//  SuperHeroMVVM
//
//  Created by Mblum on 13/05/2021.
//

import UIKit
import SDWebImage
import RxSwift

class HomeView: UIViewController {
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var disposeBag = DisposeBag()
    private var list = List()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.bind(view: self, router: router)
        configureView()
        bind()
        initCollectionView()
        self.title = "Superhero App"
        
        //getData()
    }
    
    private func getData() {
        return viewModel.retriveDataListRxSwift()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { list in
                    self.list = list
                    self.collectionView.reloadData()
                }, onError: { error in
                    print(error.localizedDescription)
                },onCompleted:{
                    
                }).disposed(by: disposeBag)
    }
    
    private func configureView() {
        activity.isHidden = false
        activity.startAnimating()
        //viewModel.retriveDataListAlamofire()
        viewModel.retriveDataListURLSession()
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

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.dataArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as!  HomeCollectionViewCell
        let object = viewModel.dataArray[indexPath.row]
        
        //cell.itemImage.sd_setImage(with: URL(string: object.images.md), placeholderImage: UIImage(named: "placeholder.png"))
        cell.itemImage.imageFromServerURL(urlString: object.images.md, placeHolderImage: UIImage(named: "placeholder.png")!)
        cell.itemImage.layer.cornerRadius = 10
        cell.itemView.layer.cornerRadius = 10
        cell.nameLabel.text = object.name
        cell.heightLabel.text = "Height: \(object.appearance.height[1])"
        cell.weightLabel.text = "Weight: \(object.appearance.height[1])"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width / 2 - 30, height: view.frame.size.height / 3 - 60)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.makeDetailView(movieID: "s")
        
    }
    
}


