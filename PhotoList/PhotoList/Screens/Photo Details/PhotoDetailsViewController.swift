//
//  PhotoDetailsViewController.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/29/22.
//

import UIKit
import Reusable
import SDWebImage

class PhotoDetailsViewController: UIViewController, ViewModelBased {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: PhotoDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchPhotoInfo()
    }
    
    func configureUI() {
        profileImageView.setRounded()
    }
    
    public func showPhotoInfo() {
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, placeholderImage: UIImage(named: "ImageNotAvailable"))
        nameLabel.text = viewModel.realName
        photoImageView.sd_setImage(with: viewModel.photoImageUrl, placeholderImage: UIImage(named: "ImageNotAvailable"))
        numberOfViewsLabel.text = viewModel.numberOfViews
        dateLabel.text = viewModel.date
        descriptionLabel.text = viewModel.description
    }
    
    public func fetchPhotoInfo() {
        ActivityIndicator.start(for: view)
        viewModel.fetchPhotoInfo { [weak self] result in
            switch result {
                case .success(_):
                    self?.showPhotoInfo()
                case .failure(let error):
                    self?.showAlert(message: error.description)
            }
            ActivityIndicator.stop()
        }
    }
}

extension PhotoDetailsViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.StoryboardName.photosDetailsViewController, bundle: nil)
    }
}
