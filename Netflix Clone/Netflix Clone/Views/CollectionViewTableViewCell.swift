//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-14.
//

import UIKit

protocol CollectionViewTableViewCellDelegate:AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell:CollectionViewTableViewCell, viewModel:TitlePreViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    weak var delegate: CollectionViewTableViewCellDelegate?

   static let identifier = "CollectionViewTableViewCell"
    
    private var titles = [Title]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self , forCellWithReuseIdentifier:TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure(with titles:[Title]) {
        self.titles = titles
        DispatchQueue.main.async {[weak self] in
            self?.collectionView.reloadData()
        }
    } 
    
    private func downloadTitleAt(indexPath:IndexPath) {
        
        DataPersistenceManager.shared.downloadTitleWith(model:titles[indexPath.row]) { results in
            switch results {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(()):
                print("Download to Database")
                NotificationCenter.default.post(name:NSNotification.Name("downloaded"), object: nil)
            }
        }
       
    }
    
}

extension CollectionViewTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
     
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let model = titles[indexPath.row].poster_path  {
            cell.configure(with: model)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let titleName = titles[indexPath.row].original_title ?? titles[indexPath.row].original_name else { return }
        
        APICaller.shared.getMovie(with: titleName) { [weak self]  result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let videoElement):
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else { return }
                guard let strongSelf = self else { return }
                let viewModel = TitlePreViewModel(title: titleName, titleOverview:titleOverview, youtubeView: videoElement)
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel:viewModel)
        }
        
    }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off)
                { _ in
                    self?.downloadTitleAt(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        return config
    }
    
     
}
