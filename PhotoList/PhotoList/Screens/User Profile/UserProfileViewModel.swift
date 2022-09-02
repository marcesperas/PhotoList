//
//  UserProfileViewModel.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import Foundation

protocol UserProfileViewModelProtocol {
    func fetchUserData(completion: @escaping (Result<Void, NetworkError>) -> Void)
}

class UserProfileViewModel: UserProfileViewModelProtocol {
    private let provider: DataProviderProtocol
    private let photo: Photo
    private var userProfile: Profile?
    private var userPhotos: UserPhotos?
    
    init(provider: DataProviderProtocol = DataProvider(),
         photo: Photo) {
        self.provider = provider
        self.photo = photo
    }
    
    var profileImageUrl: URL? {
        return photo.profileImageUrl
    }
    
    var coverPhotoUrl: URL? {
        return photo.coverPhotoUrl
    }
    
    var fullname: String {
        guard let firstName = userProfile?.firstName,
              let lastName = userProfile?.lastName,
              !firstName.isEmpty,
              !lastName.isEmpty else {
            return ""
        }
        return "\(firstName) \(lastName)"
    }
    
    var navBarTitle: String {
        guard !fullname.isEmpty else {
            return "Profile"
        }
        return fullname
    }
    
    var location: String {
        guard let city = userProfile?.city,
              let country = userProfile?.country,
              city != "",
              country != "" else {
            return "Unspecified"
        }
        return "Leaves in \(city), \(country)"
    }
    
    var joinedDate: String {
        guard let joinedDateString = userProfile?.joinDate,
              let joinedDate: Date = Double(joinedDateString)?.unixDate() else {
            return "Unspecified"
        }
        
        return "Joined \(joinedDate.timeAgoDisplay())"
    }
    
    var uploadedPhotos: String {
        guard let uploadedPhotos = userPhotos?.total else { return "" }
        return "\(uploadedPhotos.toDecimalString()) uploaded photos"
    }
    
    func numberOfItems(in section: Int) -> Int {
        return userPhotos?.photoList.count ?? 0
    }
    
    func userPhoto(at index: Int) -> Photo? {
        return userPhotos?.photoList[index]
    }
    
    func fetchUserData(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let dispatchGroup = DispatchGroup()
        let userProfileRequest: UserProfileRequest = UserProfileRequest(userId: photo.owner)
        let userPhotoRequest: UserPhotoRequest = UserPhotoRequest(userId: photo.owner)
        var networkError: NetworkError?
        
        dispatchGroup.enter()
        provider.fetchUserProfile(request: userProfileRequest) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self?.userProfile = response.profile
                    case .failure(let error):
                        networkError = error
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        provider.fetchUserPhoto(request: userPhotoRequest) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self?.userPhotos = response.userPhotos
                    case .failure(let error):
                        networkError = error
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let networkError = networkError {
                completion(.failure(networkError))
            }
            
            completion(.success(()))
        }
    }
}
