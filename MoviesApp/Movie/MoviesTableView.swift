import UIKit
//import CoreData

class MoviesTableViewController: UIViewController, UISearchResultsUpdating{
    
    //get the information of the movies from CoreDataManager
    let dataManager = CoreDataManager()
    // get the array of MovieEntities from the readMovies method from dataManager
    var movies : [MovieEntity]{
        get {
            return dataManager.readMovies()
        }
    }
    
    var filteredMovies : [MovieEntity] = []
    let searchController = UISearchController()
    
    // set the Outlet for the table
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredMovies = movies
        setUpUI()
        setUPSearchController()
        setUpTableView()
        
    }
    
    //setup the UI
    func setUpUI(){
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    // setup the searchController
    func setUPSearchController(){
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //method to conform to UISearchResultsUpdating
   func updateSearchResults(for searchController: UISearchController) {
    
        if let searchMovie = searchController.searchBar.text,
           searchMovie.isEmpty == false {
            //get the movies that start with certain letters
            filteredMovies = dataManager.filterData(startsWith: searchMovie)
        }else {
            filteredMovies = movies
        }
        moviesTableView.reloadData()
    }
    
    
    //general setup for the table
    private func setUpTableView(){
        moviesTableView.register(UINib(nibName: "MoviesTableViewCell", bundle: .main), forCellReuseIdentifier: "MoviesTableViewCell")
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
}

extension MoviesTableViewController : UITableViewDataSource{
    
    //the array of filtered movies gives the number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    // show the cells with the filtered movies
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell{
            let movie = filteredMovies[indexPath.row]
            cell.setup(withMovie: movie)
            cell.showsReorderControl = true
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension MoviesTableViewController : UITableViewDelegate{
    //method that gives the movie that has been selected
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = filteredMovies[indexPath.row]
        print(movie)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedMovie = filteredMovies.remove(at: sourceIndexPath.row)
        filteredMovies.insert(movedMovie, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
