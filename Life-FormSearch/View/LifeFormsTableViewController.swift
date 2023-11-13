//
//  LifeFormsTableViewController.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/3/23.
//

import UIKit

class LifeFormsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var lifeForms: [LifeForm] = []
    var lifeFormDetail: LifeFormDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Life Forms"
    }
    
    func performSearch(request: LifeFormRequest) {
        Task {
            do {
                let reqestedLifeForms = try await LifeFormController.shared.sendRequest(request)
                DispatchQueue.main.async {
                    self.lifeForms = reqestedLifeForms
                    self.tableView.reloadData()
                }
            } catch {
                print("Error on line 31, \(error.localizedDescription)")
            }
        }
    }
    
    @IBSegueAction func toDetail(_ coder: NSCoder, sender: Any?) -> DetailViewController? {
        let vc = DetailViewController(coder: coder)
        vc?.lifeForm = lifeFormDetail
        
        return vc
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let form = lifeForms[indexPath.row]
        let request = LifeFormDetailRequest(queryItems: ["images_per_page": "1"], itemID: form.id)
        
        Task {
            do {
                let result = try await LifeFormController.shared.sendRequest(request)
                DispatchQueue.main.async {
                    self.lifeFormDetail = result
                    self.performSegue(withIdentifier: "toDetail", sender: tableView.cellForRow(at: indexPath))
                }
            } catch {
                print("Error on line 58: \(error.localizedDescription)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifeForms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configure(cell, for: indexPath)
        
        return cell
    }
    
    func configure(_ cell: UITableViewCell, for indexPath: IndexPath) {
        let form = lifeForms[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = form.title
        content.secondaryText = form.content
        cell.contentConfiguration = content
    }

}

extension LifeFormsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!
        let request = LifeFormRequest(queryItems: ["q": text, "page": "1"])
        performSearch(request: request)
    }
    
}
