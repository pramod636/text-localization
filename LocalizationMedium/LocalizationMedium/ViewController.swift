//
//  ViewController.swift
//  LocalizationMedium
//
//  Created by Pramod M on 20/03/18.
//  Copyright © 2018 Pramod M. All rights reserved.
//

import UIKit

struct Contact: Codable {
    var first_name: String
    var last_name: String
    var phone: String
}

struct Contacts: Codable {
    var contacts: [Contact]
}

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var datasource: Contacts?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    fileprivate func loadData() {
        let path = Bundle.main.url(forResource: "contacts", withExtension: "txt")
        do {
            let data = try Data(contentsOf: path!)
            datasource = try JSONDecoder().decode(Contacts.self, from: data)
            self.tableview.reloadData()
        } catch let error {
            print(error)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.contacts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CELL") as! ContactsTableViewCell
        cell.setup(contact: datasource!.contacts[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let contact = datasource?.contacts[indexPath.row] {
            let message = String(format: NSLocalizedString("Name: Mr. %@ %@ \nPhone: %@", comment: "The variables are ordered as per constructs for english. Can be reordered for other languages"), contact.first_name, contact.last_name, contact.phone)
            let alertview = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.cancel, handler: nil)
            alertview.addAction(okAction)
            self.present(alertview, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

