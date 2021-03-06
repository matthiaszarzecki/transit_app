//
//  RouteViewController.swift
//  TransitApp01
//
//  Created by Matthias Zarzecki on 25/10/16.
//  Copyright © 2016 Matthias Zarzecki. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var price: UILabel!
  @IBOutlet weak var disclaimer: UILabel!
  @IBOutlet weak var providerIcon: UIWebView!
  
  var detailItem: Route?
  var objects = [RouteSegment]()
  
  // MARK: - Setup Functions

  func configureView() {
    if let detail = self.detailItem {
      price.text = Route.getPriceString(route: detail)
      disclaimer.text = detail.disclaimer ?? ""
      
      if let request = Route.getProviderIconRequestURL(route: detail) {
        providerIcon.loadRequest(request)
      }
      
      for segment in detail.segments! {
        if let segmentData = segment as? Dictionary<String, AnyObject> {
          objects.append(createRouteSegment(segmentData: segmentData))
        }
      }
    }
  }
  
  func createRouteSegment(segmentData: Dictionary<String, AnyObject>) -> RouteSegment {
    let newSegment = RouteSegment()
    newSegment.description = (segmentData[Keys.Description] as? String) ?? ""
    newSegment.numStops = (segmentData[Keys.NumStops] as? Int) ?? 0
    newSegment.color = (segmentData[Keys.Color] as? String) ?? ""
    newSegment.iconURL = (segmentData[Keys.IconURL] as? String) ?? ""
    newSegment.polyline = (segmentData[Keys.Polyline] as? String) ?? ""
    newSegment.travelMode = (segmentData[Keys.TravelMode] as? String) ?? ""
    newSegment.stops = (segmentData[Keys.Stops] as? Array<AnyObject>) ?? nil
    newSegment.name = (segmentData[Keys.Name] as? String) ?? ""
    newSegment.displayName = RouteSegment.getSegmentDisplayName(segment: newSegment)
    return newSegment
  }

  // MARK: - View Functions

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - TableView Functions
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RouteSegmentCell
    let object = objects[(indexPath as NSIndexPath).row]
    cell.displayName.text = object.displayName
    cell.displayNumStops.text = RouteSegment.getNumStopsDisplay(routeSegment: object)
    if let request = RouteSegment.getProviderIconRequestURL(route: object) {
      cell.providerIcon.loadRequest(request)
    }
    if let colorString = object.color {
      let color = UIColor.colorFromHex(hex: colorString)
      cell.displayName.textColor = color
      cell.displayNumStops.textColor = color
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
}
