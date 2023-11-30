//
//  Button+Extensions.swift
//  HW40_ImageEditor
//
//  Created by Dawei Hao on 2023/11/29.
//

import Foundation
import UIKit

class custombutton: UIButton {
    override var isHighlighted : Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1
        }
    }
}
