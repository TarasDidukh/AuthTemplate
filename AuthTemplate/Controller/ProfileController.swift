//
//  ProfileController.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation


class ProfileController: UIViewController {
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    
    public var authService: AuthServicing?
    
    public var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.logout))
        
        imageAvatar.kf.indicatorType = .activity
        if let user = user {
            labelUserName.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
            imageAvatar.kf.setImage(with: URL(string: user.avatar))
            imageAvatar.layer.cornerRadius = imageAvatar.frame.height/2
            imageAvatar.clipsToBounds = true
        }
    }
    
    @objc func logout() {
        authService!.singOut().start()
        self.performSegue(withIdentifier: "showSignIn", sender: user)
        self.navigationController?.viewControllers.remove(at: 0)
    }
}
