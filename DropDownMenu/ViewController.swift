//
//  ViewController.swift
//  DropDownMenu
//
//  Created by 逸唐陳 on 2018/8/2.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import UIKit

struct BackGroundColor {
    let name: String
    let color: UIColor
}

class ViewController: UIViewController {
    
    let dropDownButton: DropDownButton = {
        let button = DropDownButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Colors", for: .normal)
        return button
    }()

    let colors: [BackGroundColor] = [BackGroundColor(name: "Red", color: .red),
                                     BackGroundColor(name: "Blue", color: .blue),
                                     BackGroundColor(name: "Yellow", color: .yellow),
                                     BackGroundColor(name: "Green", color: .green),
                                     BackGroundColor(name: "Purple", color: .purple),
                                     BackGroundColor(name: "Pink", color: UIColor(red: 254/255, green: 127/255, blue: 157/255, alpha: 1)),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(dropDownButton)
        dropDownButton.dropDownView.options = colors
        dropDownButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dropDownButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dropDownButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dropDownButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropDownButton.dropDownDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dropDownButton.menuClose()
    }

}

extension ViewController: DropDownViewDelegate {
    
    func didSelectedOption(_ option: BackGroundColor) {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = option.color
        }
    }

}
