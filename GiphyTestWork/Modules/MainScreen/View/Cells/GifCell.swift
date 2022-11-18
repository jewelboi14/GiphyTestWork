//
//  GifCell.swift
//  GiphyTestWork
//
//  Created by Михаил on 18.11.2022.
//

import UIKit
import Kingfisher

final class GifCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var skeletonLayerName: String {
        return "skeletonLayerName"
    }
    
    private var skeletonGradientName: String {
        return "skeletonGradientName"
    }
    
    private var gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showSkeleton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        contentView.addSubview(gifImageView)
        makeConstraints()
        showSkeleton()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            gifImageView.topAnchor.constraint(equalTo: topAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gifImageView.rightAnchor.constraint(equalTo: rightAnchor),
            gifImageView.leftAnchor.constraint(equalTo: leftAnchor),
            
        ])
    }
    
    func fill(with imageUrlString: String) {
        guard let url = URL(string: imageUrlString) else { return }
        gifImageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ],
            completionHandler: { _ in
                self.hideSkeleton()
            }
        )
    }
    
    // MARK: - Skeleton
    
    private func showSkeleton() {
        let backgroundColor = randomColor().cgColor
        
        let highlightColor = UIColor.white.cgColor
        
        let skeletonLayer = CALayer()
        skeletonLayer.backgroundColor = backgroundColor
        skeletonLayer.name = skeletonLayerName
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size = UIScreen.main.bounds.size
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.name = skeletonGradientName
        
        gifImageView.layer.mask = skeletonLayer
        gifImageView.layer.addSublayer(skeletonLayer)
        gifImageView.layer.addSublayer(gradientLayer)
        gifImageView.clipsToBounds = true
        let widht = UIScreen.main.bounds.width
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.fromValue = -widht
        animation.toValue = widht
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
    }
    
    private func hideSkeleton() {
        gifImageView.layer.sublayers?.removeAll {
            $0.name == skeletonLayerName || $0.name == skeletonGradientName
        }
    }
    
    private func randomColor() -> UIColor {
        guard let randomColor = [
            UIColor(named: "mainPurple"),
            UIColor(named: "mainPink"),
            UIColor(named: "mainGreen"),
        ].randomElement() else { return UIColor()}
        return randomColor ?? UIColor()
    }
    
}
