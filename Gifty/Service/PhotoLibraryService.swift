//
//  PhotoLibraryService.swift
//  Gifty
//
//  Created by jito on 8/31/23.
//

import UIKit
import Photos

class PhotoLibraryService {
    func createPhotoLibraryRequestAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "사진 앨범 접근 권한 필요", message: "이 기능을 사용하기 위해선 모든 사진에 대한 접근이 필요합니다.", preferredStyle: .alert)
        
        let allowAction = UIAlertAction(title: "설정으로", style: .default) { _ in
            guard let appSettings = URL(string: UIApplication.openSettingsURLString) else {
                return print("appSetting 경로가 잘못 되었습니다.")
            }
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
    
    func requestPermission() async -> Bool {
        let photosAuthorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch photosAuthorizationStatus {
        case .authorized:
            return true
        case .denied:
            return false
        case .limited:
            return false
        case .notDetermined:
            let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            return status == .authorized
        case .restricted:
            return false
        @unknown default:
            fatalError("권한 설정에 오류가 있습니다.")
        }
    }
    
    func getPhotoCount() -> Int {
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: .none)
        return fetchResult.count
    }
}
