internal import Foundation
import UIKit
internal import CoreData

class PERSON_CRUD{
    
    static let shardDB = DATABASEOPERATION()
    let FileDownloader =  FileDownlode()
    let Context:NSManagedObjectContext
    
     init(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.Context = context
    }
    
    func PERSON_Model_Create(id_:String , profile_imgPath:String, last_Activity_date:String ,LastActivity:String , Username:String , TotalUnsinSMS:Int64 , user_id:String) async->Person?{
        do{
            let request:NSFetchRequest<Person> = Person.fetchRequest()
            request.predicate = NSPredicate(format: "user_id == %@", user_id)
            let Result = try Context.fetch(request)
            
            if(!Result.isEmpty){
                print("user Allrady Exsisit")
                return Result.first
            }else{
                    let imgPath = await FileDownloader.ImgDonwlode(URL: profile_imgPath, SaveType: Save.Permanently)
                    let person = Person(context: Context)
                    person.last_model_update = Date()
                    person.last_sms_date = last_Activity_date
                    person.name = Username
                    person.unseen_smses = TotalUnsinSMS
                    person.id_ = id_
                    person.profile_img = imgPath
                    person.user_id = user_id
                    person.last_update_sms = LastActivity
                    person.is_person_viewed = false
                    try Context.save()
                return person
            }
        }catch{
            return nil
        }
    }
    
    func PERSON_Model_Read(user_id:String)->Person?{
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "user_id == %@", user_id)
        do{
            let Results = try Context.fetch(request)
            if(request.resultType.isEmpty){
                return nil
            }
            return Results[0]
            
        }catch{
            return nil
        }
    }
    
    
    
    
    func PERSON_Model_Update(
        user_id: String, img: String? = nil, lastActivitydate: String? = nil, Username: String? = nil, TotalUnseenMessages: Int64? = nil, lastActivity: String? = nil, IspersonViewed: Bool? = nil
    ) -> Person? {
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "user_id == %@", user_id)
        do {
            guard let person = try Context.fetch(request).first else {
                return nil
            }

            if let lastActivitydate {
                person.last_sms_date = lastActivitydate
            }

            if let Username {
                person.name = Username
            }

            if let TotalUnseenMessages {
                person.unseen_smses = TotalUnseenMessages
            }

            if let lastActivity {
                person.last_update_sms = lastActivity
            }

            if let IspersonViewed {
                person.is_person_viewed = IspersonViewed
            }

            if let img {
                person.profile_img = img
            }

            person.last_model_update = Date()

            try Context.save()

            return person

        } catch {
            print("PERSON_Model_Update Error:", error)
            return nil
        }
    }
    
    func PERSON_Model_All_PersonUpdate(
        img: String? = nil,
        lastActivitydate: String? = nil,
        Username: String? = nil,
        TotalUnseenMessages: Int64? = nil,
        lastActivity: String? = nil,
        IspersonViewed: Bool? = nil
    ) {
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let persons = try Context.fetch(request)
            
            guard !persons.isEmpty else {
                return
            }
            
            for person in persons {
                
                if let lastActivitydate {
                    person.last_sms_date = lastActivitydate
                }
                
                if let Username {
                    person.name = Username
                }
                
                if let TotalUnseenMessages {
                    person.unseen_smses = TotalUnseenMessages
                }
                
                if let lastActivity {
                    person.last_update_sms = lastActivity
                }
                
                if let IspersonViewed {
                    person.is_person_viewed = IspersonViewed
                }
                
                if let img {
                    person.profile_img = img
                }
                
                person.last_model_update = Date()
            }
            
            try Context.save()
            
        } catch {
            print("PERSON_Model_All_PersonUpdate Error:", error)
        }
    }
    
    func PERSON_Model_Delete(Personid_:String)->String?{
        let request:NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@",Personid_)
        
        do{
            let result = try Context.fetch(request)
            if(result.isEmpty){
                return "no result found"
            }
            for person in result{
                Context.delete(person)
                return "person delet successfull"
            }
            try Context.save()
        }catch{
            return "Delete unsuccessfull"
        }
        return nil
    }
    
    func PERSON_Model_All_Person() -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()

        do {
            let results = try Context.fetch(request)
            return results
        } catch {
            print("Failed to fetch persons: \(error)")
            return []
        }
    }
    
    func DeleteAllPerson() {

        let request: NSFetchRequest<Person> = Person.fetchRequest()

        do {
            let result = try Context.fetch(request)

            if result.isEmpty {
            }

            for person in result {
                Context.delete(person)
            }

            try Context.save()

        } catch {
            print("Delete error: \(error)")
        }
    }
    
    
}



