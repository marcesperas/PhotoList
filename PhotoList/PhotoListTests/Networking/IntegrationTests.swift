//
//  IntegrationTests.swift
//  PhotoListTests
//
//  Created by Marc Jardine Esperas on 8/27/22.
//

import XCTest
@testable import PhotoList

class IntegrationTests: XCTestCase {
    var sut: DataProvider!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = DataProvider()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }

    func testfetchRecentPhotos_ReturnsSuccess() {
        let request: PhotoRequest = PhotoRequest()
        
        let expectation = self.expectation(description: "fetchRecentPhotos Service")
        
        sut.fetchRecentPhotos(request: request) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.stat, "ok")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func testFetchSearchPhotos_ReturnsSuccess() {
        let request: PhotoRequest = PhotoRequest(method: .search, searchText: "dog")
        
        let expectation = self.expectation(description: "searchPhotos Service")
        
        sut.fetchSearchPhotos(request: request) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.stat, "ok")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func testFetchPhotoInfo_ReturnsSuccess() {
        let request: PhotoInfoRequest = PhotoInfoRequest(photoId: "52320031942", secret: "5a0773bcb3")
        
        let expectation = self.expectation(description: "fetchPhotoInfo Service")
        
        sut.fetchPhotoInfo(request: request) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.stat, "ok")
                XCTAssertEqual(response.photoInfo.id, "52320031942")
                XCTAssertEqual(response.photoInfo.owner?.realname, "James Miller")
                XCTAssertEqual(response.photoInfo.title?.content, "Toys")
                XCTAssertEqual(response.photoInfo.photoDescription?.content, "")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func testFetchUserProfile_ReturnsSuccess() {
        let request: UserProfileRequest = UserProfileRequest(userId: "186254592@N07")
        
        let expectation = self.expectation(description: "fetchUserProfile Service")
        
        sut.fetchUserProfile(request: request) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.stat, "ok")
                XCTAssertEqual(response.profile.firstName, "Aleksandra")
                XCTAssertEqual(response.profile.lastName, "Chmiel")
                XCTAssertEqual(response.profile.occupation, "Photographer")
                XCTAssertEqual(response.profile.country, "Poland")
                XCTAssertEqual(response.profile.city, "Czestochowa")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func testFetchUserPhoto_ReturnsSuccess() {
        let request: UserPhotoRequest = UserPhotoRequest(userId: "186254592@N07")
        
        let expectation = self.expectation(description: "fetchUserPhoto Service")
        
        sut.fetchUserPhoto(request: request) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.stat, "ok")
                XCTAssertEqual(response.userPhotos.total, 35)
                XCTAssertEqual(response.userPhotos.photoList[0].owner, "186254592@N07")
                XCTAssertEqual(response.userPhotos.photoList[0].secret, "666fdc5583")
                XCTAssertEqual(response.userPhotos.photoList[0].server, "65535")
                XCTAssertEqual(response.userPhotos.photoList[0].farm, 66)
                XCTAssertEqual(response.userPhotos.photoList[0].title, "My Siberian girl")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
}
