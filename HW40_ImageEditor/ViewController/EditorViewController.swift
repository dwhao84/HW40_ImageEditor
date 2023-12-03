//
//  EditorViewController.swift
//  HW40_ UIImagePickerController
//
//  Created by Dawei Hao on 2023/11/27.
//

import UIKit

class EditorViewController: UIViewController {

    static let adjustImage  = UIImage(systemName: "dial.low.fill")
    static let filtersImage = UIImage(systemName: "camera.filters")
    static let cropImage    = UIImage(systemName: "crop.rotate")


    // In toolBar
    let adjustButton:  UIButton  = UIButton(type: .system)
    let filtersButton: UIButton  = UIButton(type: .system)
    let cropButton:    UIButton  = UIButton(type: .system)

    let resetButton = CustomButton(type: .system)

    // In navigationItem
    let cancelButton: UIButton = UIButton(type: .system)
    let doneButton:   UIButton = UIButton(type: .system)

    let backButton:     UIButton = UIButton(type: .system)
    let forwardButton:  UIButton = UIButton(type: .system)
    let redEyeButton:   UIButton = UIButton(type: .system)
    let markupButton:   UIButton = UIButton(type: .system)
    let optionButton:   UIButton = UIButton(type: .system)

    // ADJUST or rest of status.
    let statusLabel:    UILabel  = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        configureadjustButton()
        configureFiltersButton()
        configureCropButton()
        configureToolbar()


        configureDoneBarButton()
        configureCancelBarButton()

    }
    // MARK: - Custom toolBar
    func configureadjustButton () {
        adjustButton.configuration = UIButton.Configuration.plain()
        adjustButton.setTitle("Adjust", for: .normal)
        adjustButton.tintColor = .systemPink
        adjustButton.isUserInteractionEnabled = true

//        adjustButton.widthAnchor.constraint(equalToConstant: 50).isActive  = true
//        adjustButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        adjustButton.addTarget(self, action: #selector(adjustButtonTapped), for: .touchUpInside)
    }

    func configureFiltersButton () {
        filtersButton.configuration = UIButton.Configuration.plain()
        filtersButton.setTitle("Filters", for: .normal)
        filtersButton.setImage(EditorViewController.filtersImage, for: .normal)
        filtersButton.tintColor = .lightGray
        filtersButton.isUserInteractionEnabled = true

//        filtersButton.widthAnchor.constraint(equalToConstant: 50).isActive  = true
//        filtersButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        filtersButton.addTarget(self, action: #selector(filtersButtonTapped), for: .touchUpInside)
    }

    func configureCropButton () {
        cropButton.configuration = UIButton.Configuration.plain()
        cropButton.setTitle("Crop", for: .normal)
        cropButton.setImage(EditorViewController.cropImage, for: .normal)
        cropButton.tintColor = .lightGray
        cropButton.isUserInteractionEnabled = true

//        cropButton.widthAnchor.constraint(equalToConstant: 50).isActive  = true
//        cropButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        cropButton.addTarget(self, action: #selector(cropButtonTapped), for: .touchUpInside)
    }

    func configureToolbar () {

        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.toolbar.barTintColor = .clear
        let toolbarAppearance = UIToolbarAppearance()
        self.navigationController?.toolbar.standardAppearance = toolbarAppearance

        let flexibleSpaceItem: UIBarButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
        let fixedSpaceItem: UIBarButtonItem = UIBarButtonItem(systemItem: .fixedSpace)

        let adjustBarButton: UIBarButtonItem  = UIBarButtonItem(customView: adjustButton)
        let flitersBarButton: UIBarButtonItem = UIBarButtonItem(customView: filtersButton)
        let cropBarButton: UIBarButtonItem    = UIBarButtonItem(customView: cropButton)

        self.toolbarItems = [
            flexibleSpaceItem, adjustBarButton, fixedSpaceItem, flitersBarButton, fixedSpaceItem, cropBarButton, flexibleSpaceItem
        ]
    }


    // MARK: - Custom NavigationItem
    // cancelButton
    func configureCancelBarButton () {
        let cancelButtonHeight: CGFloat = 25
        let configuration = UIButton.Configuration.filled()
        cancelButton.configuration = configuration

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        let attributedText = NSAttributedString(string: "Cancel", attributes: attributes)
        cancelButton.setAttributedTitle(attributedText, for: .normal)

        cancelButton.isEnabled = false
        cancelButton.tintColor = .lightGray
        cancelButton.layer.cornerRadius = cancelButtonHeight / 2
        cancelButton.clipsToBounds = true

        cancelButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: cancelButtonHeight).isActive = true

        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        let cancelBarButton: UIBarButtonItem = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.leftBarButtonItem = cancelBarButton
    }

    // doneButton
    func configureDoneBarButton () {
        let doneButtonHeight: CGFloat = 25

        let configuration = UIButton.Configuration.filled()
        doneButton.configuration = configuration
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        let attributedText = NSAttributedString(string: "Done", attributes: attributes)
        doneButton.setAttributedTitle(attributedText, for: .normal)

        doneButton.isEnabled = false
//        doneButton.isUserInteractionEnabled = false
        doneButton.tintColor = .systemYellow
        doneButton.layer.cornerRadius = doneButtonHeight / 2
        doneButton.clipsToBounds = true

        doneButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: doneButtonHeight).isActive = true

        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        let doneBarButton: UIBarButtonItem = UIBarButtonItem(customView: doneButton)
        self.navigationItem.rightBarButtonItem = doneBarButton
    }

    // MARK: - toolBar @objc function.
    @objc func adjustButtonTapped () {
        print("adjustButtonTapped")

    }

    @objc func filtersButtonTapped () {
        print("FiltersButtonTapped")

    }

    @objc func cropButtonTapped () {
        print("FiltersButtonTapped")

    }

    // MARK: - navigationItem's @objc function.
    @objc func doneButtonTapped (_ sender: UIButton) {
        print("doneButtonTapped")
    }

    @objc func cancelButtonTapped (_ sender: UIButton) {
        print("cancelButtonTapped")

        let alertController = UIAlertController(title: "", message: "Are you sure you want to discard all the changes?", preferredStyle: .actionSheet)
        let discardChangesAction = UIAlertAction(title: "Discard Changes", style: .destructive) { action in
            // Put my action here.
               print("Discard Changes") }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alertController.addAction(discardChangesAction)
               alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }


}
