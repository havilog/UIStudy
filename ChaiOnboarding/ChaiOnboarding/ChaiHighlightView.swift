//
//  ChaiHighlightView.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/11.
//

import UIKit

final class ChaiHighlightView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView: UIView? = super.hitTest(point, with: event)
        if self == hitView { return nil }
        return hitView
    }
}
