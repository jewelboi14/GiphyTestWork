//
//  MainScreenView.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation
import UIKit

final class MainScreenView: BaseView {
    
    // MARK: - Properties
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var gifCollectionViewLayout = GifCollectionViewFlowLayout()
    
    lazy var gifCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: gifCollectionViewLayout
        )
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - UI
    
    override func setupUI() {
        backgroundColor = .black
        addSubview(categoryCollectionView)
        addSubview(gifCollectionView)
    }
    
    override func makeConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 60),
            categoryCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            categoryCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            
            gifCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            gifCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            gifCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            gifCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
