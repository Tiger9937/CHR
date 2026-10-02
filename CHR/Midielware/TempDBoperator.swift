internal import CoreData
import UIKit

class TEMPDATABASE{
    
    
    static let TempDB = TEMPDATABASE()
    let ID_work = UNIC()
    let Context:NSManagedObjectContext
    var NewSchma:DataEntity!
    var NewItem:KeyValueEntity!

    
    init(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        self.Context = context
        self.NewSchma = DataEntity(context: Context)
        self.NewItem = KeyValueEntity(context: Context)
        
    }
    
    func CreateAddress(address_sectionName:String,address_Username:String , address_id_:String)->DataEntity{

        NewSchma.id_ = address_id_
        NewSchma.sectionName = address_sectionName
        NewSchma.userName = address_Username
        
        do{
            try Context.save()
        }catch{
            print("Address Create unsuccesssfull")
        }
       
       return NewSchma
    }
    
    
    
    
    
    
    
    
    func GetAllData(){
        
        if let items = NewSchma.items as? Set <KeyValueEntity> {
            for i in items{
                print(i.key! , i.value!)
            }
        }
    }
    
    func GetDataWithFullAddress(address:DataEntity)->[[String:String]]{
        // return -> All avable item on that address
        var result:[[String:String]] = []
        if let items = address.items as? Set <KeyValueEntity>{
            for i in items{
                result.append([
                    i.key!: i.value!
                ])
                // print(i.key! , i.value!)
            }
        }else{
            print("No data inside this address")
        }
        return result
    }
    
    // pending Test 🟡
    func SearchWithAddress(ward:String)->[NSManagedObject]{
        do{
            let request:NSFetchRequest<DataEntity> = DataEntity.fetchRequest()
            request.predicate = NSPredicate(format: "userName == %@",ward)
            
            let result = try Context.fetch(request)
            if(result.isEmpty){print("result not found")}
            
            for i in result{
                if let items = i.items as? Set <KeyValueEntity>{
                    for item in items{
                        return [item]
                    }
                }else{
                    print("No data inside this address")
                }
            }
            
            
        }catch{
            
        }
        return []
    }
    // pending Test 🟡
    func ClineSection(SecttionName:String)->String{
        
        let request:NSFetchRequest<DataEntity> = DataEntity.fetchRequest()
        request.predicate = NSPredicate(format: "sectionName == %@",SecttionName)
        
        do{
           let result =  try Context.fetch(request)
            if(result.isEmpty){
                return "Result not found"
            }
            for i in result{
                ID_work.DeAssingAddressID(LastAssingID:i.id_!)
                Context.delete(i)
            }
            try Context.save()
            return "Delete Succesfull"
        }catch{ 
            return "ClineUnsuccessfull"
        }
    }
    // pending Test 🟡
    func ClineCollection(ColoctionID:String)->String{
        let request:NSFetchRequest<DataEntity> = DataEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id_ == %@",ColoctionID)
        
        do{
            let result = try Context.fetch(request)
            for resultItem in result{
                ID_work.DeAssingAddressID(LastAssingID:resultItem.id_!)
                Context.delete(resultItem)
            }
            try Context.save()
            return "Delet Successfull"
        }catch{
            return "Colocation delet unseccessfull"
        }
    }
    
    // current id -1
    
    // Items work -> this is only for our items related querys
    func AddData(key:String , value:String , address:NSManagedObject){
        let NewItem = KeyValueEntity(context: Context)
        
        NewItem.key = key
        NewItem.value = value
        NewItem.address = address as? DataEntity
        
        do{
            try Context.save()
            print("Data save")
        }catch{
            print("Data Adding unsuccessfull")
        }
    }
    
    func AddItemOnly (Key:String , Value:String){
        
        NewItem.key = Key
        NewItem.value = Value
        
        do{
            
            try Context.save()
        }catch{
            print("Save fail")
        }
    }
    
    
    
    
    func GetItemOnly(Key:String)->String{
        let ItemRequest: NSFetchRequest<KeyValueEntity> = KeyValueEntity.fetchRequest()
        ItemRequest.predicate = NSPredicate(format: "key == %@", Key)
        
        do{
            let result = try Context.fetch(ItemRequest)
            return (result.first?.value) ?? ""
        }catch{
            print("Fetch unsuccessfull",error)
            return ""
        }
    }
    
    
    
    
    
    func GetAllitems(Key:String){
        let ItemRequest: NSFetchRequest<KeyValueEntity> = KeyValueEntity.fetchRequest()
        ItemRequest.predicate = NSPredicate(format: "key == %@", Key)
        
        do{
            let result = try Context.fetch(ItemRequest)
            // print(result)
            for i in result{
                print(i.value!)
            }
        }catch{
            print("Fetch unsuccessfull",error)
        }
    }
    
    func DeleteItems(Key:String){
        let request:NSFetchRequest<KeyValueEntity> = KeyValueEntity.fetchRequest()
        request.predicate = NSPredicate(format: "key == %@",Key)
        
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
    
    func UpdateItemonly(Key:String , Value:String){
        let Itemrequest: NSFetchRequest<KeyValueEntity> = KeyValueEntity.fetchRequest()
        Itemrequest.predicate = NSPredicate(format: "key == %@", Key)
        
        do{
            let result = try Context.fetch(Itemrequest)
            if let updteItems = result.first{
                updteItems.value = Value
            }
            try Context.save()
            print("update successfull")
        }catch{
            print("update unsuccessfull")
        }
        
    }
    
}
