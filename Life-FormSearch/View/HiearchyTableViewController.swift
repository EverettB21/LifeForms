//
//  HiearchyTableViewController.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/13/23.
//

import UIKit

class HiearchyTableViewController: UITableViewController {

    var ancestors: [Ancestor] = []
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Ancestors"
        ancestors.append(Ancestor(taxonRank: "N/A", scientificName: "No Recorded Ancestor Data"))
        let request = AncestorRequest(itemID: id, queryItems: ["language": "en"])
        Task {
            do {
                let requested = try await LifeFormController.shared.sendRequest(request)
                DispatchQueue.main.async {
                    self.ancestors = requested
                    if self.ancestors.isEmpty {
                        self.ancestors.append(Ancestor(taxonRank: "N/A", scientificName: "No Recorded Ancestor Data"))
                    }
                    self.tableView.reloadData()
                }
            } catch {
                print("Line 28: \(error.localizedDescription)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hCell", for: indexPath)
        configure(cell, for: indexPath)
        
        return cell
    }
    
    func configure(_ cell: UITableViewCell, for indexPath: IndexPath) {
        let ancestor = ancestors[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = ancestor.scientificName
        content.secondaryText = ancestor.taxonRank
        cell.contentConfiguration = content
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ancestors.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
