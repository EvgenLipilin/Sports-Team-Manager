//
//  PlayerCell.swift
//  SportManager
//
//  Created by Евгений on 01.03.2021.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    static let identifierCell = "PlayerCell"
    
    let number: UILabel = {
        let number = UILabel()
        number.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        number.text = "7"
        number.textAlignment = .center
        number.translatesAutoresizingMaskIntoConstraints = false
        return number
    }()
    
    let avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFill
        avatar.backgroundColor = .systemGray
        avatar.image = #imageLiteral(resourceName: "man")
        avatar.clipsToBounds = true
        return avatar
    }()
    
    let fullName: UILabel = {
        let fullName = UILabel()
        fullName.translatesAutoresizingMaskIntoConstraints = false
        return fullName
    }()
    
    let team: UILabel = {
        let team = UILabel()
        team.translatesAutoresizingMaskIntoConstraints = false
        team.text = "Team"
        team.font = .systemFont(ofSize: 14, weight: .bold)
        return team
    }()
    
    let teamDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nationality: UILabel = {
        let nationality = UILabel()
        nationality.translatesAutoresizingMaskIntoConstraints = false
        nationality.text = "Nationality"
        nationality.font = .systemFont(ofSize: 14, weight: .bold)
        return nationality
    }()
    
    let nationalityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text"
        return label
    }()
    
    let position: UILabel = {
        let position = UILabel()
        position.translatesAutoresizingMaskIntoConstraints = false
        position.text = "Position"
        position.font = .systemFont(ofSize: 14, weight: .bold)
        return position
    }()
    
    private let positionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let age: UILabel = {
        let age = UILabel()
        age.translatesAutoresizingMaskIntoConstraints = false
        age.text = "Age"
        age.font = .systemFont(ofSize: 14, weight: .bold)
        return age
    }()
    
    let ageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainStack: UIStackView = {
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.backgroundColor = .systemGray6
        return mainStack
    }()
    
    let leftStack: UIStackView = {
        let leftStack = UIStackView()
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        return leftStack
    }()
    
    let rightStack: UIStackView = {
        let rightStack = UIStackView()
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        return rightStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCell(model: Player){
        number.text = "\(model.number)"
        avatar.image = UIImage(data: model.image ?? Data())
        fullName.text = model.fullName
        teamDescriptionLabel.text = model.team
        positionDescriptionLabel.text = model.position
        ageDescriptionLabel.text = "\(model.age)"
        nationalityDescriptionLabel.text = model.nationality
        
    }
    
    func setupLayout() {
        [number,fullName,avatar,mainStack,leftStack,rightStack,team,nationality,position,age,teamDescriptionLabel,nationalityDescriptionLabel,positionDescriptionLabel,ageDescriptionLabel].forEach { (element) in
            addSubview(element)
        }
        let inset: CGFloat = 10
        let imageSize: CGFloat = 125
        let halfMainStackViewWidth = (frame.width - (inset * 3)) / 2.5
        
        NSLayoutConstraint.activate(([number.topAnchor.constraint(equalTo: topAnchor, constant: inset),
                                      number.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
                                      number.widthAnchor.constraint(equalToConstant: 25),
                                      number.heightAnchor.constraint(equalToConstant: 25),
                                      
                                      fullName.centerYAnchor.constraint(equalTo: number.centerYAnchor),
                                      fullName.leadingAnchor.constraint(equalTo: number.trailingAnchor, constant: inset),
                                      
                                      avatar.topAnchor.constraint(equalTo: number.bottomAnchor, constant: inset),
                                      avatar.leadingAnchor.constraint(equalTo: number.leadingAnchor),
                                      avatar.heightAnchor.constraint(equalToConstant: imageSize),
                                      avatar.widthAnchor.constraint(equalToConstant: imageSize),
                                      
                                      mainStack.topAnchor.constraint(equalTo: avatar.topAnchor),
                                      mainStack.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: inset),
                                      mainStack.bottomAnchor.constraint(equalTo: avatar.bottomAnchor),
                                      mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
                                      
                                      leftStack.topAnchor.constraint(equalTo: mainStack.topAnchor),
                                      leftStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
                                      leftStack.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
                                      leftStack.widthAnchor.constraint(equalToConstant: halfMainStackViewWidth),
                                      
                                      team.topAnchor.constraint(equalTo: leftStack.topAnchor, constant: inset),
                                      team.leadingAnchor.constraint(equalTo: leftStack.leadingAnchor, constant: inset),
                                      
                                      nationality.topAnchor.constraint(equalTo: team.bottomAnchor, constant: inset),
                                      nationality.leadingAnchor.constraint(equalTo: team.leadingAnchor),
                                      
                                      position.topAnchor.constraint(equalTo: nationality.bottomAnchor, constant: inset),
                                      position.leadingAnchor.constraint(equalTo: nationality.leadingAnchor),
                                      
                                      age.topAnchor.constraint(equalTo: position.bottomAnchor, constant: inset),
                                      age.leadingAnchor.constraint(equalTo: position.leadingAnchor),
                                      
                                      rightStack.topAnchor.constraint(equalTo: leftStack.topAnchor),
                                      rightStack.leadingAnchor.constraint(equalTo: leftStack.trailingAnchor),
                                      rightStack.bottomAnchor.constraint(equalTo: leftStack.bottomAnchor),
                                      rightStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
                                      
                                      teamDescriptionLabel.topAnchor.constraint(equalTo: team.topAnchor),
                                      teamDescriptionLabel.leadingAnchor.constraint(equalTo: rightStack.leadingAnchor),
                                      
                                      nationalityDescriptionLabel.topAnchor.constraint(equalTo: nationality.topAnchor),
                                      nationalityDescriptionLabel.leadingAnchor.constraint(equalTo: teamDescriptionLabel.leadingAnchor),
                                      
                                      positionDescriptionLabel.topAnchor.constraint(equalTo: position.topAnchor),
                                      positionDescriptionLabel.leadingAnchor.constraint(equalTo: teamDescriptionLabel.leadingAnchor),
                                      
                                      ageDescriptionLabel.topAnchor.constraint(equalTo: age.topAnchor),
                                      ageDescriptionLabel.leadingAnchor.constraint(equalTo: teamDescriptionLabel.leadingAnchor)]))
    }
}
