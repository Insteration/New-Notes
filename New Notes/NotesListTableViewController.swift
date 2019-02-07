//
//  NotesListTableViewController.swift
//  New Notes
//
//  Created by Artem Karmaz on 2/7/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    
    enum Segue {
        static let noteSelected =  "CellSelected"
        static let newNote =  "AddNewNote"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Storage.notes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let notes = Storage.notes[indexPath.row]
        cell.textLabel?.text = notes.title
        // Configure the cell...

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        guard let editorVC = segue.destination as? NotesEditorViewController else {
            return
        }
        
        if Segue.noteSelected == segue.identifier {
            if let path = tableView.indexPathForSelectedRow {
                editorVC.notes = Storage.notes[path.row]
            }
        } else if Segue.newNote == segue.identifier {
            editorVC.notes = Note(text: " ")
            Storage.notes.append(editorVC.notes)
        }
    }
}
