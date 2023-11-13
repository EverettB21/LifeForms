//
//  DetailViewController.swift
//  Life-FormSearch
//
//  Created by Everett Brothers on 11/13/23.
//

import UIKit

class DetailViewController: UIViewController {

    var lifeForm: LifeFormDetail?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let lifeForm = lifeForm {
            title = "\(lifeForm.scientificName)"
            nameLabel.text = lifeForm.scientificName
            imageView.image = UIImage(named: "errorIcon.jpeg")
            
            var urlString = ""
            if let object = lifeForm.dataObjects?.first {
                urlString = object.mediaURL
                Task {
                    let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
                    guard let http = response as? HTTPURLResponse else { return }
                    if http.statusCode == 200 {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    } else {
                        return
                    }
                }
            }
        }
    }
    
    @IBSegueAction func toConcepts(_ coder: NSCoder, sender: Any?) -> ConceptsTableViewController? {
        let vc = ConceptsTableViewController(coder: coder)
        vc?.recivedConcepts = lifeForm?.taxonConcepts
        
        return vc
    }
    
    @IBSegueAction func toHierarchy(_ coder: NSCoder, sender: Any?) -> HiearchyTableViewController? {
        let vc = HiearchyTableViewController(coder: coder)
        vc?.id = lifeForm?.identifier
        
        return vc
    }
    
    @IBAction func taxonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toConcepts", sender: nil)
    }
    
    @IBAction func hiearchy(_ sender: Any) {
        performSegue(withIdentifier: "toA", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
