//
//  PhotoListViewController.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/27/22.
//

import UIKit
import Reusable

protocol PhotoListViewControllerProtocol {
    func goToUserViewController(with viewModel: UserProfileViewModel)
    func goToPhotoDetailsViewController(with viewModel: PhotoDetailsViewModel)
}

class PhotoListViewController: UIViewController, ViewModelBased {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController: UISearchController = UISearchController()
    
    var viewModel: PhotoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesBackButton()
        configureSearchController()
        configureTableView()
        fetchRecentPhotos()
    }
    
    private func configureSearchController() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureTableView() {
        tableView.register(cellType: PhotoTableViewCell.self)
    }
    
    private func fetchRecentPhotos() {
        ActivityIndicator.start(for: view)
        viewModel.fetchRecentPhotos { [weak self] result in
            switch result {
                case .success():
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(message: error.description)
                    }
            }
            ActivityIndicator.stop()
        }
    }
    
    private func fetchSearchPhotos() {
        ActivityIndicator.start(for: view)
        viewModel.fetchSearchPhotos { [weak self] result in
            switch result {
                case .success():
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(message: error.description)
                    }
            }
            ActivityIndicator.stop()
        }
    }
}

// MARK: UISearchBarDelegate
extension PhotoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchSearchPhotos()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchBar.text
    }
}

// MARK: UITableViewDataSource
extension PhotoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PhotoTableViewCell = self.tableView.dequeueReusableCell(for: indexPath)
        cell.photo = viewModel.photo(at: indexPath.row)
        
        cell.headerButtonAction = {
            let viewModel: UserProfileViewModel = UserProfileViewModel(photo: self.viewModel.photo(at: indexPath.row))
            self.goToUserViewController(with: viewModel)
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension PhotoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo: Photo = viewModel.photo(at: indexPath.row)
        let viewModel: PhotoDetailsViewModel = PhotoDetailsViewModel(photo: photo)
        goToPhotoDetailsViewController(with: viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 423
    }
}

// MARK: - StoryboardSceneBased
extension PhotoListViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: Constants.StoryboardName.photoListViewController,bundle: nil)
    }
}

// MARK: - Navigation
extension PhotoListViewController: PhotoListViewControllerProtocol {
    func goToUserViewController(with viewModel: UserProfileViewModel) {
        let viewController = UserProfileViewController.instantiate(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToPhotoDetailsViewController(with viewModel: PhotoDetailsViewModel) {
        let viewController = PhotoDetailsViewController.instantiate(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
