//
//  PlayerViewController.swift
//  SportManager
//
//  Created by Евгений on 01.03.2021.
//

import UIKit
import CoreData

class PlayerViewController: UIViewController {
    
    var dataManager: CoreDataManager!
    
    var selectedImage = #imageLiteral(resourceName: "foot")
    var selectedClub: String!
    var selectedPosition: String!
    var imagePickerController = UIImagePickerController()
    var position = ["Нападающий", "Вратарь", "Защитник", "Полузащитник"]
    var teams = ["ЦСКА","Локомотив","Спартак","Зенит","Динамо","Ахмат","Крылья Своетов","Урал","Арсенал","Ростов",]
    
    let playerStatusSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.insertSegment(withTitle: "In Play", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Bench", at: 1, animated: true)
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        //imageView.heightAnchor.constraint(equalToConstant: CGFloat(200)).isActive = true
        //imageView.widthAnchor.constraint(equalToConstant: CGFloat(200)).isActive = true
        imageView.backgroundColor = .darkGray
        imageView.image = selectedImage
        return imageView
    }()
    
    let uploadImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Upload image", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(uploadImageButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var nameTextField: UITextField = {
        var nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Name"
        nameTextField.textContentType = .name
        nameTextField.borderStyle = .roundedRect
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(inputText), for: .editingChanged)
        return nameTextField
    }()
    
    lazy var nationalityTextField: UITextField = {
        var nationalityTextField = UITextField()
        nationalityTextField.translatesAutoresizingMaskIntoConstraints = false
        nationalityTextField.placeholder = "Nationality"
        nationalityTextField.textContentType = .name
        nationalityTextField.borderStyle = .roundedRect
        nationalityTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(inputText), for: .editingChanged)
        return nationalityTextField
    }()
    
    lazy var numberTextField: UITextField = {
        var numberTextField = UITextField()
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.placeholder = "Number"
        numberTextField.textContentType = .name
        numberTextField.borderStyle = .roundedRect
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(inputText), for: .editingChanged)
        return numberTextField
    }()
    
    lazy var ageTextField: UITextField = {
        var ageTextField = UITextField()
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.placeholder = "Age"
        ageTextField.textContentType = .telephoneNumber
        ageTextField.borderStyle = .roundedRect
        ageTextField.delegate = self
        ageTextField.addTarget(self, action: #selector(inputText), for: .editingChanged)
        return ageTextField
    }()
    
    let teamLabel: UILabel = {
        let team = UILabel()
        team.translatesAutoresizingMaskIntoConstraints = false
        team.text = "Team: "
        return team
    }()
    
    let positionLabel: UILabel = {
        let position = UILabel()
        position.translatesAutoresizingMaskIntoConstraints = false
        position.text = "Position: "
        return position
    }()
    
    lazy var teamPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var positionPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isEnabled = false
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.alpha = 0.3
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let selectTeamButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Press to select", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(selectTeamButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let selectPositionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Press to select", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(selectPositionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setupLayout()
        setupImagePickerController()
    }
    
    @objc func uploadImageButtonPressed (){
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func selectTeamButtonPressed(){
        teamPickerView.isHidden = false
        hideTeamAndPosition()
    }
    
    @objc func selectPositionButtonPressed(){
        positionPickerView.isHidden = false
        hideTeamAndPosition()
    }
    
    private func setupImagePickerController() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
    }
    
    @objc func inputText() {
        guard let name = nameTextField.text,
              let number = numberTextField.text,
              let age = ageTextField.text,
              let nationality = nameTextField.text else {return}
        
        saveButton.isEnabled = !name.isEmpty && !number.isEmpty && !age.isEmpty && !nationality.isEmpty
        saveButton.alpha = saveButton.isEnabled ? 1:0.3
    }
    
    @objc func saveButtonPressed() {
        
        let context = dataManager.getContext()
        
        let club = dataManager.createObject(from: Club.self)
        club.name = selectedClub
        
        let player = dataManager.createObject(from: Player.self)
        player.fullName = nameTextField.text
        player.number = Int16((numberTextField.text! as NSString).integerValue)
        player.team = selectedClub
        player.image = selectedImage.pngData()
        player.nationality = nationalityTextField.text
        player.position = selectedPosition
        player.age = Int16((ageTextField.text! as NSString).integerValue)
        
        switch playerStatusSegmentControl.selectedSegmentIndex {
        case 0: player.inPlay = true
        case 1: player.inPlay = false
        default: break
        }
        
        dataManager.save(context: context)
        
        navigationController?.popViewController(animated: true)
    }
    
    func hideTeamAndPosition() {
        teamLabel.isHidden = true
        selectTeamButton.isHidden = true
        positionLabel.isHidden = true
        selectPositionButton.isHidden = true
    }
    
    func showTeamAndPosition(){
        teamLabel.isHidden = false
        selectTeamButton.isHidden = false
        positionLabel.isHidden = false
        selectPositionButton.isHidden = false
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        
        [playerStatusSegmentControl,avatarImage,uploadImageButton,nameTextField,nationalityTextField,numberTextField,ageTextField,teamLabel,positionLabel,teamPickerView,positionPickerView,saveButton,selectTeamButton,selectPositionButton].forEach {(element) in
            view.addSubview(element)
        }
        NSLayoutConstraint.activate([playerStatusSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     playerStatusSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     playerStatusSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                                     
                                     avatarImage.topAnchor.constraint(equalTo: playerStatusSegmentControl.bottomAnchor, constant: 40),
                                     avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     avatarImage.heightAnchor.constraint(equalToConstant: 200),
                                     avatarImage.widthAnchor.constraint(equalToConstant: 200),
                                     
                                     uploadImageButton.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
                                     uploadImageButton.centerXAnchor.constraint(equalTo: avatarImage.centerXAnchor),
                                     
                                     nameTextField.topAnchor.constraint(equalTo: uploadImageButton.bottomAnchor, constant: 20),
                                     nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     
                                     numberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
                                     numberTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
                                     numberTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
                                     
                                     nationalityTextField.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 10),
                                     nationalityTextField.leadingAnchor.constraint(equalTo: numberTextField.leadingAnchor),
                                     nationalityTextField.trailingAnchor.constraint(equalTo: numberTextField.trailingAnchor),
                                     
                                     ageTextField.topAnchor.constraint(equalTo: nationalityTextField.bottomAnchor, constant: 10),
                                     ageTextField.leadingAnchor.constraint(equalTo: nationalityTextField.leadingAnchor),
                                     ageTextField.trailingAnchor.constraint(equalTo: nationalityTextField.trailingAnchor),
                                     
                                     teamLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
                                     teamLabel.leadingAnchor.constraint(equalTo: ageTextField.leadingAnchor),
                                     teamLabel.heightAnchor.constraint(equalToConstant: 30),
                                     
                                     selectTeamButton.topAnchor.constraint(equalTo: teamLabel.topAnchor),
                                     selectTeamButton.leadingAnchor.constraint(equalTo: teamLabel.trailingAnchor, constant: 10),
                                     selectTeamButton.heightAnchor.constraint(equalToConstant: 30),
                                     
                                     positionLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 20),
                                     positionLabel.leadingAnchor.constraint(equalTo: teamLabel.leadingAnchor),
                                     positionLabel.heightAnchor.constraint(equalToConstant: 30),
                                     
                                     selectPositionButton.topAnchor.constraint(equalTo: positionLabel.topAnchor),
                                     selectPositionButton.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 10),
                                     selectPositionButton.heightAnchor.constraint(equalToConstant: 30),
                                     
                                     saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                                     saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     teamPickerView.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 10),
                                     teamPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     positionPickerView.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 10),positionPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
}

extension PlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            numberTextField.becomeFirstResponder()
        } else if textField == numberTextField {
            nationalityTextField.becomeFirstResponder()
        } else if textField == nationalityTextField {
            ageTextField.becomeFirstResponder()
        }
        
        return true
    }
}

extension PlayerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        selectedImage = image
        avatarImage.image = selectedImage
        
        imagePickerController.dismiss(animated: true, completion: nil)
        
    }
    
}

extension PlayerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == teamPickerView {
            let team = teams[row]
            selectTeamButton.setTitle(team, for: .normal)
            selectedClub = team
            teamPickerView.isHidden = true
            showTeamAndPosition()
        } else if pickerView == positionPickerView {
            let positions = position[row]
            selectPositionButton.setTitle(positions, for: .normal)
            selectedPosition = positions
            positionPickerView.isHidden = true
            showTeamAndPosition()
        }
    }
}

extension PlayerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView == teamPickerView {
            count = teams.count
        } else if pickerView == positionPickerView {
            count = position.count
        }
        
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        if pickerView == teamPickerView {
            title = teams[row]
        } else if pickerView == positionPickerView {
            title = position[row]
        }
        
        return title
    }
}
