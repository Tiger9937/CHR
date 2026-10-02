//
//  homeScrean.swift
//  CHR
//
//  Created by jagannath sahoo on 08/04/26.
//

import UIKit
internal import CoreData

class HomeVC: UIViewController {
    
    var screanfunction: ScreanFunc!
    var Cards: CARD!
     var btn: UI_BUTTON!
    // var btn: BUTTON_ACTIVITY!
    var img: UI_IMG_HOLDER!
    var textss: UI_TEXT!
    var shepe: UI_SHAPE!
    var Scroll: SCROLAREA!
    var DBop:DATABASEOPERATION!
    var Net:INTERNET!
    var Pletform:TEMPDATABASE!
    var Addresswork:UNIC!
    var UICard:UI_CARD!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screanfunction = ScreanFunc(VC: self)
        screanfunction.ChangeDefaultColor(BGcolor: .darkGray)
        screanfunction.backgroundcolor(BGcolor: .lightGray)
        
        playarea()
        
        // testarea()
    }
    
    func playarea() {
        
        // Initialize objects
        Cards = CARD()
        shepe = UI_SHAPE(VC: self)
        btn = UI_BUTTON(VC: self)
        DBop = DATABASEOPERATION()
        // btn = BUTTON_ACTIVITY()
        img = UI_IMG_HOLDER(VC: self)
        textss = UI_TEXT(VC: self)
        Scroll = SCROLAREA(VC: self)
        Net=INTERNET()
        Pletform = TEMPDATABASE()
        Addresswork = UNIC()
        
        
        UICard = UI_CARD(VC: self)
        
        
        let Arg_card_desing =  UI_CARD.UICardDising(P_X: 17, P_Y: 150, Width: 345, Height: 74 , Corner_Radius: 16)
        
        let Arg_card_text = UI_CARD.UICardText(
            Card_TXT_ISvisible: true,
            Card_TXT_Text: "Hello world",
            Card_TXT_Alignment: .left,
            Card_TXT_Text_Color: .black,
            Card_TXT_BoldSize: 10,
            Card_TXT_Font_Name: "Helvetica",
            Card_TXT_Font_Size: 18,
            Card_TXT_Opacity: nil,
            Card_TXT_Shadow_Width: 0,
            Card_TXT_Shadow_Height: 0,
            Card_TXT_Shadow_Radius: 0,
            Card_TXT_P_X: 30,
            Card_TXT_P_Y: 100,
            Card_TXT_Width: 100,
            Card_TXT_Height: 200
        )
        //
        let Arg_card_BTN =  UI_CARD.UICardButton(
            Card_BTN_ISvisible: true,
            Card_BTN_P_X: 232,
            Card_BTN_P_Y: 20,
            Card_BTN_P_width: 75,
            Card_BTN_P_height: 32,
            Card_BTN_BG_color: .systemBlue,
            Card_BTN_Text: "Click",
            Card_BTN_Text_Color: .white, Card_BTN_Radius: 15
        )
        //
        let Arg_card_IMG = UI_CARD.UICardImg(
            Card_IMG_ISvisible: true,
            Card_IMG_name:"img" ,
            Card_IMG_P_X:20,
            Card_IMG_P_Y:18,
            Card_IMG_Width: 40,
            Card_IMG_Height: 40
        )
        
        
        //        let crd = UICard.Add_Card(CardDisingAgrument:Arg_card_desing,
        //                        CardButtonArgments: Arg_card_BTN, CardimgArgument:Arg_card_IMG,
        //        )
        //
        // h-> w-> pading
        struct AppColor {
            
            // ✅ call like: AppColor.color(1)
            static func color(_ code: Int) -> UIColor {
                switch code {
                case 1:  return .red
                case 2:  return .systemBlue
                case 3:  return .systemRed
                case 4:  return .systemGreen
                case 5:  return .systemOrange
                case 6:  return .systemYellow
                case 7:  return .systemPink
                case 8:  return .systemPurple
                case 9:  return .systemTeal
                case 10: return .systemIndigo
                case 11: return .systemBrown
                case 12: return .systemCyan
                case 13: return .systemMint
                case 14: return .white
                case 15: return .black
                case 16: return .systemGray
                case 17: return .systemGray2
                case 18: return .systemGray3
                case 19: return .systemGray4
                case 20: return .systemGray5
                default: return .clear  // if wrong code, return clear
                }
            }
        }
        // ✅ store data at class level first
        var jsonpaying: [String: Any] = [:]
        // ["completed": 0, "title": delectus aut autem, "id": 1, "userId": 1]
        
        
        
        
        
        // pass the dising link and we get the page ready
        
        if(NetworkService.shared.isConnected){
            func reload(){
                // s1 -> if neet is off
                // s2 -> net is on but data is not coming after request
                Net.internet_Res(URI: "http://localhost:8000/Api/v1/Test/sendTEST") { data in jsonpaying = data
                    DispatchQueue.main.async { [self] in
                        
                        let isRequestSecced = jsonpaying["data"] as? Bool ?? false
                        if(isRequestSecced){
                            if let dataArray = jsonpaying["data"] as? [[String: Any]] {
                                Scroll.Scroll(height: 300,
                                              width: nil,
                                              view_X: nil,
                                              view_Y: 174,
                                              Cellcount: dataArray.count - 1,
                                              cellHeight: 74,
                                              cellwidth: 400,
                                              Gap: 18,
                                              items: { index in
                                    
                                    let view = UIView()
                                    view.backgroundColor = .white
                                    view.layer.cornerRadius = 16
                                    view.frame = CGRect(x: 0, y: 0, width: 357, height: 74)
                                    
                                    
                                    guard index < dataArray.count else { return [view] }
                                    
                                    let item = dataArray[index]
                                    print(item)
                                    let name = item["name"] as? String ?? ""
                                    let age = item["age"] as? Int ?? 0
                                    
                                    let TEXT = UILabel()
                                    TEXT.text = "\(name), \(age)"
                                    TEXT.textColor = .red
                                    TEXT.font = UIFont.systemFont(ofSize: 32, weight: .bold)
                                    TEXT.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
                                    
                                    view.addSubview(TEXT)
                                    
                                    return [view]
                                })
                            }
                        }else{
                            let TEXT = UILabel()
                                TEXT.text = "no data present"
                                TEXT.textColor = .systemGray
                                TEXT.font = UIFont.systemFont(ofSize: 32, weight: .bold)
                                TEXT.frame = CGRect(x: 80, y: 380, width: 300, height: 40)
                                self.view.addSubview(TEXT)
                        }
                    }
                }
            }
            reload()
        } else{
            let TEXT = UILabel()
                TEXT.text = "Internet Conection failed"
                TEXT.textColor = .systemGray
                TEXT.font = UIFont.systemFont(ofSize: 32, weight: .bold)
                TEXT.frame = CGRect(x: 0, y: 174, width: 300, height: 40)
                self.view.addSubview(TEXT)
        }
        
        
//        btn.AddButton(P_X: 28, P_Y: 30, P_width: 80, P_height: 50, BG_color: .systemBlue, BTN_Text: "Reload", Text_Color: .white, Shadow_Radius: 5)
//       
//        btn.Button_Action(Situation: UIAction { _ in
//            reload()
//        })
        
        // this is for network request
        
        
        //  Net.StoreDataKEy_val(key: "name", value: "Jaga")
        
        //        let address = Pletform.CreateAddress(address_sectionName: "AllRequest", address_Username: "jagannath", address_id_: "_96Ourt&^45")
        //
        //
        //        print("DATA address",address)
        
        // we get the "A00101" while call first time
        // scound time we call "A00102"
        // 10 time we calls "A0_02_00"
        // Pletform.GetAllitems(Key: "CurrentID")
        // Pletform.DeleteItems(Key: "CurrentID")
        
        //        for _ in 1..<99999{
        //            print(Addresswork.AssingAddressID())
        //        }
        
        
        // location caping
        //        let addres = Pletform.CreateAddress(address_sectionName: "All Request", address_Username: "jaga", address_id_: "234Rtnnh@"
        
        //        Pletform.AddData(key: "Name", value: "Jaga", address: addres)
        //        Pletform.AddData(key: "Age", value: "24", address: addres)
        
        // Pletform.GetDataWithFullAddress(address: addres)
        
        //        func card(Cell: Int) -> [UIView] {
        //
        //            let view = UILabel()
        //            view.text = "Card-\(Cell)"
        //            view.frame = CGRect(x: 70, y: 5, width: 150, height: 50)
        //            view.backgroundColor = .cyan
        //
        //            return [view]
        //        }
        
        // Scroll.Scroll(count: 5, items: card )
    }
    //    func testarea(){
    //        let ScrolView = Scroll.attachScroll(screen: self)
    //
    //
    //        for i in 0...100{
    //            let arg = CARD.CardDising(
    //                P_X: 70,
    //                P_Y: 20 + (i * 320),x
    //                Width: 250,
    //                Height: 300
    //            )
    //
    //            let cardView = Cards.Add_Card(
    //                on: Scroll.addagedscroll!, // ✅ FIX
    //                CardDisingAgrument: arg
    //            )
    //
    //            Scroll.attachScroll(screen: self, items: cardView)
    //        }
    //    }
    //}
    
    
    
    
    // img.AddImg(Img: "img", P_X: 100, P_Y: 250, Width: 200, Height: 300)
    
    // btn.AddButton(P_X: 67, P_Y: 78, P_width: 87, P_height: 87, BG_color: .green, BTN_Text: "89", Text_Color:.systemBlue , Shadow_Radius: 12)
    
    
    // shepe.AddShape(Bg_Color: .white, Corner_Radius: 12, P_X: 100, P_Y: 250, P_width: 200, P_height: 300, Shadow_Opacity: 0.5, Shadow_Width: 0.8, Shadow_Height: 12, Shadow_Radius: 23)
    
    
    // textss.AddText(Text: "helloworld", Alignment: .center, Text_Color: .systemBlue, BoldSize: 2, Font_Name: "Helvetica", Font_Size: 50, Opacity: 1, Shadow_Width: 1, Shadow_Height: 2, Shadow_Radius: 3)
    
    // textfild.Add_TextFild(Bg_Color: .white, Corner_Radius: 12, P_X: 100, P_Y: 120, P_width: 250, P_height: 80, Shadow_Color: nil, Opacity: 0.5, Shadow_Width: 3, Shadow_Height: 3, Shadow_Radius: 5, Text: "jagannath", Alignment: .center, Text_Color: .black, BoldSize: 2, Font_Name: "Helvetica", Font_Size: 40)
    
    //  button.Add_Button(P_X: 50, P_Y: 50, P_width: 200, P_height: 50, BG_color: .systemBlue, BTN_Text: "Click", Text_Color: .white,Border_Radius: 13.6)
    
    // textinput.Add_Textinput(Placeholder: "enter any thing", P_X: 200, P_Y: 50, P_width: 50, P_height: 50)
    
    // card.addButton(P_X: 200, P_Y: 100, P_width: 120, P_height: 200, BG_color: .white, BTN_Text: "Hello world", Text_Color: .systemBlue, Border_Radius: 12.6)
    
    
    
    
}

// ["data": { hello = 200;},
//    "message": reuest send successfull,
//    "success": 1,
//    "statusCode": 200
//]
