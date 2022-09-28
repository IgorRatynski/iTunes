//
//  UIImage+Resize.swift
//  iTunes
//
//  Created by Igor Ratynski on 07.09.2022.
//  Copyright © 2022 Igor Ratynski. All rights reserved.
//

import UIKit

extension UIImage {
  func resizeImage(to size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}
