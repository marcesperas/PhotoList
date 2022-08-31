//
//  PhotoTableViewCell.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/29/22.
//

import UIKit
import Reusable
import SDWebImage

class PhotoTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var userLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var headerButtonAction : (() -> ())?
    var photo: Photo? {
        didSet {
            resetValues()
            
            guard let photoUrl = photo?.photoUrl,
                  let owner = photo?.owner,
                  let profileImageUrl = photo?.profileImageUrl,
                  let title = photo?.title else {
                return
            }
            
            DispatchQueue.main.async {
                self.userProfileImageView.sd_setImage(with: profileImageUrl, placeholderImage: UIImage(named: "ProfileIcon"))
                self.userLabel.text = owner
                self.photoImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "ImageNotAvailable"))
                self.descriptionLabel.text = title
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        userProfileImageView.setRounded()
    }
    
    private func resetValues() {
        userProfileImageView.image = nil
        userLabel.text = ""
        photoImageView.image = nil
        descriptionLabel.text = ""
    }
    
    @IBAction func headerButtonAction(_ sender: UIButton) {
        headerButtonAction?()
    }
}
