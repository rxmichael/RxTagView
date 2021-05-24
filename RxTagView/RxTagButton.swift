//
//  RxTagButton.swift
//  RxTagView
//
//  Created by Michael Eid on 5/23/21.
//

import UIKit

class RxTagButton: UIButton {

    override var intrinsicContentSize: CGSize {
           let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
           return CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
    }

    init(title: String, insets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 16.0, bottom: 10.0, right: 16.0)) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        titleEdgeInsets = insets
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.size.height / 2
    }
}
