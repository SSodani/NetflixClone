//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-27.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel:TitlePreViewModel)
}

class SearchResultsViewController: UIViewController {
    
    public var titles:[Title] = [Title]()
    
    public weak var delegate:SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier:TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground 
        
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchResultsCollectionView.frame = view.bounds
    }
    
}

extension SearchResultsViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: titles[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        
        guard let titleName =   title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getMovie(with: titleName) {[weak self] results in
            switch results {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let videoElement):
                DispatchQueue.main.async {
                    
                    guard let titleOverview = title.overview else { return }
                    
                    self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreViewModel(title: titleName, titleOverview: titleOverview, youtubeView: videoElement))
                }
            }
        }
        
    }
        
    
    
    
    
    
}
