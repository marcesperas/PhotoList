//
//  PhotoListViewModel.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/29/22.
//

import Foundation

protocol PhotoListViewModelProtocol {
    func fetchRecentPhotos(completion: @escaping ((Result<Void, NetworkError>) -> Void))
    func fetchSearchPhotos(completion: @escaping ((Result<Void, NetworkError>) -> Void))
}

class PhotoListViewModel: PhotoListViewModelProtocol {
    private let provider: DataProviderProtocol
    private var photoList: [Photo] = []
    
    var searchText: String?
    
    init(provider: DataProviderProtocol = DataProvider()) {
        self.provider = provider
    }
    
    func numberOfItems(in section: Int) -> Int {
        return photoList.count
    }
    
    func photo(at index: Int) -> Photo {
        return photoList[index]
    }
    
    func fetchRecentPhotos(completion: @escaping ((Result<Void, NetworkError>) -> Void)) {
        let request = PhotoRequest()
        provider.fetchRecentPhotos(request: request) { [weak self] result in
            switch result {
                case .success(let response):
                    self?.photoList.removeAll()
                    self?.photoList = response.photos.photo
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchSearchPhotos(completion: @escaping ((Result<Void, NetworkError>) -> Void)) {
        guard let searchText = self.searchText else {
            return
        }
        
        let request = PhotoRequest(method: .search, searchText: searchText)
        provider.fetchSearchPhotos(request: request) { [weak self] result in
            switch result {
                case .success(let response):
                    self?.photoList.removeAll()
                    self?.photoList = response.photos.photo
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
