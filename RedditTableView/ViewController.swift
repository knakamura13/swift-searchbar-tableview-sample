
import UIKit
import Foundation

var userName: String!

class NamesListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Variables
    var names: [String] = ["John Dickens", "Marty Rickenson", "Jennifer Laurry", "Rick Martyson", "Sarah Pain", "Donald Tramp", "Hilary Clunt", "Streetlamp Le Moose"]
    var filteredNames: [String] = []
    var selectedName: String!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        searchBar.delegate = self
        tableView.dataSource = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    // Search bar function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text?.lowercased()
            
            filteredNames.removeAll()
            for name in names {
                if name.lowercased().contains(lower!) {  // If search text matches any part of name
                    filteredNames.append(name)
                }
            }
            tableView.reloadData()
        }
    }
    
    // Table view functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if inSearchMode {
            selectedName = filteredNames[indexPath.row]
        } else {
            selectedName = names[indexPath.row]
        }
        presentAlertToUser(message: selectedName)
        print(selectedName)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "namesListCell") as? NameCell {
            var thisName: String
            if inSearchMode {
                thisName = filteredNames[indexPath.row]
            } else {
                thisName = names[indexPath.row]
            }
            cell.configureCell(thisName)
            return cell
        } else {
            return NameCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredNames.count
        } else {
            return names.count
        }
    }
    
    // tap gesture recognizer assigned to container view (background)
    @IBAction func onBackgroundTapped(_ sender: Any) {
        view.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    // Alert user on selection
    func presentAlertToUser(message: String) {
        let alert = UIAlertController(title: "Name Selected", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Awesome", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

