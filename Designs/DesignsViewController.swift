//
//  DesignsViewController.swift
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 03. 05..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

import UIKit

class DesignsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DesignCellLongPressProtocol {
    private struct Constants {
        static let title: String = "Designs"
        static let newDesignCellReuseId: String = "NewDesignCellId"
        static let designCellReuseId: String = "DesignCellId"
        static let padding: CGFloat = 52.0
        static let contentInset: UIEdgeInsets = UIEdgeInsets(top: 120.0, left: Constants.padding, bottom: 0.0, right: Constants.padding)
    }
    
    var data: [DesignData] = [DesignData(name: "Design 0", image: #imageLiteral(resourceName: "designThumbnail0")),
                              DesignData(name: "Design 1", image: #imageLiteral(resourceName: "designThumbnail1")),
                              DesignData(name: "Watch", image: #imageLiteral(resourceName: "designThumbnail2")),
                              DesignData(name: "Ring", image: #imageLiteral(resourceName: "designThumbnail3")),
                              DesignData(name: "Spring", image: #imageLiteral(resourceName: "designThumbnail4")),
                              DesignData(name: "Skyscraper", image: #imageLiteral(resourceName: "designThumbnail5")),
                              DesignData(name: "Map", image: #imageLiteral(resourceName: "designThumbnail6"))]
    
    let headerView: DashboardHeaderview = {
        let hv = DashboardHeaderview()
        hv.titleLabel.text = Constants.title
        return hv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = SizeChangingFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.register(NewDesingCell.self, forCellWithReuseIdentifier: Constants.newDesignCellReuseId)
        cv.register(DesignCell.self, forCellWithReuseIdentifier: Constants.designCellReuseId)
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = true
        cv.contentInset = Constants.contentInset
        cv.allowsMultipleSelection = false
        return cv
    }()
    
    private let editButton: UIButton = {
        let b = UIButton()
        b.setTitle("Edit", for: .normal)
        b.contentHorizontalAlignment = .right
        b.setTitleColor(UIColor.ppkeBlue, for: .normal)
        b.setTitleColor(UIColor.ppkeGrey, for: .disabled)
        b.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        return b
    }()
    
    private let duplicateButton: UIButton = {
        let b = UIButton()
        b.setTitle("Duplicate", for: .normal)
        b.contentHorizontalAlignment = .right
        b.setTitleColor(UIColor.ppkeBlue, for: .normal)
        b.setTitleColor(UIColor.ppkeGrey, for: .disabled)
        b.addTarget(self, action: #selector(duplicateButtonTapped(_:)), for: .touchUpInside)
        return b
    }()
    
    private let deleteButton: UIButton = {
        let b = UIButton()
        b.setTitle("Delete", for: .normal)
        b.contentHorizontalAlignment = .right
        b.setTitleColor(UIColor.ppkeBlue, for: .normal)
        b.setTitleColor(UIColor.ppkeGrey, for: .disabled)
        b.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return b
    }()
    
    private let doneButton: UIButton = {
        let b = UIButton()
        b.setTitle("Done", for: .normal)
        b.contentHorizontalAlignment = .right
        b.setTitleColor(UIColor.ppkeBlue, for: .normal)
        b.setTitleColor(UIColor.ppkeGrey, for: .disabled)
        b.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        return b
    }()
    
    private lazy var editButtonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(duplicateButton)
        sv.addArrangedSubview(deleteButton)
        sv.addArrangedSubview(doneButton)
        sv.spacing = 20.0
        return sv
    }()
    
    private var normalModeConstraintForEditButtons: NSLayoutConstraint!
    private var normalModeConstraintForEditButton: NSLayoutConstraint!
    private var editModeConstraintForEditButtons: NSLayoutConstraint!
    private var editModeConstraintForEditButton: NSLayoutConstraint!

    override func loadView() {
        view = UIView()
        
        var constraints: [NSLayoutConstraint] = []
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        constraints.append(contentsOf: [headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        headerView.topAnchor.constraint(equalTo: view.topAnchor),
                                        headerView.heightAnchor.constraint(equalToConstant: headerView.height)])

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(collectionView, belowSubview: headerView)
        constraints.append(contentsOf: [collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                        collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        editButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(editButtonsStackView)
        editModeConstraintForEditButtons = editButtonsStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,
                                                                                          constant: -52.0)
        normalModeConstraintForEditButtons = editButtonsStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,
                                                                                            constant: 300.0)
        constraints.append(contentsOf: [normalModeConstraintForEditButtons,
                                        editButtonsStackView.centerYAnchor.constraint(equalTo: headerView.titleLabel.centerYAnchor)])
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(editButton)
        editModeConstraintForEditButton = editButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,
                                                                               constant: 300.0)
        normalModeConstraintForEditButton = editButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,
                                                                                 constant: -52.0)
        constraints.append(contentsOf: [normalModeConstraintForEditButton,
                                        editButton.centerYAnchor.constraint(equalTo: headerView.titleLabel.centerYAnchor)])
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.isNewDesign {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.newDesignCellReuseId, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.designCellReuseId, for: indexPath) as! DesignCell
            let currentData = data[indexPath.realItemIndex % data.count]
            cell.image = currentData.image
            cell.title = currentData.name
            cell.longPressDelegate = self
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnNumber: CGFloat = 3.0
        let width = collectionView.bounds.size.width - collectionView.contentInset.left - collectionView.contentInset.right - (columnNumber - 1) * Constants.padding
        return CGSize(width: width / 3.0, height: 254.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
        if indexPath.isNewDesign {
            addButtonTapped(self)
        } else {
            updateEditButtonsState()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateEditButtonsState()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if isEditing && indexPath.isNewDesign {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Actions
    @objc private func addButtonTapped(_ sender: Any) {
        let newData = data[Int(arc4random_uniform(UInt32(data.count)))]
        data.insert(newData, at: 0)
        collectionView.insertItems(at: [IndexPath(row: 1, section: 0)])
    }
    
    @objc private func editButtonTapped(_ sender: Any) {
        updateUIForEditing(true)
    }
    
    @objc private func duplicateButtonTapped(_ sender: Any) {
        guard let selectedItems = collectionView.indexPathsForSelectedItems else {
            return
        }
        let indicesToDuplicate: [Int] = selectedItems.map { return $0.realItemIndex }.sorted()
        let duplicatedData = data.enumerated().filter({ indicesToDuplicate.contains($0.offset) }).map({ return ($0.offset + 1, $0.element) })
        var duplicatedIndexPaths: [IndexPath] = []
        for (index , (i, d)) in duplicatedData.enumerated() {
            data.insert(d, at: i + index)
            duplicatedIndexPaths.append(IndexPath(row: i + index + 1, section: 0))
        }
        collectionView.insertItems(at: duplicatedIndexPaths)
        updateUIForEditing(false)
    }
    
    @objc private func deleteButtonTapped(_ sender: Any) {
        guard let selectedItems = collectionView.indexPathsForSelectedItems else {
            return
        }
        let indicesToRemove: [Int] = selectedItems.map { return $0.realItemIndex }
        data = data.enumerated().filter({ !indicesToRemove.contains($0.offset) }).map({ $0.element })
        collectionView.deleteItems(at: selectedItems)
        updateUIForEditing(false)
    }
    
    @objc private func doneButtonTapped(_ sender: Any) {
        updateUIForEditing(false)
    }
    
    private func updateUIForEditing(_ editing: Bool) {
        isEditing = editing
        
        if editing {
            NSLayoutConstraint.deactivate([normalModeConstraintForEditButton, normalModeConstraintForEditButtons])
            NSLayoutConstraint.activate([editModeConstraintForEditButton, editModeConstraintForEditButtons])
        } else {
            NSLayoutConstraint.deactivate([editModeConstraintForEditButton, editModeConstraintForEditButtons])
            NSLayoutConstraint.activate([normalModeConstraintForEditButton, normalModeConstraintForEditButtons])
        }
        
        updateEditButtonsState()
        collectionView.allowsMultipleSelection = editing
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            selectedItems.forEach({
                collectionView.deselectItem(at: $0, animated: true)
            })
        }
        
        UIView.animate(withDuration: 0.3) {
            self.headerView.layoutIfNeeded()
        }
    }
    
    private func updateEditButtonsState() {
        let selectedItemCount = collectionView.indexPathsForSelectedItems?.count ?? 0
        duplicateButton.isEnabled = selectedItemCount > 0
        deleteButton.isEnabled = selectedItemCount > 0
    }
    
    // MARK: - DesignCellLongPressProtocol
    func longPressed(cell: DesignCell) {
        let indexPath = collectionView.indexPath(for: cell)
        updateUIForEditing(true)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
    }
}

extension IndexPath {
    var isNewDesign: Bool { return item == 0 }
    var realItemIndex: Int { return item - 1 }
}

class SizeChangingFlowLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView!.bounds.width != newBounds.width
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        let shouldInvalidate = collectionView!.bounds.size.width != newBounds.width
        context.invalidateFlowLayoutDelegateMetrics = shouldInvalidate
        context.invalidateFlowLayoutAttributes = shouldInvalidate
        return context
    }
}
