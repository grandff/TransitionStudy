//
//  PresentationViewController.swift
//  TransitionStudy
//
//  Created by 김정민 on 2020/03/18.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController {

    /*
        View Controller Presentation
     1. Modal 방식으로 View 이동
     --> Segue로 unwind와 modal present는 연결하고 코드로 구현함
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToHere(_ sender : UIStoryboardSegue){
        
    }
    
    // Modal 방식으로 View이동 (1)
    @IBAction func present(_ sender: Any) {
        guard let modalVC = storyboard?.instantiateViewController(withIdentifier: "ModalViewController") else {return}
        present(modalVC, animated: true, completion: nil)
    }
    
}
