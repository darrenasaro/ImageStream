//
//  SwipeViewController.swift
//  ImageStream
//
//  Created by Darren Asaro on 8/20/19.
//  Copyright © 2019 Darren Asaro. All rights reserved.
//

import UIKit

/// Allows an injected UIViewController to be dismissed with a swipe.
class SwipeViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear

        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .clear
        setupScrollView()
        setupViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        scrollView.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 2*scrollView.frame.height)
        scrollView.contentOffset = CGPoint(x: 0, y: scrollView.frame.height)
    }
    
    private func setupViewController() {
        add(viewController, to: scrollView)
        viewController.view.backgroundColor = ThemeManager.shared.currentTheme.colorTheme.light
        viewController.view.frame = scrollView.bounds
        viewController.view.frame.origin.y = scrollView.frame.height
        viewController.view.layoutIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeContextBeneathVisible()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollUp()
    }
    
    func scrollUp() {
        scrollView.contentOffset = CGPoint.zero
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.y = self.scrollView.frame.height
        }
    }
    
    func scrollDown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.contentOffset.y = 0
        }) { (completed) in
            self.dismiss()
        }
    }
    
    private func dismiss() {
        viewController.remove()
        dismiss(animated: false, completion: nil)
    }
}

extension SwipeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page: Int = Int(scrollView.contentOffset.y/scrollView.frame.size.height)
        if page == 0 {
            dismiss()
        }
    }
}

extension SwipeViewController {
    func makeContextBeneathVisible() {
        for view in UIApplication.shared.keyWindow!.subviews {
            if view.isKind(of: NSClassFromString("UITransitionView")!) {
                view.backgroundColor = nil
            }
        }
    }
}
