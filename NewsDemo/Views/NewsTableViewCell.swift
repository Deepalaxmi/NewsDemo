//
//  NewsTableViewCell.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var dateLineLabel: UILabel!
    @IBOutlet weak var newsImageView: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        configure(cellViewModel: nil)
    }
    
    func configure(cellViewModel: NewsItemViewModel?){
        if let cellViewModel = cellViewModel{
            self.headlineLabel.text = cellViewModel.HeadLine
            
            let dateFormatter = DateFormatter()
            let dateFormat = "MMM dd, yyyy, hh.mma"
            dateFormatter.dateFormat = dateFormat
            let dateStr = String(cellViewModel.DateLine.dropLast(3))
            let date = dateFormatter.date(from: dateStr)
            let timeAgo = date?.getElapsedInterval()
            if let time = timeAgo {
                self.dateLineLabel.isHidden = false
                self.dateLineLabel.text = time
                
            }else{
                self.dateLineLabel.isHidden = true
            }
            if let thumbnailImageUrl = cellViewModel.Image?.Thumb {
                newsImageView.isHidden = false
                newsImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl, newsItemId: cellViewModel.NewsItemId)
            }else{
                newsImageView.isHidden = true
            }

        }else{
            self.newsImageView.image = nil
            self.headlineLabel.text = nil
            self.dateLineLabel.text = nil
        }
    }
}
