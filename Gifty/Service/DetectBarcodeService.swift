//
//  DetectBarcode.swift
//  Gifty
//
//  Created by jito on 8/24/23.
//

import Foundation

import UIKit
import Vision
import Photos

class DetectBarcodeService {
    var detectedBarcodes: Set<UIImage> = []
    
    func detectBarcodeInAsset(data: Data) {
        let request = VNDetectBarcodesRequest { [self] (request, error) in
            if let error = error {
                print("Error detecting barcodes: \(error)")
                return
            }
            
            self.processBarcodes(request: request, data: data)
        }
        
        let handler = VNImageRequestHandler(data: data, options: [:])
        
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform request: \(error)")
        }
    }
    
    func processBarcodes(request: VNRequest, data: Data) {
        guard let results = request.results as? [VNBarcodeObservation] else {
            return
        }
        
        for barcode in results {
            if barcode.payloadStringValue != nil, barcode.symbology == .code128 {
                print("find")
                if let image = UIImage(data: data) {
                    detectedBarcodes.insert(image)
                }
            }
        }
    }
}
