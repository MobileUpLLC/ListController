//
//  PaginationControl.swift
//  ListController
//
//  Created by Nikolai Timonin on 08.04.2021.
//

import UIKit

public struct PagingConfig {
        
    let isRetryEnabled: Bool
    
    let requestTriggerHeight: CGFloat
    let retryTriggerHeight: CGFloat
    
    let loadingHeight: CGFloat
    
    let isDisableOnEndItems: Bool
    
    public static let `default` = Self(
        isRetryEnabled: true,
        requestTriggerHeight: 100,
        retryTriggerHeight: 100,
        loadingHeight: 60,
        isDisableOnEndItems: true
    )
    
    public init(
        isRetryEnabled: Bool,
        requestTriggerHeight: CGFloat,
        retryTriggerHeight: CGFloat,
        loadingHeight: CGFloat,
        isDisableOnEndItems: Bool
    ) {
        self.isRetryEnabled = isRetryEnabled
        self.requestTriggerHeight = requestTriggerHeight
        self.retryTriggerHeight = retryTriggerHeight
        self.loadingHeight = loadingHeight
        self.isDisableOnEndItems = isDisableOnEndItems
    }
}

public protocol PagingAdapterDelegate: AnyObject {
    
    func pagingAdapterDidRequest(_ adapter: PagingAdapter)
    func pagingAdapterDidRetry(_ adapter: PagingAdapter)
}

open class PagingAdapter {
    
    private enum State {
        
        // Just hidden.
        case hidden
        
        // Not hidden but flutten by table bottom offset. Will be visible for user only on .loading state.
        case waiting
        
        // Visible for user on negative table bottom offset and animating loading.
        case loading
        
        // Visible for user on negative table bottom offset and messaging
        case message
        
        var isLoading: Bool { self == .loading }
    }
        
    public weak var delegate: PagingAdapterDelegate?
    
    public let config: PagingConfig
    
    public var isEnabled = false {
        didSet {
            if isEnabled && oldValue == false {
                enable()
            } else if isEnabled == false && oldValue == true {
                disable()
            }
        }
    }
        
    private var state: State = .hidden
    
    private var isRetryEnabled: Bool { config.isRetryEnabled }
    private var containerHeight: CGFloat { config.loadingHeight }
    private var requestTriggerHeight: CGFloat { config.requestTriggerHeight }
    private var retryTriggerHeight: CGFloat { config.retryTriggerHeight }
    
    private var isReadyToRequest = false
    private var isReadyToRetry = false
    
    private let pageLoadingView = PageLoadingView()
    
    private var scrollView: UIScrollView
    private var scrollViewSuperView: UIView
        
    public init(scrollView: UIScrollView, superView: UIView, config: PagingConfig) {
        self.scrollView = scrollView
        self.scrollViewSuperView = superView
        self.config = config
        
        setupPageLoadingView()
    }

    open func updateOnScrollPosition() {
        guard isEnabled else {
            return
        }
        
        // Positive if content over scroll bottom line.
        // Negative if content fully visible.
        // swiftlint:disable line_length
        let bottomVerticalContentOffset = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height)
        // swiftlint:enable line_length
        
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
                
                startLoading()
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
                    
                    startLoading()
                    delegate?.pagingAdapterDidRetry(self)
                }
            }
        }
    }
    
    open func hide() {
        guard isEnabled else {
            return
        }
        
        state = .hidden
        pageLoadingView.isHidden = true
    }

    /// Should be called after table view updates
    open func startWaiting() {
        guard isEnabled else {
            return
        }
        
        state = .waiting
        pageLoadingView.isHidden = false
        updateOnScrollPosition()
    }
    
    /// Should be called on paging error
    open func showMessage(_ msg: String) {
        guard isEnabled else {
            return
        }
        
        state = .message
        pageLoadingView.isHidden = false
        pageLoadingView.showMessage(msg)
    }
        
    private func startLoading() {
        guard isEnabled else {
            return
        }
        
        state = .loading
        pageLoadingView.isHidden = false
        pageLoadingView.startLoading()
    }
    
    private func setupPageLoadingView() {
        scrollViewSuperView.layoutSubview(
            pageLoadingView,
            with: .insets(top: nil, left: 0, bottom: 0, right: 0),
            safe: true
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
