//
//  ConceptsTableViewController.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/13/23.
//

import UIKit

class ConceptsTableViewController: UITableViewController {

    var recivedConcepts: [taxonConcept]?
    var concepts: [taxonConcept] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Names"
        
        if let recivedConcepts = recivedConcepts {
            concepts = recivedConcepts
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conceptCell", for: indexPath)
        configure(cell, for: indexPath)
        
        return cell
    }
    
    func configure(_ cell: UITableViewCell, for indexPath: IndexPath) {
        let concept = concepts[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "\(concept.name), (\(concept.scientificName))"
        content.secondaryText = concept.nameAccordingTo
        cell.contentConfiguration = content
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return concepts.count
    }

}
