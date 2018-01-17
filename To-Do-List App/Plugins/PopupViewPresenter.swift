//
//  PopupViewPresenter.swift
//  To-Do-List App
//
//  Created by David on 15/01/2018.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation
import UIKit

class PopUpViewPresenter {
    
    var popUpView: UIView
    let blackView = UIView()
    let popUpViewHeight: CGFloat
    let popUpViewWidth: CGFloat

    init(viewToPresent: UIView, withHeight height: CGFloat, withWidth width: CGFloat) {
        popUpView = viewToPresent
        popUpViewHeight = height
        popUpViewWidth = width
        setupPopUpView()
    }
    
    private func setupPopUpView() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(popUpView)
            
            popUpView.heightAnchor.constraint(equalToConstant: popUpViewHeight).isActive = true
            popUpView.widthAnchor.constraint(equalToConstant: popUpViewWidth).isActive = true
            popUpView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            popUpView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            
            blackView.frame = window.frame
            blackView.alpha = 0
            popUpView.alpha = 0
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackView.alpha = 1
                self.popUpView.alpha = 1
            }, completion: { [weak self] (success) in
                if success {
                    self?.setupObservers()
                }
            })
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDismiss), name: Constants.NotificationNames.cancelPopover, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 0
            self.popUpView.alpha = 0
        }) { (completed) in
            if completed {
                self.blackView.removeFromSuperview()
                self.popUpView.removeFromSuperview()
            }
            self.removeObserver()
        }
    }
    
}
