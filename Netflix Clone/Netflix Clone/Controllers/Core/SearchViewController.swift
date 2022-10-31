//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-14.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles:[Title] = [Title]()
    
    private let discoverTable:UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController:UISearchController = {
        let controller = UISearchController.init(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        navigationController?.navigationBar.tintColor = .label
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
         
        
        self.fetchUpcoming()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    

   func fetchUpcoming() {
       APICaller.shared.getDiscoverMovies {[weak self] result in
           switch result {
           case .failure(let error):
               print(error.localizedDescription)
           case .success(let titles):
               self?.titles = titles
               DispatchQueue.main.async {
                   self?.discoverTable.reloadData()
               }
           }
       }
    }
}

extension SearchViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titles.count
    }
    
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
             return UITableViewCell()
         }
         
         
//         if(cell == nil) {
//             cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
//         }
         let title = titles[indexPath.row]
         cell.configure(with: TitleViewModel(titleName:title.original_title ?? title.original_name ?? "Unknown" , posterURL: title.poster_path ?? ""))
         
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated:true)
        
        let title = titles[indexPath.row]
        
        guard let titleName =   title.original_title ?? title.original_name else { return }
        
        
        
        APICaller.shared.getMovie(with: titleName) {[weak self] results in
            switch results {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let videoElement):
                DispatchQueue.main.async {
                    
                    guard let titleOverview = title.overview else { return }
                    
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreViewModel(title: titleName, titleOverview: titleOverview, youtubeView: videoElement))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
}

extension SearchViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
        !query.trimmingCharacters(in: .whitespaces).isEmpty,
        query.trimmingCharacters(in: .whitespaces).count >= 3,
        let resultController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        resultController.delegate = self
        
        APICaller.shared.search(with: query) { results in
            switch results {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let titles):
                resultController.titles = titles
                DispatchQueue.main.async {
                    resultController.searchResultsCollectionView.reloadData()
                }
            }
        }
    }
    
    
}

extension SearchViewController:SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreViewModel) {
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
