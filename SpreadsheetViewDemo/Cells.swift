//
//  Cells.swift
//  SpreadsheetView
//
//  Created by Kishikawa Katsumi on 5/18/17.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import SpreadsheetView

@objc public class HeaderCell: Cell {
    @objc public let label = UILabel()
    @objc public let sortArrow = UILabel()

    override public var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 4, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        contentView.addSubview(label)

        sortArrow.text = ""
        sortArrow.font = UIFont.boldSystemFont(ofSize: 14)
        sortArrow.textAlignment = .center
        contentView.addSubview(sortArrow)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        sortArrow.sizeToFit()
        sortArrow.frame.origin.x = frame.width - sortArrow.frame.width - 8
        sortArrow.frame.origin.y = (frame.height - sortArrow.frame.height) / 2
    }
}

@objc public class TextCell: Cell {
    @objc public let label = UILabel()

    override public var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 4, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.2)
        selectedBackgroundView = backgroundView

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center

        contentView.addSubview(label)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
