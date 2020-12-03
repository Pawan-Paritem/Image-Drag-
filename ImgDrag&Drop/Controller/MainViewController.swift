//
//  MainViewController.swift
//  ImgDrag&Drop
//
//  Created by Pawan  on 01/11/2020.
//

import UIKit

class MainViewController: UIViewController, UIDropInteractionDelegate  {

    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        
        view.addInteraction(UIDropInteraction(delegate: self))
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for drageitem in session.items {
            drageitem.itemProvider.loadObject(ofClass: UIImage.self) { (obj, err) in
                if let err = err {
                    print("Failed to load our drag item")
                    return
                }
                guard let draggedImage = obj as? UIImage else { return }
                
               
                DispatchQueue.main.async {
                    let imageview = UIImageView(image: draggedImage)
                    self.view.addSubview(imageview)
                    imageview.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
                    
                    let centerPoint = session.location(in: self.view)
                    imageview.center = centerPoint
                }
               
            }
        }
    }
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
}
