//
//  PhotoLibraryService.swift
//  Gifty
//
//  Created by jito on 8/31/23.
//

import UIKit
import Photos
import Jito

class PhotoLibraryService {
    func createPhotoLibraryRequestAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "사진 앨범 접근 권한 필요", message: "이 기능을 사용하기 위해선 사진 앨범 접근이 필요합니다.", preferredStyle: .alert)
        
        let allowAction = UIAlertAction(title: "설정으로", style: .default) { _ in
            let appSettings = #unwrap(URL(string: UIApplication.openSettingsURLString), message: "appSetting 경로가 잘못 되었습니다.")
            if !UIApplication.shared.canOpenURL(appSettings) {
                fatalError("열수 없는 링크입니다.")
            }
            
            UIApplication.shared.open(appSettings)
        }
        
        let denyAction = UIAlertAction(title: "닫기", style: .cancel) { _ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(allowAction)
        alertController.addAction(denyAction)
        
        return alertController
    }
    
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
