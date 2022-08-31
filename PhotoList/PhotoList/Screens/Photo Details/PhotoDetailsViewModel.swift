//
//  PhotoDetailsViewModel.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/29/22.
//

import Foundation

protocol PhotoDetailsViewModelProtocol {
    func fetchPhotoInfo(completion: @escaping ((Result<Void, NetworkError>) -> Void))
}

class PhotoDetailsViewModel: PhotoDetailsViewModelProtocol {
    private let dataProvider: DataProviderProtocol
    private let photo: Photo
    private var photoInfo: PhotoInfo?
    
    init(dataProvider: DataProviderProtocol = DataProvider(),
         photo: Photo) {
        self.dataProvider = dataProvider
        self.photo = photo
    }
    
    var profileImageUrl: URL? {
        return photo.profileImageUrl
    }

    var realName: String {
        return photoInfo?.owner?.realname ?? ""
    }

    var photoImageUrl: URL? {
        return photo.photoUrl
    }

    var numberOfViews: String {
        guard let views = photoInfo?.views else { return "" }
        return "\(views) Views"
    }

    var date: String {
        guard let dateString: String = photoInfo?.dates?.posted,
              let date: Date = Double(dateString)?.unixDate() else {
            return ""
        }
        return date.timeAgoDisplay()
    }
    
    var description: String {
        guard let content = photoInfo?.title?.content else { return "" }
        return content
    }
    
    func fetchPhotoInfo(completion: @escaping ((Result<Void, NetworkError>) -> Void)) {
        let request: PhotoInfoRequest = PhotoInfoRequest(photoId: photo.id,
                                                         secret: photo.secret)

        dataProvider.fetchPhotoInfo(request: request) { [weak self] result in
            switch result {
                case .success(let response):
                    self?.photoInfo = response.photoInfo
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
