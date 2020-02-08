//
//  customThumbSlider.swift
//  ReadSpeed
//
//  Created by MA on 2020/1/21.
//  Copyright © 2020 mfk. All rights reserved.
//

import UIKit

@IBDesignable
class customThumbSlider: UISlider {

    var thumbTextLabel: UILabel = UILabel()

    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        thumbTextLabel.frame = thumbFrame
        thumbTextLabel.text = (Int(value * 100)).description
        thumbTextLabel.adjustsFontSizeToFitWidth = true
        thumbTextLabel.textColor = #colorLiteral(red: 0.6106091142, green: 0.7569375634, blue: 0.3590224385, alpha: 1)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
    }

}
