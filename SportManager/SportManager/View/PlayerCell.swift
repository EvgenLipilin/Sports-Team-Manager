//
//  PlayerCell.swift
//  SportManager
//
//  Created by Евгений on 01.03.2021.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    let identifierCell = "PlayerCell"
    
    let number: UILabel = {
        let number = UILabel()
        number.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        number.textAlignment = .center
        number.translatesAutoresizingMaskIntoConstraints = false
        return number
    }()
    
    let avatar: UIImageView = {
       let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFill
        avatar.backgroundColor = .systemGray
        avatar.image = #imageLiteral(resourceName: "avatar")
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
    
    let playerStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCell(_model: Player){
        number.text = "\(_model.number)"
        avatar.image = UIImage(data: _model.image ?? Data())
        fullName.text = _model.fullname
        teamDescriptionLabel.text = _model.club?.name
        positionDescriptionLabel.text = _model.position
        ageDescriptionLabel.text = "\(_model.age)"
        playerStatusLabel.text = _model.inPlay ? "In Play" : "Bench"
        
    }
    
    func setupLayout() {
        [number,fullName,playerStatusLabel,avatar,mainStack,leftStack,rightStack,team,nationality,position,age,teamDescriptionLabel,nationalityDescriptionLabel,positionDescriptionLabel,ageDescriptionLabel].forEach { (element) in
            addSubview(element)
        }
        let inset: CGFloat = 10
        let imageSize: CGFloat = 125
        let halfMainStackViewWidth = (frame.width - (inset * 3)) / 2.5
        
        NSLayoutConstraint.activate([number])
    }
}
