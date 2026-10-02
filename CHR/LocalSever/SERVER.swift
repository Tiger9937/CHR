internal import Foundation

// 10: ADD person
// convert the NSonjext to Structure Data

class PERSON_Serv {
   let FileDownloader =  FileDownlode()
   let personCRUD = PERSON_CRUD()
   var UserBasket:[PERSON_MODEL] = []
    
    func addPerson(persons: [PERSON_MODEL])async{
        
        for person in persons {

            if let existingUser = personCRUD.PERSON_Model_Read(user_id: person.Usserid),
               existingUser.user_id == person.Usserid {
                continue
            }

            // let imgPath = await FileDownloader.ImgDonwlode(URL: person.avatar)
            
            
            
            await personCRUD.PERSON_Model_Create(
                id_: UUID().uuidString,
                profile_imgPath: person.avatar ,
                last_Activity_date: person.lastActivitydate,
                LastActivity: person.LastSMS,
                Username: person.Username,
                TotalUnsinSMS: person.unseensmses,
                user_id: person.Usserid
            )
            
        }
    }
    
    func GetAllUser() -> [PERSON_MODEL] {
        let existingUsers = personCRUD.PERSON_Model_All_Person()
        
        for existingUser in existingUsers {
            let User = PERSON_MODEL(id: existingUser.id_,
                                    Usserid: existingUser.user_id ?? "",
                                    Username: existingUser.name ?? "",
                                    avatar: existingUser.profile_img!,
                                    lastActivitydate: "\(String(describing: existingUser.last_sms_date!))",
                                    unseensmses: existingUser.unseen_smses,
                                    LastSMS: existingUser.last_update_sms ?? "",
                                    LastModelUpdate: "\(String(describing: existingUser.last_model_update))",
                                    ISUserviewed: existingUser.is_person_viewed
            )
            
            UserBasket.append(User)
        }
        
        return UserBasket
    }
    
    func UpdateInViewFalse_AllUser(){
        personCRUD.PERSON_Model_All_PersonUpdate(IspersonViewed: false)
    }
    
    func UserViewupdate(UserID:String,updateView:Bool){
        personCRUD.PERSON_Model_Update( user_id: UserID, IspersonViewed: true )
    }
}
