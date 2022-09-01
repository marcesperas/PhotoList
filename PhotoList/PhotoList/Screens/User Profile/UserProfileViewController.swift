//
//  UserProfileViewController.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import UIKit
import Reusable

protocol UserProfileViewControllerProtocol {
    func goToPhotoDetailsViewController(with viewModel: PhotoDetailsViewModel)
}

class UserProfileViewController: UIViewController, ViewModelBased {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UserProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        hidesBackButton()
        fetchUserData()
    }
    
    private func loadUI() {
        title = viewModel.fullname.isEmpty ? "Profile" : viewModel.fullname
    }
    
    private func configureTableView() {
        tableView.register(headerFooterViewType: UserProfileTableHeaderView.self)
        tableView.register(cellType: UserProfileTableViewCell.self)
    }
    
    private func fetchUserData() {
        ActivityIndicator.start(for: view)
        viewModel.fetchUserData { [weak self] result in
            switch result {
                case .success():
                    self?.configureTableView()
                    self?.loadUI()
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showAlert(message: error.description)
            }
            ActivityIndicator.stop()
        }
    }
}

// MARK: UITableViewDataSource
extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserProfileTableViewCell = self.tableView.dequeueReusableCell(for: indexPath)
        
        cell.userPhoto = viewModel.userPhoto(at: indexPath.row)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tableHeaderView = tableView.dequeueReusableHeaderFooterView(UserProfileTableHeaderView.self) else {
            return nil
        }
        
        tableHeaderView.profileImageUrl = viewModel.profileImageUrl
        tableHeaderView.coverPhotoUrl = viewModel.coverPhotoUrl
        tableHeaderView.fullname = viewModel.fullname
        tableHeaderView.location = viewModel.location
        tableHeaderView.joinedDate = viewModel.joinedDate
        tableHeaderView.uploadedPhotos = viewModel.uploadedPhotos
        
        return tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo: Photo = viewModel.userPhoto(at: indexPath.row) else { return }
        let viewModel: PhotoDetailsViewModel = PhotoDetailsViewModel(photo: photo)
        goToPhotoDetailsViewController(with: viewModel)
    }
}

// MARK: - StoryboardSceneBased
extension UserProfileViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.StoryboardName.userProfileViewController,bundle: nil)
    }
}

extension UserProfileViewController: UserProfileViewControllerProtocol {
    func goToPhotoDetailsViewController(with viewModel: PhotoDetailsViewModel) {
        let viewController = PhotoDetailsViewController.instantiate(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
