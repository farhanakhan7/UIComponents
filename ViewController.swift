//
//  ViewController.swift
//  Custom UIComponents
//
//  Created by Farhana Khan on 01/01/24.
//

import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var imageView: UIImageView!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureViewController()
        configureUI()
        setupDragInteraction()
        setupDropInteraction()
    }
    
    // MARK: - Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Drag & Drop Image"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI() {
        setupImageView()
        setupConstraints()
    }
    
    private func setupImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder")
        imageView.isUserInteractionEnabled = true
        
        view.addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupDragInteraction() {
        let dragInteraction = UIDragInteraction(delegate: self)
        imageView.addInteraction(dragInteraction)
    }
    
    private func setupDropInteraction() {
        let dropInteraction = UIDropInteraction(delegate: self)
        imageView.addInteraction(dropInteraction)
    }
}

// MARK: - Extension
extension ViewController: UIDragInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = imageView.image else { return [] }
        
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image
        
        return [item]
    }
}

extension ViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [UTType.image.identifier]) && session.items.count == 1
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        
        let dropLocation = session.location(in: self.view)
        let operation: UIDropOperation
        
        if imageView.frame.contains(dropLocation) {
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            operation = .cancel
        }
        
        return UIDropProposal(operation: operation)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            if let image = imageItems.first as? UIImage {
                self.imageView.image = image
            }
        }
    }
}
