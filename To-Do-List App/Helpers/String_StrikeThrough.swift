//
//  String_StrikeThrough.swift
//  To-Do-List App
//
//  Created by David on 26/12/2017.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

extension String {
    func strikeThroughText() -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}

