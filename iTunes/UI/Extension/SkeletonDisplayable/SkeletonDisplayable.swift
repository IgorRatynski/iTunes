//
//  SkeletonDisplayable.swift
//  iTunes
//
//  Created by Igor Ratynski on 12.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

protocol SkeletonDisplayable {
  func showSkeleton()
  func hideSkeleton()
}

extension SkeletonDisplayable where Self: UIViewController {
  
  var skeletonLayerName: String {
    "skeletonLayerName"
  }
  
  var skeletonGradientName: String {
    "skeletonGradientName"
  }
  
  func showSkeleton() {
    let skeletons = skeletonViews(in: view)
    let backgroundColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0).cgColor
    let highlightColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
    
    let skeletonLayer = CALayer()
    skeletonLayer.backgroundColor = backgroundColor
    skeletonLayer.name = skeletonLayerName
    skeletonLayer.anchorPoint = .zero
    skeletonLayer.frame.size = UIScreen.main.bounds.size
    
    skeletons.forEach {
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
      gradientLayer.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height - 150)//UIScreen.main.bounds
//      gradientLayer.frame = UIScreen.main.bounds
      gradientLayer.name = skeletonGradientName
      
      $0.layer.mask = skeletonLayer
      $0.layer.addSublayer(skeletonLayer)
      $0.layer.addSublayer(gradientLayer)
      $0.clipsToBounds = true
      let widht = UIScreen.main.bounds.width// * 2
      
      let animation = CABasicAnimation(keyPath: "transform.translation.x")
      animation.duration = 1
      animation.fromValue = -widht * 0.25
      animation.toValue = 0 // widht
      animation.repeatCount = .infinity
      animation.autoreverses = true
      animation.fillMode = CAMediaTimingFillMode.forwards
      
      gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
    }
  }
  
  func hideSkeleton() {
    skeletonViews(in: view).forEach {
      $0.layer.sublayers?.removeAll {
        $0.name == skeletonLayerName || $0.name == skeletonGradientName
      }
    }
  }
}

private extension SkeletonDisplayable where Self: UIViewController {
  func skeletonViews(in view: UIView) -> [UIView] {
    var results: [UIView] = []
    for subview in view.subviews as [UIView] {
      switch subview {
        case _ where subview.isKind(of: UILabel.self):
          results += [subview]
        case _ where subview.isKind(of: UIImageView.self):
          results += [subview]
        case _ where subview.isKind(of: UIButton.self):
          results += [subview]
        default: results += skeletonViews(in: subview)
      }
      
    }
    return results
  }
}
