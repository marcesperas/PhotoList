//
//  UserProfileTableViewCell.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import UIKit
import Reusable

class UserProfileTableViewCell: UITableViewCell, NibReusable{
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var userPhoto: UserPhoto? {
        didSet {
            resetValues()
            
            guard let photoUrl = userPhoto?.userPhotoUrl,
                  let description = userPhoto?.title else {
                return
            }
            
            DispatchQueue.main.async {
                self.photoImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "ImageNotAvailable"))
                self.descriptionLabel.text = description
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func resetValues() {
        photoImageView.image = nil
        descriptionLabel.text = ""
    }
}
