//
//  AddNewItemViewController.swift
//  AnAppHasNoName
//
//  Created by Amjad Almuwallad on 09/02/2019.
//  Copyright © 2019 Amjad. All rights reserved.
//

import UIKit
import MBProgressHUD

class AddNewItemViewController: UIViewController {
    
    @IBOutlet weak var stepIndicatorView: StepIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backButtonOutlet: UIBarButtonItem!
    
    private var isScrollViewInitialized = false
    private var itemDataDic = [String: Any]()
    private var selectedImage: UIImage?
    private var typsButtonsArray = [UIButton]()
    private var selectedImagePlaceholder = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButtonOutlet.isEnabled = false
        self.backButtonOutlet.tintColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isScrollViewInitialized {
            isScrollViewInitialized = true
            self.initScrollView()
        }
    }
    
    private func initScrollView() {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(self.stepIndicatorView.numberOfSteps), height: self.scrollView.frame.height)
        
        for i in 1...self.stepIndicatorView.numberOfSteps {
            
            let scrollViewLabel: UILabel = {
                let label = UILabel()
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 30) //TODO: Change font size in small screens "for iphone 5s"
                label.textColor = Config.MAIN_COLOR
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            let scrollViewNextButton: UIButton = {
                let button = UIButton()
                button.backgroundColor = Config.MAIN_COLOR
                button.setTitle("Next", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.layer.cornerRadius = 20
                button.tag = 1
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
                return button
            }()
            
            self.scrollView.addSubview(scrollViewLabel)
            self.scrollView.addSubview(scrollViewNextButton)
            
            if i == 1{
                scrollViewLabel.text = "What do you wanna add?"
                let typesButtonTitles = ["Movie","TV Series","Book"]
                var typesButtonTopAnchor: CGFloat = 30
                var typesButtonTagIndex = 1
                
                for typesButtonTitle in typesButtonTitles {
                    let typesButton: UIButton = {
                        let button = UIButton()
                        button.backgroundColor = .white
                        button.setTitle("\(typesButtonTitle)", for: .normal)
                        button.setTitleColor(Config.MAIN_COLOR, for: .normal)
                        button.layer.cornerRadius = 15
                        button.tag = typesButtonTagIndex
                        button.translatesAutoresizingMaskIntoConstraints = false
                        button.addTarget(self, action: #selector(selectItemType), for: .touchUpInside)
                        return button
                    }()
                    
                    self.typsButtonsArray.append(typesButton)
                    self.scrollView.addSubview(typesButton)
                    typesButton.topAnchor.constraint(equalTo: scrollViewLabel.bottomAnchor, constant: typesButtonTopAnchor).isActive = true
                    typesButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 45).isActive = true
                    typesButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
                    typesButton.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 90).isActive = true
                    typesButtonTopAnchor += 70
                    typesButtonTagIndex += 1
                }
                
            } else if i == 2 {
                scrollViewLabel.text = "What's its neme?"
                let itemNametextField: UITextField = {
                    let textField = UITextField()
                    textField.placeholder = "Type it here"
                    textField.textAlignment = .center
                    textField.tintColor = .white
                    textField.textColor = .white
                    textField.translatesAutoresizingMaskIntoConstraints = false
                    textField.addTarget(self, action: #selector(textFieldTyping), for: .editingChanged)
                    return textField
                }() //TODO: Add underline to textfield
                
                self.scrollView.addSubview(itemNametextField)
                itemNametextField.topAnchor.constraint(equalTo: scrollViewLabel.bottomAnchor, constant: 30).isActive = true
                itemNametextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.scrollView.frame.width * CGFloat(i - 1) + 45).isActive = true
                itemNametextField.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 90).isActive = true
                itemNametextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
                
            } else if i == 3 {
                scrollViewLabel.text = "Upload a picture of it" //TODO: Replace the word 'it' with what the user choose
                let selectPictureButton: UIButton = {
                    let button = UIButton()
                    button.backgroundColor = .clear
                    button.setTitle("Select a picture", for: .normal)
                    button.setTitleColor(.white, for: .normal)
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.white.cgColor
                    button.layer.cornerRadius = 15
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.addTarget(self, action: #selector(selectItemPicture), for: .touchUpInside)
                    return button
                }()
                
                self.selectedImagePlaceholder = {
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    return imageView
                }()
                
                self.scrollView.addSubview(selectPictureButton)
                self.scrollView.addSubview(selectedImagePlaceholder)
                selectPictureButton.topAnchor.constraint(equalTo: scrollViewLabel.bottomAnchor, constant: 40).isActive = true
                selectPictureButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.scrollView.frame.width * CGFloat(i - 1) + 80).isActive = true
                selectPictureButton.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 160).isActive = true
                selectPictureButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
                
                selectedImagePlaceholder.topAnchor.constraint(equalTo: selectPictureButton.bottomAnchor, constant: 20).isActive = true
                selectedImagePlaceholder.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.scrollView.frame.width * CGFloat(i - 1) + 45).isActive = true
                selectedImagePlaceholder.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 90).isActive = true
                selectedImagePlaceholder.heightAnchor.constraint(equalToConstant: self.scrollView.frame.height / 2).isActive = true
                
                
            } else if i == 4 {
                scrollViewLabel.text = "What is it talking about?"
                scrollViewNextButton.tag = 2
                scrollViewNextButton.setTitle("Submit", for: .normal)
                //TODO: scrollViewNextButton may have different style in this case
                
                //TODO: Add a placeholder to this textView
                let itemCaptiontextView: UITextView = {
                    let textView = UITextView()
                    textView.textAlignment = .left
                    textView.layer.cornerRadius = 10
                    textView.backgroundColor = .white
                    textView.font = UIFont.systemFont(ofSize: 20)
                    textView.textColor = .lightGray
                    textView.delegate = self
                    textView.translatesAutoresizingMaskIntoConstraints = false
                    return textView
                }()//TODO: Prevent too long text
                
                self.scrollView.addSubview(itemCaptiontextView)
                itemCaptiontextView.topAnchor.constraint(equalTo: scrollViewLabel.bottomAnchor, constant: 40).isActive = true
                itemCaptiontextView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: self.scrollView.frame.width * CGFloat(i - 1) + 45).isActive = true
                itemCaptiontextView.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 90).isActive = true
                itemCaptiontextView.heightAnchor.constraint(equalToConstant: self.scrollView.frame.height / 2).isActive = true
                
            }
            
            scrollViewLabel.centerXAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0)).isActive = true
            scrollViewLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 5).isActive = true
            
            scrollViewNextButton.centerXAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: self.scrollView.frame.width / 2.0 * (CGFloat(i - 1) * 2.0 + 1.0)).isActive = true
            scrollViewNextButton.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width - 160).isActive = true
            scrollViewNextButton.bottomAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            scrollViewNextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
    }
    
    @objc func selectItemType(sender:UIButton!) {
        switch sender.tag { //TODO: Change buttons tags to text via enum
        case 1:
            self.itemDataDic["type"] = Config.MOVIES_ENDPOINT
        case 2:
            self.itemDataDic["type"] = Config.TV_SERIESES_ENDPOINT
        case 3:
            self.itemDataDic["type"] = Config.BOOKS_ENDPOINT
        default:
            print("Unknown type")
        }
        
        for button in self.typsButtonsArray {
            if button.tag == sender.tag {
                sender.backgroundColor = Config.MAIN_COLOR
                sender.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .white
                button.setTitleColor(Config.MAIN_COLOR, for: .normal)
            }
        }
    }
    
    @objc func selectItemPicture() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @objc func goToNextPage(sender:UIButton!) { //TODO: Merge Next and Back methods together
        if sender.tag == 1 {
            let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
            var frame: CGRect = self.scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(pageNumber + 1.0)
            frame.origin.y = 0
            self.scrollView.scrollRectToVisible(frame, animated: true)
        } else {
            //Case to send data to database
            let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
            progressHUD.label.text = "Please wait"
            if let itemleImg =  self.selectedImage, let imageData = itemleImg.jpegData(compressionQuality: 0.1){
                self.itemDataDic["date"] = Date().description
                ServerManger.sendDataToDatabase(type: self.itemDataDic["type"] as! String, name: self.itemDataDic["name"] as! String, imageData: imageData, caption: self.itemDataDic["caption"] as! String, date: self.itemDataDic["date"] as! String, onSuccess: {
                    progressHUD.hide(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }) { (error) in
                    progressHUD.hide(animated: true)
                    Config.displayAlert(self, title: "Error", message: error!)
                }
            } else {
                progressHUD.hide(animated: true)
                Config.displayAlert(self, title: "Error", message: "item image can't be empty")
            }
        }
    }
    
    @objc func textFieldTyping(textField:UITextField) {
        if let typedText = textField.text {
            self.itemDataDic["name"] = typedText
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(pageNumber - 1.0)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
    
}

extension AddNewItemViewController: UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width
        stepIndicatorView.currentStep = Int(pageIndex)
        
        if pageIndex != 0.0 {
            self.backButtonOutlet.isEnabled = true
            self.backButtonOutlet.tintColor = .white
        } else {
            self.backButtonOutlet.isEnabled = false
            self.backButtonOutlet.tintColor = .clear
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
            selectedImagePlaceholder.image = selectedImage
            //TODO: It may need an indicator while image uploading
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.itemDataDic["caption"] = textView.text
    }
}
