//
//  PresentationContextViewController.swift
//  TransitionStudy
//
//  Created by 김정민 on 2020/03/18.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class PresentationContextViewController: UIViewController {
    /*
       View Controller Presentation
    1. Presentation Context로 지정하면 네비게이션 바를 보이게 할 수 있음
    2. 이 때 이전 페이지로 돌아가면 페이지가 안보임. 뷰를 삭제하기 때문인데, presentation context를 제거하거나 Over Current Context로 지정을 해줘야함
    */
    
    // Presentaion context 지정 (1)
    @IBAction func switchChanged(_ sender: UISwitch) {
        definesPresentationContext = sender.isOn
    }
}
