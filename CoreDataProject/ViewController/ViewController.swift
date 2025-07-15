//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Durvesh Manjhi on 15/07/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var persons:[Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        persons = CoreDataManager.shared.fetchPersons()
    }
    func reloadData() {
        persons = CoreDataManager.shared.fetchPersons()
        tableView.reloadData()
    }
    @IBAction func addPersonTapped(_ sender: UIButton) {
        showAlerttoAddOrEdit()
       }

    func showAlerttoAddOrEdit(_ person:Person? = nil){
        let alert = UIAlertController(title: person == nil ? "Add Person" : "Edit Person", message: nil, preferredStyle: .alert)
        alert.addTextField{$0.placeholder = "name";$0.text = person?.name}
        alert.addTextField{$0.placeholder = "age"; $0.keyboardType = .numberPad;if let age = person?.age{ $0.text = "\(age)"}}
        
        let saveAction = UIAlertAction(title: person == nil ? "Add" : "Update", style: .default) { _ in
            guard let name = alert.textFields?[0].text,
            let ageText = alert.textFields?[1].text ,
            let age = Int16(ageText)
            else {
                return
            }
            
            if let person = person{
                CoreDataManager.shared.updatePerson(person, newName: name, newAge: age)
            }else{
                CoreDataManager.shared.addPerson(name: name, age: age)
            }
            
            self.reloadData()
        }
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: false)
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! personCell
        
        cell.name.text = persons[indexPath.row].name
        cell.ageText.text = "Age: \(persons[indexPath.row].age)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = persons[indexPath.row]
        showAlerttoAddOrEdit(person)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            CoreDataManager.shared.deletePerson(persons[indexPath.row])
            reloadData()
        }
    }
}
