//
//  DetailView.swift
//  GiphyTestWork
//
//  Created by Михаил on 18.11.2022.
//

import Foundation
import UIKit

final class DetailView: BaseView {

    // MARK: - Properties
    
    lazy var gifImageView: UIImageView = {
        let gifImageView = UIImageView()
        gifImageView.contentMode = .scaleAspectFit
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        return gifImageView
    }()
    
    lazy var closeImageView: UIImageView = {
        let closeImageView = UIImageView()
        closeImageView.isUserInteractionEnabled = true
        closeImageView.image = UIImage(systemName: "multiply")
        closeImageView.tintColor = .white
        closeImageView.translatesAutoresizingMaskIntoConstraints = false
        return closeImageView
    }()
    
    lazy var copyGiphyLinkLabel: UILabel = {
        let copyGiphyLinkLabel = UILabel()
        copyGiphyLinkLabel.isUserInteractionEnabled = true
        copyGiphyLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        copyGiphyLinkLabel.textAlignment = .center
        copyGiphyLinkLabel.backgroundColor = UIColor(named: "mainPurple")
        copyGiphyLinkLabel.font = .systemFont(ofSize: 12, weight: .bold)
        copyGiphyLinkLabel.textColor = .white
        copyGiphyLinkLabel.text = "Copy GIF Link"
        return copyGiphyLinkLabel
    }()
    
    lazy var saveToPhotosImageView: UIImageView = {
        let saveToPhotosImageView = UIImageView()
        saveToPhotosImageView.isUserInteractionEnabled = true
        saveToPhotosImageView.image = UIImage(named: "share")
        saveToPhotosImageView.tintColor = .white
        saveToPhotosImageView.translatesAutoresizingMaskIntoConstraints = false
        return saveToPhotosImageView
    }()
    
    // MARK: - UI
    
    override func setupUI() {
        backgroundColor = .black
        addSubview(closeImageView)
        addSubview(gifImageView)
        addSubview(saveToPhotosImageView)
        addSubview(copyGiphyLinkLabel)
    }
    
    override func makeConstraints() {
        NSLayoutConstraint.activate([
            closeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            closeImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            closeImageView.widthAnchor.constraint(equalToConstant: 32),
            closeImageView.heightAnchor.constraint(equalToConstant: 32),
            
            saveToPhotosImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            saveToPhotosImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            saveToPhotosImageView.widthAnchor.constraint(equalToConstant: 42),
            saveToPhotosImageView.heightAnchor.constraint(equalToConstant: 42),
            
            gifImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            gifImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            gifImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            gifImageView.bottomAnchor.constraint(equalTo: copyGiphyLinkLabel.topAnchor, constant: -10),
            
            copyGiphyLinkLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
            copyGiphyLinkLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            copyGiphyLinkLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            copyGiphyLinkLabel.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    func fill(with imageUrlString: String) {
        guard let url = URL(string: imageUrlString) else { return }
        gifImageView.kf.setImage(
            with: url,
            placeholder: nil
        )
    }
    
}
