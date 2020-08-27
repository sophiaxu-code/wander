//
//  ViewController.swift
//  traveljournalios
//
//  Created by Sophia Xu on 11/20/19.
//  Copyright © 2019 Sophia Xu. All rights reserved.
//

import UIKit
import SnapKit

protocol AddTripDelegate: class{
    func AddNewTrip(tripName: String, tripLoc: String, tripDes: String, tripStart: String, tripEnd: String, imageData: Data)
}

protocol EditTripDelegate: class{
    func editTrip(tripName: String, tripStart: String, tripEnd: String, tripLoc: String, imageData: Data, trip: Trip)
}

class ViewController: UIViewController {
    var tripCollectionView: UICollectionView!
    var trips: [Trip]!
    let tripCellReuseIdentifier = "tripCellReuseIdentifier"
    let padding: CGFloat = 8
    
    var myTripsLabel: UILabel!
    var searchBarTextField: UITextField!
    var addTripButton: UIButton!
    let mainFontColor = UIColor(red: 42/255, green: 54/255, blue: 157/255, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        
        tripCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tripCollectionView.backgroundColor = .white
        tripCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripCollectionView)
        tripCollectionView.register(TripCollectionViewCell.self, forCellWithReuseIdentifier: tripCellReuseIdentifier)
        tripCollectionView.showsVerticalScrollIndicator = false
        tripCollectionView.dataSource = self
        tripCollectionView.delegate = self
        
        myTripsLabel = UILabel()
        myTripsLabel.translatesAutoresizingMaskIntoConstraints = false
        myTripsLabel.text = "My Trips"
        myTripsLabel.textColor = mainFontColor
        myTripsLabel.backgroundColor = .white
        myTripsLabel.font = UIFont(name: "GillSans", size: 34)
        view.addSubview(myTripsLabel)
        
        searchBarTextField = UITextField()
        searchBarTextField.translatesAutoresizingMaskIntoConstraints = false
        searchBarTextField.placeholder = "Search"
        searchBarTextField.font = UIFont.systemFont(ofSize: 12)
        searchBarTextField.borderStyle = .roundedRect
        view.addSubview(searchBarTextField)
        
        let addTripButtonImage = UIImage(named: "addanewtrip") as UIImage?
        addTripButton = UIButton()
        addTripButton.translatesAutoresizingMaskIntoConstraints = false
        addTripButton.layer.cornerRadius = 20
        addTripButton.clipsToBounds = true
        addTripButton.setBackgroundImage(addTripButtonImage, for: .normal)
        addTripButton.setTitle("START YOUR NEXT ADVENTURE", for: .normal)
        addTripButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
        addTripButton.setTitleColor(.white, for: .normal)
        addTripButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        view.addSubview(addTripButton)
        
        
        // Testing Hard Code


        trips = []



        setupConstraints()
//        getTrips()
    }
    
    func setupConstraints(){
        let padding: CGFloat = 45
        NSLayoutConstraint.activate([
            myTripsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 126),
            myTripsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            addTripButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addTripButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 211),
            addTripButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.18),
            addTripButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.95),
        ])
        
        NSLayoutConstraint.activate([
            tripCollectionView.topAnchor.constraint(equalTo: addTripButton.bottomAnchor, constant: 19),
            tripCollectionView.leadingAnchor.constraint(equalTo: addTripButton.leadingAnchor),
            tripCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tripCollectionView.trailingAnchor.constraint(equalTo:
                addTripButton.trailingAnchor)
               ])
    }
    
    func getTrips() {
        NetworkManager.getTrips { trips in
            // once we have an actual json, uncomment line below
//            self.trips = trips
//            print(self.trips)
            DispatchQueue.main.async {
                self.tripCollectionView.reloadData()
            }
       }
}
    @objc func addItem(){
        let viewController = AddTripViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tripCellReuseIdentifier, for: indexPath) as! TripCollectionViewCell
        cell.configure(for: trips[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.frame.width
        return CGSize(width: size, height: 215)
    }
}

extension ViewController: UICollectionViewDelegate{
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let trip = trips[indexPath.row]
    let viewController = TripViewController(trip: trip)
    viewController.delegate = self
    navigationController?.pushViewController(viewController, animated: true)

    }
}

extension ViewController: AddTripDelegate{
    func AddNewTrip(tripName: String, tripLoc: String, tripDes: String, tripStart: String, tripEnd: String, imageData: Data){
        let newTrip = Trip(tripName: tripName, tripStartDate: tripStart, tripEndDate: tripEnd, tripLocation: tripLoc, imageData: imageData, tripDescription: tripDes, timelineEvents: [])
        trips.append(newTrip)
        tripCollectionView.reloadData()
    }
    
}

extension ViewController: EditTripDelegate{
    func editTrip(tripName: String, tripStart: String, tripEnd: String, tripLoc: String, imageData: Data, trip: Trip) {
        let name = trip.tripName
        if let first = trips.firstIndex(where: {$0.tripName == name}){
            trips[first].tripName = tripName
            trips[first].tripLocation = tripLoc
            trips[first].tripStartDate = tripStart
            trips[first].tripEndDate = tripEnd
            trips[first].imageData = imageData
        }
        navigationController?.dismiss(animated: false, completion: nil)
        tripCollectionView.reloadData()
        
    }
}
