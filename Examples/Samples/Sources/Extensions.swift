// Copyright 2018 the FloatingPanel authors. All rights reserved. MIT license.

import UIKit

extension UIView {
    func makeBoundsLayoutGuide() -> UILayoutGuide {
        let guide = UILayoutGuide()
        addLayoutGuide(guide)
        NSLayoutConstraint.activate([
            guide.topAnchor.constraint(equalTo: topAnchor),
            guide.leftAnchor.constraint(equalTo: leftAnchor),
            guide.bottomAnchor.constraint(equalTo: bottomAnchor),
            guide.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        return guide
    }
}

protocol LayoutGuideProvider {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}
extension UILayoutGuide: LayoutGuideProvider {}

class CustomLayoutGuide: LayoutGuideProvider {
    let topAnchor: NSLayoutYAxisAnchor
    let bottomAnchor: NSLayoutYAxisAnchor
    init(topAnchor: NSLayoutYAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor) {
        self.topAnchor = topAnchor
        self.bottomAnchor = bottomAnchor
    }
}

extension UIViewController {
    var layoutInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            return UIEdgeInsets(top: topLayoutGuide.length,
                                left: 0.0,
                                bottom: bottomLayoutGuide.length,
                                right: 0.0)
        }
    }

    var layoutGuide: LayoutGuideProvider {
        if #available(iOS 11.0, *) {
            return view!.safeAreaLayoutGuide
        } else {
            return CustomLayoutGuide(topAnchor: topLayoutGuide.bottomAnchor,
                                     bottomAnchor: bottomLayoutGuide.topAnchor)
        }
    }
}
