//
//  infoContainerView.swift
//  To-Do-List App
//
//  Created by David on 23/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit

protocol InfoContainerViewDelegate: class {
    func didTapOnCreateNewItem()
}

class InfoContainerView: UIView {
    
    weak var delegate: InfoContainerViewDelegate?
    
    lazy var addButton: PlusButton = {
        let but = PlusButton(type: UIButtonType.system)
        but.addTarget(self, action: #selector(createNewItem), for: .touchUpInside)
        return but
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    @objc private func createNewItem() {
        if let delegate = self.delegate {
            delegate.didTapOnCreateNewItem()
        }
    }
    
    private func setupUI() {
        
        addSubview(addButton)
        
        addButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 10, width: 50, height: 50)
        addButton.anchorCenterYToSuperview()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
