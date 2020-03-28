//
//  DetailsViewController.swift
//  FacebookSignInExample
//
//  Created by John Codeos on 3/24/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var facebookIdLabel: UILabel!
    @IBOutlet weak var facebookFirstNameLabel: UILabel!
    @IBOutlet weak var facebookMiddleNameLabel: UILabel!
    @IBOutlet weak var facebookLastNameLabel: UILabel!
    @IBOutlet weak var facebookNameLabel: UILabel!
    @IBOutlet weak var facebookProfilePicUrlLabel: UILabel!
    @IBOutlet weak var facebookEmailLabel: UILabel!
    @IBOutlet weak var facebookAccessTokenLabel: UILabel!
    
    
    var facebookId = ""
    var facebookFirstName = ""
    var facebookMiddleName = ""
    var facebookLastName = ""
    var facebookName = ""
    var facebookProfilePicURL = ""
    var facebookEmail = ""
    var facebookAccessToken = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        facebookIdLabel.text = facebookId
        facebookFirstNameLabel.text = facebookFirstName
        facebookMiddleNameLabel.text = facebookMiddleName
        facebookLastNameLabel.text = facebookLastName
        facebookNameLabel.text = facebookName
        facebookProfilePicUrlLabel.text = facebookProfilePicURL
        facebookEmailLabel.text = facebookEmail
        facebookAccessTokenLabel.text = facebookAccessToken
    }
}
