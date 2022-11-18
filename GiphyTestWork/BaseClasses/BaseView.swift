//
//  BaseView.swift
//  GiphyTestWork
//
//  Created by Михаил on 17.11.2022.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    func setupUI() { }
    
    func makeConstraints() { }
}
