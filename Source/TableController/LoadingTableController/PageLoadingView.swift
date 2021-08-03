//
//  PageLoadingView.swift
//  ListController
//
//  Created by Nikolai Timonin on 26.04.2021.
//

import UIKit

// MARK: - PageLoadingView

public class PageLoadingView: UIView {
    
    // MARK: - Private properties
    
    private let loadingIndicatorView = UIActivityIndicatorView(style: .medium)
    private let messageLabel = UILabel()
    
    // MARK: - Override methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        
        loadingIndicatorView.startAnimating()
        layoutSubview(loadingIndicatorView)
        
        messageLabel.textAlignment = .center
        layoutSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
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
