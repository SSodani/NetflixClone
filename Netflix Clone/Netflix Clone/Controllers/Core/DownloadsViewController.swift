//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-14.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titles:[TitleItem] = [TitleItem]()

    private let downloadTabel: UITableView = {
        let tableView = UITableView.init(frame:.zero ,style: .plain)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
        
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        downloadTabel.delegate = self
        downloadTabel.dataSource = self
        
        view.addSubview(downloadTabel)
        
        fetchLocalStorageForDownload()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        downloadTabel.frame = view.bounds
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let titleItems):
                self?.titles = titleItems
                DispatchQueue.main.async {
                    self?.downloadTabel.reloadData()
                }
            }
        }
    }

}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWithModel(model: titles[indexPath.row]) { results in
                switch results {
                case .failure(let error):
                    print(error.localizedDescription)
                    
                case .success():
                    print("Data deleted")
                    self.titles.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
                }
                
            }
            
        default:
            break;
        }
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

