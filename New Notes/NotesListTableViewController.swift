//
//  NotesListTableViewController.swift
//  New Notes
//
//  Created by Artem Karmaz on 2/7/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var storage = Storage()
    var filteredStorage = [Note]()
    
    enum Segue {
        static let noteSelected =  "CellSelected"
        static let newNote =  "AddNewNote"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    fileprivate func createSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your notes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0

        
        createSearchBar()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredStorage.count
        }
        return storage.notes.count
    }


    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let search: Note
        if isFiltering() {
            search = filteredStorage[indexPath.row]
        } else {
            search = storage.notes[indexPath.row]
        }
        
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let textColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: font,
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle]
        let attributedString = NSAttributedString(string: search.title, attributes: attributes)
        cell.textLabel?.attributedText = attributedString
        cell.selectionStyle = .blue
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        guard let editorVC = segue.destination as? NotesEditorViewController else {
            return
        }

        
        if Segue.noteSelected == segue.identifier {
            if let path = tableView.indexPathForSelectedRow {

                if isFiltering() {
                    editorVC.notes = filteredStorage[path.row]
                } else {
                    editorVC.notes = storage.notes[path.row]
                }
                
            }
        } else if Segue.newNote == segue.identifier {
            editorVC.notes = Note(text: " ")
            storage.notes.append(editorVC.notes)
        }
    }
    
    //MARK: Search
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredStorage = storage.notes.filter({( title : Note) -> Bool in
            return title.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

extension NotesListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
