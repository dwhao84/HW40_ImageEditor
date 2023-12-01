//
//  WhateverViewController.swift
//  HW40_ImageEditor
//
//  Created by Dawei Hao on 2023/12/1.
//

import UIKit

class WhateverViewController: UIViewController {

    var trashButton: UIBarButtonItem = UIBarButtonItem()
    var loveButton: UIButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        configureUIButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.setToolbarHidden(false, animated: animated)
    }

    func createBarButtonItem(image: UIImage?, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "", image: image, target: self, action: action)
        }

    func configureUIButton() {

        view.backgroundColor = .white

        let toolBarFixedSpaceWidth: CGFloat = 88
        let toolBarFixedSpaceView = UIView(frame: CGRect(x: 0, y: 0, width: toolBarFixedSpaceWidth, height: 1))
        let toolBarFixedSpaceItem = UIBarButtonItem(customView: toolBarFixedSpaceView)

        self.navigationController?.toolbar.isHidden = false
        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.toolbar.tintColor = .systemPink

        let trashButton = createBarButtonItem(image: PhotoViewController.trashButtonImage, action: #selector(tappedTrashButton))

        loveButton.setImage(PhotoViewController.loveButtonImage, for: .normal)
        loveButton.addTarget(self, action: #selector(tappedTrashButton), for: .touchUpInside)

        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.toolbar.isHidden = false

        self.toolbarItems = [trashButton, toolBarFixedSpaceItem, UIBarButtonItem(customView: loveButton) ]
    }

    @objc func tappedTrashButton () {

        let alertController = UIAlertController(title: "", message: "This photo will be deleted from iCloud Photos on your devices. It will be in Recently Deleted for 30 days.", preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                   // Handle the delete action
                   print("Item deleted")
               }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alertController.addAction(deleteAction)
               alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    @objc func deleteActionSheetTapped (_ sender: UIAlertAction) {
        print("Delete actionSheet tapped ")
    }



}
