//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by mac on 15/1/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var artistNameLable: UILabel!
    @IBOutlet weak var artworkImageView:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let selectedView = UIView(frame: CGRect.zeroRect)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
