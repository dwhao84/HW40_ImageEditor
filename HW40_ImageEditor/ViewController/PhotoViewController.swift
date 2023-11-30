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

    let shareButton: UIBarButtonItem = UIBarButtonItem ()
    let loveButton:  UIBarButtonItem = UIBarButtonItem ()
    let infoButton:  UIBarButtonItem = UIBarButtonItem ()
    let trashButton: UIBarButtonItem = UIBarButtonItem ()

    // In NavigationBar
    let editButton: UIBarButtonItem = UIBarButtonItem()
    let menuButton: UIButton = CustomButton(type: .system)

    let fixedSpaceWidth: CGFloat = 5


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

        let fixedSpaceView = UIView(frame: CGRect(x: 0, y: 0, width: fixedSpaceWidth, height: 1))
        let fixedSpaceItem = UIBarButtonItem(customView: fixedSpaceView)

        let menuBarButton = UIBarButtonItem(customView: menuButton)

        self.navigationItem.rightBarButtonItems = [ menuBarButton, fixedSpaceItem, editButton]

        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.compactAppearance = appearance
    }

    @objc func editButtonTapped (_ sender: UIBarButtonItem) {
        print("editButtonTapped")
        let editorVC = EditorViewController()
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
    // MARK: - Tab Controller



        func createBarButtonItem(image: UIImage?, action: Selector) -> UIBarButtonItem {
            return UIBarButtonItem(title: "", image: image, target: self, action: action)
        }

    func configureToolBarButton () {

        let shareButton = createBarButtonItem(image: PhotoViewController.shareButtonImage, action: #selector(shareButtonTapped))
        let loveButton = createBarButtonItem(image: PhotoViewController.loveButtonImage, action: #selector(loveButtonTapped))
        let infoButton = createBarButtonItem(image: PhotoViewController.infoButtonImage, action: #selector(infoButtonTapped))
        let trashButton = createBarButtonItem(image: PhotoViewController.trashButtonImage, action: #selector(trashButtonTapped))

        let toolBarFixedSpaceWidth: CGFloat = 85
        let toolBarFixedSpaceView = UIView(frame: CGRect(x: 0, y: 0, width: toolBarFixedSpaceWidth, height: 1))
        let toolBarFixedSpaceItem = UIBarButtonItem(customView: toolBarFixedSpaceView)

        self.navigationController?.toolbar.isHidden = false
        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.toolbar.tintColor = .systemPink

        let toolbarAppearance = UIToolbarAppearance()
        self.navigationController?.toolbar.compactScrollEdgeAppearance = toolbarAppearance

        self.toolbarItems = [shareButton, toolBarFixedSpaceItem, loveButton, toolBarFixedSpaceItem,  infoButton, toolBarFixedSpaceItem, trashButton]
    }

    @objc func shareButtonTapped (_ sender: UIBarButtonItem) {
        print("shareButtonTapped")
        let activityController = UIActivityViewController(activityItems: [""], applicationActivities: nil)
        self.present(activityController, animated: true)
    }

    @objc func loveButtonTapped (_ sender: UIButton) {
        print("loveButtonTapped")

    }

    @objc func infoButtonTapped (_ sender: UIButton) {
        print("infoButtonTapped")

    }

    @objc func trashButtonTapped (_ sender: UIButton) {
        print("trashButtonTapped")

    }




}

