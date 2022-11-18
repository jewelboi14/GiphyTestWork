//
//  MainScreenViewController.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var currentCategory: String = "Trending"
    
    private lazy var gifList: [Gif] = []
    private lazy var categories: [Category] = [
        Category(name: "Trending")
    ]
    
    private lazy var gifPaginationTotalCount = 0
    private lazy var categoryPaginationTotalCount = 0
    
    private var gifOffset = 0
    private var categoryOffset = 0
    
    private lazy var provider = MainViewProvider()
    
    private lazy var contentView = MainScreenView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        fetchTrendingGifs()
        fetchCategories()
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func configureCollectionViews() {
        contentView.gifCollectionView.delegate = self
        contentView.categoryCollectionView.delegate = self
        contentView.gifCollectionView.dataSource = self
        contentView.categoryCollectionView.dataSource = self
        contentView.gifCollectionViewLayout.delegate = self
        
        contentView.categoryCollectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: String(describing: CategoryCell.self)
        )
        
        contentView.gifCollectionView.register(
            GifCell.self,
            forCellWithReuseIdentifier: String(describing: GifCell.self)
        )
        
    }
    
    // MARK: - Get Data
    
    private func fetchTrendingGifs(needClearList: Bool = false) {
        Task {
            let result = await provider.fetchTrendingGifs(offset: gifOffset)
            switch result {
            case .success(let gifList):
                
                if needClearList {
                    self.gifList = []
                }
                self.gifPaginationTotalCount = gifList.pagination.totalCount
                self.gifList.append(contentsOf: gifList.data)
                self.contentView.gifCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCategories() {
        Task {
            let result = await provider.fetchCategories(offset: categoryOffset)
            switch result {
            case .success(let categories):
                self.categoryPaginationTotalCount = categories.pagination.totalCount
                self.categories.append(contentsOf: categories.data)
                self.contentView.categoryCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchBy(category: String, needClearList: Bool = false) {
        Task {
            let result = await provider.searchByCategory(
                offset: gifOffset,
                categoryName: category
            )
            switch result {
            case .success(let gifList):
                if needClearList {
                    self.gifList = []
                }
                self.gifList.append(contentsOf: gifList.data)
                self.contentView.gifCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension MainScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case contentView.gifCollectionView:
            navigateToDetailVC(with: gifList[indexPath.row].images.original.url)
        case contentView.categoryCollectionView:
            if indexPath.row == 0 {
                fetchTrendingGifs(needClearList: true)
                currentCategory = "Trending"
            } else {
                currentCategory = categories[indexPath.row].name
                fetchBy(category: currentCategory, needClearList: true)
            }
            gifOffset = 0
            contentView.gifCollectionView.setContentOffset(.zero, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case contentView.gifCollectionView:
            guard
                indexPath.row == gifOffset,
                gifOffset <= gifPaginationTotalCount
            else { return }
            
            gifOffset += 20
            switch currentCategory {
            case "Trending": fetchTrendingGifs()
            default: fetchBy(category: currentCategory)
            }
        case contentView.categoryCollectionView:
            guard indexPath.row == categoryOffset,
                  categoryOffset <= categoryPaginationTotalCount
            else { return }
            
            categoryOffset += 20
            fetchCategories()
        default:
            break
        }
    }
    
    private func navigateToDetailVC(with gifUrl: String) {
        let vc = DetailViewController(gifUrl: gifUrl)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case contentView.gifCollectionView:
            return gifList.count
        case contentView.categoryCollectionView:
            return categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case contentView.gifCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: GifCell.self),
                for: indexPath
            ) as? GifCell else { return UICollectionViewCell() }
            cell.fill(with: gifList[indexPath.row].images.previewGif.url)
            return cell
        case contentView.categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CategoryCell.self),
                for: indexPath
            ) as? CategoryCell else { return UICollectionViewCell() }
            cell.tag = indexPath.row
            if cell.tag == indexPath.row {
                cell.fill(with: categories[indexPath.row].name)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

// MARK: - GifCollectionViewFlowLayoutDelegate

extension MainScreenViewController: GifCollectionViewFlowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForGifAtIndexPath indexPath: IndexPath) -> CGFloat {
        let downSized = gifList[indexPath.row].images.fixedWidthDownsampled
        let width = downSized.width
        let height = downSized.height
        
        let downloadedImageWidth = CGFloat(NSString(string: width).floatValue)
        let downloadedImageHeight = CGFloat(NSString(string: height).floatValue)
        let collectionViewHalfWidth = (collectionView.bounds.width / 2)
        let ratio = collectionViewHalfWidth / CGFloat(downloadedImageWidth)
        
        return downloadedImageHeight * ratio
    }
}
