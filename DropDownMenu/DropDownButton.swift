//
//  DropDownButton.swift
//  DropDownMenu
//
//  Created by 逸唐陳 on 2018/8/2.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import Foundation
import UIKit

protocol DropDownViewDelegate: class {
    func didSelectedOption(_ option: BackGroundColor)
}

class DropDownButton: UIButton, DropDownViewDelegate {
    
    func didSelectedOption(_ option: BackGroundColor) {
        self.setTitle(option.name, for: .normal)
        menuClose()
        dropDownDelegate?.didSelectedOption(option)
    }
    
    
    let dropDownView: DropDownView = {
        let view = DropDownView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dropDownViewHeight: NSLayoutConstraint?
    var isOpen = false
    weak var dropDownDelegate: DropDownViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.superview?.addSubview(dropDownView)
        self.superview?.bringSubviewToFront(dropDownView)
        dropDownView.tableView.backgroundColor = .darkGray
        dropDownView.delegate = self
        dropDownView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropDownView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropDownView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        dropDownViewHeight = dropDownView.heightAnchor.constraint(equalToConstant: 0)
        dropDownViewHeight?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !isOpen {
            menuOpen()
        }else {
            menuClose()
        }
    }
    
    private func menuOpen() {
        isOpen = true
        if dropDownView.tableView.contentSize.height > 150 {
            self.dropDownViewHeight?.constant = 150
        }else {
            self.dropDownViewHeight?.constant = dropDownView.tableView.contentSize.height
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropDownView.layoutIfNeeded()
            self.dropDownView.center.y += self.dropDownView.frame.height / 2
        }, completion: nil)
    }
    
    func menuClose() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.dropDownViewHeight!])
        self.dropDownViewHeight?.constant = 0
        NSLayoutConstraint.activate([self.dropDownViewHeight!])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropDownView.center.y -= self.dropDownView.frame.height / 2
            self.dropDownView.layoutIfNeeded()
        }, completion: nil)
    }
    
}

class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.separatorInset.left = 0
        return table
    }()

    var options: [BackGroundColor]?
    weak var delegate: DropDownViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options?[indexPath.row].name
        cell.backgroundColor = .darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let option = options?[indexPath.row] else { return }
        delegate?.didSelectedOption(option)
    }
    
}
