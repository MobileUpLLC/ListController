//
//  PaginationControl.swift
//  ListController
//
//  Created by Nikolai Timonin on 08.04.2021.
//

import UIKit

public struct PagingConfig {
    
    // MARK: - Public properties
    
    let isRetryEnabled: Bool
    
    let requestTriggerHeight: CGFloat
    let retryTriggerHeight: CGFloat
    
    let loadingHeight: CGFloat
    
    let isDisableOnEndItems: Bool
    
    static let `default` = Self(
        isRetryEnabled: true,
        requestTriggerHeight: 100,
        retryTriggerHeight: 100,
        loadingHeight: 60,
        isDisableOnEndItems: true
    )
}

// MARK: - PagingAdapterDelegate

protocol PagingAdapterDelegate: AnyObject {
    
    func pagingAdapterDidRequest(_ adapter: PagingAdapter)
    func pagingAdapterDidRetry(_ adapter: PagingAdapter)
}

// MARK: - PaginationAdapter

open class PagingAdapter {
    
    private enum State {
        
        // not visible for user
        case waiting
        
        // visible for user and loading
        case loading
        
        // visible for user and messaging
        case message
        
        var isLoading: Bool { self == .loading }
    }
    
    // MARK: - Public properties
    
    weak var delegate: PagingAdapterDelegate?
    
    let config: PagingConfig
    
    var isEnabled: Bool {
        get { pageLoadingView.isHidden == false }
        set {
            if newValue == true && pageLoadingView.isHidden {
                enable()
            } else if newValue == false && pageLoadingView.isHidden == false {
                disable()
            }
        }
    }
    
    // MARK: - Private properties
    
    private var state: State = .waiting
    
    private var isRetryEnabled: Bool { config.isRetryEnabled }
    private var containerHeight: CGFloat { config.loadingHeight }
    private var requestTriggerHeight: CGFloat { config.requestTriggerHeight }
    private var retryTriggerHeight: CGFloat { config.retryTriggerHeight }
    
    private var isReadyToRequest: Bool = false
    private var isReadyToRetry: Bool = false
    
    private let pageLoadingView = PageLoadingView()
    
    private var scrollView: UIScrollView
    private var scrollViewSuperView: UIView
    
    // MARK: - Public methods
    
    init(scrollView: UIScrollView, superView: UIView, config: PagingConfig) {
        self.scrollView = scrollView
        self.scrollViewSuperView = superView
        self.config = config
        
        setupPageLoadingView()
    }

    func updateOnScroll() {
        guard isEnabled else { return }
        
        // Positive if content over scroll bottom line.
        // Negative if content fully visible.
        let bottomVerticalContentOffset = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height)
        
        
        // Loading view Layout
        let loadingViewHeight = abs(min(0, bottomVerticalContentOffset))
        pageLoadingView.findConstraint(type: .height)?.constant = loadingViewHeight
        
        
        // Request
        if bottomVerticalContentOffset > requestTriggerHeight {
            isReadyToRequest = true
        }
        
        if isReadyToRequest, bottomVerticalContentOffset < requestTriggerHeight {
            if state.isLoading == false {
                isReadyToRequest = false
                
                state = .loading
                pageLoadingView.startLoading()
                
                delegate?.pagingAdapterDidRequest(self)
            }
        }
        
        // Retry
        if isRetryEnabled {
            if -bottomVerticalContentOffset < retryTriggerHeight {
                isReadyToRetry = true
            }
            
            if isReadyToRetry, -bottomVerticalContentOffset > retryTriggerHeight {
                if state.isLoading == false {
                    isReadyToRetry = false
                    
                    state = .loading
                    pageLoadingView.startLoading()
                    
                    delegate?.pagingAdapterDidRetry(self)
                }
            }
        }
    }
    
    /// Should be called after table view updates
    func startWaiting() {
        state = .waiting
        updateOnScroll()
    }
    
    func showMessage(_ msg: String) {
        state = .message
        pageLoadingView.showMessage(msg)
    }
    
    // MARK: - Private methods
    
    private func setupPageLoadingView() {
        scrollViewSuperView.layoutSubview(
            pageLoadingView,
            with: .insets(top: nil, left: 0, bottom: 0, right: 0)
        )
        pageLoadingView.layoutSize(height: containerHeight)
        
        pageLoadingView.isHidden = true
    }
    
    private func disable() {
        scrollView.contentInset.bottom -= containerHeight
        pageLoadingView.isHidden = true
    }
    
    private func enable() {
        scrollView.contentInset.bottom += containerHeight
        pageLoadingView.isHidden = false
    }
}
