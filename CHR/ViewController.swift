//
//  ViewController.swift
//  CHR
//
//  Created by jagannath sahoo on 07/04/26.
//


// domp screan
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let SC_ONE = ChatwindowVC()
        addScrean(SC: SC_ONE)
        SC_ONE.view.backgroundColor = .systemGray
        
    }
    
    func addScrean(SC: UIViewController){
        addChild(SC)
        SC.view.frame = view.bounds
        view.addSubview(SC.view)
        SC.didMove(toParent: self)
    }
    
}


// give some instction and screan is createtd

// hapen navigation thought this page
// main page of all page

//   get two page inside this page and shoing up on screan
