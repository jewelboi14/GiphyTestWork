//
//  GifCollectionViewFlowLayout.swift
//  GiphyTestWork
//
//  Created by Михаил on 18.11.2022.
//

import Foundation
import UIKit

protocol GifCollectionViewFlowLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForGifAtIndexPath indexPath: IndexPath
    ) -> CGFloat
}

final class GifCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    
    private let distance: CGFloat = 2
    private let numberOfColumns: Int = 2
    private var contentHeight: CGFloat = 0
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    weak var delegate: GifCollectionViewFlowLayoutDelegate?
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - Lifecycle
    
    override func prepare() {
        
        guard let collectionView = collectionView else { return }
        
        cache.removeAll()
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let gifHeight = delegate?.collectionView(
                collectionView,
                heightForGifAtIndexPath: indexPath
            ) ?? 180
            
            let frame = CGRect(
                x: xOffset[column],
                y: yOffset[column],
                width: columnWidth,
                height: gifHeight
            )
            
            let insetFrame = frame.insetBy(dx: distance, dy: distance)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = frame.maxY
            yOffset[column] = yOffset[column] + gifHeight
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        // Если фрейм ячейки пересекается с видимой областью, то отобразить ячейку
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
}
