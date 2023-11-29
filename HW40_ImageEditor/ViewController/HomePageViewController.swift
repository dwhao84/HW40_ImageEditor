//
//  PHPickerViewController.swift
//  HW40_ UIImagePickerController
//
//  Created by Dawei Hao on 2023/11/27.
//

import UIKit
import PhotosUI
import Photos

class HomePageViewController: UIViewController {


    let chooseButton = UIButton(type: .system)
    let secondImageView = UIImageView()

    let stackView = UIStackView()

    var imageViews: [UIImageView]!

    let navigationTitle: String = "Home Page"

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Into imageVC")


        customNavigationBar ()
        configureStackView()
    }
    
    // MARK: - Setup UI

    func customNavigationBar () {
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationController?.toolbar.isTranslucent = false
    }

    func configureStackView () {
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.alignment = .center

        stackView.addArrangedSubview(secondImageView)
        stackView.addArrangedSubview(chooseButton)

        configureChooseButton()
        configureSecondImageView()

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 260)
        ])
    }

    func configureChooseButton () {
        chooseButton.configuration = UIButton.Configuration.plain()
        chooseButton.setTitle("Choose image", for: .normal)
        chooseButton.tintColor = UIColor.systemPink
        chooseButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        chooseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // addTarget
        chooseButton.addTarget(self, action: #selector(chooseButtonTapped), for: .touchUpInside)
    }

    func configureSecondImageView () {
        secondImageView.image = UIImage(systemName: "plus.square.dashed")
        secondImageView.contentMode = .scaleAspectFit
        secondImageView.isUserInteractionEnabled = true
        secondImageView.tintColor = UIColor.systemPink
        secondImageView.widthAnchor.constraint(equalToConstant: 260).isActive  = true
        secondImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
        // Show PHPickerVC
        present(picker, animated: true)
    }
}

extension HomePageViewController: PHPickerViewControllerDelegate {
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
