//
//  NotesListTableViewController.swift
//  New Notes
//
//  Created by Artem Karmaz on 2/7/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    var storage = Storage()
    
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.notes.count
    }


    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = storage.notes[indexPath.row]
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let textColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: font,
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle]
        let attributedString = NSAttributedString(string: note.title, attributes: attributes)
        cell.textLabel?.attributedText = attributedString
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        guard let editorVC = segue.destination as? NotesEditorViewController else {
            return
        }
        
        if Segue.noteSelected == segue.identifier {
            if let path = tableView.indexPathForSelectedRow {
                editorVC.notes = storage.notes[path.row]
            }
        } else if Segue.newNote == segue.identifier {
            editorVC.notes = Note(text: " ")
            storage.notes.append(editorVC.notes)
        }
    }
}
