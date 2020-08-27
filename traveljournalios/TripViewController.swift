//
//  TripViewController.swift
//  traveljournalios
//
//  Created by Sophia Xu on 11/22/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit
import SnapKit

protocol addEventtoTimeLineDelegate: class {
    func addEvent(to event: TimelineEvent)
}

protocol editTheTripDelegate: class{
    func editTheTrip(tripName: String, tripStart: String, tripEnd: String, tripLoc: String, imageData: Data)
}

class TripViewController: UIViewController {
    var trip: Trip!
    var headImage: UIImageView!
    var dateLabel: UILabel!
    var editButton: UIButton!
    var tripTitle: UILabel!
    var locationLabel: UILabel!
    var tripSummaryLabel: UILabel!
    var tripDescription: UITextView!
    var timelineLabel: UILabel!
    var timelineAddButton: UIButton!
    
    var timelineTableView: UITableView!
    let timelineReuseIdentifier = "timelineReuseIdentifier"
    let cellHeight: CGFloat = 126
    
    let mainFontColor = UIColor(red: 42/255, green: 54/255, blue: 157/255, alpha: 1)
    let fillColor = UIColor(red: 42/255, green: 54/255, blue: 157/255, alpha: 0.15)
    var lineColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor

    var delegate: EditTripDelegate?
    
    init(trip: Trip){
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUILabel(textColor: UIColor, text: String, fontSize: CGFloat) -> UILabel {
        let newUILabel: UILabel! = UILabel()
        newUILabel.text = text
        newUILabel.textColor = textColor
        newUILabel.font = UIFont(name: "GillSans", size: fontSize)
        return newUILabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = trip.tripName
        view.backgroundColor = .white
        
        headImage = UIImageView(image: UIImage(data: trip.imageData!))
        view.addSubview(headImage)
        
        tripTitle = initUILabel(textColor: mainFontColor, text: trip.tripName, fontSize: 28)
        locationLabel = initUILabel(textColor: .black, text: trip.tripLocation, fontSize: 13)
        dateLabel = initUILabel(textColor: .black, text: trip.tripStartDate, fontSize: 13)
        tripSummaryLabel = initUILabel(textColor: mainFontColor, text: "Trip Summary: ", fontSize: 17)
        timelineLabel = initUILabel(textColor: mainFontColor, text: "Timeline", fontSize: 17)

        view.addSubview(tripTitle)
        view.addSubview(locationLabel)
        view.addSubview(dateLabel)
        view.addSubview(tripSummaryLabel)
        view.addSubview(timelineLabel)
               
        tripDescription = UITextView()
        tripDescription.text = trip.tripDescription
        tripDescription.textColor = .black
        tripDescription.isEditable = true
        tripDescription.layer.backgroundColor = fillColor.cgColor
        tripDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripDescription)
        
        let addButtonImage = UIImage(named: "plusIcon")
        timelineAddButton = UIButton()
        timelineAddButton.translatesAutoresizingMaskIntoConstraints = false
        timelineAddButton.setBackgroundImage(addButtonImage, for: .normal)
        timelineAddButton.addTarget(self, action: #selector(addTimelineItem), for: .touchUpInside)
        view.addSubview(timelineAddButton)
        
        let editButtonImage = UIImage(named: "editicon") as UIImage?
        editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setBackgroundImage(editButtonImage, for: .normal)
        editButton.addTarget(self, action: #selector(editTripDetails), for: .touchUpInside)
        view.addSubview(editButton)
        
        timelineTableView = UITableView()
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        timelineTableView.translatesAutoresizingMaskIntoConstraints = false
        timelineTableView.register(TimelineTableViewCell.self, forCellReuseIdentifier: timelineReuseIdentifier)
        view.addSubview(timelineTableView)
        
        timelineTableView.reloadData()
        setupConstraints()
    }
    
    @objc func addTimelineItem(){
        let viewController = TimelineViewController()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func editTripDetails(){
        let viewController = EditTripViewController()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

    func setupConstraints(){
        headImage.snp.makeConstraints { make in
            make.left.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height * 0.305)
            
        }
        tripTitle.snp.makeConstraints{ make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(headImage.snp.bottom)//.offset(11)
            make.height.equalTo(34)
        }
        
        editButton.snp.makeConstraints{ make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-(view.frame.width * 0.07))//33.83)
            make.centerY.equalTo(tripTitle.snp.centerY)
            make.width.equalTo(25)
            make.height.equalTo(25)
                       
        }
        locationLabel.snp.makeConstraints{ make in
            make.left.equalTo(tripTitle.snp.left)
            make.top.equalTo(tripTitle.snp.bottom).offset(2)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.top)
            make.left.equalTo(locationLabel.snp.right).offset(8)
        }
        
        tripSummaryLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        tripDescription.snp.makeConstraints { make in
            make.top.equalTo(tripSummaryLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(68)
        }
        
        timelineLabel.snp.makeConstraints { make in
           make.top.equalTo(tripDescription.snp.bottom).offset(14)
           make.left.equalTo(view.safeAreaLayoutGuide).offset(26)
       }
    
        
        NSLayoutConstraint.activate([
            timelineAddButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.86),
            timelineAddButton.topAnchor.constraint(equalTo: tripDescription.bottomAnchor, constant: 14),
            timelineAddButton.heightAnchor.constraint(equalToConstant: 20),
            timelineAddButton.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        timelineTableView.snp.makeConstraints { make in
            make.top.equalTo(timelineLabel.snp.bottom).offset(18)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
    }
}
extension TripViewController: addEventtoTimeLineDelegate{
    func addEvent(to event: TimelineEvent) {
        trip.timelineEvents.append(event)
        timelineTableView.reloadData()
    }
}
extension TripViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip.timelineEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: timelineReuseIdentifier, for: indexPath) as! TimelineTableViewCell
        let timelineEvent = trip.timelineEvents[indexPath.row]
        cell.configure(for: timelineEvent)
        cell.selectionStyle = .none
        return cell
    }
}

extension TripViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension TripViewController: editTheTripDelegate{
    func editTheTrip(tripName: String, tripStart: String, tripEnd: String, tripLoc: String, imageData: Data) {
        delegate?.editTrip(tripName: tripName, tripStart: tripStart, tripEnd: tripEnd, tripLoc: tripLoc, imageData: imageData, trip: self.trip)
        navigationController?.popViewController(animated: true)
    }
}
