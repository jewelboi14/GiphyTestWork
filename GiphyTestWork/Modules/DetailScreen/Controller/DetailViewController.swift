//
//  DetailViewController.swift
//  GiphyTestWork
//
//  Created by Михаил on 18.11.2022.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var contentView = DetailView()
    
    private var gifUrl: String
    
    // MARK: - Lifecycle
    
    init(gifUrl: String) {
        self.gifUrl = gifUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRecognizers()
        configureContentView()
    }
    
    override func loadView() {
        view = contentView
    }
    
    // MARK: - Configure
    
    private func configureContentView() {
        contentView.fill(with: gifUrl)
    }
    
    private func configureRecognizers() {
        let closeImageViewGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCloseImageView)
        )
        contentView.closeImageView.addGestureRecognizer(closeImageViewGestureRecognizer)
        
        let saveToPhotosImageViewGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapShareButton(_:))
        )
        contentView.saveToPhotosImageView.addGestureRecognizer(saveToPhotosImageViewGestureRecognizer)
        
        let copyGifLinkGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCopyLink)
        )
        
        contentView.copyGiphyLinkLabel.addGestureRecognizer(copyGifLinkGestureRecognizer)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapCloseImageView() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapCopyLink() {
        UIPasteboard.general.string = gifUrl
        contentView.copyGiphyLinkLabel.text = "Copied!"
    }
    
    @objc
    private func didTapShareButton(_ sender: UIView) {
        
        let image : UIImage = contentView.gifImageView.image ?? UIImage()
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
}
