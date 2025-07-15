//
//  CoreDataManager.swift
//  CoreDataProject
//
//  Created by Durvesh Manjhi on 15/07/25.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveContext(){
        do{
            try context.save()
        }catch{
            print("saving error \(error)")
        }
    }

    func fetchPersons() -> [Person]{
        let request:NSFetchRequest<Person> = Person.fetchRequest()
        do {
            return try context.fetch(request)
        
        } catch {
            print("Fetching error: \(error)")
            return []
        }
    }
    
    
    func addPerson(name:String,age:Int16){
        let person = Person(context: context)
        person.name = name
        person.age = age
        saveContext()
    }
    func updatePerson(_ person:Person,newName:String,newAge:Int16){
        person.name = newName
        person.age = newAge
        saveContext()
    }
    
    func deletePerson(_ person:Person){
        context.delete(person)
        saveContext()
    }
}
