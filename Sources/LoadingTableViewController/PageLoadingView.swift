//
//  PageLoadingView.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

open class PageLoadingView: UIView {
        
    private let loadingIndicatorView = UIActivityIndicatorView(style: .medium)
    private let messageLabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        
        loadingIndicatorView.startAnimating()
        layoutSubview(loadingIndicatorView)
        
        messageLabel.textAlignment = .center
        layoutSubview(messageLabel)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func startLoading() {
        superview?.bringSubviewToFront(self)
        
        loadingIndicatorView.isHidden = false
        loadingIndicatorView.startAnimating()
        
        messageLabel.isHidden = true
    }
    
    func showMessage(_ msg: String) {
        superview?.bringSubviewToFront(self)
        
        loadingIndicatorView.isHidden = true
        loadingIndicatorView.stopAnimating()
        
        messageLabel.text = msg
        messageLabel.isHidden = false
    }
}
