//
//  TransitionStyleViewController.swift
//  TransitionStudy
//
//  Created by 김정민 on 2020/03/18.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class TransitionStyleViewController: UIViewController {

    /*
       View Controller Presentation
    1. View의 Transition 마다 다른 효과를 가짐
    --> segment로 선택해서 확인하는 방식
    --> segue로 구현 시 modal로 했는지 꼭 체크하기
    2. 코드로 transition을 구현할 때는 Segment 이동 전 호출되는 prepare에서 구현해야함
    */
    
    var selectedTransitionStyle = UIModalTransitionStyle.coverVertical
    
    // segment를 통해 다른 presentation style 지정 (1)
    @IBAction func styleChanged(_ sender: UISegmentedControl) {
        selectedTransitionStyle = UIModalTransitionStyle(rawValue: sender.selectedSegmentIndex) ?? .coverVertical
        print(selectedTransitionStyle)
    }
    
    // 코드로 Transition 구현할 경우 prepare에서 설정 (2)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let presentedVC = segue.destination
        presentedVC.modalTransitionStyle = selectedTransitionStyle
    }
    
    // 코드로 Transition 구현 (2)
    @IBAction func present(_ sender: Any) {
        let sb = UIStoryboard(name: "Presentation", bundle: nil)
        let modalVC = sb.instantiateViewController(withIdentifier: "ModalViewController")
        
        // Transition style 설정
        modalVC.modalTransitionStyle = selectedTransitionStyle
        
        present(modalVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
