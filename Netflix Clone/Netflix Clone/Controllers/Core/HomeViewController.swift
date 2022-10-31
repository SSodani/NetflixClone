//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-14.
//
//what is bounds
//what is viewdidlayoutsubviews, loadView
//scaleAspectFit
//clips to bound
//when to use layout subviews
//assets difference between 1x 2x 3x
//why translatesAutoresizingMaskIntoConstraints set to false
//what is tint colour
//need to understand how the caching is done
//how to have size that fits all screen:  layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
//layout.minimumInteritemSpacing = 0
//.fragmentsAllowed in jsonserialization means
//button.layer.masksToBounds means

import UIKit

enum Sections:Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case UpcomingMovies = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    
    private var headerView:HeroHeaderUIView?

    let sectionTitles:[String] = ["Trending Movies","Trending T.V.","Popular", "Upcoming Movies", "Top Rated"]
    
    private let homeFeedTable : UITableView =  {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    
         
        configureNavBar()
        
        headerView = HeroHeaderUIView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
       configureHeroHeaderView()
        
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingMoview {[weak self] results in
            switch results {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let titles):
                let selectedTitles = titles.randomElement()
                
                self?.randomTrendingMovie = selectedTitles
                
                let titleName = selectedTitles?.original_title ?? ""
                self?.headerView?.configure(with: TitleViewModel(titleName: titleName, posterURL: selectedTitles?.poster_path ?? ""))
            }
        }
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "netflix_logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person" ), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle" ), style: .done, target: self, action: nil)
            ]
        
        navigationController?.navigationBar.tintColor = .white
         
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //print("capita = \(self.sectionTitles[section].capatalieFirstLetter())")
        return self.sectionTitles[section].capatalieFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMoview { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let titles):
                    cell.configure(with: titles)
                    
                }
            }
        case Sections.TrendingTV.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let titles):
                    cell.configure(with: titles)
                    
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMoview { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let titles):
                    cell.configure(with: titles)
                    
                }
            }
        case Sections.UpcomingMovies.rawValue:
            APICaller.shared.getUpComingMoview { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let titles):
                    cell.configure(with: titles)
                    
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMoview { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let titles):
                    cell.configure(with: titles)
                    
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        headerView.textLabel?.frame = CGRect(x: view.bounds.origin.x + 20, y: view.bounds.origin.y, width: 100, height: view.bounds.height)
        headerView.textLabel?.textColor = .white
        headerView.textLabel?.text =  headerView.textLabel?.text?.lowercased()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffSet = self.view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffSet
        
        navigationController?.navigationBar.transform = CGAffineTransform.init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController:CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreViewModel) {
        DispatchQueue.main.async {[weak self] in 
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        }
}
