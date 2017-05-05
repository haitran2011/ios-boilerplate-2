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
    
    private static let ThumbnailSize = CGSize(width: 80, height: 80)
    
    lazy private var imageOptions: KingfisherOptionsInfo = {
        var options: KingfisherOptionsInfo = []
        
        let resizing = ResizingImageProcessor(
            referenceSize: ThumbnailSize, mode: .aspectFill)
        let cropping = CroppingImageProcessor(
            size: ThumbnailSize, anchor: CGPoint(x: 0.5, y: 0.5))
        let imageProcessor: ImageProcessor = resizing >> cropping
        
        options.append(.processor(imageProcessor))
        
        return options
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.setupPropertyForNonAlphaNumeric()
        thumbnailView.kf.indicatorType = .activity
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
        
        thumbnailView.kf.setImage(
            with: item.imageURL, options: imageOptions)
    }
    
    func cancelTask() {
        thumbnailView.kf.cancelDownloadTask()
    }
}
