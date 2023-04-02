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
    @IBOutlet weak var BlurView: UIVisualEffectView!
    
    var imageDataRequest: DataRequest?
    
    func configure(with post: Post?) {
        PostImageView.layer.cornerRadius = 9
        BlurView.layer.cornerRadius = 9
        BlurView.clipsToBounds = true
        
        if let user = post?.user {
            NameLabel.text = user.username
        }
        
        if let caption = post?.caption {
            CaptionLabel.text = caption
        }
        
        var locationAndTimeLabelText: String?
        if let locationName = post?.location {
            locationAndTimeLabelText = locationName + " · "
        }
        if let takenTime = post?.createdTime {
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            
            locationAndTimeLabelText? += timeFormatter.string(from: takenTime)
        }
        if locationAndTimeLabelText != nil {
            LocationAndTimeLabel.text = locationAndTimeLabelText
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
        
        if let currentUser = User.current, let lastPostedDate = currentUser.lastPostedDate, let postCreatedDate = post?.createdAt, let dateDifference = Calendar.current.dateComponents([.hour], from: postCreatedDate, to: lastPostedDate).hour {
            if abs(dateDifference) < 24 || post?.user == currentUser {
                BlurView.isHidden = true
            }
            else {
                BlurView.isHidden = false
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
