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


class SMS_Serv {
    let person = PERSON_CRUD()
    let StoreMessages = CHAT_CRUD()
    
    enum ChatBasketItems {
        case ongoing(ALL_ONGOING_CHATS)
        case upcoming(ALL_UPCOMING_CHATS)
    }
    var AllChatBasket: [ChatBasketItems] = []
    
    
    func addUpcomigMessages(SMS:String , time:String , SMS_Direction:MessageDirection , Personid:String , SMS_ID:UUID){

        guard let personData = person.PERSON_Model_Read(user_id: Personid) else {
            print("Person not found")
            return
        }
        
        StoreMessages.CHAT_Model_Create(id: SMS_ID,
                                   Dipatcher_Status: "",
                                   Last_Model_Update: Date(),
                                   Message_Direction:SMS_Direction.rawValue ,
                                   Message_Text: SMS,
                                   Time_Stamp: time,
                                   PersonId: personData
        )
        
    }
    
    func addOutgoingMessages(SMS:String  , time:String , Personid:String , SMS_Direction:MessageDirection , Dipatcher_Status_INFO:StatusDispatch , SMS_ID:UUID){
        
//        let persons = person.PERSON_Model_All_Person()
        
        guard let person_ID = person.PERSON_Model_Read(user_id: Personid) else {
            print("Person not found")
            return
        }
        
        print("New Time",time)
        
        let SMS_store = StoreMessages.CHAT_Model_Create(id:SMS_ID,
                                   Dipatcher_Status: Dipatcher_Status_INFO.rawValue,
                                   Last_Model_Update: Date(),
                                   Message_Direction:SMS_Direction.rawValue ,
                                   Message_Text: SMS,
                                   Time_Stamp: time,
                                   PersonId: person_ID
        )
        print("SMS:ST",SMS_store)
    }
    
    
    func GetAllChats(PersonID:String)->[ChatBasketItems]{ 
        
        let timeDetect =  TimeDetectr()
        let AllChats = StoreMessages.CHAT_Model_GetAllChatsOnPerson(Personid: PersonID)
        
        if (AllChats == []) {
            
        }else{
            for AllChat in AllChats {
                if(AllChat.message_direction == 1){
                    let OngoingMessage = ALL_ONGOING_CHATS(id: "\(AllChat.id_!)",
                                      Message: AllChat.text!,
                                                           DispatchTime: "\(timeDetect.FindCurrentTime(TimeWIthString:nil , DateWithDateFormat:AllChat.time_stamp) ?? "Date Not found")",
                                      DispatchStatus: StatusDispatch(rawValue: AllChat.dipatcher_status!)!,
                                      MessageDirection: AllChat.message_direction)
                    AllChatBasket.append(.ongoing(OngoingMessage))
                    
                }else{
                    let UpcomingChats = ALL_UPCOMING_CHATS(id: "\(AllChat.id_!)",
                                                           Message: AllChat.text!,
                                                           DeliveryTime: "\(timeDetect.FindCurrentTime(TimeWIthString:nil , DateWithDateFormat:AllChat.time_stamp) ?? "Date Not found")",
                                                           MessageDirection: AllChat.message_direction)
                    AllChatBasket.append(.upcoming(UpcomingChats))
                }
            }
        }

        
        
        return AllChatBasket
    }
    
    
}
