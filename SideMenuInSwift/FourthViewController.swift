//
//  FourthViewController.swift
//  SideMenuInSwift
//
//  Created by matrixstream on 24/05/21.
//

import UIKit
import ViewDeck


class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuBtnAct(_ sender: Any) {
        viewDeckController?.open(IIViewDeckSide.left, animated: true)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
