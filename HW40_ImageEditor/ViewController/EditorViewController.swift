//
//  EditorViewController.swift
//  HW40_ UIImagePickerController
//
//  Created by Dawei Hao on 2023/11/27.
//

import UIKit

class EditorViewController: UIViewController {

    // In toolBar
    let editButton   = UIButton(type: .system)
    let plusButton   = UIButton(type: .system)
    let cameraButton = UIButton(type: .system)

    let resetButton = CustomButton(type: .system)

    // In navigationItem
    let cancelButton: UIButton = UIButton(type: .system)
    let doneButton:   UIButton = UIButton(type: .system)




    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        configureDoneBarButton()
        configureCancelBarButton()

    }
    // MARK: - Custom toolBar
    func configureEditButton () {
        editButton.configuration = UIButton.Configuration.plain()
        editButton.setTitle("Edit", for: .normal)
        editButton.tintColor = .systemPink
        editButton.isUserInteractionEnabled = true

        editButton.widthAnchor.constraint(equalToConstant: 0).isActive  = true
        editButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
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
        doneButton.tintColor = .systemYellow
        doneButton.layer.cornerRadius = doneButtonHeight / 2
        doneButton.clipsToBounds = true

        doneButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: doneButtonHeight).isActive = true

        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        let doneBarButton: UIBarButtonItem = UIBarButtonItem(customView: doneButton)
        self.navigationItem.rightBarButtonItem = doneBarButton
    }

    // MARK: - @objc actuon
    @objc func editButtonTapped () {
        print("editButtonTapped")

    }

    @objc func plusButtonTapped () {
        print("plusButtonTapped")

    }

    @objc func cameraButtonTapped () {
        print("plusButtonTapped")

    }

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
