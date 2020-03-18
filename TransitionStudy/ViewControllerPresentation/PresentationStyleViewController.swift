//
//  PresentationStyleViewController.swift
//  TransitionStudy
//
//  Created by 김정민 on 2020/03/18.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class PresentationStyleViewController: UIViewController {
    /*
     View Controller Presentation
     1. Presentation style에 따라 다른 효과를 줄 수 있음
     --> 아이폰 보다는 아이패드에서 확연히 차이점이 나옴
     --> 각 Presentation 마다 view will appear, view will disappear 같은 콜백 메서드가 다르게 호출됨
     2. 아이패드의 경우 pop over에서 크래시가 나기 때문에 수정해줘야함
     */
    
    // Presentation Style 확인 (1)
    @IBAction func present(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Presentation", bundle: nil)
        let modalVC = sb.instantiateViewController(withIdentifier: "ModalViewController")
        
        // presentation style
        let style = UIModalPresentationStyle(rawValue: sender.tag) ?? .fullScreen
        modalVC.modalPresentationStyle = style
        
        // 아이패드 Pop over 크래시 해결 (2)
        if let pc = modalVC.popoverPresentationController{
            pc.sourceView = sender
            // 크기조절도 같이 해줌
            modalVC.preferredContentSize = CGSize(width: 500, height: 300)
        }
        
        printPresentationStyle(for: modalVC)
        present(modalVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(String(describing: type(of: self)), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print(String(describing: type(of: self)), #function)
    }
}

extension PresentationStyleViewController{
    func printPresentationStyle(for vc : UIViewController){
        print("\n\n======== ", separator : "", terminator: "")
        
        switch vc.modalPresentationStyle {
        case .fullScreen:
            print("full screen")
        case .pageSheet:
            print("page sheet")
        case .formSheet:
            print("form sheet")
        case .currentContext:
            print("current context")
        case .overFullScreen:
            print("over full screen")
        case .overCurrentContext:
            print("over current context")
        case .popover:
            print("popover")
        default:
            print("none")
        }
    }
}
