//
//  UIView+Extensions.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

struct AnchorPadding {
    let top: CGFloat
    let bottom: CGFloat
    let left: CGFloat
    let right: CGFloat
}

extension AnchorPadding {
    static var zero: AnchorPadding {
        AnchorPadding(top: 0, bottom: 0, left: 0, right: 0)
    }
}

extension UIView {
    func fixInView(_ container: UIView, anchorPadding: AnchorPadding = AnchorPadding.zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.bounds
        container.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: anchorPadding.top),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: anchorPadding.bottom),
            leftAnchor.constraint(equalTo: container.leftAnchor, constant: anchorPadding.left),
            rightAnchor.constraint(equalTo: container.rightAnchor, constant: anchorPadding.right)
        ])
    }
}
