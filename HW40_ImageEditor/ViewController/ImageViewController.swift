//
//  PHPickerViewController.swift
//  HW40_ UIImagePickerController
//
//  Created by Dawei Hao on 2023/11/27.
//

import UIKit
import PhotosUI
import Photos

class ImageViewController: UIViewController {

    var image: [UIImageView]!

    // imageView
    var imageView: UIImageView =  {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(systemName: "")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    } ()    

    // secondImageView
    var secondImageView: UIImageView =  {
        let secondImageView: UIImageView = UIImageView()
        secondImageView.image = UIImage(systemName: "")
        secondImageView.contentMode = .scaleAspectFit
        secondImageView.isUserInteractionEnabled = true
        return secondImageView
    } ()

    // chooseButton
    var chooseButton: UIButton = {
        let chooseButton: UIButton = UIButton(type: .system)
        chooseButton.configuration = UIButton.Configuration.tinted()
        chooseButton.setTitle("Choose Picture", for: .normal)

        return chooseButton
    } ()


    override func viewDidLoad() {
        super.viewDidLoad()



    }
    
    // MARK: - UI Setup
    func configureUI () {
        chooseButton.addTarget(self, action: #selector(chooseButtonTapped), for: .touchUpInside)
        view.addSubview(imageView)
        view.addSubview(secondImageView)
        view.addSubview(chooseButton)
    }

    @objc func chooseButtonTapped () {
        print("chooseButtonTapped")

        var configuration = PHPickerConfiguration()
        // Choose photos or videos.
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    @objc func imageViewTapped () {
        print("imageViewTapped")
    }

    @objc func secondImageViewTapped () {
        print("secondImageViewTapped")

    }

}

extension ImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
    }

}

