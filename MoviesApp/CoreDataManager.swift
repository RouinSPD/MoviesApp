//
//  CoreDataManager.swift
//  MoviesApp
//
//  Created by MacBook 28 on 17/02/23.
//

import Foundation
import CoreData

class CoreDataManager{
    
    private let container : NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "MoviesApp")
        setUpDataBase()
    }
    
    //recibe una estructura Movie y se lo pasa a la base de datos
    func saveMovie(movie : Movie){
        let context = container.viewContext
        let newMovie = MovieEntity(context: context)
        newMovie.name = movie.name
        newMovie.year = Int16(movie.year)
        newMovie.duration = Int16(movie.duration)
        newMovie.director = movie.director
        newMovie.isRestricted = movie.isRestricted
        
        //acá emoieza el proceso para guardar
        do{
            try context.save()
            print("MOVIE SAVED: \(newMovie.name)")
        } catch{
            print("ERROR: \(error)")
        }
        
        
    }
    
    func readMovies() -> [MovieEntity]{
        //hace una solicitud a la base de datos local
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do{
            //entra al contenedor y ejecuta la solicitud, devuelve el resultado
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        }catch{
            print("ERROR: \(error)")
            return []
        }
    }
    
    func filterData(startsWith letters : String) -> [MovieEntity]{
        let fetchRequest: NSFetchRequest<MovieEntity>
        fetchRequest = MovieEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH %@ ", letters)
        fetchRequest.includesPropertyValues = false
        let context = container.viewContext
        //busca para eliminar
        do{
            //puede ser más de un objeto con ese nombre por eso se tiene objects, puede devolver mas de uno
            let objects = try context.fetch(fetchRequest)
            return objects
        }catch{
            print("ERROR: \(error)")
        }
        //guardar el contexto
        do{
            try context.save()
            
        } catch {
            print("ERROR: \(error)")
        }
        return []
    }
    
    
    func deleteMovie(name: String){
        let fetchRequest: NSFetchRequest<MovieEntity>
        fetchRequest = MovieEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        fetchRequest.includesPropertyValues = false
        let context = container.viewContext
        //busca para eliminar
        do{
            //puede ser más de un objeto con ese nombre por eso se tiene objects, puede devolver mas de uno
            let objects = try context.fetch(fetchRequest)
            for object in objects{
                context.delete(object)
            }
        }catch{
            print("ERROR: \(error)")
        }
        //guardar el contexto
        do{
            try context.save()
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    
    func updateMovie(withName name: String, duration : Int){
        let fetchRequest: NSFetchRequest<MovieEntity>
        fetchRequest = MovieEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        fetchRequest.includesPropertyValues = false
        let context = container.viewContext
        //busca para eliminar
        do{
            //puede ser más de un objeto con ese nombre por eso se tiene objects, puede devolver mas de uno
            let objects = try context.fetch(fetchRequest)
            for object in objects{
                object.duration = Int16(duration)
            }
        }catch{
            print("ERROR: \(error)")
        }
        //guardar el contexto
        do{
            try context.save()
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    
    
    //función para que cargue la base, devuelve una descripcion de la base de datos o un error en caso de que algo falle al buscarla o cargarla
    private func setUpDataBase() {
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }else{
                print("DATA BASE: \(description)")
            }
        }
    }
}

