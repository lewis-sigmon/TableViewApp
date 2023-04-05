//
//  ViewController.swift
//  TableStory
//
//  Created by Sigmon, Lewis P on 3/22/23.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Brew and Brew", type: "Coffee & Food", desc: "Not only brews coffee but beer aswell, hence the name.", lat: 30.264614946562336, long: -97.73305951483454, imageName: "brewbrew"),
    Item(name: "Revival Coffee", type: "Coffee", desc: "Latina owned coffee shop recognized for its pink design. Includes adjoining food truck courtyard and hammock lounge.", lat: 30.264474980448913, long: -97.72774740134187, imageName: "revivalcoffee"),
    Item(name: "Easy Tiger", type: "Coffee & Food", desc: "Coffee shop that also includes outdoor area. Has a dog friendly park and outdoor games such as ping pong, corn hole and more.", lat: 30.26426584703827, long: -97.72703281668487, imageName: "easytiger"),
    Item(name: "Royal Blue Grocery", type: "Coffee & Food", desc: "This coffee shop is also a grocery store. Open till late at night.", lat: 30.26507731364953, long: -97.74207188969949, imageName: "royalblue"),
    Item(name: "Lazarus", type: "Coffee & Food", desc: "Cozy brewery for house beers, plus root beer, kombucha, espresso & house tacos.", lat: 30.261841717009492, long: -97.72202395901338, imageName: "lazarus")
   
]

struct Item {
    var name: String
    var type: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate,
UITableViewDataSource {

    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      return cell!
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //add to ViewDidLoad, name corresponds to name of TableView
        theTable.delegate = self
        theTable.dataSource = self  //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
        
     // loop through the items in the dataset and place them on the map
         for item in data {
            let annotation = MKPointAnnotation()
            let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
            annotation.coordinate = eachCoordinate
                annotation.title = item.name
                mapView.addAnnotation(annotation)
                }}
    

}

