//
//  CustomPresentationViewController.swift
//  TransitionStudy
//
//  Created by 김정민 on 2020/03/20.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class CustomPresentationViewController: UIViewController {

    /*
       Custom Presentation
    1. Segue에서 Custom Presentation을 사용하도록 설정
    --> delegate도 추가해야함
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // custom presentation 사용 (1)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self
    }
}

// delegate 설정 (1)
extension CustomPresentationViewController : UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SimplePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
