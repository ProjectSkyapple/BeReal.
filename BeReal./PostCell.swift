//
//  PostCell.swift
//  BeReal.
//
//  Created by Aaron Jacob on 3/28/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var LocationAndTimeLabel: UILabel!
    @IBOutlet weak var PostImageView: UIImageView!
    @IBOutlet weak var CaptionLabel: UILabel!
    
    var imageDataRequest: DataRequest?
    
    func configure(with post: Post?) {
        PostImageView.layer.cornerRadius = 9
        
        if let user = post?.user {
            NameLabel.text = user.username
        }
        
        if let caption = post?.caption {
            CaptionLabel.text = caption
        }

        // Image
        if let imageFile = post?.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.PostImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset image view image.
        PostImageView.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }
    
}
