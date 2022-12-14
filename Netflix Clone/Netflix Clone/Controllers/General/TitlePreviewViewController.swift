//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-28.
//

import UIKit
import WebKit



class TitlePreviewViewController: UIViewController {
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Harry Potter"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let overviewLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is an awsome moview. Must watch for kids"
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        self.applyConstraints()
        
    }
    
    func applyConstraints() {
        
        let webViewConstraints = [webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                  webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                  webView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
                                  webView.heightAnchor.constraint(equalToConstant: 300)]
        
        let titleLabelConstraints = [titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
                                     titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                                     titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                                     titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let overviewLabelConstraints = [overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
                                     overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                                     overviewLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let downloadButtonConstraints = [downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
                                         downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                         downloadButton.widthAnchor.constraint(equalToConstant: 140),
                                         downloadButton.heightAnchor.constraint(equalToConstant: 40)]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
     
    func configure(with model:TitlePreViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return }
        
        
            self.webView.load(URLRequest(url: url))
        
        
    }

} 
