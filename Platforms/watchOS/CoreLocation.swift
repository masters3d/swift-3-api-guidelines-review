
typealias CLBeaconMajorValue = UInt16
typealias CLBeaconMinorValue = UInt16
@available(watchOS 2.0, *)
class CLCircularRegion : CLRegion {
  init(center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String)
  var center: CLLocationCoordinate2D { get }
  var radius: CLLocationDistance { get }
  func contains(coordinate: CLLocationCoordinate2D) -> Bool
  @available(watchOS, introduced=2.0, deprecated=2.0)
  init(circularRegionWithCenter center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String)
  init()
  init?(coder aDecoder: Coder)
}
enum CLError : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case LocationUnknown
  case Denied
  case Network
  case HeadingFailure
  case RegionMonitoringDenied
  case RegionMonitoringFailure
  case RegionMonitoringSetupDelayed
  case RegionMonitoringResponseDelayed
  case GeocodeFoundNoResult
  case GeocodeFoundPartialResult
  case GeocodeCanceled
  case DeferredFailed
  case DeferredNotUpdatingLocation
  case DeferredAccuracyTooLow
  case DeferredDistanceFiltered
  case DeferredCanceled
  case RangingUnavailable
  case RangingFailure
}

extension CLError : _BridgedNSError {
  static var _NSErrorDomain: String { get }
  typealias RawValue = Int
}
let kCLErrorDomain: String
typealias CLGeocodeCompletionHandler = ([CLPlacemark]?, Error?) -> Void
@available(watchOS 2.0, *)
class CLGeocoder : Object {
  var isGeocoding: Bool { get }
  func reverseGeocodeLocation(location: CLLocation, completionHandler: CLGeocodeCompletionHandler)
  func geocodeAddressDictionary(addressDictionary: [Object : AnyObject], completionHandler: CLGeocodeCompletionHandler)
  func geocodeAddressString(addressString: String, completionHandler: CLGeocodeCompletionHandler)
  func geocodeAddressString(addressString: String, in region: CLRegion?, completionHandler: CLGeocodeCompletionHandler)
  func cancelGeocode()
  init()
}
typealias CLHeadingComponentValue = Double
let kCLHeadingFilterNone: CLLocationDegrees
typealias CLLocationDegrees = Double
typealias CLLocationAccuracy = Double
typealias CLLocationSpeed = Double
typealias CLLocationDirection = Double
struct CLLocationCoordinate2D {
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  init()
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}
typealias CLLocationDistance = Double
let kCLDistanceFilterNone: CLLocationDistance
@available(watchOS 2.0, *)
let kCLLocationAccuracyBestForNavigation: CLLocationAccuracy
let kCLLocationAccuracyBest: CLLocationAccuracy
let kCLLocationAccuracyNearestTenMeters: CLLocationAccuracy
let kCLLocationAccuracyHundredMeters: CLLocationAccuracy
let kCLLocationAccuracyKilometer: CLLocationAccuracy
let kCLLocationAccuracyThreeKilometers: CLLocationAccuracy
@available(watchOS 2.0, *)
let CLLocationDistanceMax: CLLocationDistance
@available(watchOS 2.0, *)
let CLTimeIntervalMax: TimeInterval
@available(watchOS 2.0, *)
let kCLLocationCoordinate2DInvalid: CLLocationCoordinate2D
@available(watchOS 2.0, *)
func CLLocationCoordinate2DIsValid(coord: CLLocationCoordinate2D) -> Bool
@available(watchOS 2.0, *)
func CLLocationCoordinate2DMake(latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) -> CLLocationCoordinate2D
@available(watchOS 2.0, *)
class CLFloor : Object, Copying, SecureCoding {
  var level: Int { get }
  init()
  @available(watchOS 2.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(watchOS 2.0, *)
  class func supportsSecureCoding() -> Bool
  @available(watchOS 2.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}
@available(watchOS 2.0, *)
class CLLocation : Object, Copying, SecureCoding {
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
  init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, timestamp: Date)
  @available(watchOS 2.0, *)
  init(coordinate: CLLocationCoordinate2D, altitude: CLLocationDistance, horizontalAccuracy hAccuracy: CLLocationAccuracy, verticalAccuracy vAccuracy: CLLocationAccuracy, course: CLLocationDirection, speed: CLLocationSpeed, timestamp: Date)
  var coordinate: CLLocationCoordinate2D { get }
  var altitude: CLLocationDistance { get }
  var horizontalAccuracy: CLLocationAccuracy { get }
  var verticalAccuracy: CLLocationAccuracy { get }
  @NSCopying var timestamp: Date { get }
  @available(watchOS 2.0, *)
  @NSCopying var floor: CLFloor? { get }
  var description: String { get }
  @available(watchOS 2.0, *)
  func distanceFrom(location: CLLocation) -> CLLocationDistance
  init()
  @available(watchOS 2.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(watchOS 2.0, *)
  class func supportsSecureCoding() -> Bool
  @available(watchOS 2.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}
enum CLDeviceOrientation : Int32 {
  init?(rawValue: Int32)
  var rawValue: Int32 { get }
  case Unknown
  case Portrait
  case PortraitUpsideDown
  case LandscapeLeft
  case LandscapeRight
  case FaceUp
  case FaceDown
}
enum CLAuthorizationStatus : Int32 {
  init?(rawValue: Int32)
  var rawValue: Int32 { get }
  case NotDetermined
  case Restricted
  case Denied
  @available(watchOS 2.0, *)
  case AuthorizedAlways
  @available(watchOS 2.0, *)
  case AuthorizedWhenInUse
}
enum CLActivityType : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Other
  case AutomotiveNavigation
  case Fitness
  case OtherNavigation
}
@available(watchOS 2.0, *)
class CLLocationManager : Object {
  @available(watchOS 2.0, *)
  class func locationServicesEnabled() -> Bool
  @available(watchOS 2.0, *)
  class func authorizationStatus() -> CLAuthorizationStatus
  unowned(unsafe) var delegate: @sil_unmanaged CLLocationManagerDelegate?
  var distanceFilter: CLLocationDistance
  var desiredAccuracy: CLLocationAccuracy
  @NSCopying var location: CLLocation? { get }
  @available(watchOS 2.0, *)
  func requestWhenInUseAuthorization()
  @available(watchOS 2.0, *)
  func requestAlwaysAuthorization()
  func stopUpdatingLocation()
  @available(watchOS 2.0, *)
  func requestLocation()
  init()
}
protocol CLLocationManagerDelegate : ObjectProtocol {
  @available(watchOS 2.0, *)
  optional func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  @available(watchOS 2.0, *)
  optional func locationManager(manager: CLLocationManager, didFailWithError error: Error)
  @available(watchOS 2.0, *)
  optional func locationManager(manager: CLLocationManager, didChange status: CLAuthorizationStatus)
}
extension CLLocationManager {
}
@available(watchOS 2.0, *)
class CLPlacemark : Object, Copying, SecureCoding {
  init(placemark: CLPlacemark)
  @NSCopying var location: CLLocation? { get }
  @NSCopying var region: CLRegion? { get }
  @available(watchOS 2.0, *)
  @NSCopying var timeZone: TimeZone? { get }
  var addressDictionary: [Object : AnyObject]? { get }
  var name: String? { get }
  var thoroughfare: String? { get }
  var subThoroughfare: String? { get }
  var locality: String? { get }
  var subLocality: String? { get }
  var administrativeArea: String? { get }
  var subAdministrativeArea: String? { get }
  var postalCode: String? { get }
  var isOcountryCode: String? { get }
  var country: String? { get }
  var inlandWater: String? { get }
  var ocean: String? { get }
  var areasOfInterest: [String]? { get }
  init()
  @available(watchOS 2.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(watchOS 2.0, *)
  class func supportsSecureCoding() -> Bool
  @available(watchOS 2.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}
@available(watchOS 2.0, *)
class CLRegion : Object, Copying, SecureCoding {
  @available(watchOS, introduced=2.0, deprecated=2.0)
  init(circularRegionWithCenter center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String)
  @available(watchOS, introduced=2.0, deprecated=2.0)
  var center: CLLocationCoordinate2D { get }
  @available(watchOS, introduced=2.0, deprecated=2.0)
  var radius: CLLocationDistance { get }
  @available(watchOS 2.0, *)
  var identifier: String { get }
  @available(watchOS 2.0, *)
  var notifyOnEntry: Bool
  @available(watchOS 2.0, *)
  var notifyOnExit: Bool
  @available(watchOS, introduced=2.0, deprecated=2.0)
  func contains(coordinate: CLLocationCoordinate2D) -> Bool
  init()
  @available(watchOS 2.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(watchOS 2.0, *)
  class func supportsSecureCoding() -> Bool
  @available(watchOS 2.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}
