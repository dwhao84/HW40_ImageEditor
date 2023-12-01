//
//  EditorViewController.swift
//  HW40_ UIImagePickerController
//
//  Created by Dawei Hao on 2023/11/27.
//

import UIKit

class EditorViewController: UIViewController {

    let editButton   = UIButton(type: .system)
    let plusButton   = UIButton(type: .system)
    let cameraButton = UIButton(type: .system)

    let resetButton = CustomButton(type: .system)


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

    }
    
    func configureEditButton () {
        editButton.configuration = UIButton.Configuration.plain()
        editButton.setTitle("Edit", for: .normal)
        editButton.tintColor = .systemPink
        editButton.isUserInteractionEnabled = true

        editButton.widthAnchor.constraint(equalToConstant: 0).isActive  = true
        editButton.heightAnchor.constraint(equalToConstant: 0).isActive = true

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }


    @objc func editButtonTapped () {

        print("editButtonTapped")

    }    

    @objc func plusButtonTapped () {

        print("plusButtonTapped")

    }

    @objc func cameraButtonTapped () {

        print("plusButtonTapped")

    }



}
