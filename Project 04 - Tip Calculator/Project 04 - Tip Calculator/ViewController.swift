//
//  ViewController.swift
//  Project 04 - Tip Calculator
//
//  Created by 海啸 on 2017/6/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    //var
    private let bag = DisposeBag()
    //UI
    let inputTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textAlignment = .right
        field.attributedPlaceholder = NSAttributedString(string:"$0.00", attributes:[NSForegroundColorAttributeName: UIColor.gray,NSFontAttributeName :UIFont(name: "Arial", size: 20)!])

        return field
    }()
    
    let tipLabel: UILabel = {
        let label = UILabel()
        label.text = "Tip(0%):     $0.00"
        label.textColor = .black
        label.textAlignment = NSTextAlignment.right
        label.backgroundColor = .white
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:     $0.00"
        label.textColor = .black
        label.textAlignment = NSTextAlignment.right
        label.backgroundColor = .white
        return label
    }()
    
    let slideBar: UISlider = {
        let slider = UISlider()
        slider.backgroundColor = .white
        return slider
    }()
    
    
    //setUI
    func setupUI() {
        self.view.addSubview(inputTextField)
        self.view.addSubview(self.tipLabel)
        self.view.addSubview(self.totalLabel)
        self.view.addSubview(self.slideBar)
        
        self.inputTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.top).offset(100)
            make.width.height.equalTo(CGSize(width: 300, height: 50))
        }
        
        self.tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.top).offset(200)
            make.width.height.equalTo(CGSize(width: 300, height: 50))
        }
        
        self.totalLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.top).offset(300)
            make.width.height.equalTo(CGSize(width: 300, height: 50))
        }
        
        self.slideBar.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.top).offset(400)
            make.width.height.equalTo(CGSize(width: 300, height: 50))
        }
    }
    
    //rxBlock
    
    func rxBlock() {
        //inputField
        self.inputTextField.rx.controlEvent(.touchDown).subscribe(onNext: {[weak self] (_) in
            self?.inputTextField.text = ""
        }).addDisposableTo(bag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.rxBlock()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .red
        self.navigationItem.title = "04 Tip Calculator"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

