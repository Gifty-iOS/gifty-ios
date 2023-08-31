//
//  PhotoLibraryService.swift
//  Gifty
//
//  Created by jito on 8/31/23.
//

import Foundation
import Photos

class PhotoLibraryService {
    func requestPermission(completion: @escaping (Bool) -> Void) {
        let photosAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photosAuthorizationStatus {
        case .authorized:
            completion(true)
        case .denied:
            completion(false)
        case .limited:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                completion(newStatus == .authorized)
            }
            completion(false)
        case .restricted:
            completion(false)
        @unknown default:
            fatalError("권한 설정에 오류가 있습니다.")
        }
    }
    
    func getPhotoCount() -> Int {
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: .none)
        return fetchResult.count
    }
}
