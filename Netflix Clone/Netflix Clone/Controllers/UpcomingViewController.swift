//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-14.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private let upcomingTabel: UITableView = {
        let tableView = UITableView.init(frame:.zero ,style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var titles : [Title]? {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.upcomingTabel.reloadData()
            }
           
        }
    }
    
    

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
        APICaller.shared.getUpComingMoview { result in
            switch result {
            case(.failure(let error)):
                print(error.localizedDescription)
            case(.success(let titles)):
                self.titles = titles
            }
        }
    }


}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         self.titles?.count ?? 0
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
         
//         if(cell == nil) {
//            cell =  UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
//         }
         
         cell.textLabel?.text = self.titles?[indexPath.row].original_title ?? "Unknown"
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
