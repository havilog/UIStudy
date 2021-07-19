//
//  ChaiTimerProgressView.swift
//  ChaiOnboarding
//
//  Created by 한상진 on 2021/07/19.
//

import UIKit

final class ChaiTimerProgressView: UIView {
    
    private var circleLayer: CAShapeLayer = .init()
    private var progressLayer: CAShapeLayer = .init()
    private var startPoint: CGFloat = CGFloat(-Double.pi / 2)
    private var endPoint: CGFloat = CGFloat(3 * Double.pi / 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createCircularPath() {
        let circularPath = UIBezierPath(
            arcCenter: .init(
                x: frame.size.width,
                y: frame.size.height
            ),
            radius: 40,
            startAngle: startPoint,
            endAngle: endPoint,
            clockwise: true
        )
        circleLayer.do {
            $0.path = circularPath.cgPath
            $0.fillColor = UIColor.clear.cgColor
            $0.lineCap = .round
            $0.lineWidth = 20.0
            $0.strokeColor = UIColor.white.cgColor
            $0.strokeEnd = 1.0
        }
        
        layer.addSublayer(circleLayer)
        
        progressLayer.do {
            $0.path = circularPath.cgPath
            $0.fillColor = UIColor.clear.cgColor
            $0.lineCap = .round
            $0.lineWidth = 10.0
            $0.strokeColor = UIColor.green.cgColor
            $0.strokeEnd = 0
        }
        
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let circularAnimation: CABasicAnimation = .init(keyPath: "strokeEnd")
        
        circularAnimation.do {
            $0.duration = duration
            $0.toValue = 1
            $0.fillMode = .forwards
            $0.isRemovedOnCompletion = false
        }
        
        progressLayer.add(circularAnimation, forKey: "circularAnimation")
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ChaiTimerProgressViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    func makeUIView(context: Context) -> UIView {
        ChaiTimerProgressView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
@available(iOS 13.0, *)
struct ChaiTimerProgressViewPreview: PreviewProvider {
    typealias Previews = ChaiTimerProgressViewRepresentable
    static var previews: Previews {
        return ChaiTimerProgressViewRepresentable()
    }
}
#endif
