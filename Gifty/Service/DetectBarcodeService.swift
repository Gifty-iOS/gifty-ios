//
//  DetectBarcode.swift
//  Gifty
//
//  Created by jito on 8/24/23.
//

import Foundation

import UIKit
import Vision

class DetectBarcodeService {
    private var detectedBarcodes: Set<String> = []

    func detectBarcodeInImage(images: [UIImage]) {
        for image in images {
            guard let cgImage = image.cgImage else {
                return
            }
            let request = VNDetectBarcodesRequest { [weak self] (request, error) in
                if let error = error {
                    print("Error detecting barcodes: \(error)")
                    return
                }

                self?.processBarcodes(request: request, in: cgImage)
            }

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            request.revision = VNDetectBarcodesRequestRevision1

            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform request: \(error)")
            }
        }
    }

    private func processBarcodes(request: VNRequest, in cgImage: CGImage) {
        guard let results = request.results as? [VNBarcodeObservation] else {
            return
        }
        
        for barcode in results {
            if let payload = barcode.payloadStringValue {
                detectedBarcodes.insert(payload)
                print("Detected barcode with value: \(payload) and symbology: \(barcode.symbology.rawValue)")
            }
        }
        
        print("Find \(detectedBarcodes.count) barcodes")
    }
}
