//
//  UserProfileTableHeaderView.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import UIKit
import Reusable
import SDWebImage

class UserProfileTableHeaderView: UITableViewHeaderFooterView, NibReusable {
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var uploadedPhotosLabel: UILabel!
    
    var coverPhotoUrl: URL? {
        didSet {
            guard let coverPhotoUrl = coverPhotoUrl else {
                return
            }
            DispatchQueue.main.async {
                self.backgroundImageView.sd_setImage(with: coverPhotoUrl, placeholderImage: UIImage(named: "ImageNotAvailable"))
            }
        }
    }
    
    var profileImageUrl: URL? {
        didSet {
            guard let profileImageUrl = profileImageUrl else {
                return
            }
            DispatchQueue.main.async {
                self.profileImageView.sd_setImage(with: profileImageUrl, placeholderImage: UIImage(named: "ProfileIcon"))
            }
        }
    }
    
    var fullname: String? {
        didSet {
            guard let fullname = fullname else {
                return
            }
            nameLabel.text = fullname
        }
    }
    
    var location: String? {
        didSet {
            guard let location = location else {
                return
            }
            countryLabel.text = location
        }
    }
    
    var joinedDate: String? {
        didSet {
            guard let joinedDate = joinedDate else {
                return
            }
            dateLabel.text = joinedDate
        }
    }
    
    var uploadedPhotos: String? {
        didSet {
            guard let uploadedPhotos = uploadedPhotos else {
                return
            }
            uploadedPhotosLabel.text = uploadedPhotos
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        profileImageView.setRounded()
    }
}
