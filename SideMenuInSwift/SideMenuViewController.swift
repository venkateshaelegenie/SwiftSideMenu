//
//  SideMenuViewController.swift
//  SideMenuInSwift
//
//  Created by matrixstream on 24/05/21.
//

import UIKit
import ViewDeck


class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var viewDeckController2: IIViewDeckController?

    
    var namesArray = ["My Rides","Promotions","My Favourites","My Payments","Notifications","Support"]

    
    @IBOutlet weak var sideMenuTableV: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuTableV.register(UINib(nibName: "SideMenuTableCell", bundle: nil), forCellReuseIdentifier: "cell")

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

}
extension SideMenuViewController
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SideMenuTableCell
        
        cell?.titleLbl.text=namesArray[indexPath.row]
        cell?.selectionStyle = .none
        
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==0 {
            let mobileLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
            mobileLoginVC.selectedIndex=indexPath.row
            let navigationVC = UINavigationController(rootViewController: mobileLoginVC)
            
            let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
            
            let navigationVC2 = UINavigationController(rootViewController: sideMenuVC)


      
            navigationVC.navigationBar.isHidden=true
            navigationVC2.navigationBar.isHidden=true


            let viewDeckController = IIViewDeckController(center: navigationVC, leftViewController: navigationVC2)

            self.viewDeckController2 = viewDeckController

            self.view.window?.rootViewController = viewDeckController
            self.view.window?.makeKeyAndVisible()
         
           
        }
        else if indexPath.row==1 {
            let mobileLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
            mobileLoginVC.selectedIndex=indexPath.row
            let navigationVC = UINavigationController(rootViewController: mobileLoginVC)
            
            let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
            
            let navigationVC2 = UINavigationController(rootViewController: sideMenuVC)


      
            navigationVC.navigationBar.isHidden=true
            navigationVC2.navigationBar.isHidden=true


            let viewDeckController = IIViewDeckController(center: navigationVC, leftViewController: navigationVC2)

            self.viewDeckController2 = viewDeckController

            self.view.window?.rootViewController = viewDeckController
            self.view.window?.makeKeyAndVisible()
        }
        else if indexPath.row==2 {
            let mobileLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
            mobileLoginVC.selectedIndex=indexPath.row
            let navigationVC = UINavigationController(rootViewController: mobileLoginVC)
            
            let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
            
            let navigationVC2 = UINavigationController(rootViewController: sideMenuVC)


      
            navigationVC.navigationBar.isHidden=true
            navigationVC2.navigationBar.isHidden=true


            let viewDeckController = IIViewDeckController(center: navigationVC, leftViewController: navigationVC2)

            self.viewDeckController2 = viewDeckController

            self.view.window?.rootViewController = viewDeckController
            self.view.window?.makeKeyAndVisible()
        }
        else if indexPath.row==3 {
            let mobileLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as! TabbarViewController
            mobileLoginVC.selectedIndex=indexPath.row
            let navigationVC = UINavigationController(rootViewController: mobileLoginVC)
            
            let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
            
            let navigationVC2 = UINavigationController(rootViewController: sideMenuVC)


      
            navigationVC.navigationBar.isHidden=true
            navigationVC2.navigationBar.isHidden=true


            let viewDeckController = IIViewDeckController(center: navigationVC, leftViewController: navigationVC2)

            self.viewDeckController2 = viewDeckController

            self.view.window?.rootViewController = viewDeckController
            self.view.window?.makeKeyAndVisible()
        }
        else{
            let mobileLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "FifthViewController") as! FifthViewController
            let navigationVC = UINavigationController(rootViewController: mobileLoginVC)
            
            let sideMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
            
            let navigationVC2 = UINavigationController(rootViewController: sideMenuVC)


      
            navigationVC.navigationBar.isHidden=true
            navigationVC2.navigationBar.isHidden=true


            let viewDeckController = IIViewDeckController(center: navigationVC, leftViewController: navigationVC2)

            self.viewDeckController2 = viewDeckController

            self.view.window?.rootViewController = viewDeckController
            self.view.window?.makeKeyAndVisible()
        }
    }
}

