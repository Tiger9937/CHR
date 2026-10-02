import UIKit
internal import CoreData
internal import System
import JavaScriptCore



class INTERNET{
    // json system that helping to reading data form any to json
    // hendel the json
    //
    var tempData: TEMPDATABASE
    var ID:UNIC
    let Context:NSManagedObjectContext
    
    init(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.Context = context
        self.tempData = TEMPDATABASE()
        self.ID = UNIC()
    }
    
    
    func DataHolder(Payload:Data,sectionName:String)->Bool{
        
        
        if let entitys = try? JSONSerialization.jsonObject(with: Payload) as? [String: Any] {
            
            for (entitykey , entityvalue) in entitys{
                let address = tempData.CreateAddress(address_sectionName: sectionName,
                                                     address_Username: entitykey,
                                                     address_id_: ID.AssingAddressID())
                
                if let items = entityvalue as? [String:String] {
                    for (itemkey,itemvalue) in items{
                        tempData.AddData(key: itemkey, value: itemvalue, address: address)
                    }
                }
            }
            return true
        }
        
        // fetch refcter and return
        
        // store the data on CD{address , Actual Data}
        //  payloaad devidwer ->string <-[string]
        // return dta on array [key.value]
        //  addressfetch-> for{avable seation name}
        //  [addressfetch.. ret->[key,value]..
        //  ]-> for{ ret->[key,value].. GetDataWithFullAddress(addressfetch) }
        // [
        //  address1[
        //        data1[key,value]
        //        data2[key,value],
        //  ],address2[
        //        data1[key,value]
        //        data2[key,value],
        //  ]
        //  ]
        // set expire rool
        //
        return false
    }
    
    func GET(URI:String)async throws -> Data{
        
        let IsinternetOn = NetworkService.shared.Networkstatus()
        if(!IsinternetOn){
            throw ErrorService.AllNetworkError.Usernetoff
        }
        
        let endpoint = "\(URI)"
        guard URL(string: endpoint) != nil else{
            throw ErrorService.AllNetworkError.InvalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: URL(string: endpoint)!)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ErrorService.AllNetworkError.ServerError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ErrorService.AllNetworkError.ServerErrorCode(statusCode:httpResponse.statusCode )
        }
        
        return data
    }

    
    // -> [String: [String]]
    func internet_Res(URI:String,JSON_Payload: @escaping ([String:Any]) -> Void) {
        // get data form server
        
        // STAGE 1: GET URL
        guard let uri = URL(string:URI) else {return}

        // STAGE 2: FETCH DATA
        URLSession.shared.dataTask(with:uri){
            data,response,
            error in if let error = error {
                print("data gating error",error)
                return
            }
            
            guard let data = data else {return}
            
            // let result = String(data:data , encoding: .utf8)
            do{
                let JSON_Data = try JSONSerialization.jsonObject(with: data)
                JSON_Payload(JSON_Data as! [String : Any])
            }catch{
                print("erreoooooo->",error)
                // JSON_Payload(["Error":"Data is not loading"])
                JSON_Payload(["Error":error])
            }
            
    }.resume()
        
        func internet_Req(){
            
        }
        //    func StoreDataKEy_val(key:String , value:String)->NSManagedObject{
        //        var newData = DataEntity(context: Context)
        //        newData.id_ = Date()
        //
        //        func additems(key:String , value:String){
        //            let itemEntity = KeyValueEntity(context: Context)
        //
        //            itemEntity.key = key
        //            itemEntity.value = value
        //            itemEntity.parent = newData
        //
        //        }
        //
        //        do{
        //            additems(key:key , value: value)
        //            try Context.save()
        //            print("Data store succesfull")
        //        }catch{
        //            print("add data unsuccessfull")
        //        }
        //
        //        return newData
        //    }
    }
    
    
}

