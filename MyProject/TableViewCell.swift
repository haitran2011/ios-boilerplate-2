//
//  TableViewCell.swift
//  MyProject
//
//  Created by Ryoichi Hara on 2017/05/03.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit
import Kingfisher

final class TableViewCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: Label!
    @IBOutlet weak private var thumbnailView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.setupPropertyForNonAlphaNumeric()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Clear cached images
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: ListItem) {
        titleLabel.text = item.title
        
        let imageSize = CGSize(width: 80, height: 80)
        let resizeProcessor = ResizingImageProcessor(
            referenceSize: imageSize, mode: .aspectFill)
        let cropProcessor = CroppingImageProcessor(
            size: imageSize, anchor: CGPoint(x: 0.5, y: 0.5))
        let processor = resizeProcessor >> cropProcessor
        
        thumbnailView.kf.setImage(
            with: item.imageURL, options: [.processor(processor)])
    }
}
