//
//  ViewController.swift
//  CellarTracker
//
//  Created by Damien Bannerot on 29/09/2016.
//  Copyright © 2016 Damien Bannerot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var bottlesTableView: UITableView!
	
	var manager: CoreDataManager?
	var bottlesArray: [Bottle] = []
	
	override func viewDidLoad() {
		
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidLoad()
		self.loadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Helpers
	
	func loadData() {
		self.bottlesArray = CoreDataManager.shared.retrieveExistingBottles()
		self.bottlesTableView.reloadData()

	}
	
	// MARK: UITableViewDataSource
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.bottlesArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//TODO: relocate to custom cell class
		var cell = tableView.dequeueReusableCell(withIdentifier: "wineBottleTableViewCell") as? WineBottleTableViewCell
		if (cell == nil) {
			cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "wineBottleTableViewCell") as? WineBottleTableViewCell
		}
		print(self.bottlesArray[indexPath.row].name!)
		cell!.wineBottleNameLabel.text = "\(self.bottlesArray[indexPath.row].name!) \(self.bottlesArray[indexPath.row].year)"
		cell!.wineBottleCountLabel.text = "\(self.bottlesArray[indexPath.row].count) 🍾"
		cell!.wineBottleImageView.image = UIImage.init(data: self.bottlesArray[indexPath.row].image! as Data)
		if let domain = self.bottlesArray[indexPath.row].fromDomain {
			cell!.wineBottleDomainLabel.text = domain.name!
		} else {
			cell!.wineBottleDomainLabel.text = ""
		}
		if let type = self.bottlesArray[indexPath.row].isOfType {
			cell!.wineBottleTypeLabel.text = type.value!
		} else {
			cell!.wineBottleTypeLabel.text = ""
		}
		
		return cell!
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
		return UITableViewCellEditingStyle.delete
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		// CoreData deletion
		CoreDataManager.shared.managedObjectContext.delete(self.bottlesArray[indexPath.row])
		try! CoreDataManager.shared.managedObjectContext.save()
		self.bottlesArray.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
		self.loadData()
	}
}

