//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Sonam Sodani on 2022-10-17.
//

import UIKit

//issue: need to fix graient clor to be responsive with screen mode change
class HeroHeaderUIView: UIView {

    private let  heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(heroImageView)
        addGradient()
        self.addSubview(playButton)
        self.addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let playButtonContraints = [
            playButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(playButtonContraints)
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            //downloadButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            downloadButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(downloadButtonConstraints)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.heroImageView.frame  = self.bounds
    }
    
    private  func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.systemBackground.cgColor]
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    

}
