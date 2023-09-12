//
//  MainViewModel.swift
//  Gifty
//
//  Created by 주동석 on 2023/09/11.
//

import UIKit
import Algorithms

actor ProgressTracker {
    private var _count: Int = 0
    private var _total: Int
    
    init(total: Int) {
        self._total = total
    }
    
    func increment() async {
        _count += 1
    }
    
    var progressPercentage: Double {
        return Double(_count) / Double(_total) * 100.0
    }
}

class MainViewModel {
    private let photoLibraryService = PhotoLibraryService()
    private let detectBarcodeService = DetectBarcodeService()
    
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
    
    func getBarcodeImageCount() -> Int {
        return detectBarcodeService.detectedBarcodes.count
    }
    
    func fetchPhotoImages() async -> Set<UIImage> {
        let photoAssets = photoLibraryService.getPhotoAssets()
        
        let chunkSize = 8
        let chunks = photoAssets.chunks(ofCount: chunkSize)
        let progressTracker = ProgressTracker(total: photoAssets.count)

        for chunk in chunks {
            await withTaskGroup(of: Void.self) { group in
                for asset in chunk {
                    group.addTask { [self] in
                        let image = photoLibraryService.photoAssetToUIImage(photoAsset: asset)
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                            await updateProgress(using: progressTracker)
                            return
                        }
                        
                        detectBarcodeService.detectBarcodeInAsset(data: imageData)
                        await updateProgress(using: progressTracker)
                    }
                }
            }
        }
        
        
        print("바코드 찾기 끝")
        return detectBarcodeService.detectedBarcodes
    }
    
    
    func updateProgress(using tracker: ProgressTracker) async {
        await tracker.increment()
        let progress = await tracker.progressPercentage
        print("진행률: \(progress)%")
    }
}
