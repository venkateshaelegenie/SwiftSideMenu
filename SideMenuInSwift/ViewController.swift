//
//  ViewController.swift
//  SideMenuInSwift
//
//  Created by matrixstream on 24/05/21.
//

import UIKit
import ViewDeck

class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    @IBAction func menuBtnAct(_ sender: Any) {
        viewDeckController?.open(IIViewDeckSide.left, animated: true)
        
    }
    
}

