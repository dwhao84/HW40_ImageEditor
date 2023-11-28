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

    let chooseButton = UIButton(type: .system)
    let secondImageView = UIImageView()
    
    var imageViews: [UIImageView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Into imageVC")

        configureSubview()

        configureChooseButton()
    }
    
    // MARK: - Setup UI
    func configureSubview () {

        // addTarget
        chooseButton.addTarget(self, action: #selector(chooseButtonTapped), for: .touchUpInside)

        view.backgroundColor = .white

        self.view.addSubview(secondImageView)
        self.view.addSubview(chooseButton)
    }



    func configureChooseButton () {
        chooseButton.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints for chooseButton
        NSLayoutConstraint.activate([
            chooseButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            chooseButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            chooseButton.widthAnchor.constraint(equalToConstant: 200),
            chooseButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        chooseButton.configuration = UIButton.Configuration.filled()
        chooseButton.setTitle("Choose Picture", for: .normal)
    }

    func configureSecondImageView () {
        secondImageView.translatesAutoresizingMaskIntoConstraints = false

        // Constraints for secondImageView
        NSLayoutConstraint.activate([
            secondImageView.widthAnchor.constraint(equalToConstant: 260),
            secondImageView.heightAnchor.constraint(equalToConstant: 200),
            secondImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            secondImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        secondImageView.image = UIImage(systemName: "photo.badge.plus.fill")
        secondImageView.contentMode = .scaleAspectFit
        secondImageView.isUserInteractionEnabled = true
    }

    // MARK: - Action

    // chooseButton
    @objc func chooseButtonTapped (_ sender: UIButton) {
        print("chooseButtonTapped")

        var configuration = PHPickerConfiguration()
        // Choose photos or videos.
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    // imageView
    @objc func imageViewTapped (_ sender: UIImageView) {
        print("imageViewTapped")
        var configuration = PHPickerConfiguration()
        // Choose photos or videos.
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    // secondImageView tapped
    @objc func secondImageViewTapped (_ sender: UIImageView) {
        print("secondImageViewTapped")
        var configuration = PHPickerConfiguration()
        // Choose photos or videos.
        configuration.filter = .images
        // Name
        let picker = PHPickerViewController(configuration: configuration)
        // Call PHPickerVC delegate itself.
        picker.delegate = self
        // Show pickerVC
        present(picker, animated: true)
    }

}

extension ImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true)
        let itemProviders = results.map(\.itemProvider)
        for (i, itemProvider) in itemProviders.enumerated() where itemProvider.canLoadObject(ofClass: UIImage.self) {

            let previousImage = self.imageViews[0].image
            itemProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.imageViews[i].image == previousImage else { return }
                    self.imageViews[i].image = image
                }
            }
        }
    }
}
