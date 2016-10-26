//
//  RouteViewController.swift
//  TransitApp01
//
//  Created by Matthias Zarzecki on 25/10/16.
//  Copyright © 2016 Matthias Zarzecki. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var price: UILabel!
  @IBOutlet weak var disclaimer: UILabel!
  @IBOutlet weak var providerIcon: UIWebView!
  
  var detailItem: Route?
  var objects = [RouteSegment]()
  
  // MARK: - Setup Functions

  func configureView() {
    if let detail = self.detailItem {
      name.text = Route.getDisplayName(route: detail)
      price.text = Route.getPriceString(route: detail)
      disclaimer.text = detail.disclaimer ?? ""
      
      if let request = Route.getProviderIconRequestURL(route: detail) {
        providerIcon.loadRequest(request)
      }
      
      let newSegment = RouteSegment()
      newSegment.title = "Cell Title"
      objects.append(newSegment)
    }
  }
  
  // MARK: - View Functions

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let object = objects[(indexPath as NSIndexPath).row]
    cell.textLabel?.text = object.title
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
}