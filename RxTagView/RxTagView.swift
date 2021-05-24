//
//  RxTagView.swift
//  RxTagView
//
//  Created by Michael Eid on 5/23/21.
//

import UIKit
import Combine

class RxTagsView: UIView {

    // MARK: - Properties

    struct RxTagConfiguration {
        let spacing: CGFloat
        let leftMargin: CGFloat
        let topMargin: CGFloat

        static let `default` = Self(spacing: 10, leftMargin: 5, topMargin: 5)
    }

    private var numberOfLines = 1

    private var tagHeight: Double = 0

    private var configuration: RxTagConfiguration = .default
    
    private var buttonTags: [RxTagButton] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    var tags: [String]? {
        didSet {
            setupTags()
        }
    }
    
    var estimatedHeight: Double = .zero
    
    var tagPressed: ((String?) -> Void)?

    // MARK: - Public functions
    
    func setupTagButtons() {
        guard let tags = tags else {
            return
        }
        subviews.forEach({ $0.removeFromSuperview() })

        buttonTags = tags.map { RxTagButton(title: $0) }
        
        buttonTags.forEach {
            $0.publisher()
                .sink { [weak self] in
                    self?.tagPressed?($0.titleLabel?.text)
                }.store(in: &subscriptions)
        }
    }
    
    init(configuration: RxTagConfiguration = .default) {
        self.configuration = configuration
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTags() {
        setupTagButtons()
        
        setNeedsLayout()
        layoutIfNeeded()

        var lastPosition: CGPoint = .init(x: configuration.leftMargin, y: configuration.topMargin)
        numberOfLines = 1
        buttonTags.forEach {
            let tagSize = $0.intrinsicContentSize
            tagHeight = Double(tagSize.height)
            if lastPosition.x > configuration.leftMargin && lastPosition.x + tagSize.width > frame.width {
                lastPosition.x = configuration.leftMargin
                lastPosition.y += tagSize.height + configuration.spacing
                    numberOfLines += 1
            }
            $0.frame = CGRect(origin: lastPosition, size: tagSize)
            lastPosition.x += tagSize.width + configuration.spacing
            addSubview($0)
        }
        let height = Double(numberOfLines) * (tagHeight + Double(configuration.spacing))
        frame.size = CGSize(width: Double(frame.width), height: height)
        invalidateIntrinsicContentSize()

    }

    override var intrinsicContentSize: CGSize {
        let height = Double(numberOfLines) * (tagHeight + Double(configuration.spacing))
        return CGSize(width: Double(frame.width), height: height)
    }
}
