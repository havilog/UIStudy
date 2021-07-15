//
//  HVDropDownView.swift
//  HVDropDown
//
//  Created by 한상진 on 2021/07/13.
//

import UIKit

public final class HVDropDownView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct VCRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    func makeUIView(context: Context) -> UIView {
        HVDropDownView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
@available(iOS 13.0, *)
struct VCPreview: PreviewProvider {
    typealias Previews = VCRepresentable
    static var previews: Previews {
        return VCRepresentable()
    }
}
#endif

