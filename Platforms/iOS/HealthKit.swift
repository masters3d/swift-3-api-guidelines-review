
var HKAnchoredObjectQueryNoAnchor: Int32 { get }

/*!
 @class         HKQueryAnchor
 @discussion    This object encapsulates the state of an HKAnchoredObjectQuery
 */
@available(iOS 9.0, *)
class HKQueryAnchor : Object, SecureCoding, Copying {

  /*!
   @method        anchorFromValue:
   @discussion    Creates an HKQueryAnchor with an integer anchor which was previously obtained from an HKAnchoredObjectQuery prior to iOS 9.0.
   */
  convenience init(fromValue value: Int)
  @available(iOS 9.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 9.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 9.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class         HKAnchoredObjectQuery
 @discussion    This query can be used by an application to find out about new or deleted samples in the HealthKit
                database.
 */
@available(iOS 8.0, *)
class HKAnchoredObjectQuery : HKQuery {

  /*!
   @property      updateHandler
   @abstract      An optional handler to be called when samples matching the given predicate are added or deleted.
   @discussion    This property may not be modified once the query has been executed.  It may only be set if the query has
                  no limit.
   */
  @available(iOS 9.0, *)
  var updateHandler: ((HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void)?
  @available(iOS, introduced=8.0, deprecated=9.0)
  init(type: HKSampleType, predicate: Predicate?, anchor: Int, limit: Int, completionHandler handler: (HKAnchoredObjectQuery, [HKSample]?, Int, Error?) -> Void)

  /*!
   @method        initWithType:predicate:anchor:limit:resultsHandler:
   @abstract      Returns a query that will retrieve HKSamples and HKDeletedObjects matching the given predicate that are
                  newer than the given anchor.
   @discussion    If no updateHandler is set on the query, the query will automatically stop after calling resultsHandler.
                  Otherwise, the query continues to run and call updateHandler as samples matching the predicate are
                  created or deleted.
   
   @param         type            The type of sample to retrieve.
   @param         predicate       The predicate which samples should match.
   @param         anchor          The anchor which was returned by a previous HKAnchoredObjectQuery result or update
                                  handler.  Pass nil when querying for the first time.
   @param         limit           The maximum number of samples and deleted objects to return.  Pass HKObjectQueryNoLimit
                                  for no limit.
   @param         resultsHandler  The block to invoke with results when the query has finished finding.
   */
  @available(iOS 9.0, *)
  init(type: HKSampleType, predicate: Predicate?, anchor: HKQueryAnchor?, limit: Int, resultsHandler handler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void)
}

/*!
 @class      HKCategorySample
 @abstract   An HKObject subclass representing an category measurement
 @discussion Category samples are samples that can be categorized into an enum of concrete values
 */
@available(iOS 8.0, *)
class HKCategorySample : HKSample {
  var categoryType: HKCategoryType { get }

  /*!
   @property   value
   @discussion The preferred enum for the value is determined by the receiver's category type.
   */
  var value: Int { get }

  /*!
   @method     categorySampleWithType:value:startDate:endDate:metadata:
   @abstract   Creates a new HKCategorySample.
   
   @param      type       The type of the sample.
   @param      value      The enumeration value for the sample. See HKCategoryTypeIdentifier for appropriate value.
   @param      startDate  The start date of the sample.
   @param      endDate    The end date of the sample.
   @param      metadata   Metadata for the sample (optional).
   */
  convenience init(type: HKCategoryType, value: Int, start startDate: Date, end endDate: Date, metadata: [String : AnyObject]?)

  /*!
   @method     categorySampleWithType:value:startDate:endDate:
   @abstract   Creates a new HKCategorySample.
   
   @param      type       The type of the sample.
   @param      value      The enumeration value for the sample. See HKCategoryTypeIdentifier for appropriate value.
   @param      startDate  The start date of the sample.
   @param      endDate    The end date of the sample.
   */
  convenience init(type: HKCategoryType, value: Int, start startDate: Date, end endDate: Date)

  /*!
   @method     categorySampleWithType:value:startDate:endDate:device:metadata:
   @abstract   Creates a new HKCategorySample.
   
   @param      type       The type of the sample.
   @param      value      The enumeration value for the sample. See HKCategoryTypeIdentifier for appropriate value.
   @param      startDate  The start date of the sample.
   @param      endDate    The end date of the sample.
   @param      device     The HKDevice that generated the sample (optional).
   @param      metadata   Metadata for the sample (optional).
   */
  @available(iOS 9.0, *)
  convenience init(type: HKCategoryType, value: Int, start startDate: Date, end endDate: Date, device: HKDevice?, metadata: [String : AnyObject]?)
  init?(coder aDecoder: Coder)
}

/*!
 @constant     HKPredicateKeyPathCategoryValue
 */
@available(iOS 8.0, *)
let HKPredicateKeyPathCategoryValue: String

/*!
 @class         HKCorrelation
 @abstract      An HKCorrelation is a collection of correlated objects.
 @discussion    When multiple readings are taken together, it may be beneficial to correlate them so that they can be
                displayed together and share common metadata about how they were created.
 
                For example, systolic and diastolic blood pressure readings are typically presented together so these
                readings should be saved with a correlation of type blood pressure.
 */
@available(iOS 8.0, *)
class HKCorrelation : HKSample {
  var correlationType: HKCorrelationType { get }

  /*!
   @property  objects
   @abstract  A set of HKSamples containing all of the objects that were saved with the receiver.
   */
  var objects: Set<HKSample> { get }

  /*!
   @method        correlationWithType:startDate:endDate:objects:
   @abstract      Creates a new HKCorrelation with the given type, start date, end date, and objects.
   @discussion    objects must be a set of HKQuantitySamples and HKCategorySamples
   */
  convenience init(type correlationType: HKCorrelationType, start startDate: Date, end endDate: Date, objects: Set<HKSample>)

  /*!
   @method        correlationWithType:startDate:endDate:objects:metadata:
   @abstract      Creates a new HKCorrelation with the given type, start date, end date, objects, and metadata.
   @discussion    objects must be a set of HKQuantitySamples and HKCategorySamples
   */
  convenience init(type correlationType: HKCorrelationType, start startDate: Date, end endDate: Date, objects: Set<HKSample>, metadata: [String : AnyObject]?)

  /*!
   @method        correlationWithType:startDate:endDate:objects:device:metadata:
   @abstract      Creates a new HKCorrelation with the given type, start date, end date, objects, and metadata.
   @param         type        The correlation type of the objects set.
   @param         startDate   The start date of the correlation.
   @param         endDate     The end date of the correlation.
   @param         device      The HKDevice that generated the samples (optional).
   @param         metadata    Metadata for the correlation (optional).
   @discussion    objects must be a set of HKQuantitySamples and HKCategorySamples
   */
  @available(iOS 9.0, *)
  convenience init(type correlationType: HKCorrelationType, start startDate: Date, end endDate: Date, objects: Set<HKSample>, device: HKDevice?, metadata: [String : AnyObject]?)

  /*!
   @method    objectsForType:
   @abstract  Returns the set of correlated objects with the specified type.
   */
  func objectsFor(objectType: HKObjectType) -> Set<HKSample>
  init?(coder aDecoder: Coder)
}

/*!
 @class         HKCorrelationQuery
 @abstract      A query to find HKCorrelations
 @discussion    Correlations are HKSamples that contain a set of correlated samples. HKCorrelationQuery
                accepts a predicate to filter HKCorrelations and a dictionary of predicates to filter the
                correlated samples.
 */
@available(iOS 8.0, *)
class HKCorrelationQuery : HKQuery {
  @NSCopying var correlationType: HKCorrelationType { get }

  /*!
   @property      samplePredicates
   @abstract      A dictionary of predicates for the HKCorrelation's objects
   @discussion    samplePredicates maps HKSampleTypes to NSPredicates. The predicate value will apply
                  to objects of the key type. 
   
   */
  var samplePredicates: [HKSampleType : Predicate]? { get }

  /*!
   @method    initWithTypes:predicate:samplePredicate:completion:
   @abstract  The designated initializer for HKCorrelationQuery.
  
   @param     correlationType     The type of correlation that is being queried for
  
   @param     predicate           The predicate for scoping which HKCorrelations are returned
  
   @param     samplePredicates    A dictionary mapping HKSampleTypes to NSPredicates. If no predicate for a particular type
                                  is provided, it is assumed to be a nil predicate and objects of that type will not be
                                  filtered.
   */
  init(type correlationType: HKCorrelationType, predicate: Predicate?, samplePredicates: [HKSampleType : Predicate]?, completion: (HKCorrelationQuery, [HKCorrelation]?, Error?) -> Void)
}
@available(iOS 8.0, *)
let HKErrorDomain: String

/*!
 @enum      HKErrorCode
 
 @constant  HKNoError                           No error.
 @constant  HKErrorHealthDataUnavailable        HealthKit is not available on this device.
 @constant  HKErrorHealthDataRestricted         HealthKit is restricted on this device.
 @constant  HKErrorInvalidArgument              An invalid argument was provided to the API.
 @constant  HKErrorAuthorizationDenied          The application is not authorized to perform the requested operation.
 @constant  HKErrorAuthorizationNotDetermined   The user has not yet chosen whether the application is authorized to
                                                perform the requested operation.
 @constant  HKErrorDatabaseInaccessible         Protected health data is inaccessible because the device is locked.
 @constant  HKErrorUserCanceled                 The user canceled the operation.
 @constant  HKErrorAnotherWorkoutSessionStarted Another workout session was started by this or another application.
 @constant  HKErrorUserExitedWorkoutSession     User exited the application while a workout session was running.
 */
@available(iOS 8.0, *)
enum HKErrorCode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case NoError
  case ErrorHealthDataUnavailable
  case ErrorHealthDataRestricted
  case ErrorInvalidArgument
  case ErrorAuthorizationDenied
  case ErrorAuthorizationNotDetermined
  case ErrorDatabaseInaccessible
  case ErrorUserCanceled
  @available(iOS 9.0, *)
  case ErrorAnotherWorkoutSessionStarted
  @available(iOS 9.0, *)
  case ErrorUserExitedWorkoutSession
}

/*!
 @enum      HKUpdateFrequency
 */
@available(iOS 8.0, *)
enum HKUpdateFrequency : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Immediate
  case Hourly
  case Daily
  case Weekly
}

/*!
 @enum      HKAuthorizationStatus
 @abstract  This enumerated type is used to indicate the currently granted authorization status for a specific
            HKObjectType.
 
 @constant  HKAuthorizationStatusNotDetermined      The user has not yet made a choice regarding whether this 
                                                    application may save objects of the specified type.
 @constant  HKAuthorizationStatusSharingDenied      This application is not allowed to save objects of the specified type.
 @constant  HKAuthorizationStatusSharingAuthorized  This application is authorized to save objects of the specified type.
 */
@available(iOS 8.0, *)
enum HKAuthorizationStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case NotDetermined
  case SharingDenied
  case SharingAuthorized
}

/*!
 @enum       HKBiologicalSex
 @abstract   This enumerated type is used to represent the biological sex of an individual.
 */
enum HKBiologicalSex : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case NotSet
  @available(iOS 8.0, *)
  case Female
  @available(iOS 8.0, *)
  case Male
  @available(iOS 8.2, *)
  case Other
}

/*!
 @enum       HKBloodType
 @abstract   This enumerated type is used to represent the blood type of an individual.
 */
@available(iOS 8.0, *)
enum HKBloodType : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case NotSet
  case APositive
  case ANegative
  case BPositive
  case BNegative
  case ABPositive
  case ABNegative
  case OPositive
  case ONegative
}

/*!
 @enum          HKCategoryValueSleepAnalysis
 @abstract      Set of values that may be used for HKCategorySamples with the HKCategoryTypeIdentifierSleepAnalysis type.
 @discussion    To represent the user being both in bed and asleep, use two or more samples with overlapping times. By comparing the 
                start and end times of these samples, it is possible to calculate a number of secondary statistics: 
                1) The amount of time it took for the user to fall asleep
                2) The percentage of time in bed that the user actually spent sleeping,
                3) The number of times the user woke while in bed
                4) The total amount of time spent both in bed and asleep.
 */
@available(iOS 8.0, *)
enum HKCategoryValueSleepAnalysis : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case InBed
  case Asleep
}

/*!
 @enum          HKCategoryValueAppleStandHour
 @abstract      Set of values that may be used for HKCategorySamples with the HKCategoryTypeIdentifierAppleStandHour type.
 
 @constant      HKCategoryValueAppleStandHourStood  The user stood up and moved a little for at least one minute during
                                                    the sample.
 @constant      HKCategoryValueAppleStandHourIdle   The user did not stand up and move a little for at least one
                                                    continuous minute during the sample.
 */
@available(iOS 9.0, *)
enum HKCategoryValueAppleStandHour : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Stood
  case Idle
}

/*!
 @enum          HKFitzpatrickSkinType
 @abstract      This enumerated type is used to represent the skin type of an individual based on the Fitzpatrick scale.
 @discussion    The Fitzpatrick scale is a numerical classification for skin color based on the skin's response to sun
                exposure in terms of the degree of burning and tanning.

 @constant      HKFitzpatrickSkinTypeI      Pale white skin that always burns easily in the sun and never tans.
 @constant      HKFitzpatrickSkinTypeII     White skin that burns easily and tans minimally.
 @constant      HKFitzpatrickSkinTypeIII    White to light brown skin that burns moderately and tans uniformly.
 @constant      HKFitzpatrickSkinTypeIV     Beige-olive, lightly tanned skin that burns minimally and tans moderately.
 @constant      HKFitzpatrickSkinTypeV      Brown skin that rarely burns and tans profusely.
 @constant      HKFitzpatrickSkinTypeVI     Dark brown to black skin that never burns and tans profusely.
 */
@available(iOS 9.0, *)
enum HKFitzpatrickSkinType : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case NotSet
  case I
  case II
  case III
  case IV
  case V
  case VI
}

/*!
 @enum          HKCategoryValueCervicalMucusQuality
 @abstract      Set of values that may be used for HKCategorySamples with the HKCategoryValueCervicalMucusQuality type.
 @discussion    These cervical mucus quality values are ordered from least-fertile (Dry) to most-fertile (EggWhite).
 */
@available(iOS 9.0, *)
enum HKCategoryValueCervicalMucusQuality : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Dry
  case Sticky
  case Creamy
  case Watery
  case EggWhite
}

/*!
 @enum          HKCategoryValueOvulationTestResult
 @abstract      Set of values that may be used for HKCategorySamples with the HKCategoryValueOvulationTestResult type.
 @discussion    This category value tracks the result of a home ovulation test that use surges in luteinizing hormone 
                levels to indicate fertility.
 */
@available(iOS 9.0, *)
enum HKCategoryValueOvulationTestResult : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Negative
  case Positive
  case Indeterminate
}

/*!
 @enum          HKCategoryValueMenstrualFlow
 @abstract      Set of values to indicate the type of menstrual flow.
 */
@available(iOS 9.0, *)
enum HKCategoryValueMenstrualFlow : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unspecified
  case Light
  case Medium
  case Heavy
}

/*!
 @enum          HKCategoryValue
 @abstract      This category value is to be used for types which don't have a specific value defined.
 */
@available(iOS 9.0, *)
enum HKCategoryValue : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case NotApplicable
}

/*!
 @class         HKDeletedObject
 @abstract      A class representing an HKObject that was deleted from the HealtKit database.
 */
@available(iOS 9.0, *)
class HKDeletedObject : Object, SecureCoding {

  /*!
   @property      UUID
   @abstract      The unique identifier of the HKObject that was deleted from the HealthKit database.
   */
  var uuid: UUID { get }
  @available(iOS 9.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 9.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!
 @constant      HKDevicePropertyKeyName
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a device name.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeyName: String

/*!
 @constant      HKDevicePropertyKeyManufacturer
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a device manufacturer.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeyManufacturer: String

/*!
 @constant      HKDevicePropertyKeyModel
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a device model.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeyModel: String

/*!
 @constant      HKDevicePropertyKeyHardwareVersion
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a hardware version.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeyHardwareVersion: String

/*!
 @constant      HKDevicePropertyKeyFirmwareVersion
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a firmware version.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeyFirmwareVersion: String

/*!
 @constant      HKDevicePropertyKeySoftwareVersion
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a software version.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeySoftwareVersion: String

/*!
 @constant      HKDevicePropertyKeyLocalIdentifier
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a local identifier.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeyLocalIdentifier: String

/*!
 @constant      HKDevicePropertyKeyUDIDeviceIdentifier
 @abstract      Used with predicateForObjectsWithDeviceProperty to specify a UDI device identifier.
 @discussion    The expected value type is an NSString.
 */
@available(iOS 9.0, *)
let HKDevicePropertyKeyUDIDeviceIdentifier: String
@available(iOS 9.0, *)
class HKDevice : Object, SecureCoding, Copying {

  /*!
   @property      name
   @abstract      The name of the receiver.
   @discussion    The user-facing name, such as the one displayed in the Bluetooth Settings for a BLE device.
   */
  var name: String { get }

  /*!
   @property      manufacturer
   @abstract      The manufacturer of the receiver.
   */
  var manufacturer: String? { get }

  /*!
   @property      model
   @abstract      The model of the receiver.
   */
  var model: String? { get }

  /*!
   @property      hardwareVersion
   @abstract      The hardware revision of the receiver.
   */
  var hardwareVersion: String? { get }

  /*!
   @property      firmwareVersion
   @abstract      The firmware revision of the receiver.
   */
  var firmwareVersion: String? { get }

  /*!
   @property      softwareVersion
   @abstract      The software revision of the receiver.
   */
  var softwareVersion: String? { get }

  /*!
   @property      localIdentifier
   @abstract      A unique identifier for the receiver.
   @discussion    This property is available to clients for a local identifier.
                  For example, Bluetooth peripherals managed by HealthKit use this
                  for the CoreBluetooth UUID which is valid only on the local
                  device and thus distinguish the same Bluetooth peripheral used
                  between multiple devices.
   */
  var localIdentifier: String? { get }

  /*!
   @property      UDIDeviceIdentifier
   @abstract      Represents the device identifier portion of a device's FDA UDI (Unique Device Identifier).
   @discussion    The device identifier can be used to reference the FDA's GUDID (Globally Unique Device
                  Identifier Database). Note that for user privacy concerns this field should not be used to
                  persist the production identifier portion of the device UDI. HealthKit clients should manage
                  the production identifier independently, if needed.
                  See http://www.fda.gov/MedicalDevices/DeviceRegulationandGuidance/UniqueDeviceIdentification/ for more information.
   */
  var udiDeviceIdentifier: String? { get }

  /*!
   @method        initWithName:manufacturer:model:hardwareVersion:firmwareVersion:softwareVersion:localIdentifier:UDIDeviceIdentifier:
   @abstract      Initialize a new HKDevice with the specified values.
   @discussion    This allows initialization of an HKDevice object based on the
                  information provided.
   */
  init(name: String?, manufacturer: String?, model: String?, hardwareVersion: String?, firmwareVersion: String?, softwareVersion: String?, localIdentifier: String?, udiDeviceIdentifier UDIDeviceIdentifier: String?)

  /*!
   @method        localDevice
   @abstract      Returns a device representing the host.
   @discussion    If an app chooses to save samples that were retrieved from the local device, e.g. an HKWorkout with a 
                  totalDistance HKQuantity gathered from CoreLocation GPS distances, then this would be an appropriate 
                  HKDevice to use.
   */
  class func local() -> HKDevice
  @available(iOS 9.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 9.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 9.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class         HKHealthStore
 @abstract      The HKHealthStore class provides an interface for accessing and storing the user's health data.
 */
@available(iOS 8.0, *)
class HKHealthStore : Object {

  /*!
   @method        isHealthDataAvailable
   @abstract      Returns YES if HealthKit is supported on the device.
   @discussion    HealthKit is not supported on all iOS devices.  Using HKHealthStore APIs on devices which are not
                  supported will result in errors with the HKErrorHealthDataUnavailable code.  Call isHealthDataAvailable
                  before attempting to use other parts of the framework.
   */
  class func isHealthDataAvailable() -> Bool

  /*!
   @method        authorizationStatusForType:
   @abstract      Returns the application's authorization status for the given object type.
   */
  func authorizationStatusFor(type: HKObjectType) -> HKAuthorizationStatus

  /*!
   @method        requestAuthorizationToShareTypes:readTypes:completion:
   @abstract      Prompts the user to authorize the application for reading and saving objects of the given types.
   @discussion    Before attempting to execute queries or save objects, the application should first request authorization
                  from the user to read and share every type of object for which the application may require access.
   
                  The request is performed asynchronously and its completion will be executed on an arbitrary background
                  queue after the user has responded.  If the user has already chosen whether to grant the application
                  access to all of the types provided, then the completion will be called without prompting the user.
                  The success parameter of the completion indicates whether prompting the user, if necessary, completed
                  successfully and was not cancelled by the user.  It does NOT indicate whether the application was
                  granted authorization.
   
                  To customize the messages displayed on the authorization sheet, set the following keys in your app's
                  Info.plist file. Set the NSHealthShareUsageDescription key to customize the message for reading data. Set
                  the NSHealthUpdateUsageDescription key to customize the message for writing data.
   */
  func requestAuthorizationToShare(typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: (Bool, Error?) -> Void)

  /*!
   @method        handleAuthorizationForExtensionWithCompletion:
   @abstract      Prompts the user to authorize the application for reading and saving objects.
   @discussion    When an app extension calls requestAuthorizationToShareTypes:readTypes:completion:, the parent application
                  is responsible for calling this method to prompt the user to authorize the app and its extensions for the
                  types that the extension requested access to.
   
                  The request is performed asynchronously and its completion will be executed on an arbitrary background
                  queue after the user has responded.  The success parameter of the completion indicates whether prompting
                  the user, if necessary, completed successfully and was not cancelled by the user.  It does NOT indicate
                  whether the application was granted authorization.
   */
  @available(iOS 9.0, *)
  func handleAuthorizationForExtensionWithCompletion(completion: (Bool, Error?) -> Void)

  /*!
   @method        earliestPermittedSampleDate
   @abstract      Samples prior to the earliestPermittedSampleDate cannot be saved or queried.
   @discussion    On some platforms, only samples with end dates newer than the value returned by earliestPermittedSampleDate
                  may be saved or retreived.
   */
  @available(iOS 9.0, *)
  func earliestPermittedSampleDate() -> Date

  /*!
   @method        saveObject:withCompletion:
   @abstract      Saves an HKObject.
   @discussion    After an object is saved, on subsequent retrievals the sourceRevision property of the object will be set
                  to the HKSourceRevision representing the version of the application that saved it.
   
                  If the object has an HKObjectType property, then in order to save an object successfully the application
                  must first request authorization to share objects with that type.  Saving an object with the same unique
                  identifier as another object that has already been saved will fail.  When the application attempts to
                  save multiple objects, if any single object cannot be saved then none of the objects will be saved.
                  The operation will fail if the objects array contains samples with endDates that are older than the date
                  returned by earliestPermittedSampleDate.
   
                  This operation is performed asynchronously and the completion will be executed on an arbitrary
                  background queue.
   */
  func save(object: HKObject, withCompletion completion: (Bool, Error?) -> Void)

  /*!
   @method        saveObjects:withCompletion:
   @abstract      Saves an array of HKObjects.
   @discussion    See discussion of saveObject:withCompletion:.
   */
  func save(objects: [HKObject], withCompletion completion: (Bool, Error?) -> Void)

  /*!
   @method        deleteObject:withCompletion:
   @abstract      Deletes a single HKObject from the HealthKit database.
   @discussion    See deleteObjects:withCompletion:.
   */
  func delete(object: HKObject, withCompletion completion: (Bool, Error?) -> Void)

  /*!
   @method        deleteObjects:withCompletion:
   @abstract      Deletes multiple HKObjects from the HealthKit database.
   @discussion    An application may only delete objects that it previously saved.  This operation is performed
                  asynchronously and the completion will be executed on an arbitrary background queue.
   */
  @available(iOS 9.0, *)
  func delete(objects: [HKObject], withCompletion completion: (Bool, Error?) -> Void)

  /*!
   @method        deleteObjectsMatchingQuery:withCompletion:
   @abstract      Deletes all objects matching the given predicate from the HealthKit database.
   @discussion    An application may only delete objects that it previously saved.  This operation is performed
                  asynchronously and the completion will be executed on an arbitrary background queue.
   */
  @available(iOS 9.0, *)
  func deleteObjectsOf(objectType: HKObjectType, predicate: Predicate, withCompletion completion: (Bool, Int, Error?) -> Void)

  /*!
   @method        executeQuery:
   @abstract      Begins executing the given query.
   @discussion    After executing a query the completion, update, and/or results handlers of that query will be invoked
                  asynchronously on an arbitrary background queue as results become available.  Errors that prevent a
                  query from executing will be delivered to one of the query's handlers.  Which handler the error will be
                  delivered to is defined by the HKQuery subclass.  The behavior of calling this method with a query that
                  is already executing is undefined.  If a query would retrieve objects with an HKObjectType property,
                  then the application must request authorization to access objects of that type before executing the query.
   */
  func execute(query: HKQuery)

  /*!
   @method        stopQuery:
   @abstract      Stops a query that is executing from continuing to run.
   @discussion    Calling this method will prevent the handlers of the query from being invoked in the future.  If the
                  query is already stopped, this method does nothing.
   */
  func stop(query: HKQuery)

  /*!
   @method        splitTotalEnergy:startDate:endDate:resultsHandler:
   @abstract      For the time period specified, this method calculates the resting and active energy parts of the total
                  energy passed.
   @discussion    This method uses the users metrics like age, biological sex, body mass and height to determine
                  their basal metabolic rate. If the application does not have authorization to access these characteristics
                  or if the user has not entered their data then this method uses builtin default values.
   */
  @available(iOS 9.0, *)
  func splitTotalEnergy(totalEnergy: HKQuantity, start startDate: Date, end endDate: Date, resultsHandler: (HKQuantity?, HKQuantity?, Error?) -> Void)

  /*!
   @method        dateOfBirthWithError:
   @abstract      Returns the user's date of birth.
   @discussion    Before calling this method, the application should request authorization to access objects with the
                  HKCharacteristicType identified by HKCharacteristicTypeIdentifierDateOfBirth.
   */
  func dateOfBirth() throws -> Date

  /*!
   @method        biologicalSexWithError:
   @abstract      Returns an object encapsulating the user's biological sex.
   @discussion    Before calling this method, the application should request authorization to access objects with the
                  HKCharacteristicType identified by HKCharacteristicTypeIdentifierBiologicalSex.
   */
  func biologicalSex() throws -> HKBiologicalSexObject

  /*!
   @method        bloodTypeWithError:
   @abstract      Returns an object encapsulating the user's blood type.
   @discussion    Before calling this method, the application should request authorization to access objects with the
                  HKCharacteristicType identified by HKCharacteristicTypeIdentifierBloodType.
   */
  func bloodType() throws -> HKBloodTypeObject

  /*!
   @method        fitzpatrickSkinTypeWithError:
   @abstract      Returns an object encapsulating the user's Fitzpatrick skin type.
   @discussion    Before calling this method, the application should request authorization to access objects with the
                  HKCharacteristicType identified by HKCharacteristicTypeIdentifierFitzpatrickSkinType.
   */
  @available(iOS 9.0, *)
  func fitzpatrickSkinType() throws -> HKFitzpatrickSkinTypeObject
  init()
}
extension HKHealthStore {

  /*!
   @method        addSamples:toWorkout:completion:
   @abstract      Associates samples with a given workout.
   @discussion    This will associate the given samples with the given workout. These samples will then be returned by a
                  query that contains this workout as a predicate. If a sample is added that is not saved yet, then it will
                  be saved for you. Note that the sample will be saved without an HKDevice.
   
                  The workout provided must be one that has already been saved to HealthKit.
   */
  func add(samples: [HKSample], to workout: HKWorkout, completion: (Bool, Error?) -> Void)
}
extension HKHealthStore {

  /*!
   @method        enableBackgroundDeliveryForType:frequency:withCompletion:
   @abstract      This method enables activation of your app when data of the type is recorded at the cadence specified.
   @discussion    When an app has subscribed to a certain data type it will get activated at the cadence that is specified
                  with the frequency parameter. The app is still responsible for creating an HKObserverQuery to know which
                  data types have been updated and the corresponding fetch queries. Note that certain data types (such as
                  HKQuantityTypeIdentifierStepCount) have a minimum frequency of HKUpdateFrequencyHourly. This is enforced
                  transparently to the caller.
   */
  func enableBackgroundDeliveryFor(type: HKObjectType, frequency: HKUpdateFrequency, withCompletion completion: (Bool, Error?) -> Void)
  func disableBackgroundDeliveryFor(type: HKObjectType, withCompletion completion: (Bool, Error?) -> Void)
  func disableAllBackgroundDeliveryWithCompletion(completion: (Bool, Error?) -> Void)
}

/*!
 @constant      HKUserPreferencesDidChangeNotification
 @abstract      A notification posted every time the user updates their preferred units.
 @discussion    Each HKHealthStore posts a HKUserPreferencesDidChangeNotification notification when the preferred unit 
                for a HKQuantityType is changed by the user. To guarantee your listener will only receive a single 
                notification when this occurs, it is necessary to provide an HKHealthStore instance for the object
                parameter of NSNotificationCenter's addObserver methods.
 */
@available(iOS 8.2, *)
let HKUserPreferencesDidChangeNotification: String
extension HKHealthStore {

  /*!
   @method        preferredUnitsForQuantityTypes:completion:
   @abstract      Calls the completion with the preferred HKUnits for a given set of HKQuantityTypes.
   @discussion    A preferred unit is either the unit that the user has chosen in Health for displaying samples of the
                  given quantity type or the default unit for that type in the current locale of the device. To access the
                  user's preferences it is necessary to request read or share authorization for the set of HKQuantityTypes
                  provided. If neither read nor share authorization has been granted to the app, then the default unit for
                  the locale is provided.
   
                  An error will be returned when preferred units are inaccessible because protected health data is
                  unavailable or authorization status is not determined for one or more of the provided types.
   
                  The returned dictionary will map HKQuantityType to HKUnit.
   */
  @available(iOS 8.2, *)
  func preferredUnitsFor(quantityTypes: Set<HKQuantityType>, completion: ([HKQuantityType : HKUnit], Error?) -> Void)
}

/*!
 @class     HKBiologicalSexObject
 @abstract  A wrapper object for HKBiologicalSex enumeration.
 */
@available(iOS 8.0, *)
class HKBiologicalSexObject : Object, Copying, SecureCoding {
  var biologicalSex: HKBiologicalSex { get }
  init()
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!
 @class     HKBloodTypeObject
 @abstract  A wrapper object for HKBloodType enumeration.
 */
@available(iOS 8.0, *)
class HKBloodTypeObject : Object, Copying, SecureCoding {
  var bloodType: HKBloodType { get }
  init()
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!
 @class     HKFitzpatrickSkinTypeObject
 @abstract  A wrapper object for HKFitzpatrickSkinType enumeration.
 */
@available(iOS 9.0, *)
class HKFitzpatrickSkinTypeObject : Object, Copying, SecureCoding {
  var skinType: HKFitzpatrickSkinType { get }
  init()
  @available(iOS 9.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 9.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 9.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!
 @constant      HKMetadataKeyUDIProductionIdentifier
 @abstract      Represents the serial number of the device that created the HKObject.
 @discussion    The expected value type is NSString.
 */
@available(iOS 8.0, *)
let HKMetadataKeyDeviceSerialNumber: String

/*!
 @constant      HKMetadataKeyBodyTemperatureSensorLocation
 @abstract      Represents the location where a particular body temperature reading was taken.
 @discussion    The expected value type is an NSNumber containing a HKBodyTemperatureSensorLocation value.
 */
@available(iOS 8.0, *)
let HKMetadataKeyBodyTemperatureSensorLocation: String
@available(iOS 8.0, *)
enum HKBodyTemperatureSensorLocation : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Other
  case Armpit
  case Body
  case Ear
  case Finger
  case GastroIntestinal
  case Mouth
  case Rectum
  case Toe
  case EarDrum
  case TemporalArtery
  case Forehead
}

/*!
 @constant      HKMetadataKeyHeartRateSensorLocation
 @abstract      Represents the location where a particular heart rate reading was taken.
 @discussion    The expected value type is an NSNumber containing a HKHeartRateSensorLocation value.
 */
@available(iOS 8.0, *)
let HKMetadataKeyHeartRateSensorLocation: String
@available(iOS 8.0, *)
enum HKHeartRateSensorLocation : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Other
  case Chest
  case Wrist
  case Finger
  case Hand
  case EarLobe
  case Foot
}

/*!
 @constant      HKMetadataKeyFoodType
 @abstract      Represents the type of food that was consumed when creating an HKObject.
 @discussion    This should be a short string representing the type of food, such as 'Banana'. The expected value type
                is NSString.
 */
@available(iOS 8.0, *)
let HKMetadataKeyFoodType: String

/*!
 @constant      HKMetadataKeyUDIDeviceIdentifier
 @abstract      Represents the device identifier portion of a device's UDI (Unique Device Identifier).
 @discussion    The device identifier can be used to reference the GUDID (Globally Unique Device Identifier Database).
                The expected value type is NSString.
 
                ** Note that the use of this key is now discouraged in favor of the HKDevice class.
 */
@available(iOS 8.0, *)
let HKMetadataKeyUDIDeviceIdentifier: String

/*!
 @constant      HKMetadataKeyUDIProductionIdentifier
 @abstract      Represents the production identifier portion of a device's UDI (Unique Device Identifier).
 @discussion    While part of a device's UDI, the production identifier is not saved in the FDA's GUDID 
                (Globally Unique Device Identifier Database) and its use in HealthKit is now discouraged for
                user privacy reasons. Apps should consider handling this independently of HealthKit APIs if
                needed.
                The expected value type is NSString.
 */
@available(iOS 8.0, *)
let HKMetadataKeyUDIProductionIdentifier: String

/*!
 @constant      HKMetadataKeyDigitalSignature
 @abstract      Represents a digital signature validating the origin of an HKObject's value.
 @discussion    Intended to provide data integrity for sample data produced by trusted (tamper resistant) measuring devices.
                The digital signature format should be CMS (Cryptographic Message Syntax specified in IETF RFC 5652).
                It should be a “Signed-data” type signature containing the data items to be signed (e.g., timestamp, value, etc.)
                using ASN.1 encoding with DER (Distinguished Encoding Rules). The entire enveloping signature should be further
                encoded using base64. Recommended digest is SHA256, and recommended cipher is FIPS PUB 186-4 Digital Signature 
                Standard Elliptic Curve P-256. See documentation for details.

 */
@available(iOS 8.0, *)
let HKMetadataKeyDigitalSignature: String

/*!
 @constant      HKMetadataKeyExternalUUID
 @abstract      Represents a unique identifier for an HKObject that is set by its source. 
 @discussion    The expected value type is NSString.
 */
@available(iOS 8.0, *)
let HKMetadataKeyExternalUUID: String

/*!
 @constant      HKMetadataKeyTimeZone
 @abstract      Represents the time zone that the user was in when the HKObject was created.
 @discussion    The expected value type is an NSString compatible with NSTimeZone's +timeZoneWithName:.
 */
@available(iOS 8.0, *)
let HKMetadataKeyTimeZone: String

/*!
 @constant      HKMetadataKeyDeviceName
 @abstract      Represents the name of the device that took the reading.
 @discussion    The expected value type is NSString.
 
                ** Note that the use of this key is now discouraged in favor of the HKDevice class.
 */
@available(iOS 8.0, *)
let HKMetadataKeyDeviceName: String

/*!
 @constant      HKMetadataKeyDeviceManufacturerName
 @abstract      Represents the name of the manufacturer of the device that took the reading.
 @discussion    The expected value type is NSString.
 
                ** Note that the use of this key is now discouraged in favor of the HKDevice class.
 */
@available(iOS 8.0, *)
let HKMetadataKeyDeviceManufacturerName: String

/*!
 @constant      HKMetadataKeyWasTakenInLab
 @abstract      Represents whether or not the reading was taken in a lab.
 @discussion    The expected value type is an NSNumber containing a BOOL value.
 */
@available(iOS 8.0, *)
let HKMetadataKeyWasTakenInLab: String

/*!
 @constant      HKMetadataKeyReferenceRangeLowerLimit
 @abstract      Represents the lower limit of the reference range for a lab result.
 @discussion    The expected value type is an NSNumber.
 */
@available(iOS 8.0, *)
let HKMetadataKeyReferenceRangeLowerLimit: String

/*!
 @constant      HKMetadataKeyReferenceRangeUpperLimit
 @abstract      Represents the upper limit of the reference range for a lab result.
 @discussion    The expected value type is an NSNumber.
 */
@available(iOS 8.0, *)
let HKMetadataKeyReferenceRangeUpperLimit: String

/*!
 @constant      HKMetadataKeyWasUserEntered
 @abstract      Represents whether or not the reading was entered by the user.
 @discussion    The expected value type is an NSNumber containing a BOOL value.
 */
@available(iOS 8.0, *)
let HKMetadataKeyWasUserEntered: String

/*!
 @constant      HKMetadataKeyWorkoutBrandName
 @abstract      Represents the brand name of a particular workout.
 @discussion    The expected value type is NSString.
 */
@available(iOS 8.0, *)
let HKMetadataKeyWorkoutBrandName: String

/*!
 @constant      HKMetadataKeyGroupFitness
 @abstract      Represents whether or not a workout was performed as part of a group fitness class.
 @discussion    The expected value type is an NSNumber containing a BOOL value.
 */
@available(iOS 8.0, *)
let HKMetadataKeyGroupFitness: String

/*!
 @constant      HKMetadataKeyIndoorWorkout
 @abstract      Represents whether or not a workout was performed indoors as opposed to outdoors.
 @discussion    The expected value type is an NSNumber containing a BOOL value.
 */
@available(iOS 8.0, *)
let HKMetadataKeyIndoorWorkout: String

/*!
 @constant      HKMetadataKeyCoachedWorkout
 @abstract      Represents whether or not a workout was performed with a coach or personal trainer.
 @discussion    The expected value type is an NSNumber containing a BOOL value.
 */
@available(iOS 8.0, *)
let HKMetadataKeyCoachedWorkout: String

/*!
 @constant      HKMetadataKeySexualActivityProtectionUsed
 @abstract      Represents whether or not protection was used during sexual activity. This can be used to track either
                protection from STIs or protection from pregnancy.
 @discussion    The expected value type is an NSNumber containing a BOOL value.
 */
@available(iOS 9.0, *)
let HKMetadataKeySexualActivityProtectionUsed: String

/*!
 @constant      HKMetadataKeyMenstrualCycleStart
 @abstract      Indicates whether or not the sample represents the start of a menstrual cycle. This is a required
                metadata key for category samples of type HKCategorySampleMenstrualFlow.
 @discussion    The expected value type is an NSNumber containing a BOOL value.
 */
@available(iOS 9.0, *)
let HKMetadataKeyMenstrualCycleStart: String
@available(iOS 8.0, *)
class HKObject : Object, SecureCoding {

  /*!
   @property      UUID
   @abstract      A unique identifier of the receiver in the HealthKit database.
   */
  var uuid: UUID { get }
  @available(iOS, introduced=8.0, deprecated=9.0, message="Use sourceRevision")
  var source: HKSource { get }

  /*!
   @property      sourceRevision
   @abstract      Represents the revision of the source responsible for saving the receiver.
   */
  @available(iOS 9.0, *)
  var sourceRevision: HKSourceRevision { get }

  /*!
   @property      device
   @abstract      Represents the device that generated the data of the receiver.
   */
  @available(iOS 9.0, *)
  var device: HKDevice? { get }

  /*!
   @property      metadata
   @abstract      Extra information describing properties of the receiver.
   @discussion    Keys must be NSString and values must be either NSString, NSNumber, or NSDate.
                  See HKMetadata.h for potential metadata keys and values.
   */
  var metadata: [String : AnyObject]? { get }
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}
@available(iOS 8.0, *)
let HKPredicateKeyPathUUID: String
@available(iOS 8.0, *)
let HKPredicateKeyPathSource: String
@available(iOS 8.0, *)
let HKPredicateKeyPathMetadata: String
@available(iOS 8.0, *)
let HKPredicateKeyPathCorrelation: String
@available(iOS 8.0, *)
let HKPredicateKeyPathWorkout: String
@available(iOS 9.0, *)
let HKPredicateKeyPathDevice: String
@available(iOS 9.0, *)
let HKPredicateKeyPathSourceRevision: String

/*!
 @class         HKObjectType
 @abstract      An abstract class representing a type of object that can be stored by HealthKit.
 */
@available(iOS 8.0, *)
class HKObjectType : Object, SecureCoding, Copying {

  /*!
   @property      identifier
   @abstract      A unique string identifying a type of health object.
   @discussion    See HKTypeIdentifiers.h for possible values.
   */
  var identifier: String { get }
  class func quantityTypeForIdentifier(identifier: String) -> HKQuantityType?
  class func categoryTypeForIdentifier(identifier: String) -> HKCategoryType?
  class func characteristicTypeForIdentifier(identifier: String) -> HKCharacteristicType?
  class func correlationTypeForIdentifier(identifier: String) -> HKCorrelationType?
  class func workoutType() -> HKWorkoutType
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class         HKCharacteristicType
 @abstract      Represents a type of object that desribes a characteristic of the user (such as date of birth).
 */
@available(iOS 8.0, *)
class HKCharacteristicType : HKObjectType {
  init?(coder aDecoder: Coder)
}

/*!
 @class         HKSampleType
 @abstract      Represents a type of HKSample.
 */
@available(iOS 8.0, *)
class HKSampleType : HKObjectType {
  init?(coder aDecoder: Coder)
}

/*!
 @class         HKCategoryType
 @abstract      Represent a type of HKCategorySample.
 */
@available(iOS 8.0, *)
class HKCategoryType : HKSampleType {
  init?(coder aDecoder: Coder)
}

/*!
 @class         HKCorrelationType
 @abstract      Represents a type of HKCorrelation
 */
@available(iOS 8.0, *)
class HKCorrelationType : HKSampleType {
  init?(coder aDecoder: Coder)
}

/*!
 @enum          HKQuantityAggregationStyle
 @discussion    Describes how quantities can be aggregated over time.
 
 @constant      HKQuantityAggregationStyleCumulative    Samples may be summed over a time interval.
 @constant      HKQuantityAggregationStyleDiscrete      Samples may be averaged over a time interval.
 */
@available(iOS 8.0, *)
enum HKQuantityAggregationStyle : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Cumulative
  case Discrete
}

/*!
 @class         HKQuantityType
 @abstract      Represents types of HKQuantitySamples.
 */
@available(iOS 8.0, *)
class HKQuantityType : HKSampleType {
  var aggregationStyle: HKQuantityAggregationStyle { get }

  /*!
   @method        isCompatibleWithUnit:
   @abstract      Returns YES if the type of HKQuantitySample represented by the receiver can be created with quantities 
                  of the given unit.
   */
  func isCompatibleWith(unit: HKUnit) -> Bool
  init?(coder aDecoder: Coder)
}

/*!
 @class         HKCategoryType
 @abstract      Represents a workout or exercise
 */
@available(iOS 8.0, *)
class HKWorkoutType : HKSampleType {
  init?(coder aDecoder: Coder)
}
typealias HKObserverQueryCompletionHandler = () -> Void
@available(iOS 8.0, *)
class HKObserverQuery : HKQuery {

  /*!
   @method        initWithSampleType:predicate:updateHandler:
   @abstract      This method installs a handler that is called when a sample type has a new sample added.
   @discussion    If you have subscribed to background updates you must call the passed completion block
                  once you have processed data from this notification. Otherwise the system will continue
                  to notify you of this data.
   */
  init(sampleType: HKSampleType, predicate: Predicate?, updateHandler: (HKObserverQuery, HKObserverQueryCompletionHandler, Error?) -> Void)
}

/*!
 @class         HKQuantity
 @abstract      The HKQuantity class provides an encapsulation of a quantity value and the unit of measurement.
 */
@available(iOS 8.0, *)
class HKQuantity : Object, SecureCoding, Copying {

  /*!
   @method        quantityWithUnit:doubleValue:
   @abstract      Returns a new object representing a quantity measurement with the given unit.
   */
  convenience init(unit: HKUnit, doubleValue value: Double)

  /*!
   @method        isCompatibleWithUnit:
   @abstract      Returns yes if the receiver's value can be converted to a value of the given unit.
   */
  func isCompatibleWith(unit: HKUnit) -> Bool

  /*!
   @method        doubleValueForUnit:
   @abstract      Returns the quantity value converted to the given unit.
   @discussion    Throws an exception if the receiver's value cannot be converted to one of the requested unit.
   */
  func doubleValueFor(unit: HKUnit) -> Double

  /*!
   @method        compare:
   @abstract      Returns an NSComparisonResult value that indicates whether the receiver is greater than, equal to, or 
                  less than a given quantity.
   @discussion    Throws an exception if the unit of the given quantity is not compatible with the receiver's unit.
   */
  func compare(quantity: HKQuantity) -> ComparisonResult
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class         HKQuantitySample
 @abstract      An HKObject subclass representing a quantity measurement.
 */
@available(iOS 8.0, *)
class HKQuantitySample : HKSample {
  var quantityType: HKQuantityType { get }
  var quantity: HKQuantity { get }

  /*!
   @method        quantitySampleWithType:quantity:startDate:endDate:
   @abstract      Creates a new HKQuantitySample with the given type, quantity, start date, and end date.
   @discussion    The quantity must have a unit that is compatible with the given quantity type.
                  See -[HKQuantityType isCompatibleWithUnit:].
   */
  convenience init(type quantityType: HKQuantityType, quantity: HKQuantity, start startDate: Date, end endDate: Date)

  /*!
   @method        quantitySampleWithType:quantity:startDate:endDate:metadata:
   @abstract      Creates a new HKQuantitySample with the given type, quantity, start date, end date, and metadata.
   @discussion    The quantity must have a unit that is compatible with the given quantity type.
                  See -[HKQuantityType isCompatibleWithUnit:].
   */
  convenience init(type quantityType: HKQuantityType, quantity: HKQuantity, start startDate: Date, end endDate: Date, metadata: [String : AnyObject]?)

  /*!
   @method        quantitySampleWithType:quantity:startDate:endDate:device:metadata:
   @abstract      Creates a new HKQuantitySample with the given type, quantity, start date, end date, and metadata.
   @param         type        The type of the sample.
   @param         startDate   The start date of the sample.
   @param         endDate     The end date of the sample.
   @param         device      The HKDevice that generated the sample (optional).
   @param         metadata    Metadata for the sample (optional).
   @discussion    The quantity must have a unit that is compatible with the given quantity type.
                  See -[HKQuantityType isCompatibleWithUnit:].
   */
  @available(iOS 9.0, *)
  convenience init(type quantityType: HKQuantityType, quantity: HKQuantity, start startDate: Date, end endDate: Date, device: HKDevice?, metadata: [String : AnyObject]?)
  init?(coder aDecoder: Coder)
}
@available(iOS 8.0, *)
let HKPredicateKeyPathQuantity: String
@available(iOS 8.0, *)
class HKQuery : Object {
  var sampleType: HKSampleType { get }
  var predicate: Predicate? { get }
}

/**
 @enum      HKQueryOptions
 @abstract  Time interval options are used to describe how an HKSample's time period overlaps with a given time period.
 
 @constant  HKQueryOptionNone               The sample's time period must overlap with the predicate's time period.
 @constant  HKQueryOptionStrictStartDate    The sample's start date must fall in the time period (>= startDate, < endDate)
 @constant  HKQueryOptionStrictEndDate      The sample's end date must fall in the time period (>= startDate, < endDate)
 
 */
@available(iOS 8.0, *)
struct HKQueryOptions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var None: HKQueryOptions { get }
  static var StrictStartDate: HKQueryOptions { get }
  static var StrictEndDate: HKQueryOptions { get }
}
extension HKQuery {

  /*!
   @method        predicateForObjectsWithMetadataKey:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches objects with metadata that contains a given key.
   
   @param         key     The metadata key.
   */
  class func predicateForObjectsWithMetadataKey(key: String) -> Predicate

  /*!
   @method        predicateForObjectsWithMetadataKey:allowedValues:
   @abstract      Creates a predicate for use with HKQuery subclasses
   @discussion    Creates a query predicate that matches objects with metadata containing a value the matches one of the
                  given values for the given key.
   
   @param         key             The metadata key.
   @param         allowedValues   The list of values that the metadata value can be equal to.
   */
  class func predicateForObjectsWithMetadataKey(key: String, allowedValues: [AnyObject]) -> Predicate

  /*!
   @method        predicateForObjectsWithMetadataKey:operatorType:value:
   @abstract      Creates a predicate for use with HKQuery subclasses
   @discussion    Creates a query predicate that matches objects with a value for a given metadata key matches the given
                  operator type and value.
   
   @param         key            The metadata key.
   @param         operatorType   The comparison operator type for the expression.
   @param         value          The value to be compared against.
   */
  class func predicateForObjectsWithMetadataKey(key: String, operatorType: PredicateOperatorType, value: AnyObject) -> Predicate

  /*!
   @method        predicateForObjectsFromSource:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches objects saved by a given source.
   
   @param         source  The source.
   */
  class func predicateForObjectsFrom(source: HKSource) -> Predicate

  /*!
   @method        predicateForObjectsFromSources:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches objects saved by any of the given sources.
   
   @param         sources The list of sources.
   */
  class func predicateForObjectsFrom(sources: Set<HKSource>) -> Predicate

  /*!
   @method        predicateForObjectsFromSourceRevisions:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches objects saved by any of the specified HKSourceRevisions.
   
   @param         sourceRevisions The list of source revisions.
   */
  @available(iOS 9.0, *)
  class func predicateForObjectsFrom(sourceRevisions: Set<HKSourceRevision>) -> Predicate

  /*!
   @method        predicateForObjectsFromDevices:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches objects associated with any of the given devices. All properties
                  of each HKDevice are considered in the query and must match exactly, including nil values. To perform 
                  searches based on specific device properties, use predicateForObjectsWithDeviceProperty:allowedValues:.
   
   @param         devices     The set of devices that generated data.
   */
  @available(iOS 9.0, *)
  class func predicateForObjectsFrom(devices: Set<HKDevice>) -> Predicate

  /*!
   @method        predicateForObjectsWithDeviceProperty:allowedValues:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches objects associated with an HKDevice with the specified device
                  property matching any value included in allowedValues. To query for samples with devices that match all 
                  the properties of an HKDevice, use predicateForObjectsFromDevices.
   
   @param         key             The device property key. (See HKDevice.h)
   @param         allowedValues   The set of values for which the device property can match. An empty set will match all
                  devices whose property value is nil.
   */
  @available(iOS 9.0, *)
  class func predicateForObjectsWithDeviceProperty(key: String, allowedValues: Set<String>) -> Predicate

  /*!
   @method        predicateForObjectWithUUID:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches the object saved with a particular UUID.
   
   @param         UUID The UUID of the object.
   */
  class func predicateForObjectWith(UUID: UUID) -> Predicate

  /*!
   @method        predicateForObjectsWithUUIDs:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches the objects saved with one of the given UUIDs.
   
   @param         UUIDs The set of NSUUIDs.
   */
  class func predicateForObjectsWithUUIDs(UUIDs: Set<UUID>) -> Predicate

  /*!
   @method        predicateForObjectsNoCorrelation
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches the objects that are not associated with an HKCorrelation.
   */
  class func predicateForObjectsWithNoCorrelation() -> Predicate

  /*!
   @method        predicateForObjectsFromWorkout:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches the objects that have been added to the given workout.
   
   @param         workout     The HKWorkout that the object was added to.
   */
  class func predicateForObjectsFrom(workout: HKWorkout) -> Predicate
}
extension HKQuery {

  /*!
   @method        predicateForSamplesWithStartDate:endDate:options:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches samples with a startDate and an endDate that lie inside of a
                  given time interval.
   
   @param         startDate  The start date of the predicate's time interval.
   @param         endDate    The end date of the predicate's time interval.
   @param         options    The rules for how a sample's time interval overlaps with the predicate's time interval.
   */
  class func predicateForSamplesWithStart(startDate: Date?, end endDate: Date?, options: HKQueryOptions = []) -> Predicate
}
extension HKQuery {

  /*!
   @method        predicateForQuantitySamplesWithOperatorType:quantity:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches quantity samples with values that match the expression formed by
                  the given operator and quantity.
   
   @param         operatorType    The operator type for the expression.
   @param         quantity        The quantity that the sample's quantity is being compared to. It is the right hand side
                                  of the expression.
   */
  class func predicateForQuantitySamplesWith(operatorType: PredicateOperatorType, quantity: HKQuantity) -> Predicate
}
extension HKQuery {

  /*!
   @method        predicateForCategorySamplesWithOperatorType:value:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches category samples with values that match the expression formed by 
                  the given operator and value.
   
   @param         operatorType    The operator type for the expression.
   @param         value           The value that the sample's value is being compared to. It is the right hand side of the
                                  expression.
   */
  class func predicateForCategorySamplesWith(operatorType: PredicateOperatorType, value: Int) -> Predicate
}
extension HKQuery {

  /*!
   @method        predicateForWorkoutsWithWorkoutActivityType:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches HKWorkouts with the given HKWorkoutActivityType.
   
   @param         workoutActivityType     The HKWorkoutActivity type of the workout
   */
  class func predicateForWorkoutsWith(workoutActivityType: HKWorkoutActivityType) -> Predicate

  /*!
   @method        predicateForWorkoutsWithOperatorType:duration:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches HKWorkouts by the given operator type and duration
   
   @param         operatorType    The operator type for the expression.
   @param         duration        The value that the workout's duration is being compared to. It is the right hand side of the
                                  expression.
   */
  class func predicateForWorkoutsWith(operatorType: PredicateOperatorType, duration: TimeInterval) -> Predicate

  /*!
   @method        predicateForWorkoutsWithOperatorType:totalEnergyBurned:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches HKWorkouts by the given operator type and totalEnergyBurned
   
   @param         operatorType        The operator type for the expression.
   @param         totalEnergyBurned   The value that the workout's totalEnergyBurned is being compared to. It is the right hand side of the
                                      expression. The unit for this value should be of type Energy.
   */
  class func predicateForWorkoutsWith(operatorType: PredicateOperatorType, totalEnergyBurned: HKQuantity) -> Predicate

  /*!
   @method        predicateForWorkoutsWithOperatorType:totalDistance:
   @abstract      Creates a predicate for use with HKQuery subclasses.
   @discussion    Creates a query predicate that matches HKWorkouts by the given operator type and totalEnergyBurned
   
   @param         operatorType    The operator type for the expression.
   @param         totalDistance   The value that the workout's totalEnergyBurned is being compared to. It is the right hand side of the
                                  expression. The unit for this value should be of type Distance
   */
  class func predicateForWorkoutsWith(operatorType: PredicateOperatorType, totalDistance: HKQuantity) -> Predicate
}

/*!
 @class         HKSample
 @abstract      An abstract class representing measurements taken over a period of time.
 */
@available(iOS 8.0, *)
class HKSample : HKObject {
  var sampleType: HKSampleType { get }
  var startDate: Date { get }
  var endDate: Date { get }
  init?(coder aDecoder: Coder)
}
@available(iOS 8.0, *)
let HKSampleSortIdentifierStartDate: String
@available(iOS 8.0, *)
let HKSampleSortIdentifierEndDate: String
@available(iOS 8.0, *)
let HKPredicateKeyPathStartDate: String
@available(iOS 8.0, *)
let HKPredicateKeyPathEndDate: String
var HKObjectQueryNoLimit: Int32 { get }

/*!
 @class         HKSampleQuery
 @abstract      A concrete subclass of HKQuery that provides an interface to retrieve HKSample objects.
 */
@available(iOS 8.0, *)
class HKSampleQuery : HKQuery {

  /*!
   @property      limit
   @abstract      The maximum number of results the receiver will return upon completion.
   */
  var limit: Int { get }

  /*!
   @property      sortDescriptors
   @abstract      An array of NSSortDescriptors.
   */
  var sortDescriptors: [SortDescriptor]? { get }

  /*!
   @method        initWithSampleType:predicate:limit:sortDescriptors:resultsHandler:
   @abstract      Returns a query that will retrieve HKSamples matching the given predicate.
   
   @param         sampleType      The type of sample to retrieve.
   @param         predicate       The predicate which samples should match.
   @param         limit           The maximum number of samples to return.  Pass HKObjectQueryNoLimit for no limit.
   @param         sortDescriptors The sort descriptors to use to order the resulting samples.
   @param         resultsHandler  The block to invoke with results when the query has finished executing.
   */
  init(sampleType: HKSampleType, predicate: Predicate?, limit: Int, sortDescriptors: [SortDescriptor]?, resultsHandler: (HKSampleQuery, [HKSample]?, Error?) -> Void)
}

/*!
 @class     HKSource
 @abstract  Represents the entity that created an object stored by HealthKit.
 */
@available(iOS 8.0, *)
class HKSource : Object, SecureCoding, Copying {

  /*!
   @property      name
   @abstract      The name of the source represented by the receiver.  If the source is an app, then the name is the
                  localized name of the app.
   */
  var name: String { get }

  /*!
   @property  bundleIdentifier
   @abstract  The bundle identifier of the source represented by the receiver.
   */
  var bundleIdentifier: String { get }

  /*!
   @method    defaultSource
   @abstract  Returns the source representing the calling application.
   */
  class func defaultSource() -> HKSource
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class         HKSourceQuery
 @abstract      A query that returns a set of sources that have saved objects matching certain criteria.
 */
@available(iOS 8.0, *)
class HKSourceQuery : HKQuery {

  /*!
   @method        initWithSampleType:samplePredicate:completionHandler:
   @abstract      Returns a query that will retrieve HKSources that have saved samples of the given type matching the 
                  given predicate.
   
   @param         sampleType          The type of sample.
   @param         samplePredicate     The predicate which samples must match.
   @param         completionHandler   The block to be called when the query has finished executing.
   */
  init(sampleType: HKSampleType, samplePredicate objectPredicate: Predicate?, completionHandler: (HKSourceQuery, Set<HKSource>?, Error?) -> Void)
}

/*!
 @class         HKSourceRevision
 @abstract      Represents a specific revision of an HKSource.
 */
@available(iOS 9.0, *)
class HKSourceRevision : Object, SecureCoding, Copying {

  /*!
   @property      source
   @abstract      The HKSource of the receiver.
   */
  var source: HKSource { get }

  /*!
   @property      version
   @abstract      The version of the source property.
   @discussion    This value is taken from the CFBundleVersion of the source. May be nil for older data.
   */
  var version: String? { get }

  /*!
   @method        initWithSource:version:
   @abstract      Initializes a new HKSourceRevision with the given source and version.
   */
  init(source: HKSource, version: String)
  @available(iOS 9.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 9.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 9.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @enum          HKStatisticsOptions
 @abstract      Options for specifying which statistics to calculate
 @discussion    When querying for HKStatistics objects, an options bitmask will specify which statistics will be 
                calculated.
 
                Statistics are classified as discrete or cumulative.  If a discrete statistics option is specified for a
                cumulative HKQuantityType, an exception will be thrown.  If a cumulative statistics options is specified
                for a discrete HKQuantityType, an exception will also be thrown.
 
 @constant      HKStatisticsOptionNone
 @constant      HKStatisticsOptionSeparateBySource
 @constant      HKStatisticsOptionDiscreteAverage   Calculate averageQuantity when creating statistics.
 @constant      HKStatisticsOptionDiscreteMin       Calculate minQuantity when creating statistics.
 @constant      HKStatisticsOptionDiscreteMax       Calculate maxQuantity when creating statistics.
 @constant      HKStatisticsOptionCumulativeSum     Calculate sumQuantity when creating statistics.
 */
@available(iOS 8.0, *)
struct HKStatisticsOptions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var None: HKStatisticsOptions { get }
  static var SeparateBySource: HKStatisticsOptions { get }
  static var DiscreteAverage: HKStatisticsOptions { get }
  static var DiscreteMin: HKStatisticsOptions { get }
  static var DiscreteMax: HKStatisticsOptions { get }
  static var CumulativeSum: HKStatisticsOptions { get }
}

/*!
 @class         HKStatistics
 @abstract      Represents statistics for quantity samples over a period of time.
 */
@available(iOS 8.0, *)
class HKStatistics : Object, SecureCoding, Copying {
  var quantityType: HKQuantityType { get }
  var startDate: Date { get }
  var endDate: Date { get }
  var sources: [HKSource]? { get }

  /*!
   @method        averageQuantityForSource:
   @abstract      Returns the average quantity for the given source in the time period represented by the receiver.
   @discussion    If HKStatisticsOptionSeparateBySource is not specified, then this will always be nil.
   */
  func averageQuantityFor(source: HKSource) -> HKQuantity?

  /*!
   @method        averageQuantity
   @abstract      Returns the average quantity in the time period represented by the receiver.
   */
  func averageQuantity() -> HKQuantity?

  /*!
   @method        minimumQuantityForSource:
   @abstract      Returns the minimum quantity for the given source in the time period represented by the receiver.
   @discussion    If HKStatisticsOptionSeparateBySource is not specified, then this will always be nil.
   */
  func minimumQuantityFor(source: HKSource) -> HKQuantity?

  /*!
   @method        minimumQuantity
   @abstract      Returns the minimum quantity in the time period represented by the receiver.
   */
  func minimumQuantity() -> HKQuantity?

  /*!
   @method        maximumQuantityForSource:
   @abstract      Returns the maximum quantity for the given source in the time period represented by the receiver.
   @discussion    If HKStatisticsOptionSeparateBySource is not specified, then this will always be nil.
   */
  func maximumQuantityFor(source: HKSource) -> HKQuantity?

  /*!
   @method        maximumQuantity
   @abstract      Returns the maximum quantity in the time period represented by the receiver.
   */
  func maximumQuantity() -> HKQuantity?

  /*!
   @method        sumQuantityForSource:
   @abstract      Returns the sum quantity for the given source in the time period represented by the receiver.
   @discussion    If HKStatisticsOptionSeparateBySource is not specified, then this will always be nil.
   */
  func sumQuantityFor(source: HKSource) -> HKQuantity?

  /*!
   @method        sumQuantity
   @abstract      Returns the sum of quantities in the time period represented by the receiver.
   */
  func sumQuantity() -> HKQuantity?
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 8.0, *)
class HKStatisticsCollection : Object {

  /*!
   @method        statisticsForDate:
   @abstract      Returns the statistics object that this date is inside of
   @discussion    If there are no samples for the given date, an HKStatistics instance with nil quantities will be returned.
   */
  func statisticsFor(date: Date) -> HKStatistics?

  /*!
   @method        enumerateStatisticsFromDate:toDate:withBlock:
   @abstract      Enumerates all statistics objects from startDate to endDate.
   @discussion    Statistics objects will be enumerated in chronological order. If there are no samples for an interval
                  between the start and end date, then the HKStatistics object for that interval will have nil quantities.
   */
  func enumerateStatisticsFrom(startDate: Date, to endDate: Date, withBlock block: (HKStatistics, UnsafeMutablePointer<ObjCBool>) -> Void)

  /*!
   @method        statistics
   @abstract      Returns a copy of the populated statistics objects.
   @discussion    The statistics objects are ordered chronologically.
   */
  func statistics() -> [HKStatistics]

  /*!
   @method        sources
   @abstract      Returns all HKSources found in the contained HKStatistics objects.
   @discussion    Sources will be empty unless HKStatisticsOptionSeparateBySource is specified in the
                  HKStatisticsCollectionQuery options.
   */
  func sources() -> Set<HKSource>
}
@available(iOS 8.0, *)
class HKStatisticsCollectionQuery : HKQuery {
  var anchorDate: Date { get }
  var options: HKStatisticsOptions { get }
  @NSCopying var intervalComponents: DateComponents { get }
  var initialResultsHandler: ((HKStatisticsCollectionQuery, HKStatisticsCollection?, Error?) -> Void)?
  var statisticsUpdateHandler: ((HKStatisticsCollectionQuery, HKStatistics?, HKStatisticsCollection?, Error?) -> Void)?
  init(quantityType: HKQuantityType, quantitySamplePredicate: Predicate?, options: HKStatisticsOptions = [], anchorDate: Date, intervalComponents: DateComponents)
}

/*!
 @class     HKStatisticsQuery
 @abstract  Calculates statistics on quantity samples matching the given quantity type and predicate.
 */
@available(iOS 8.0, *)
class HKStatisticsQuery : HKQuery {
  init(quantityType: HKQuantityType, quantitySamplePredicate: Predicate?, options: HKStatisticsOptions = [], completionHandler handler: (HKStatisticsQuery, HKStatistics?, Error?) -> Void)
}
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBodyMassIndex: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBodyFatPercentage: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierHeight: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBodyMass: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierLeanBodyMass: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierStepCount: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDistanceWalkingRunning: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDistanceCycling: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBasalEnergyBurned: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierActiveEnergyBurned: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierFlightsClimbed: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierNikeFuel: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierHeartRate: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBodyTemperature: String
@available(iOS 9.0, *)
let HKQuantityTypeIdentifierBasalBodyTemperature: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBloodPressureSystolic: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBloodPressureDiastolic: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierRespiratoryRate: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierOxygenSaturation: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierPeripheralPerfusionIndex: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBloodGlucose: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierNumberOfTimesFallen: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierElectrodermalActivity: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierInhalerUsage: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierBloodAlcoholContent: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierForcedVitalCapacity: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierForcedExpiratoryVolume1: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierPeakExpiratoryFlowRate: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryFatTotal: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryFatPolyunsaturated: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryFatMonounsaturated: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryFatSaturated: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryCholesterol: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietarySodium: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryCarbohydrates: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryFiber: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietarySugar: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryEnergyConsumed: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryProtein: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryVitaminA: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryVitaminB6: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryVitaminB12: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryVitaminC: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryVitaminD: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryVitaminE: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryVitaminK: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryCalcium: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryIron: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryThiamin: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryRiboflavin: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryNiacin: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryFolate: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryBiotin: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryPantothenicAcid: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryPhosphorus: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryIodine: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryMagnesium: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryZinc: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietarySelenium: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryCopper: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryManganese: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryChromium: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryMolybdenum: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryChloride: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryPotassium: String
@available(iOS 8.0, *)
let HKQuantityTypeIdentifierDietaryCaffeine: String
@available(iOS 9.0, *)
let HKQuantityTypeIdentifierDietaryWater: String
@available(iOS 9.0, *)
let HKQuantityTypeIdentifierUVExposure: String
@available(iOS 8.0, *)
let HKCategoryTypeIdentifierSleepAnalysis: String
@available(iOS 9.0, *)
let HKCategoryTypeIdentifierAppleStandHour: String
@available(iOS 9.0, *)
let HKCategoryTypeIdentifierCervicalMucusQuality: String
@available(iOS 9.0, *)
let HKCategoryTypeIdentifierOvulationTestResult: String
@available(iOS 9.0, *)
let HKCategoryTypeIdentifierMenstrualFlow: String
@available(iOS 9.0, *)
let HKCategoryTypeIdentifierIntermenstrualBleeding: String
@available(iOS 9.0, *)
let HKCategoryTypeIdentifierSexualActivity: String
@available(iOS 8.0, *)
let HKCharacteristicTypeIdentifierBiologicalSex: String
@available(iOS 8.0, *)
let HKCharacteristicTypeIdentifierBloodType: String
@available(iOS 8.0, *)
let HKCharacteristicTypeIdentifierDateOfBirth: String
@available(iOS 9.0, *)
let HKCharacteristicTypeIdentifierFitzpatrickSkinType: String
@available(iOS 8.0, *)
let HKCorrelationTypeIdentifierBloodPressure: String
@available(iOS 8.0, *)
let HKCorrelationTypeIdentifierFood: String
@available(iOS 8.0, *)
let HKWorkoutTypeIdentifier: String
@available(iOS 8.0, *)
class HKUnit : Object, SecureCoding, Copying {

  /// Returns a unique string representation for the unit that could be used with +unitFromString:
  var unitString: String { get }
  convenience init(from string: String)
  convenience init(from massFormatterUnit: MassFormatterUnit)
  class func massFormatterUnitFrom(unit: HKUnit) -> MassFormatterUnit
  convenience init(from lengthFormatterUnit: LengthFormatterUnit)
  class func lengthFormatterUnitFrom(unit: HKUnit) -> LengthFormatterUnit
  convenience init(from energyFormatterUnit: EnergyFormatterUnit)
  class func energyFormatterUnitFrom(unit: HKUnit) -> EnergyFormatterUnit
  func isNull() -> Bool
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 8.0, *)
enum HKMetricPrefix : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case None
  case Pico
  case Nano
  case Micro
  case Milli
  case Centi
  case Deci
  case Deca
  case Hecto
  case Kilo
  case Mega
  case Giga
  case Tera
}
extension HKUnit {
  class func gramUnitWith(prefix: HKMetricPrefix) -> Self
  class func gram() -> Self
  class func ounce() -> Self
  class func pound() -> Self
  class func stone() -> Self
  class func moleUnitWith(prefix: HKMetricPrefix, molarMass gramsPerMole: Double) -> Self
  class func moleUnitWithMolarMass(gramsPerMole: Double) -> Self
}
extension HKUnit {
  class func meterUnitWith(prefix: HKMetricPrefix) -> Self
  class func meter() -> Self
  class func inch() -> Self
  class func foot() -> Self
  @available(iOS 9.0, *)
  class func yard() -> Self
  class func mile() -> Self
}
extension HKUnit {
  class func literUnitWith(prefix: HKMetricPrefix) -> Self
  class func liter() -> Self
  class func fluidOunceUS() -> Self
  class func fluidOunceImperial() -> Self
  class func pintUS() -> Self
  class func pintImperial() -> Self
  @available(iOS 9.0, *)
  class func cupUS() -> Self
  @available(iOS 9.0, *)
  class func cupImperial() -> Self
}
extension HKUnit {
  class func pascalUnitWith(prefix: HKMetricPrefix) -> Self
  class func pascal() -> Self
  class func millimeterOfMercury() -> Self
  class func centimeterOfWater() -> Self
  class func atmosphere() -> Self
}
extension HKUnit {
  class func secondUnitWith(prefix: HKMetricPrefix) -> Self
  class func second() -> Self
  class func minute() -> Self
  class func hour() -> Self
  class func day() -> Self
}
extension HKUnit {
  class func jouleUnitWith(prefix: HKMetricPrefix) -> Self
  class func joule() -> Self
  class func calorie() -> Self
  class func kilocalorie() -> Self
}
extension HKUnit {
  class func degreeCelsius() -> Self
  class func degreeFahrenheit() -> Self
  class func kelvin() -> Self
}
extension HKUnit {
  class func siemenUnitWith(prefix: HKMetricPrefix) -> Self
  class func siemen() -> Self
}
extension HKUnit {
  class func count() -> Self
  class func percent() -> Self
}
extension HKUnit {
  func unitMultipliedBy(unit: HKUnit) -> HKUnit
  func unitDividedBy(unit: HKUnit) -> HKUnit
  func unitRaisedToPower(power: Int) -> HKUnit
  func reciprocal() -> HKUnit
}
var HKUnitMolarMassBloodGlucose: Double { get }

/*!
 @enum          HKWorkoutActivityType
 @abstract      Represents a particular type of workout or exercise
 */
@available(iOS 8.0, *)
enum HKWorkoutActivityType : UInt {
  init?(rawValue: UInt)
  var rawValue: UInt { get }
  case AmericanFootball
  case Archery
  case AustralianFootball
  case Badminton
  case Baseball
  case Basketball
  case Bowling
  case Boxing
  case Climbing
  case Cricket
  case CrossTraining
  case Curling
  case Cycling
  case Dance
  case DanceInspiredTraining
  case Elliptical
  case EquestrianSports
  case Fencing
  case Fishing
  case FunctionalStrengthTraining
  case Golf
  case Gymnastics
  case Handball
  case Hiking
  case Hockey
  case Hunting
  case Lacrosse
  case MartialArts
  case MindAndBody
  case MixedMetabolicCardioTraining
  case PaddleSports
  case Play
  case PreparationAndRecovery
  case Racquetball
  case Rowing
  case Rugby
  case Running
  case Sailing
  case SkatingSports
  case SnowSports
  case Soccer
  case Softball
  case Squash
  case StairClimbing
  case SurfingSports
  case Swimming
  case TableTennis
  case Tennis
  case TrackAndField
  case TraditionalStrengthTraining
  case Volleyball
  case Walking
  case WaterFitness
  case WaterPolo
  case WaterSports
  case Wrestling
  case Yoga
  case Other
}
@available(iOS 8.0, *)
enum HKWorkoutEventType : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Pause
  case Resume
}

/*!
 @class         HKWorkoutEvent
 @abstract      Represents a particular event that occurred during a workout
 */
@available(iOS 8.0, *)
class HKWorkoutEvent : Object, SecureCoding {
  var type: HKWorkoutEventType { get }
  @NSCopying var date: Date { get }
  convenience init(type: HKWorkoutEventType, date: Date)
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!
 @class         HKWorkout
 @abstract      An HKObject subclass representing a workout or activity
 */
@available(iOS 8.0, *)
class HKWorkout : HKSample {

  /*!
   @property      workoutActivityType
   @abstract      Represents the activity that the user was performing during a workout
   */
  var workoutActivityType: HKWorkoutActivityType { get }

  /*!
   @property      workoutEvents
   @abstract      An array of HKWorkoutEvents that occurred during a workout.
   @discussion    These events will be ordered by date in ascending order. All events must take place
                  between the start date and end date of the workout. The first workout event should always be a pause event
                  because it is assumed that the workout begins in a running state. A pause event can only be followed by
                  a resume event, and a resume event can only be followed by a pause event.
   */
  var workoutEvents: [HKWorkoutEvent]? { get }

  /*!
   @property      duration
   @abstract      The length of time that a workout was recording
   @discussion    The duration is derived from the start an end date of the workout, and takes into account periods that the 
                  workout was paused. Periods that the workout was paused are based off of the workoutEvents property.
   */
  var duration: TimeInterval { get }

  /*!
   @property      totalEnergyBurned
   @abstract      The amount of energy that was burned during a workout
   @discussion    This metric should represent the total active energy burned during the course of the workout. It should be a
                  quantity with a unit representing energy.
   */
  var totalEnergyBurned: HKQuantity? { get }

  /*!
   @property      totalDistance
   @abstract      The total distance that was traveled during a workout
   @discussion    This metric should represent the total distance traveled during the course of the workout. It should be a
                  quantity with a unit representing length.
   */
  var totalDistance: HKQuantity? { get }

  /*!
   @method        workoutWithActivityType:startDate:endDate:
  
   @param         workoutActivityType     The activity type of the workout
   @param         startDate               The point in time that the workout was started
   @param         endDate                 The point in time that the workout was ended
   */
  convenience init(activityType workoutActivityType: HKWorkoutActivityType, start startDate: Date, end endDate: Date)

  /*!
   @method        workoutWithActivityType:startDate:endDate:workoutEvents:totalEnergyBurned:totalDistance:metadata
   @discussion    If the optional total parameters are specified, matching samples that add up to the calculated total quantities
                  should be associated with this workout using addSamples:toWorkout:completion: in HKHealthStore.
   
   @param         workoutActivityType     The activity type of the workout
   @param         startDate               The point in time that the workout was started
   @param         endDate                 The point in time that the workout was ended
   @param         workoutEvents           An array of HKWorkoutEvents. The workout's duration is derived from these events. (Optional)
   @param         totalEnergyBurned       The amount of energy that was burned during the workout. (Optional)
   @param         totalDistance           The total distance that was traveled during the workout. (Optional)
   @param         metadata                Metadata for the workout. (Optional)
   */
  convenience init(activityType workoutActivityType: HKWorkoutActivityType, start startDate: Date, end endDate: Date, workoutEvents: [HKWorkoutEvent]?, totalEnergyBurned: HKQuantity?, totalDistance: HKQuantity?, metadata: [String : AnyObject]?)

  /*!
   @method        workoutWithActivityType:startDate:endDate:workoutEvents:totalEnergyBurned:totalDistance:metadata
   @discussion    If the optional total parameters are specified, matching samples that add up to the calculated total quantities
                  should be associated with this workout using addSamples:toWorkout:completion: in HKHealthStore.
   
   @param         workoutActivityType     The activity type of the workout
   @param         startDate               The point in time that the workout was started
   @param         endDate                 The point in time that the workout was ended
   @param         workoutEvents           An array of HKWorkoutEvents. The workout's duration is derived from these events. (Optional)
   @param         totalEnergyBurned       The amount of energy that was burned during the workout. (Optional)
   @param         totalDistance           The total distance that was traveled during the workout. (Optional)
   @param         device                  The HKDevice associated with the workout (optional).
   @param         metadata                Metadata for the workout. (Optional)
   */
  @available(iOS 9.0, *)
  convenience init(activityType workoutActivityType: HKWorkoutActivityType, start startDate: Date, end endDate: Date, workoutEvents: [HKWorkoutEvent]?, totalEnergyBurned: HKQuantity?, totalDistance: HKQuantity?, device: HKDevice?, metadata: [String : AnyObject]?)

  /*!
   @method        workoutWithActivityType:startDate:endDate:duration:totalEnergyBurned:totalDistance:metadata:
   @discussion    If the optional total parameters are specified, matching samples that add up to the calculated total quantities
                  should be associated with this workout using addSamples:toWorkout:completion: in HKHealthStore.
   
   @param         workoutActivityType     The activity type of the workout
   @param         startDate               The point in time that the workout was started
   @param         endDate                 The point in time that the workout was ended
   @param         duration                The duration of the workout. If 0, the difference between startDate and endDate is used.
   @param         totalEnergyBurned       The amount of energy that was burned during the workout. (Optional)
   @param         totalDistance           The total distance that was traveled during the workout. (Optional)
   @param         metadata                Metadata for the workout. (Optional)
   */
  convenience init(activityType workoutActivityType: HKWorkoutActivityType, start startDate: Date, end endDate: Date, duration: TimeInterval, totalEnergyBurned: HKQuantity?, totalDistance: HKQuantity?, metadata: [String : AnyObject]?)

  /*!
   @method        workoutWithActivityType:startDate:endDate:duration:totalEnergyBurned:totalDistance:device:metadata:
   @discussion    If the optional total parameters are specified, matching samples that add up to the calculated total quantities
                  should be associated with this workout using addSamples:toWorkout:completion: in HKHealthStore.
   
   @param         workoutActivityType     The activity type of the workout
   @param         startDate               The point in time that the workout was started
   @param         endDate                 The point in time that the workout was ended
   @param         duration                The duration of the workout. If 0, the difference between startDate and endDate is used.
   @param         totalEnergyBurned       The amount of energy that was burned during the workout. (Optional)
   @param         totalDistance           The total distance that was traveled during the workout. (Optional)
   @param         device                  The HKDevice associated with the workout (optional).
   @param         metadata                Metadata for the workout. (Optional)
   */
  @available(iOS 9.0, *)
  convenience init(activityType workoutActivityType: HKWorkoutActivityType, start startDate: Date, end endDate: Date, duration: TimeInterval, totalEnergyBurned: HKQuantity?, totalDistance: HKQuantity?, device: HKDevice?, metadata: [String : AnyObject]?)
  init?(coder aDecoder: Coder)
}
@available(iOS 8.0, *)
let HKPredicateKeyPathWorkoutDuration: String
@available(iOS 8.0, *)
let HKPredicateKeyPathWorkoutTotalDistance: String
@available(iOS 8.0, *)
let HKPredicateKeyPathWorkoutTotalEnergyBurned: String
@available(iOS 8.0, *)
let HKPredicateKeyPathWorkoutType: String
@available(iOS 8.0, *)
let HKWorkoutSortIdentifierDuration: String
@available(iOS 8.0, *)
let HKWorkoutSortIdentifierTotalDistance: String
@available(iOS 8.0, *)
let HKWorkoutSortIdentifierTotalEnergyBurned: String
