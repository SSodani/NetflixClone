//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-20.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let titlePosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30 ))
        //button.setTitle("Play", for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = .label
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        self.applyConstraints()
    }
    
    func applyConstraints() {
        let titlePosterUIImageViewConstraints = [titlePosterUIImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                                                 titlePosterUIImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
                                                 titlePosterUIImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10),
                                                 titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100)]
        
        let titleLabelConstraints = [titleLabel.leadingAnchor.constraint(equalTo: self.titlePosterUIImageView.trailingAnchor, constant: 20),
                                     titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
                                    // titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
                                    // titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ]
        
        let playTitleButtonConstraints = [playTitleButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
                                          playTitleButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
//                                          playTitleButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
//                                          playTitleButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
//                                          playTitleButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ]
        
        
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    public func configure(with model:TitleViewModel) {
        
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        titlePosterUIImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
     required init?(coder: NSCoder) {
        fatalError()
    }

}
