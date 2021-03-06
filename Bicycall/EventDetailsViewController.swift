//
//  EventDetailsViewController.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 10/1/2021.
//

import UIKit
import CoreData

class EventDetailsViewController: UIViewController {

//vars
    
    var event_id: Int?
    var event_title: String?
    var adresse_evt: String?
    var date_evt: String?
    var time_evt: String?
    var user: Int?
    var BR = BaseUrl.baseUrl
    var u = ConnectedUser()

    
//widgets
    
    @IBOutlet weak var txtTitle: UILabel!
    
    @IBOutlet weak var txtAdress: UILabel!
    
    @IBOutlet weak var txtDate: UILabel!
    
    @IBOutlet weak var txtTime: UILabel!
    
    //Actions
    
    @IBAction func btnParticipate(_ sender: Any) {
        
        //post
        guard let url = URL(string: BR+"/participate") else {
        return
        }
        
        let bodyparameters = ["event_id": event_id!,"user": user!] as [String : Any]
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyparameters, options: []) else{
            return
            }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data,response,error) in
            if let response = response {
                print(response)
            }
            
          if let data = data , let dataString = String(data: data, encoding: String.Encoding.utf8){
                    print(data)
                    DispatchQueue.main.async {
                        print("Participate Successfully")
                         let alert = UIAlertController(title: "Success", message: "Participation Added Successfully", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                         self.present(alert, animated: true)
                      print(dataString)
                    }
            }
            
        }.resume()
        
    }
    
    
    @IBAction func btnParticipants(_ sender: Any) {
        let bike = Event(id: event_id! ,event_title: event_title! ,adress_evt: adresse_evt! ,date_evt: date_evt! ,time_evt: time_evt!, user: user!)
        performSegue(withIdentifier: "mParticipants" , sender: bike) //passage de variable locale)
    }
   
   
   /* prepare est pour passer les parametres  */
   override func prepare(for segue: UIStoryboardSegue, sender: Any?){
   if segue.identifier == "mParticipants" {
   let bike = sender as! Event
   let destination = segue.destination as! ParticipantsViewController
       destination.event_id = bike.event_id
     }
       
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DisplayConnectedUser()
        
        txtTitle.text = event_title!
        txtAdress.text = adresse_evt!
        txtDate.text = date_evt!
        txtTime.text = time_evt!
        
    }
    
    func DisplayConnectedUser() {
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //represente l'ORM
                let persistentContainer = appDelegate.persistentContainer
                let managedContext = persistentContainer.viewContext     //retourne NSManagedObject toujours
                
                //la requete retourne un NSManagedObject
                let request = NSFetchRequest<NSManagedObject>(entityName :   "Users")
                //execution de la requete
                do {
                
                    let result = try  managedContext.fetch(request)
                for item in result {
                    print(item.value(forKey: "user_id") as! Int )
                    print(item.value(forKey: "email")  as! String)
                    self.u.user_id  = (item.value(forKey: "user_id")  as! Int)
                    self.u.email = (item.value(forKey: "email")  as! String)
                    self.u.password = (item.value(forKey: "password")  as! String)
                    self.u.name = (item.value(forKey: "name")  as! String)
                    self.u.lastname = (item.value(forKey: "lastname")  as! String)
                    self.u.phone = (item.value(forKey: "phone")  as! String)
                   
                    print(self.u.user_id!)
                    print(self.u.email!)
                    print(self.u.password!)
                    print(self.u.name!)
                    print(self.u.lastname!)
                    print(self.u.phone!)
                  
                }
                
                   }
                   catch {
                   print("NO DATA FOUND , Error")
                   }
        }
    

}
