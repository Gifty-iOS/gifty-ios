//
//  MainViewModel.swift
//  Gifty
//
//  Created by 주동석 on 2023/09/11.
//

import UIKit

class MainViewModel {
    private let photoLibraryService = PhotoLibraryService()
    @Published var photoCount = 0
    
    init(photoCount: Int = 0) {
        self.photoCount = photoCount
    }
    
    func setPermission() async -> UIAlertController? {
        let status = await photoLibraryService.requestPermission()
        self.photoCount = photoLibraryService.getPhotoCount()

        if (!status) {
            return photoLibraryService.createPhotoLibraryRequestAlert()
        }
        return nil
    }
}
