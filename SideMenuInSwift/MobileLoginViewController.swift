//
//  MobileLoginViewController.swift
//  SideMenuInSwift
//
//  Created by matrixstream on 06/07/21.
//

import UIKit

class MobileLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginBtnAct(_ sender: Any) {
        let tabbarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
        self.navigationController?.pushViewController(tabbarVC, animated: true)

    }

}
