//
//  ViewController.swift
//  Project 01 - Tap Counter
//
//  Created by 海啸 on 2017/6/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxGesture

class ViewController: UIViewController {
    //private variable
    private let bag = DisposeBag()
    private var timer = Timer()
    //UI
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = .white
        return label
    }()
    let tapButton: UIButton = {
       let button = UIButton()
        button.setTitle("Tap", for: UIControlState.normal)
        button.setTitleColor(.blue, for: UIControlState.normal)
        button.backgroundColor = .white
        return button
    }()
    
     let resetButton: UIButton = {
       let button = UIButton()
        button.setTitle("Reset", for: UIControlState.normal)
        button.setTitleColor(.blue, for: UIControlState.normal)
        button.backgroundColor = .white
        return button
    }()

    
    //Setup UI
    func setupUI() {
        self.view.addSubview(countLabel)
        self.view.addSubview(self.tapButton)
        self.view.addSubview(self.resetButton)
        
        self.countLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.height.equalTo(CGSize(width: 100, height: 50))
        }
        
        self.tapButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(CGSize(width: 100, height: 50))
        }

        self.resetButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.width.height.equalTo(CGSize(width: 100, height: 50))
        }
    }
    
    //Rx func
    func rxBlock() {
        //使用RxGesture 判断longpress 的开始
        tapButton.rx.anyGesture(
                (.longPress(), when: .began)
        ).subscribe(onNext: { [weak self] (gesture) in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                    let num = Int((self?.countLabel.text)!)
                    self?.countLabel.text = String(num!+1)
            })
        }).addDisposableTo(bag)
       
        //使用RxGesture 判断longpress 的结束
        tapButton.rx.anyGesture((.longPress(), when: .ended)).subscribe(onNext: { (_) in
            self.timer.invalidate()
        }).addDisposableTo(bag)
        
        //注意循环引用weak self
        tapButton.rx.tap.subscribe(onNext: { [weak self] event in
            let num = Int((self?.countLabel.text)!)
            self?.countLabel.text = String(num!+1)
        }).addDisposableTo(bag)
        
        self.resetButton.rx.tap.subscribe { [weak self] event in
            self?.countLabel.text = "0"
        }.addDisposableTo(bag)
    }
    //Life 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.rxBlock()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .red
        self.navigationItem.title = "02 Hold Counter"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

