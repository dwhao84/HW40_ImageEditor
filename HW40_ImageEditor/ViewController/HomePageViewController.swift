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


    let selectImageButton = UIButton(type: .system)
    let titleLabel = UILabel()

    var imageViews: [UIImageView] = []

    let stackView = UIStackView()

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
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationController?.toolbar.isTranslucent = false
    }

    func configureStackView () {
        let spacing: CGFloat = 30.0
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = spacing
        stackView.distribution = .equalSpacing
        stackView.alignment = .center

        stackView.addArrangedSubview(selectImageButton)
        stackView.addArrangedSubview(titleLabel)

        configureselectImageButton()
        configureTitleLabel()

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 260)
        ])
    }

    func configureselectImageButton () {
        selectImageButton.configuration = UIButton.Configuration.plain()
        selectImageButton.setImage(UIImage(systemName: "plus.square.dashed"), for: .normal)
        selectImageButton.setPreferredSymbolConfiguration(.init(pointSize: 100), forImageIn: .normal)
        selectImageButton.tintColor = UIColor.systemPink
        selectImageButton.widthAnchor.constraint(equalToConstant:  145).isActive = true
        selectImageButton.heightAnchor.constraint(equalToConstant: 130).isActive = true

        // addTarget
        selectImageButton.addTarget(self, action: #selector(selectImageButtonTapped), for: .touchUpInside)
    }

    func configureTitleLabel () {
        titleLabel.text = "Click the + Button"
        titleLabel.font = UIFont.systemFont(ofSize: 20.0)
        titleLabel.textColor = .systemPink
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        titleLabel.widthAnchor.constraint(equalToConstant: 175).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }


    // MARK: - Action

    // selectImageButton
    @objc func selectImageButtonTapped (_ sender: UIButton) {

        print("selectImageButtonTapped")

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
