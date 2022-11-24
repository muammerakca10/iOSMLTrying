//
//  ViewController.swift
//  MLDeneme2
//
//  Created by MUAMMER AKCA on 24.11.2022.
//

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        DispatchQueue.global().async {
            results[0].itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (reading, error) in
                guard let image = reading as? UIImage, error == nil else {return}
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
                
            }
        }
        
        
        
    }
    
    
    
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
    
    
    
}

