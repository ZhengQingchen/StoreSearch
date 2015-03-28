//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by mac on 15/1/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit
import Haneke

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var artistNameLable: UILabel!
    @IBOutlet weak var artworkImageView:UIImageView!
    
    var downloadTask: NSURLSessionDownloadTask?

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadTask?.cancel()
        downloadTask = nil  
        
        nameLable.text = nil
        artistNameLable.text = nil
        artworkImageView.image = nil
    }
    
    
    func configureForSearchResult(searchResult:SearchResult) {
        nameLable.text = searchResult.name
        if searchResult.artistName.isEmpty {
            artistNameLable.text = "Unknow"
        }else{
            artistNameLable.text = String(format: "%@ (%@)",searchResult.artistName,searchResult.kindForDisplay())
        }
        
        artworkImageView.image = UIImage (named: "Placeholder")
        if let url = NSURL(string: searchResult.artworkURL60){
            
            artworkImageView.sd_setImageWithURL(url)
//            downloadTask = artworkImageView.loadImageWithURL(url)
//            println(artworkImageView.image?.description)
            
//            searchResult.imageView = [url:artworkImageView.image]
            
            
//            artworkImageView.hnk_setImageFromURL(url)
        }
        
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
//            placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        
        
    }
    
    }
