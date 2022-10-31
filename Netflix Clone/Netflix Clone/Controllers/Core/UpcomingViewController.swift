//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-14.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles:[Title] = [Title]()
    
    private let upcomingTabel: UITableView = {
        let tableView = UITableView.init(frame:.zero ,style: .plain)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
//    private var titleViewModel : TitleViewModel? {
//        didSet {
//            DispatchQueue.main.async {[weak self] in
//                self?.upcomingTabel.reloadData()
//            }
//
//        }
//    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        self.view.addSubview(self.upcomingTabel)
        self.upcomingTabel.delegate = self
        self.upcomingTabel.dataSource = self
        
        self.fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.upcomingTabel.frame = self.view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpComingMoview {[weak self] result in
            switch result {
            case(.failure(let error)):
                print(error.localizedDescription)
            case(.success(let titles)):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTabel.reloadData()
                }
               
            }
        }
    }


}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         self.titles.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier,for: indexPath) as? TitleTableViewCell else {
             return UITableViewCell()
         }
         let title = self.titles[indexPath.row]
         
         cell.configure(with: TitleViewModel(titleName:title.original_title ?? title.original_name ?? "Unknown", posterURL: title.poster_path ?? ""))
         
         
         
//         if(cell == nil) {
//            cell =  UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
//         }
         
         
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
