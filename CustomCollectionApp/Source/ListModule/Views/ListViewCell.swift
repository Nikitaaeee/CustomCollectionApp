//
//  ListViewCell.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import UIKit

final class ListViewCell: UICollectionViewCell {
    
    private var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.personImageName)
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.nameLabelFontSize)
        return label
    }()
    
    private var phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.phoneImageName)
        return imageView
    }()
    
    private var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(Constants.phoneNumberFontSize)
        return label
    }()
    
    private var skillsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.skillsLabelText
        label.font = label.font.withSize(Constants.skillsLabelFontSize)
        label.textColor = .lightGray
        return label
    }()
    
    private var skillsValueLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(Constants.skillsValueFontSize)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppColors.lightGray.color
        addSubviews()
        makeConstraints()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - DisplaysTutorialCollectionViewCell

extension ListViewCell {
    func configure(with viewModel: ListDataFlow.CellViewModel) {
        nameLabel.text = viewModel.employeeName
        phoneNumberLabel.text = viewModel.phoneNumber
        skillsValueLabel.text = convertSkillsToString(array: viewModel.skills)
    }
}

private extension ListViewCell {
    func convertSkillsToString(array: [String]) -> String {
        return array.joined(separator: Constants.separator)
    }
    
    private func configureLayout() {
        self.layer.cornerRadius = Constants.cellCornerRadius
        self.layer.masksToBounds = true
    }
}

private extension ListViewCell {
    func addSubviews() {
        self.addSubview(userImage)
        self.addSubview(nameLabel)
        self.addSubview(phoneImageView)
        self.addSubview(phoneNumberLabel)
        self.addSubview(skillsLabel)
        self.addSubview(skillsValueLabel)
    }
    
    func makeConstraints() {
        makeImageViewConstraints()
        makeNameLabelConstraints()
        makePhoneImageViewConstraints()
        makePhoneNumberConstraints()
        makeSkillsConstraints()
        makeSkillsValueConstraints()
    }
    
    func makeImageViewConstraints() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingOffset))
        constraints.append(userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(userImage.heightAnchor.constraint(equalToConstant: Constants.userImageViewSize))
        constraints.append(userImage.widthAnchor.constraint(equalToConstant: Constants.userImageViewSize))

        NSLayoutConstraint.activate(constraints)
    }
    
    func makeNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: self.userImage.trailingAnchor, constant: Constants.leadingOffset))
        constraints.append(nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5))
        constraints.append(nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3))

        NSLayoutConstraint.activate(constraints)
    }
    
    func makePhoneImageViewConstraints() {
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(phoneImageView.leadingAnchor.constraint(equalTo: self.userImage.trailingAnchor, constant: Constants.leadingOffset))
        constraints.append(phoneImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor))
        constraints.append(phoneImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15))
        constraints.append(phoneImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1))

        NSLayoutConstraint.activate(constraints)
    }
    
    func makePhoneNumberConstraints() {
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(phoneNumberLabel.leadingAnchor.constraint(equalTo: self.phoneImageView.trailingAnchor, constant: 5))
        constraints.append(phoneNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(phoneNumberLabel.topAnchor.constraint(equalTo: phoneImageView.topAnchor))
        constraints.append(phoneNumberLabel.heightAnchor.constraint(equalTo: phoneImageView.heightAnchor))

        NSLayoutConstraint.activate(constraints)
    }

    func makeSkillsConstraints() {
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(skillsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor))
        constraints.append(skillsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(skillsLabel.topAnchor.constraint(equalTo: phoneImageView.bottomAnchor, constant: 4))
        constraints.append(skillsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15))

        NSLayoutConstraint.activate(constraints)
    }
    
    func makeSkillsValueConstraints() {
        skillsValueLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(skillsValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor))
        constraints.append(skillsValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(skillsValueLabel.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor))
        constraints.append(skillsValueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4))

        NSLayoutConstraint.activate(constraints)
    }
}

private extension ListViewCell {
    enum Constants {
        static let personImageName: String = "person.crop.circle.fill"
        static let nameLabelFontSize: CGFloat = 20.0
        static let phoneImageName: String = "phone"
        static let phoneNumberFontSize: CGFloat = 15.0
        static let skillsLabelText: String = "Main skills:"
        static let skillsLabelFontSize: CGFloat = 13.0
        static let skillsValueFontSize: CGFloat = 15.0
        static let separator: String = ", "
        static let cellCornerRadius: CGFloat = 20
        static let leadingOffset: CGFloat = 10
        static let userImageViewSize: CGFloat = 60
    }
}
