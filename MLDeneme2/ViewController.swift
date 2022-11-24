//
//  ViewController.swift
//  MLDeneme2
//
//  Created by MUAMMER AKCA on 24.11.2022.
//

import UIKit
import Photos
import PhotosUI
import CoreML
import Vision

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gorselDegistir))
        
        imageView.addGestureRecognizer(gesture)
        
    }
    
    @objc func gorselDegistir(){
        
        
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        
        configuration.selectionLimit = 1
        configuration.filter = PHPickerFilter.images
        let vc = PHPickerViewController(configuration: configuration)
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        DispatchQueue.global().async {
            results[0].itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (reading, error) in
                guard let imageSelected = reading as? UIImage, error == nil else {return}
                
                guard let ciimage = CIImage(image: imageSelected) else {fatalError("Problem while converting to CIImage")}
                
                
                DispatchQueue.main.async {
                    self?.imageView.image = imageSelected
                }
                
            }
        }
    }
    
    func detectImage(image : CIImage){
        
        let config = MLModelConfiguration()
        
        guard let model  = try? VNCoreMLModel(for: DogCatRabbitMLTry_1.init(configuration: config).model) else {fatalError("Loading CoreML Model Failed")}
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                    fatalError("Model failde to process image")
            }
            print(results)
        }
        
        
        
    }
    
}

