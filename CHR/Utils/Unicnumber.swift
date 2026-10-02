

internal import Foundation
class UNIC{
    var DataOP:TEMPDATABASE!
    var Key:String = "CurrentID"
    
    func AssingAddressID()->String{
       
        var Wings:String? = nil
        var Floor:String? = nil
        var Room:String? = nil
        DataOP = TEMPDATABASE()
        
        var PreviusGENID:String? = ""
        
        var ID:String
        
        
        
        if(DataOP.GetItemOnly(Key: Key) == ""){
            Wings = "A0"
            Floor = "00"
            Room = "01"
            
            ID = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
            DataOP.AddItemOnly(Key: Key, Value: ID)
            PreviusGENID = ID
            return ID
        }
        
        PreviusGENID = DataOP.GetItemOnly(Key: Key)
        let ID_Slice:[String] = stride(from: 0, to: PreviusGENID!.count, by: 2).map{
        let Start = PreviusGENID?.index(PreviusGENID!.startIndex,offsetBy: $0)
        
        let End = PreviusGENID?.index(Start! , offsetBy: 2 , limitedBy: PreviusGENID!.endIndex) ?? PreviusGENID?.endIndex
        
        return String(PreviusGENID![Start!..<End!])
        }
        
        Wings = ID_Slice[0]
        Floor = ID_Slice[1]
        Room = ID_Slice[2]

        // Cut value
        var CH_CODE:Int = 0
        var WCH:Character
        var WNUM:String
        var FNUM:String
        var RNUM:String
        
        
        if let STR = Wings?.dropLast().unicodeScalars.first?.value{
            CH_CODE = Int(STR)
        }
        
         
         let WingsNum = (Int(Wings?.dropFirst() ?? "") ?? 0)
         let Flor = String(format: "%02d", (Int(Floor!) ?? 0))
         let Rom = String(format: "%02d", (Int(Room!) ?? 0))
        
        var Totalnumber = Int("\(WingsNum)\(Flor)\(String(describing: Rom))") ?? 0
        
        if(Totalnumber == 99999){
            if(CH_CODE == 90){
                return "Address is full no space is remain"
            }else{
                WCH = Character(UnicodeScalar(CH_CODE + 1)!)
                WNUM = "00"
                FNUM = "00"
                RNUM = "00"
                let NewId = "\(WCH)\(WNUM)\(FNUM)\(RNUM)"
                DataOP.UpdateItemonly(Key: Key, Value: NewId)
                return NewId
            }
        }else{
            Totalnumber += 1
            let TotalnumberInst = String(format: "%05d", Totalnumber)
            WCH = Character(UnicodeScalar(CH_CODE)!)
            WNUM = String(TotalnumberInst.prefix(1))
            FNUM = String(TotalnumberInst.dropFirst().prefix(2))
            RNUM = String(TotalnumberInst.suffix(2))
            
            
            let NewId = "\(WCH)\(WNUM)\(FNUM)\(RNUM)" // A00000
            DataOP.UpdateItemonly(Key: Key, Value: NewId)
            return NewId
           
        }
    }
    
    func DeAssingAddressID(LastAssingID:String){
        var CH_CODE:Int = 0
        let PreviusGENID = LastAssingID
        let ID_Slice:[String] = stride(from: 0, to: PreviusGENID.count, by: 2).map{
            let Start = PreviusGENID.index(PreviusGENID.startIndex,offsetBy: $0)
        
            let End = PreviusGENID.index(Start , offsetBy: 2 , limitedBy: PreviusGENID.endIndex) ?? PreviusGENID.endIndex
        
            return String(PreviusGENID[Start..<End])
        }
        
        let WingsName = ID_Slice[0].dropLast()
        let WingsNumber = ID_Slice[0].dropFirst()
        let Flor = String(format: "%02d", (Int(ID_Slice[1]) ?? 0))
        let Room = String(format: "%02d", (Int(ID_Slice[2]) ?? 0))
        
        if let STR = WingsName.unicodeScalars.first?.value{
            CH_CODE = Int(STR)
        }
        
        let TotalNumber = Int("\(WingsNumber)\(Flor)\(Room)")! - 1
        let TotalnumberInst = String(format: "%05d", TotalNumber)
            
        let newID = "\(CH_CODE - 1)\(TotalnumberInst.prefix(1))\(TotalnumberInst.dropFirst().prefix(2))\(TotalnumberInst.suffix(2))"
        DataOP.UpdateItemonly(Key: Key, Value: newID)
    }
}






/*
if((Int(Room!) ?? 00) == 99){
    print("case 1")
    RNUM = "00"
    FNUM = String(format: "%02d", (Int(Floor!) ?? 0) + 1)
    WCH = Character(UnicodeScalar(CH_CODE)!)
    WNUM = (Int(Wings?.dropFirst() ?? "") ?? 0)
    
    
    Wings = "\(WCH)\(WNUM)"
    Floor = "\(FNUM)"
    Room = "\(RNUM)"
   
   let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
   DataOP.UpdateItemonly(Key: Key, Value: NewId)
   
   
   return NewId
    
    
}else{
    print("case 1 else")
    RNUM = String(format: "%02d", (Int(Room!) ?? 0) + 1)
    FNUM = String(format: "%02d", (Int(Floor!) ?? 0))
    WCH = Character(UnicodeScalar(CH_CODE)!)
    WNUM = (Int(Wings?.dropFirst() ?? "") ?? 0)
    
    
    Wings = "\(WCH)\(WNUM)"
    Floor = "\(FNUM)"
    Room = "\(RNUM)"
    
    let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
    DataOP.UpdateItemonly(Key: Key, Value: NewId)
    return NewId
}

// flor
if((Int(Floor!) ?? 00) == 99){
    print("case 2")
    FNUM = "00"
    RNUM = "00"
    WNUM = (Int(Wings?.dropFirst() ?? "") ?? 0) + 1
    WCH = Character(UnicodeScalar(CH_CODE)!)
    
    Wings = "\(WCH)\(WNUM)"
    Floor = "\(FNUM)"
    Room = "\(RNUM)"
    
    let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
    DataOP.UpdateItemonly(Key: Key, Value: NewId)
    return NewId
}else{
    print("case 2 else")
    RNUM = String(format: "%02d", (Int(Room!) ?? 0) )
    FNUM = String(format: "%02d", (Int(Floor!) ?? 0) + 1)
    WCH = Character(UnicodeScalar(CH_CODE)!)
    WNUM = (Int(Wings?.dropFirst() ?? "") ?? 0)
    
    
    Wings = "\(WCH)\(WNUM)0"
    Floor = "\(FNUM)0"
    Room = "\(RNUM)0"
    
    let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
    DataOP.UpdateItemonly(Key: Key, Value: NewId)
    return NewId
}

// WNUM
if((Int(Wings?.dropFirst() ?? "") ?? 0) == 9){
    print("case 3")
    FNUM = "00"
    RNUM = "00"
    WNUM = 0
    WCH = Character(UnicodeScalar(CH_CODE+1)!)
    
    Wings = "\(WCH)\(WNUM)"
    Floor = "\(FNUM)"
    Room = "\(RNUM)"
    
    let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
    DataOP.UpdateItemonly(Key: Key, Value: NewId)
    return NewId
}else{
    print("case 3 else")
    RNUM = String(format: "%02d", (Int(Room!) ?? 0) )
    FNUM = String(format: "%02d", (Int(Floor!) ?? 0) )
    WCH = Character(UnicodeScalar(CH_CODE)!)
    WNUM = (Int(Wings?.dropFirst() ?? "") ?? 0) + 1
    
    Wings = "\(WCH)\(WNUM)"
    Floor = "\(FNUM)"
    Room = "\(RNUM)"
    
    let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
    DataOP.UpdateItemonly(Key: Key, Value: NewId)
    return NewId
}

// WCH
if(CH_CODE == 90){
    print("case 4")
    FNUM = "00"
    RNUM = "00"
    WNUM = 0
    WCH = "#"
    
    Wings = "\(WCH)\(WNUM)"
    Floor = "\(FNUM)"
    Room = "\(RNUM)"
    
    let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
    DataOP.UpdateItemonly(Key: Key, Value: NewId)
    return NewId
}else{
    print("case 4 else")
    RNUM = String(format: "%02d", (Int(Room!) ?? 0) )
    FNUM = String(format: "%02d", (Int(Floor!) ?? 0) )
    WCH = Character(UnicodeScalar(CH_CODE + 1)!)
    WNUM = (Int(Wings?.dropFirst() ?? "") ?? 0)
    
    
    Wings = "\(WCH)\(WNUM)"
    Floor = "\(FNUM)"
    Room = "\(RNUM)"
    
    let NewId = "\(String(describing: Wings!))\(String(describing: Floor!))\(String(describing: Room!))"
    DataOP.UpdateItemonly(Key: Key, Value: NewId)
    return NewId
}
*/
