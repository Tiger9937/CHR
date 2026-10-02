internal import CoreData
import UIKit

class DATABASEOPERATION{
    
    static let shardDB = DATABASEOPERATION()
    
    let Context:NSManagedObjectContext
    
     init(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.Context = context
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                self.context = appDelegate.persistentContainer.viewContext
    }
    
    // Test pass ✔️ ❤️
    func Mchat_Add_text(text:String , id_:String , personid_:String , Name:String! , Img:String!){
        print("hello")
        let chat = Chats(context: Context)
        
        let Person_request : NSFetchRequest<Person> = Person.fetchRequest()
        Person_request.predicate = NSPredicate(format: "id_ == %@",personid_)
        
        let Chat_Request: NSFetchRequest<Chats> = Chats.fetchRequest()
        Chat_Request.predicate = NSPredicate(format: "id_ == %@" , id_)
        
        do{
            let ChatRequest = try Context.fetch(Chat_Request)
            if(ChatRequest.first != nil){
                print("chat is allrady ther")
                return
            }else{
                chat.id_ = id_
                chat.text = text
            }
            
            let Personrequest = try Context.fetch(Person_request)
            if (Personrequest.first != nil) {
                print("person allrDY HAVE")
                chat.oneperson = Personrequest.first
                
            } else {
                let Person_REF = Mperson_add_Person(Personid_: personid_, Name: Name, Img: Img)
                chat.oneperson = Person_REF
                
            }
            print("text saved")
            try Context.save()
            
        }catch{
            print("data save unsuccessfull")
        }
    
    }
    
    // Test pass ✔️ ❤️
    func Mchat_Remove_spcific_Text(Textid_:String){
        let request: NSFetchRequest<Chats> = Chats.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@",Textid_)
        
        do{
            let result = try Context.fetch(request)
            
            for chat in result{
                
                Context.delete(chat)
                print("chat delet successfull")
            }
            
            try Context.save()
        }catch{
            print("data delete unsuccessfull")
        }
    }
    
    // Test pass ✔️ ❤️
    func Mchat_Remove_All_Text(Personid_:String){
        let request: NSFetchRequest<NSFetchRequestResult> = Chats.fetchRequest()
        request.predicate = NSPredicate(format: "oneperson.id_ == %@",Personid_)
        
        let AllChatsDELRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do{
            try Context.execute(AllChatsDELRequest)
            print("All texts are removed")
        }catch{
            print("data delete unsuccessfull")
        }
    }
    
    // Test pass ✔️❤️
    func Mchat_Update_Text(Textid_:String,UpdatedText:String){
        
        // update the data a see it
        
        let request: NSFetchRequest<Chats> = Chats.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@",Textid_)
        
        do{
            
            let TXT = try Context.fetch(request)
            if let TXTUpdate = TXT.first{
                TXTUpdate.text = UpdatedText
            }
            
            try Context.save()
            print("Updte successfull")
            
        }catch{
            print("data update unsuccessfull")
        }
    }
    
    // Test pass ✔️❤️
    func Mchat_Get_Texts(Personid_:String){
        let Person_request : NSFetchRequest<Person> = Person.fetchRequest()
        Person_request.predicate = NSPredicate(format: "id_ == %@",Personid_)
        
        let request: NSFetchRequest<Chats> = Chats.fetchRequest()
        // request.predicate = NSPredicate(format: "id_ == %@",Personid_)
   
        do{
            let Chats = try Context.fetch(request)
            let Currentperson = try Context.fetch(Person_request)
            // print(Chats)
        
                        
            
            let matchedChats = Chats.filter {
                $0.oneperson?.id_ == Currentperson.first?.id_
            }

            if matchedChats.isEmpty {
                print("No matching chats found")
            } else {
                matchedChats.forEach { print($0) }
            }
            
        }catch{
            print("Geting all data unsuccessfull")
            
        }
    }
    
    // Test pass ✔️❤️
    
    
    
    func Mperson_add_Person(Personid_:String! , Name:String! , Img:String!) -> Person?{
        do{

            let request:NSFetchRequest<Person> = Person.fetchRequest()
            request.predicate = NSPredicate(format: "id_ == %@", Personid_)

            let Result = try Context.fetch(request)
            
            if(!Result.isEmpty){
                print("Person allrady In DB")
                return Result.first
            }else{
                
                                      let person = Person(context: Context)
                                          person.id_ = Personid_
                                          person.name = Name
                                          // person.img = Img
                                      try Context.save()
                return person
            }


        
        }catch{
            print("Createing Person unsuccessfull")
            return nil
        }
        
    }
    
    // Test pass ✔️ ❤️
    func Mperson_Get_All_Person(){
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        do{
            
            let Results = try Context.fetch(request)
            
            print(Results)
            
            
        }catch{
            print("Geting data unsuccessfull")
        }
    }
    
    // Test pass ✔️ ❤️
    func Mperson_Get_Person(Personid_:String ){
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@" , Personid_)
        
        do{
            
            let Results = try Context.fetch(request)
            print(Results[0])
            
        }catch{
            print("Geting data unsuccessfull")
        }
    }
    
    // Test pass ✔️ ❤️
    func Mperson_Update_Person(Personid_:String , Name:String! , Img:String!){
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@" , Personid_)
        
        do{
            let Result = try Context.fetch(request)
            
            if(Result.isEmpty){
                return
            }
            
            if let Personupdate = Result.first{
                
                // Personupdate.img = (Img?.isEmpty == false) ? Img : Personupdate.img
                Personupdate.name = (Name?.isEmpty == false) ? Name : Personupdate.name
                
            }
            
            try Context.save()
            
            print("update successfull")
        }catch{
            print("Update unsuccessfull" , error)
        }
    }
    
    // Test pass ✔️ ❤️
    func Mperson_delete_Person(Personid_:String){
        let request:NSFetchRequest<Person> = Person.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@",Personid_)
        
        do{
            let result = try Context.fetch(request)
            if(result.isEmpty){
                print("no result found")
            }
            for person in result{
                Context.delete(person)
                print("person delet successfull")
            }
            try Context.save()
        }catch{
            print("Delete Unsuccessfull")
        }
    }
    
    // Test pass ✔️❤️
    func Mperson_delete_All_Person(){
        let request: NSFetchRequest<NSFetchRequestResult> = Person.fetchRequest()
        
        let AllPersonDELRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do{
            try Context.execute(AllPersonDELRequest)
        }catch{
            print("data delete unsuccessfull")
        }
        
        
    }
    
    
    
}
