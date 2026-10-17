internal import Foundation
import UIKit
internal import CoreData

class PERSON_CRUD{
    
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
            Context.rollback()
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

class CHAT_CRUD {
    let Context:NSManagedObjectContext
    init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.Context = context
    }
    
    private func fetchChat(_ id: UUID) throws -> Chats? {
        let request: NSFetchRequest<Chats> = Chats.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@", id as CVarArg)
        request.fetchLimit = 1
        return try Context.fetch(request).first
    }
    
    
    func CHAT_Model_Create(id:UUID , Dipatcher_Status:String , Last_Model_Update:Date ,
                           Message_Direction:Int16 , Message_Text:String , Time_Stamp:String,
                           PersonId:Person
    )->String{
        
        do {
                // 1. Duplicate check
            if try fetchChat(id) != nil {
                    return "Chat of this id exists"
            }
                // 2. Create the chat
                let newSMS = Chats(context: Context)
                newSMS.id_ = id
                newSMS.dipatcher_status = Dipatcher_Status
                newSMS.last_model_update = Last_Model_Update
                newSMS.message_direction = Message_Direction
                newSMS.text = Message_Text
                newSMS.time_stamp = Time_Stamp
                newSMS.oneperson = PersonId

                // 3. Save
                try Context.save()
                return "SMS store successful"

            } catch {
                Context.rollback()   // throw away the unsaved chat
                return "SMS store unsuccessful: \(error)"
            }
    }
    
    
    func CHAT_Model_Read(id: UUID) throws -> Chats? {
        let request: NSFetchRequest<Chats> = Chats.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@", id as CVarArg)
        request.fetchLimit = 1
        return try Context.fetch(request).first
    }
    
    
    func CHAT_Model_Update(id:UUID , Dipatcher_Status:String? = nil , Last_Model_Update:Date? = nil ,
                           Message_Direction:Int16? = nil , Message_Text:String? = nil , Time_tamp:String? = nil
    ) throws {
        
        if let chatModelUpdate = try? fetchChat(id) {

            if let Dipatcher_Status   { chatModelUpdate.dipatcher_status = Dipatcher_Status }
            if let Message_Direction  { chatModelUpdate.message_direction = Message_Direction }
            if let Message_Text       { chatModelUpdate.text = Message_Text }
            if let Time_tamp         { chatModelUpdate.time_stamp = Time_tamp }
            
            chatModelUpdate.last_model_update = Last_Model_Update ?? Date()
            
            do {
                try Context.save()
            } catch {
                Context.rollback()   // undo the unsaved changes
            }

        }
        
    }
    
    
    func CHAT_Model_Delete(id: UUID) -> String{
        do {
            guard let chat = try fetchChat(id) else {
                return "No chat with this id"
            }

            Context.delete(chat)     // mark it for deletion
            try Context.save()       // actually remove it from disk
            
            return "Chat save successfull"
        } catch {
            Context.rollback()       // undo the delete if saving failed
            return "Saving failed"
        }
    }
    
    
}
