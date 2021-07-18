//
//  FifthViewController.swift
//  SideMenuInSwift
//
//  Created by matrixstream on 24/05/21.
//

import UIKit
import ViewDeck


class FifthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func menuBtnAct(_ sender: Any) {
        viewDeckController?.open(IIViewDeckSide.left, animated: true)

    }
    @IBAction func backBtnAct(_ sender: Any) {
       // self.navigationController?.popViewController(animated: true)
        
        let mobileLoginVC=self.storyboard?.instantiateViewController(withIdentifier: "MobileLoginViewController") as! MobileLoginViewController
        self.navigationController?.pushViewController(mobileLoginVC, animated: true)
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
