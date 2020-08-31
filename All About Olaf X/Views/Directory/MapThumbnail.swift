//
//  MapThumbnail.swift
//  All About Olaf X
//
//  Created by Drew Volz on 8/26/20.
//
// https://swiftwithmajid.com/2020/07/29/using-mapkit-with-swiftui/
// http://synappse.co/blog/showing-map-preview-with-mkmapsnapshotter/

import SwiftUI
import MapKit

struct MapThumbnail: View {
    var address: String

    @State var image = UIImage()
    var imageCache = MapImageCache.getImageCache()

    init(address: String) {
        self.address = address
    }
    
    private func getLocation() {
        guard !address.isEmpty else {
            return
        }
        
        if let cacheImage = imageCache.get(forKey: address) {
            self.image = cacheImage
            return
        }
        
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                snapshot(location: location, completionHandler: {
                    self.image = $0
                })
            }
        }
    }
    
    private func snapshot(location: CLLocation, completionHandler: @escaping (UIImage) -> Void) {
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(center: location.coordinate, span: span)
        options.size = CGSize(width: 90, height: 90)
        options.pointOfInterestFilter = .excludingAll

        let snapshotter = MKMapSnapshotter(options: options)

        snapshotter.start { (snapshot, error) in
            guard error == nil else {
                return
            }
            
            if let snapshot = snapshot {
                drawPin(snapshot: snapshot, location: location, completionHandler: completionHandler)
            }
        }
    }
    
    private func drawPin(snapshot: MKMapSnapshotter.Snapshot, location: CLLocation, completionHandler: @escaping (UIImage) -> Void) {
        let snapShotImage = snapshot.image
        let coordinatePoint = snapshot.point(for: location.coordinate)

        let pinImage = UIImage(symbol: .mapPinCircleFill)!
            .withTintColor(.systemRed)
            .resized(to: CGSize(width: 30, height: 30))

        UIGraphicsBeginImageContextWithOptions(snapShotImage.size, true, snapShotImage.scale)
        snapShotImage.draw(at: CGPoint.zero)
        
        // need to fix the point position to match the anchor point of pin which is in middle bottom of the frame
        let fixedPinPoint = CGPoint(x: coordinatePoint.x - pinImage.size.width / 2, y: coordinatePoint.y - pinImage.size.height)

        pinImage.draw(at: fixedPinPoint)
        
        let mapImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if let annotatedImage = mapImage {
            imageCache.set(forKey: address, image: annotatedImage)
        }

        completionHandler(mapImage ?? UIImage())
        UIGraphicsEndImageContext()
    }

    var body: some View {
        Image(uiImage: image)
            .frame(width: 90, height: 90)
            .cornerRadius(5.0)
            .onAppear {
                getLocation()
            }
    }
}

// MARK: Image caching

class MapImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension MapImageCache {
    private static var imageCache = MapImageCache()
    static func getImageCache() -> MapImageCache {
        return imageCache
    }
}


extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

struct MapThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        MapThumbnail(address: "1500 St. Olaf Ave, Northfield MN 55057")
    }
}
