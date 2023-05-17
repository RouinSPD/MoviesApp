//
//  ViewController.swift
//  MoviesApp
//
//  Created by MacBook 28 on 17/02/23.
//

import UIKit

class ViewController: UIViewController {
    var movies : [MovieEntity] = []
    
    //Outlets for the buttons and textfields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var restrictedSwitch: UISwitch!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var deleteTextField: UITextField!
    
    
    //start working with CoreDataManager
    let dataManager = CoreDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        //
        //dataManager.updateMovie(withName: "Titanic", duration: 90)
    }
    //setup the UI with specific types of keyboard and change the style of the buttons
    func setUpUI(){
        nameTextField.keyboardType = .default
        yearTextField.keyboardType = .numberPad
        durationTextField.keyboardType = .numberPad
        directorTextField.keyboardType = .default
        saveButton.layer.cornerRadius = 10
        readButton.layer.cornerRadius = 10
        deleteButton.layer.cornerRadius = 10
    }
    
    //MARK: CRUD
    
    //MARK: CREATE operation: saving the information of the textfields into a movie using CoreDara
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
              let year = yearTextField.text, !year.isEmpty,
              let yearInt = Int(year),
              let duration = durationTextField.text, !duration.isEmpty,
              let durationInt = Int(duration),
              let director = directorTextField.text, !director.isEmpty else {return}
        let movie = Movie(name: name, year: yearInt, duration: durationInt, director: director, isRestricted: restrictedSwitch.isOn)
        dataManager.saveMovie(movie: movie)
    }
    
    //MARK: READ operation: getting the information of the movies that have been previously saved using CoreData
    @IBAction func readButtonTapped(_ sender: Any) {
        print("showmovies button tapped")
        let moviesTableView = UIStoryboard(name: "Movies", bundle: .main)
        if let moviesTableViewController = moviesTableView.instantiateViewController(withIdentifier: "MoviesTV") as? MoviesTableViewController{
            self.navigationController?.pushViewController(moviesTableViewController, animated: true)
        }
        
    }
    
    //MARK: DELETE operation: deleting a complete movie using CoreDara
    @IBAction func deleteButtonTapped(_ sender: Any) {
        dataManager.deleteMovie(name: deleteTextField.text!)
    }
}

