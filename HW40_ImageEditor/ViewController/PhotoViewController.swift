//
//  PhotoViewController.swift
//  HW40_ImageEditor
//
//  Created by Dawei Hao on 2023/11/30.
//

import UIKit

class PhotoViewController: UIViewController {

    static let shareButtonImage  = UIImage(systemName: "square.and.arrow.up")
    static let loveButtonImage   = UIImage(systemName: "heart")
    static let infoButtonImage   = UIImage(systemName: "info.circle")
    static let trashButtonImage  = UIImage(systemName: "trash")
    static let editTitle: String = "Edit"

    let shareButton: UIButton = UIButton(type: .system)
    let loveButton:  UIButton = UIButton(type: .system)
    let infoButton:  UIButton = UIButton(type: .system)
    let trashButton: UIButton = UIButton(type: .system)

    // In NavigationBar
    let editButton: UIBarButtonItem = UIBarButtonItem()
    let menuButton: UIButton = CustomButton(type: .system)

    let flexibleSpaceItem = UIBarButtonItem(systemItem: .flexibleSpace)


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        // navigation bar
        configureMenuButton()
        configureEditButton()

        // toolBar
        configureToolBarButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.setToolbarHidden(false, animated: animated)
    }

    // MARK: - Custom NavigationBar

    // #1 editButton
    func configureEditButton () {
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonTapped))
        let menuBarButton  = UIBarButtonItem(customView: menuButton)
        self.navigationItem.rightBarButtonItems = [ menuBarButton, flexibleSpaceItem, editButton]
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.compactAppearance = appearance
    }

    @objc func editButtonTapped (_ sender: UIBarButtonItem) {
        print("editButtonTapped")
        let editorVC = EditorViewController()
        editorVC.modalPresentationStyle = .fullScreen
        present(editorVC, animated: true)
    }

    // #2 menuButton
    func configureMenuButton () {
        menuButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        menuButton.isEnabled = true
        menuButton.isUserInteractionEnabled = true
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)

        menuButton.showsMenuAsPrimaryAction = true
        menuButton.menu = UIMenu(children: [
            // Section #1
            // #1
            UIAction(title: "Copy",
                     image: UIImage(systemName: "doc.on.doc"),
                     handler: { action in print("Copy") }),
            // #2
            UIAction(title: "Duplicate",
                     image: UIImage(systemName: "plus"),
                     handler: { action in print("Duplicate") }),
            // #3
            UIAction(title: "Hide",
                     image: UIImage(systemName: "eye.slash"),
                     handler: { action in print("Hide") }),
            // #4
            UIAction(title: "Slideshow",
                     image: UIImage(systemName: "play.rectangle"),
                     handler: { action in print("Slideshow") }),
            // Section #2
            UIMenu(options: .displayInline, children: [

            // #5
            UIAction(title: "Add to Album",
                     image: UIImage(systemName: "rectangle.stack.badge.plus"),
                     handler: { action in print("Add to Album") })
            ]),
            // Section #3
            UIMenu(options: .displayInline,
                   children: [
            // #6
            UIAction(title: "Adjust Location",
                     image: UIImage(systemName: "mappin.circle"),
                     handler: { action in print("Adjust Location") }),
            // #7
            UIAction(title: "Adjust Data & Time",
                     image: UIImage(systemName: "calendar.badge.plus"),
                     handler: { action in print("Adjust Data & Time") })
             ])
        ])

    }

    @objc func menuButtonTapped (_ sender: UIButton) {
        print("menuButtonTapped")
        configureMenuButton()
    }
    // MARK: - Custom ToolBar

    func configureToolBarButton () {

        shareButton.setImage(PhotoViewController.shareButtonImage, for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)

        infoButton.setImage(PhotoViewController.infoButtonImage, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)

        loveButton.setImage(PhotoViewController.loveButtonImage, for: .normal)
        loveButton.addTarget(self, action: #selector(loveButtonTapped), for: .touchUpInside)

        trashButton.setImage(PhotoViewController.trashButtonImage, for: .normal)
        trashButton.addTarget(self, action: #selector(tappedTrashButton), for: .touchUpInside)

        self.navigationController?.toolbar.isHidden = false
        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.toolbar.tintColor = .systemPink

        let toolbarAppearance = UIToolbarAppearance()
        self.navigationController?.toolbar.scrollEdgeAppearance = toolbarAppearance

        let shareBarButton: UIBarButtonItem = UIBarButtonItem(customView: shareButton)
        let loveBarButton : UIBarButtonItem = UIBarButtonItem(customView: loveButton)
        let inforBarButton: UIBarButtonItem = UIBarButtonItem(customView: infoButton)
        let trashBarButton: UIBarButtonItem = UIBarButtonItem(customView: trashButton)

        self.toolbarItems = [shareBarButton, flexibleSpaceItem,
                             loveBarButton,  flexibleSpaceItem,
                             inforBarButton, flexibleSpaceItem, trashBarButton]
    }

    @objc func shareButtonTapped (_ sender: UIBarButtonItem) {
        print("shareButtonTapped")
//        let activityController = UIActivityViewController(activityItems: [""], applicationActivities: nil)
//        self.present(activityController, animated: true)
    }

    @objc func loveButtonTapped () {
        print("loveButtonTapped")

    }

    @objc func infoButtonTapped () {
        print("infoButtonTapped")

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

