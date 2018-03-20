//
//  ContactsTableViewCell.swift
//  LocalizationMedium
//
//  Created by Pramod M on 20/03/18.
//  Copyright © 2018 Pramod M. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!

    func setup(contact: Contact) {
        self.name.text = "\(contact.first_name) \(contact.last_name)"
        self.number.text = contact.phone
    }
}
