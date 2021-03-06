

/*!
 @constant					AVCoreAnimationBeginTimeAtZero
 @discussion				Use this constant to set the CoreAnimation's animation beginTime property to be time 0.
							The constant is a small, non-zero, positive value which avoids CoreAnimation
							from replacing 0.0 with CACurrentMediaTime().
*/
@available(iOS 4.0, *)
let AVCoreAnimationBeginTimeAtZero: CFTimeInterval

/*!
	@constant		AVLayerVideoGravityResizeAspect
	@abstract		Preserve aspect ratio; fit within layer bounds.
	@discussion		AVLayerVideoGravityResizeAspect may be used when setting the videoGravity
                    property of an AVPlayerLayer or AVCaptureVideoPreviewLayer instance.
 */
@available(iOS 4.0, *)
let AVLayerVideoGravityResizeAspect: String

/*!
	@constant		AVLayerVideoGravityResizeAspectFill
	@abstract		Preserve aspect ratio; fill layer bounds.
    @discussion     AVLayerVideoGravityResizeAspectFill may be used when setting the videoGravity
                    property of an AVPlayerLayer or AVCaptureVideoPreviewLayer instance.
 */
@available(iOS 4.0, *)
let AVLayerVideoGravityResizeAspectFill: String

/*!
	@constant		AVLayerVideoGravityResize
	@abstract		Stretch to fill layer bounds.
    @discussion     AVLayerVideoGravityResize may be used when setting the videoGravity
                    property of an AVPlayerLayer or AVCaptureVideoPreviewLayer instance.
 */
@available(iOS 4.0, *)
let AVLayerVideoGravityResize: String
@available(iOS 4.0, *)
class AVAsset : Object, Copying, AVAsynchronousKeyValueLoading {

  /*!
    @method		assetWithURL:
    @abstract		Returns an instance of AVAsset for inspection of a media resource.
    @param		URL
  				An instance of NSURL that references a media resource.
    @result		An instance of AVAsset.
    @discussion	Returns a newly allocated instance of a subclass of AVAsset initialized with the specified URL.
  */
  convenience init(url URL: URL)
  var duration: CMTime { get }
  var preferredRate: Float { get }
  var preferredVolume: Float { get }
  var preferredTransform: CGAffineTransform { get }
  init()
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject

  /*!
    @method		statusOfValueForKey:
    @abstract		Reports whether the value for a key is immediately available without blocking.
    @param		key
      An instance of NSString containing the specified key.
    @param		outError
      If the status of the value for the key is AVKeyValueStatusFailed, *outError is set to a non-nil NSError that describes the failure that occurred.
    @result		The value's current loading status.
    @discussion
      Clients can use -statusOfValueForKey: to determine the availability of the value of any key of interest. However, this method alone does not prompt the receiver to load the value of a key that's not yet available. To request values for keys that may not already be loaded, without blocking, use -loadValuesAsynchronouslyForKeys:completionHandler:, await invocation of the completion handler, and test the availability of each key via -statusOfValueForKey: before invoking its getter.
   
      Even if access to values of some keys may be readily available, as can occur with receivers initialized with URLs for resources on local volumes, extensive I/O or parsing may be needed for these same receivers to provide values for other keys. A duration for a local MP3 file, for example, may be expensive to obtain, even if the values for other AVAsset properties may be trivial to obtain.
  
      Blocking that may occur when calling the getter for any key should therefore be avoided in the general case by loading values for all keys of interest via -loadValuesAsynchronouslyForKeys:completionHandler: and testing the availability of the requested values before fetching them by calling getters.
        
      The sole exception to this general rule is in usage on Mac OS X on the desktop, where it may be acceptable to block in cases in which the client is preparing objects for use on background threads or in operation queues. On iOS, values should always be loaded asynchronously prior to calling getters for the values, in any usage scenario.
  */
  @available(iOS 4.0, *)
  func statusOfValueForKey(key: String, error outError: ErrorPointer) -> AVKeyValueStatus

  /*!
    @method		loadValuesAsynchronouslyForKeys:completionHandler:
    @abstract		Directs the target to load the values of any of the specified keys that are not already loaded.
    @param		keys
      An instance of NSArray, containing NSStrings for the specified keys.
    @param		completionHandler
      The block to be invoked when loading succeeds, fails, or is cancelled.
  */
  @available(iOS 4.0, *)
  func loadValuesAsynchronouslyForKeys(keys: [String], completionHandler handler: (() -> Void)? = nil)
}
extension AVAsset {
  var providesPreciseDurationAndTiming: Bool { get }

  /*!
    @method		cancelLoading
    @abstract		Cancels the loading of all values for all observers.
    @discussion	Deallocation or finalization of an instance of AVAsset will implicitly cancel loading if any loading requests are still outstanding.
  */
  func cancelLoading()
}
extension AVAsset {

  /*!
    @property		referenceRestrictions
    @abstract		Indicates the reference restrictions being used by the receiver.
    @discussion
  	For AVURLAsset, this property reflects the value passed in for AVURLAssetReferenceRestrictionsKey, if any. See AVURLAssetReferenceRestrictionsKey below for a full discussion of reference restrictions. The default value for this property is AVAssetReferenceRestrictionForbidNone.
  */
  @available(iOS 5.0, *)
  var referenceRestrictions: AVAssetReferenceRestrictions { get }
}

/*!
  @enum			AVAssetReferenceRestrictions
  @abstract		These constants can be passed in to AVURLAssetReferenceRestrictionsKey to control the resolution of references to external media data.
 
  @constant		AVAssetReferenceRestrictionForbidNone
	Indicates that all types of references should be followed.
  @constant		AVAssetReferenceRestrictionForbidRemoteReferenceToLocal
	Indicates that references from a remote asset (e.g. referenced via http URL) to local media data (e.g. stored in a local file) should not be followed.
  @constant		AVAssetReferenceRestrictionForbidLocalReferenceToRemote
	Indicates that references from a local asset to remote media data should not be followed.
  @constant		AVAssetReferenceRestrictionForbidCrossSiteReference
	Indicates that references from a remote asset to remote media data stored at a different site should not be followed.
  @constant		AVAssetReferenceRestrictionForbidLocalReferenceToLocal
	Indicates that references from a local asset to local media data stored outside the asset's container file should not be followed.
  @constant		AVAssetReferenceRestrictionForbidAll
	Indicates that only references to media data stored within the asset's container file should be allowed.
*/
struct AVAssetReferenceRestrictions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var ForbidNone: AVAssetReferenceRestrictions { get }
  static var ForbidRemoteReferenceToLocal: AVAssetReferenceRestrictions { get }
  static var ForbidLocalReferenceToRemote: AVAssetReferenceRestrictions { get }
  static var ForbidCrossSiteReference: AVAssetReferenceRestrictions { get }
  static var ForbidLocalReferenceToLocal: AVAssetReferenceRestrictions { get }
  static var ForbidAll: AVAssetReferenceRestrictions { get }
}
extension AVAsset {

  /*!
    @property		tracks
    @abstract		Provides the array of AVAssetTracks contained by the asset
  */
  var tracks: [AVAssetTrack] { get }

  /*!
    @method		trackWithTrackID:
    @abstract		Provides an instance of AVAssetTrack that represents the track of the specified trackID.
    @param		trackID
  				The trackID of the requested AVAssetTrack.
    @result		An instance of AVAssetTrack; may be nil if no track of the specified trackID is available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func trackWithTrackID(trackID: CMPersistentTrackID) -> AVAssetTrack?

  /*!
    @method		tracksWithMediaType:
    @abstract		Provides an array of AVAssetTracks of the asset that present media of the specified media type.
    @param		mediaType
  				The media type according to which AVAsset filters its AVAssetTracks. (Media types are defined in AVMediaFormat.h.)
    @result		An NSArray of AVAssetTracks; may be empty if no tracks of the specified media type are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaType(mediaType: String) -> [AVAssetTrack]

  /*!
    @method		tracksWithMediaCharacteristic:
    @abstract		Provides an array of AVAssetTracks of the asset that present media with the specified characteristic.
    @param		mediaCharacteristic
  				The media characteristic according to which AVAsset filters its AVAssetTracks. (Media characteristics are defined in AVMediaFormat.h.)
    @result		An NSArray of AVAssetTracks; may be empty if no tracks with the specified characteristic are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaCharacteristic(mediaCharacteristic: String) -> [AVAssetTrack]

  /*!
   @property trackGroups
   @abstract
  	All track groups in the receiver.
   
   @discussion
  	The value of this property is an NSArray of AVAssetTrackGroups, each representing a different grouping of tracks in the receiver.
   */
  @available(iOS 7.0, *)
  var trackGroups: [AVAssetTrackGroup] { get }
}
extension AVAsset {
  @available(iOS 5.0, *)
  var creationDate: AVMetadataItem? { get }
  var lyrics: String? { get }
  var commonMetadata: [AVMetadataItem] { get }
  @available(iOS 8.0, *)
  var metadata: [AVMetadataItem] { get }
  var availableMetadataFormats: [String] { get }

  /*!
    @method		metadataForFormat:
    @abstract		Provides an NSArray of AVMetadataItems, one for each metadata item in the container of the specified format; can subsequently be filtered according to language via +[AVMetadataItem metadataItemsFromArray:filteredAndSortedAccordingToPreferredLanguages:], according to locale via +[AVMetadataItem metadataItemsFromArray:withLocale:], or according to key via +[AVMetadataItem metadataItemsFromArray:withKey:keySpace:].
    @param		format
  				The metadata format for which items are requested.
    @result		An NSArray containing AVMetadataItems; may be empty if there is no metadata of the specified format.
    @discussion	Becomes callable without blocking when the key @"availableMetadataFormats" has been loaded
  */
  func metadataForFormat(format: String) -> [AVMetadataItem]
}
extension AVAsset {
  @available(iOS 4.3, *)
  var availableChapterLocales: [Locale] { get }

  /*!
    @method		chapterMetadataGroupsWithTitleLocale:containingMetadataItemsWithCommonKeys:
    @abstract		Provides an array of chapters.
    @param		locale
  				Locale of the metadata items carrying chapter titles to be returned (supports the IETF BCP 47 specification).
    @param		commonKeys
  				Array of common keys of AVMetadataItem to be included; can be nil. 
  				AVMetadataCommonKeyArtwork is the only supported key for now.
    @result		An NSArray of AVTimedMetadataGroup.
    @discussion	
  	This method returns an array of AVTimedMetadataGroup objects. Each object in the array always contains an AVMetadataItem representing the chapter title; the timeRange property of the AVTimedMetadataGroup object is equal to the time range of the chapter title item.
  
  	An AVMetadataItem with the specified common key will be added to an existing AVTimedMetadataGroup object if the time range (timestamp and duration) of the metadata item and the metadata group overlaps. The locale of items not carrying chapter titles need not match the specified locale parameter.
   
  	Further filtering of the metadata items in AVTimedMetadataGroups according to language can be accomplished using +[AVMetadataItem metadataItemsFromArray:filteredAndSortedAccordingToPreferredLanguages:]; filtering of the metadata items according to locale can be accomplished using +[AVMetadataItem metadataItemsFromArray:withLocale:].
  */
  @available(iOS 4.3, *)
  func chapterMetadataGroupsWithTitleLocale(locale: Locale, containingItemsWithCommonKeys commonKeys: [String]?) -> [AVTimedMetadataGroup]

  /*!
   @method		chapterMetadataGroupsBestMatchingPreferredLanguages:
   @abstract		Tests, in order of preference, for a match between language identifiers in the specified array of preferred languages and the available chapter locales, and returns the array of chapters corresponding to the first match that's found.
   @param			preferredLanguages
   An array of language identifiers in order of preference, each of which is an IETF BCP 47 (RFC 4646) language identifier. Use +[NSLocale preferredLanguages] to obtain the user's list of preferred languages.
   @result		An NSArray of AVTimedMetadataGroup.
   @discussion	
   Safe to call without blocking when the AVAsset key availableChapterLocales has status AVKeyValueStatusLoaded.
   
   Returns an array of AVTimedMetadataGroup objects. Each object in the array always contains an AVMetadataItem representing the chapter title; the timeRange property of the AVTimedMetadataGroup object is equal to the time range of the chapter title item.
   
   All of the available chapter metadata is included in the metadata groups, including items with the common key AVMetadataCommonKeyArtwork, if such items are present. Items not carrying chapter titles will be added to an existing AVTimedMetadataGroup object if the time range (timestamp and duration) of the metadata item and that of the metadata group overlaps. The locale of such items need not match the locale of the chapter titles.
   
   Further filtering of the metadata items in AVTimedMetadataGroups according to language can be accomplished using +[AVMetadataItem metadataItemsFromArray:filteredAndSortedAccordingToPreferredLanguages:]; filtering of the metadata items according to locale can be accomplished using +[AVMetadataItem metadataItemsFromArray:withLocale:].
  .
  */
  @available(iOS 6.0, *)
  func chapterMetadataGroupsBestMatchingPreferredLanguages(preferredLanguages: [String]) -> [AVTimedMetadataGroup]
}
extension AVAsset {
  @available(iOS 5.0, *)
  var availableMediaCharacteristicsWithMediaSelectionOptions: [String] { get }

  /*!
    @method		mediaSelectionGroupForMediaCharacteristic:
    @abstract		Provides an instance of AVMediaSelectionGroup that contains one or more options with the specified media characteristic.
    @param		mediaCharacteristic
  	A media characteristic for which you wish to obtain the available media selection options. AVMediaCharacteristicAudible, AVMediaCharacteristicLegible, and AVMediaCharacteristicVisual are currently supported.
  
  	Pass AVMediaCharacteristicAudible to obtain the group of available options for audio media in various languages and for various purposes, such as descriptive audio.
  	Pass AVMediaCharacteristicLegible to obtain the group of available options for subtitles in various languages and for various purposes.
  	Pass AVMediaCharacteristicVisual to obtain the group of available options for video media.
    @result		An instance of AVMediaSelectionGroup. May be nil.
    @discussion
  	Becomes callable without blocking when the key @"availableMediaCharacteristicsWithMediaSelectionOptions" has been loaded.
  
  	If the asset has no AVMediaSelectionGroup containing options with the specified media characteristic, the return value will be nil.
  	
  	Filtering of the options in the returned AVMediaSelectionGroup according to playability, locale, and additional media characteristics can be accomplished using the category AVMediaSelectionOptionFiltering defined on AVMediaSelectionGroup.
  */
  @available(iOS 5.0, *)
  func mediaSelectionGroupForMediaCharacteristic(mediaCharacteristic: String) -> AVMediaSelectionGroup?

  /*!
    @property		preferredMediaSelection
    @abstract		Provides an instance of AVMediaSelection with default selections for each of the receiver's media selection groups.
  */
  @available(iOS 9.0, *)
  var preferredMediaSelection: AVMediaSelection { get }
}
extension AVAsset {
  @available(iOS 4.2, *)
  var hasProtectedContent: Bool { get }
}
extension AVAsset {

  /*!
    @property		canContainFragments
    @abstract		Indicates whether the asset is capable of being extended by fragments.
    @discussion	For QuickTime movie files and MPEG-4 files, the value of canContainFragments is YES if an 'mvex' box is present in the 'moov' box. For those types, the 'mvex' box signals the possible presence of later 'moof' boxes.
  */
  @available(iOS 9.0, *)
  var canContainFragments: Bool { get }

  /*!
    @property		containsFragments
    @abstract		Indicates whether the asset is extended by at least one movie fragment.
    @discussion	For QuickTime movie files and MPEG-4 files, the value of this property is YES if canContainFragments is YES and at least one 'moof' box is present after the 'moov' box.
  */
  @available(iOS 9.0, *)
  var containsFragments: Bool { get }
}
extension AVAsset {
  @available(iOS 4.3, *)
  var isPlayable: Bool { get }
  @available(iOS 4.3, *)
  var isExportable: Bool { get }
  @available(iOS 4.3, *)
  var isReadable: Bool { get }
  @available(iOS 4.3, *)
  var isComposable: Bool { get }
  @available(iOS 5.0, *)
  var isCompatibleWithSavedPhotosAlbum: Bool { get }

  /*!
    @property		compatibleWithAirPlayVideo
    @abstract		Indicates whether the asset is compatible with AirPlay Video.
    @discussion	YES if an AVPlayerItem initialized with the receiver can be played by an external device via AirPlay Video.
   */
  @available(iOS 9.0, *)
  var isCompatibleWithAirPlayVideo: Bool { get }
}

/*!
  @constant		AVURLAssetPreferPreciseDurationAndTimingKey
  @abstract
	Indicates whether the asset should be prepared to indicate a precise duration and provide precise random access by time.
	The value for this key is a boolean NSNumber.
  @discussion
	If nil is passed as the value of the options parameter to -[AVURLAsset initWithURL:options:], or if a dictionary that lacks a value for the key AVURLAssetPreferPreciseDurationAndTimingKey is passed instead, a default value of NO is assumed. If the asset is intended to be played only, because AVPlayer will support approximate random access by time when full precision isn't available, the default value of NO will suffice.
	Pass YES if longer loading times are acceptable in cases in which precise timing is required. If the asset is intended to be inserted into an AVMutableComposition, precise random access is typically desirable and the value of YES is recommended.
	Note that such precision may require additional parsing of the resource in advance of operations that make use of any portion of it, depending on the specifics of its container format. Many container formats provide sufficient summary information for precise timing and do not require additional parsing to prepare for it; QuickTime movie files and MPEG-4 files are examples of such formats. Other formats do not provide sufficient summary information, and precise random access for them is possible only after a preliminary examination of a file's contents.
	If you pass YES for an asset that you intend to play via an instance of AVPlayerItem and you are prepared for playback to commence before the value of -[AVPlayerItem duration] becomes available, you can omit the key @"duration" from the array of AVAsset keys you pass to -[AVPlayerItem initWithAsset:automaticallyLoadedAssetKeys:] in order to prevent AVPlayerItem from automatically loading the value of duration while the item becomes ready to play.
	If precise duration and timing is not possible for the timed media resource referenced by the asset's URL, AVAsset.providesPreciseDurationAndTiming will be NO even if precise timing is requested via the use of this key.
					
*/
@available(iOS 4.0, *)
let AVURLAssetPreferPreciseDurationAndTimingKey: String

/*!
  @constant		AVURLAssetReferenceRestrictionsKey
  @abstract
	Indicates the restrictions used by the asset when resolving references to external media data. The value of this key is an NSNumber wrapping an AVAssetReferenceRestrictions enum value or the logical combination of multiple such values.
  @discussion
	Some assets can contain references to media data stored outside the asset's container file, for example in another file. This key can be used to specify a policy to use when these references are encountered. If an asset contains one or more references of a type that is forbidden by the reference restrictions, loading of asset properties will fail. In addition, such an asset cannot be used with other AVFoundation modules, such as AVPlayerItem or AVAssetExportSession.
*/
@available(iOS 5.0, *)
let AVURLAssetReferenceRestrictionsKey: String

/*!
 @constant		AVURLAssetHTTPCookiesKey
 @abstract
	HTTP cookies that the AVURLAsset may send with HTTP requests
	Standard cross-site policy still applies: cookies will only be sent to domains to which they apply.
 @discussion
	By default, an AVURLAsset will only have access to cookies in the client's default cookie storage 
	that apply to the AVURLAsset's URL.  You can supplement the cookies available to the asset
	via use of this initialization option 
	
	HTTP cookies do not apply to non-HTTP(S) URLS.
	In HLS, many HTTP requests (e.g., media, crypt key, variant index) might be issued to different paths or hosts.
	In both of these cases, HTTP requests will be missing any cookies that do not apply to the AVURLAsset's URL.  
	This init option allows the AVURLAsset to use additional HTTP cookies for those HTTP(S) requests.
 */
@available(iOS 8.0, *)
let AVURLAssetHTTPCookiesKey: String
@available(iOS 4.0, *)
class AVURLAsset : AVAsset {

  /*!
    @method		audiovisualTypes
    @abstract		Provides the file types the AVURLAsset class understands.
    @result		An NSArray of UTIs identifying the file types the AVURLAsset class understands.
  */
  @available(iOS 5.0, *)
  class func audiovisualTypes() -> [String]

  /*!
    @method		audiovisualMIMETypes
    @abstract		Provides the MIME types the AVURLAsset class understands.
    @result		An NSArray of NSStrings containing MIME types the AVURLAsset class understands.
  */
  @available(iOS 5.0, *)
  class func audiovisualMIMETypes() -> [String]

  /*!
    @method		isPlayableExtendedMIMEType:
    @abstract		Returns YES if asset is playable with the codec(s) and container type specified in extendedMIMEType. Returns NO otherwise.
    @param		extendedMIMEType
    @result		YES or NO.
  */
  @available(iOS 5.0, *)
  class func isPlayableExtendedMIMEType(extendedMIMEType: String) -> Bool

  /*!
    @method		initWithURL:options:
    @abstract		Initializes an instance of AVURLAsset for inspection of a media resource.
    @param		URL
  				An instance of NSURL that references a media resource.
    @param		options
  				An instance of NSDictionary that contains keys for specifying options for the initialization of the AVURLAsset. See AVURLAssetPreferPreciseDurationAndTimingKey and AVURLAssetReferenceRestrictionsKey above.
    @result		An instance of AVURLAsset.
  */
  init(url URL: URL, options: [String : AnyObject]? = [:])
  @NSCopying var url: URL { get }

  /*!
    @method		assetWithURL:
    @abstract		Returns an instance of AVAsset for inspection of a media resource.
    @param		URL
  				An instance of NSURL that references a media resource.
    @result		An instance of AVAsset.
    @discussion	Returns a newly allocated instance of a subclass of AVAsset initialized with the specified URL.
  */
  convenience init(url URL: URL)
}
extension AVURLAsset {

  /*!
   @property resourceLoader
   @abstract
      Provides access to an instance of AVAssetResourceLoader, which offers limited control over the handling of URLs that may be loaded in the course of performing operations on the asset, such as playback.
      The loading of file URLs cannot be mediated via use of AVAssetResourceLoader.
      Note that copies of an AVAsset will vend the same instance of AVAssetResourceLoader.
  */
  @available(iOS 6.0, *)
  var resourceLoader: AVAssetResourceLoader { get }
}
extension AVURLAsset {

  /*!
    @method		compatibleTrackForCompositionTrack:
    @abstract		Provides a reference to an AVAssetTrack of the target from which any timeRange
  				can be inserted into a mutable composition track (via -[AVMutableCompositionTrack insertTimeRange:ofTrack:atTime:error:]).
    @param		compositionTrack
  				The composition track for which a compatible AVAssetTrack is requested.
    @result		an instance of AVAssetTrack
    @discussion
  	Finds a track of the target with content that can be accommodated by the specified composition track.
  	The logical complement of -[AVMutableComposition mutableTrackCompatibleWithTrack:].
  */
  func compatibleTrackFor(compositionTrack: AVCompositionTrack) -> AVAssetTrack?
}

/*!
 @constant       AVAssetDurationDidChangeNotification
 @abstract       Posted when the duration of an AVFragmentedAsset changes while it's being minded by an AVFragmentedAssetMinder, but only for changes that occur after the status of the value of @"duration" has reached AVKeyValueStatusLoaded.
*/
@available(iOS 9.0, *)
let AVAssetDurationDidChangeNotification: String

/*!
 @constant       AVAssetChapterMetadataGroupsDidChangeNotification
 @abstract       Posted when the collection of arrays of timed metadata groups representing chapters of an AVAsset change and when any of the contents of the timed metadata groups change, but only for changes that occur after the status of the value of @"availableChapterLocales" has reached AVKeyValueStatusLoaded.
*/
@available(iOS 9.0, *)
let AVAssetChapterMetadataGroupsDidChangeNotification: String

/*!

 @constant       AVAssetMediaSelectionGroupsDidChangeNotification
 @abstract       Posted when the collection of media selection groups provided by an AVAsset changes and when any of the contents of its media selection groups change, but only for changes that occur after the status of the value of @"availableMediaCharacteristicsWithMediaSelectionOptions" has reached AVKeyValueStatusLoaded.
*/
@available(iOS 9.0, *)
let AVAssetMediaSelectionGroupsDidChangeNotification: String

/*!
	@class			AVFragmentedAsset
 
	@abstract		A subclass of AVURLAsset that represents media resources that can be extended in total duration without modifying previously existing data structures.
	Such media resources include QuickTime movie files and MPEG-4 files that indicate, via an 'mvex' box in their 'moov' box, that they accommodate additional fragments. Media resources of other types may also be supported. To check whether a given instance of AVFragmentedAsset can be used to monitor the addition of fragments, check the value of the AVURLAsset property canContainFragments.
	An AVFragmentedAsset is capable of changing the values of certain of its properties and those of its tracks, while an operation that appends fragments to the underlying media resource in in progress, if the AVFragmentedAsset is associated with an instance of AVFragmentedAssetMinder.
	@discussion		While associated with an AVFragmentedAssetMinder, AVFragmentedAssetTrack posts AVAssetDurationDidChangeNotification and whenever new fragments are detected, as appropriate. It may also post AVAssetContainsFragmentsDidChangeNotification and AVAssetWasDefragmentedNotification, as discussed in documentation of those notifications.
*/
protocol AVFragmentMinding {
}
extension AVFragmentedAsset {

  /*!
    @method		trackWithTrackID:
    @abstract		Provides an instance of AVFragmentedAssetTrack that represents the track of the specified trackID.
    @param		trackID
  				The trackID of the requested AVFragmentedAssetTrack.
    @result		An instance of AVFragmentedAssetTrack; may be nil if no track of the specified trackID is available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func trackWithTrackID(trackID: CMPersistentTrackID) -> AVFragmentedAssetTrack?

  /*!
    @method		tracksWithMediaType:
    @abstract		Provides an array of AVFragmentedAssetTracks of the asset that present media of the specified media type.
    @param		mediaType
  				The media type according to which the receiver filters its AVFragmentedAssetTracks. (Media types are defined in AVMediaFormat.h)
    @result		An NSArray of AVFragmentedAssetTracks; may be empty if no tracks of the specified media type are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaType(mediaType: String) -> [AVFragmentedAssetTrack]

  /*!
    @method		tracksWithMediaCharacteristic:
    @abstract		Provides an array of AVFragmentedAssetTracks of the asset that present media with the specified characteristic.
    @param		mediaCharacteristic
  				The media characteristic according to which the receiver filters its AVFragmentedAssetTracks. (Media characteristics are defined in AVMediaFormat.h)
    @result		An NSArray of AVFragmentedAssetTracks; may be empty if no tracks with the specified characteristic are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaCharacteristic(mediaCharacteristic: String) -> [AVFragmentedAssetTrack]
}

/*!
 @constant		AVAssetDownloadTaskMinimumRequiredMediaBitrateKey
 @abstract		The lowest media bitrate greater than or equal to this value will be selected. Value should be a NSNumber in bps. If no suitable media bitrate is found, the highest media bitrate will be selected.
				The value for this key should be a NSNumber.
 @discussion	By default, the highest media bitrate will be selected for download.
*/
@available(iOS 9.0, *)
let AVAssetDownloadTaskMinimumRequiredMediaBitrateKey: String

/*!
 @constant		AVAssetDownloadTaskMediaSelectionKey
 @abstract		The media selection for this download.
				The value for this key should be an AVMediaSelection.
 @discussion	By default, media selections for AVAssetDownloadTask will be automatically selected.
*/
@available(iOS 9.0, *)
let AVAssetDownloadTaskMediaSelectionKey: String

/*!
 @class			AVAssetDownloadTask
 @abstract		A NSURLSessionTask that accepts remote AVURLAssets to download locally.
 @discussion	Should be created with -[AVAssetDownloadURLSession assetDownloadTaskWithURLAsset:destinationURL:options:]. To utilize local data for playback for downloads that are in-progress, re-use the URLAsset supplied in initialization. An AVAssetDownloadTask may be instantiated with a destinationURL pointing to an existing asset on disk, for the purpose of completing or augmenting a downloaded asset.
*/
@available(iOS 9.0, *)
class AVAssetDownloadTask : URLSessionTask {

  /*!
   @property		URLAsset
   @abstract		The asset supplied to the download task upon initialization.
  */
  var urlAsset: AVURLAsset { get }

  /*!
   @property		destinationURL
   @abstract		The file URL supplied to the download task upon initialization.
   @discussion	This URL may have been appended with the appropriate extension for the asset.
  */
  var destinationURL: URL { get }

  /*!
   @property		options
   @abstract		The options supplied to the download task upon initialization.
  */
  var options: [String : AnyObject]? { get }

  /*!
   @property		loadedTimeRanges
   @abstract		This property provides a collection of time ranges for which the download task has media data already downloaded and playable. The ranges provided might be discontinuous.
   @discussion	Returns an NSArray of NSValues containing CMTimeRanges.
  */
  var loadedTimeRanges: [Value] { get }
  init()
}

/*!
 @protocol		AVAssetDownloadDelegate
 @abstract		Delegate method to implement when adopting AVAssetDownloadTask.
*/
protocol AVAssetDownloadDelegate : URLSessionTaskDelegate {

  /*!
   @method		URLSession:assetDownloadTask:didLoadTimeRange:totalTimeRangesLoaded:timeRangeExpectedToLoad:
   @abstract		Method to adopt to subscribe to progress updates of the AVAssetDownloadTask
   @param			session
  				The session the asset download task is on.
   @param			assetDownloadTask
  				The AVAssetDownloadTask which is being updated.
   @param			timeRange
  				A CMTimeRange indicating the time range loaded since the last time this method was called.
   @param			loadedTimeRanges
  				A NSArray of NSValues of CMTimeRanges indicating all the time ranges loaded by this asset download task.
   @param			timeRangeExpectedToLoad
  				A CMTimeRange indicating the single time range that is expected to be loaded when the download is complete.
  */
  @available(iOS 9.0, *)
  optional func urlSession(session: URLSession, assetDownloadTask: AVAssetDownloadTask, didLoad timeRange: CMTimeRange, totalTimeRangesLoaded loadedTimeRanges: [Value], timeRangeExpectedToLoad: CMTimeRange)
  @available(iOS 9.0, *)
  optional func urlSession(session: URLSession, assetDownloadTask: AVAssetDownloadTask, didResolve resolvedMediaSelection: AVMediaSelection)
}

/*!
 @class			AVAssetDownloadURLSession
 @abstract		A subclass of NSURLSession to support AVAssetDownloadTask.
*/
@available(iOS 9.0, *)
class AVAssetDownloadURLSession : URLSession {

  /*!
   @method		sessionWithConfiguration:assetDownloadDelegate:delegateQueue:
   @abstract		Creates and initializes an AVAssetDownloadURLSession for use with AVAssetDownloadTasks.
   @param			configuration
  				The configuration for this URLSession. Must be a background configuration.
   @param			assetDownloadDelegate
  				The delegate object to handle asset download progress updates and other session related events.
   @param			delegateQueue
  				The queue to receive delegate callbacks on. If nil, a serial queue will be provided.
  */
  /*not inherited*/ init(configuration: URLSessionConfiguration, assetDownloadDelegate delegate: AVAssetDownloadDelegate?, delegateQueue: OperationQueue?)

  /*!
   @method		assetDownloadTaskWithURLAsset:destinationURL:options:
   @abstract		Creates and initializes an AVAssetDownloadTask to be used with this AVAssetDownloadURLSession.
   @discussion	This method may return nil if the URLSession has been invalidated.
   @param			URLAsset
  				The AVURLAsset to download locally.
   @param			destinationURL
  				The local URL to download the asset to. This must be a file URL.
   @param			options
  				See AVAssetDownloadTask*Key above. Configures non-default behavior for the download task. Using this parameter is required for downloading non-default media selections for HLS assets.
  */
  func assetDownloadTaskWith(URLAsset: AVURLAsset, destinationURL: URL, options: [String : AnyObject]? = [:]) -> AVAssetDownloadTask?
  init()
}

/*!
	@class		AVAssetExportSession

	@abstract	An AVAssetExportSession creates a new timed media resource from the contents of an 
				existing AVAsset in the form described by a specified export preset.

	@discussion
				Prior to initializing an instance of AVAssetExportSession, you can invoke
				+allExportPresets to obtain the complete list of presets available. Use
				+exportPresetsCompatibleWithAsset: to obtain a list of presets that are compatible
				with a specific AVAsset.

				To configure an export, initialize an AVAssetExportSession with an AVAsset that contains
				the source media, an AVAssetExportPreset, the output file type, (a UTI string from 
				those defined in AVMediaFormat.h) and the output URL.

				After configuration is complete, invoke exportAsynchronouslyWithCompletionHandler: 
				to start the export process. This method returns immediately; the export is performed 
				asynchronously. Invoke the -progress method to check on the progress. Note that in 
				some cases, depending on the capabilities of the device, when multiple exports are 
				attempted at the same time some may be queued until others have been completed. When 
				this happens, the status of a queued export will indicate that it's "waiting".

				Whether the export fails, completes, or is cancelled, the completion handler you
				supply to -exportAsynchronouslyWithCompletionHandler: will be called. Upon
				completion, the status property indicates whether the export has completed
				successfully. If it has failed, the value of the error property supplies additional
				information about the reason for the failure.

*/
@available(iOS 4.0, *)
let AVAssetExportPresetLowQuality: String
@available(iOS 4.0, *)
let AVAssetExportPresetMediumQuality: String
@available(iOS 4.0, *)
let AVAssetExportPresetHighestQuality: String
@available(iOS 4.0, *)
let AVAssetExportPreset640x480: String
@available(iOS 4.0, *)
let AVAssetExportPreset960x540: String
@available(iOS 4.0, *)
let AVAssetExportPreset1280x720: String
@available(iOS 5.0, *)
let AVAssetExportPreset1920x1080: String
@available(iOS 9.0, *)
let AVAssetExportPreset3840x2160: String
@available(iOS 4.0, *)
let AVAssetExportPresetAppleM4A: String
@available(iOS 4.0, *)
let AVAssetExportPresetPassthrough: String
enum AVAssetExportSessionStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case Waiting
  case Exporting
  case Completed
  case Failed
  case Cancelled
}
@available(iOS 4.0, *)
class AVAssetExportSession : Object {

  /*!
  	@method						initWithAsset:presetName:
  	@abstract					Initialize an AVAssetExportSession with the specified preset and set the source to the contents of the asset.
  	@param		asset			An AVAsset object that is intended to be exported.
  	@param		presetName		An NSString specifying the name of the preset template for the export.
  	@result						Returns the initialized AVAssetExportSession.
  	@discussion					If the specified asset belongs to a mutable subclass of AVAsset, AVMutableComposition or AVMutableMovie, the results of any export-related operation are undefined if you mutate the asset after the operation commences. These operations include but are not limited to: 1) testing the compatibility of export presets with the asset, 2) calculating the maximum duration or estimated length of the output file, and 3) the export operation itself.
  */
  init?(asset: AVAsset, presetName: String)
  var presetName: String { get }
  @available(iOS 5.0, *)
  var asset: AVAsset { get }
  var outputFileType: String?
  @NSCopying var outputURL: URL?
  var shouldOptimizeForNetworkUse: Bool
  var status: AVAssetExportSessionStatus { get }
  var error: Error? { get }

  /*!
  	@method						exportAsynchronouslyWithCompletionHandler:
  	@abstract					Starts the asynchronous execution of an export session.
  	@param						handler
  								If internal preparation for export fails, the handler will be invoked synchronously.
  								The handler may also be called asynchronously after -exportAsynchronouslyWithCompletionHandler: returns,
  								in the following cases: 
  								1) if a failure occurs during the export, including failures of loading, re-encoding, or writing media data to the output,
  								2) if -cancelExport is invoked, 
  								3) if export session succeeds, having completely written its output to the outputURL. 
  								In each case, AVAssetExportSession.status will signal the terminal state of the asset reader, and if a failure occurs, the NSError 
  								that describes the failure can be obtained from the error property.
  	@discussion					Initiates an asynchronous export operation and returns immediately.
  */
  func exportAsynchronouslyWithCompletionHandler(handler: () -> Void)
  var progress: Float { get }

  /*!
  	@method						cancelExport
  	@abstract					Cancels the execution of an export session.
  	@discussion					Cancel can be invoked when the export is running.
  */
  func cancelExport()
}
extension AVAssetExportSession {

  /*!
  	@method						allExportPresets
  	@abstract					Returns all available export preset names.
  	@discussion					Returns an array of NSStrings with the names of all available presets. Note that not all presets are 
  								compatible with all AVAssets.
  	@result						An NSArray containing an NSString for each of the available preset names.
  */
  class func allExportPresets() -> [String]

  /*!
  	@method						exportPresetsCompatibleWithAsset:
  	@abstract					Returns only the identifiers compatible with the given AVAsset object.
  	@discussion					Not all export presets are compatible with all AVAssets. For example an video only asset is not compatible with an audio only preset.
  								This method returns only the identifiers for presets that will be compatible with the given asset. 
  								A client should pass in an AVAsset that is ready to be exported.
  								In order to ensure that the setup and running of an export operation will succeed using a given preset no significant changes 
  								(such as adding or deleting tracks) should be made to the asset between retrieving compatible identifiers and performing the export operation.
  								This method will access the tracks property of the AVAsset to build the returned NSArray.  To avoid blocking the calling thread, 
  								the tracks property should be loaded using the AVAsynchronousKeyValueLoading protocol before calling this method.
  	@param asset				An AVAsset object that is intended to be exported.
  	@result						An NSArray containing NSString values for the identifiers of compatible export types.  
  								The array is a complete list of the valid identifiers that can be used as arguments to 
  								initWithAsset:presetName: with the specified asset.
  */
  class func exportPresetsCompatibleWith(asset: AVAsset) -> [String]

  /*!
  	@method						determineCompatibilityOfExportPreset:withAsset:outputFileType:completionHandler:
  	@abstract					Performs an inspection on the compatibility of an export preset, AVAsset and output file type.  Calls the completion handler with YES if
  								the arguments are compatible; NO otherwise.
  	@discussion					Not all export presets are compatible with all AVAssets and file types.  This method can be used to query compatibility.
  								In order to ensure that the setup and running of an export operation will succeed using a given preset no significant changes 
  								(such as adding or deleting tracks) should be made to the asset between retrieving compatible identifiers and performing the export operation.
  	@param presetName			An NSString specifying the name of the preset template for the export.
  	@param asset				An AVAsset object that is intended to be exported.
  	@param outputFileType		An NSString indicating a file type to check; or nil, to query whether there are any compatible types.
  	@param completionHandler	A block called with the compatibility result.
   */
  @available(iOS 6.0, *)
  class func determineCompatibilityOfExportPreset(presetName: String, withAsset asset: AVAsset, outputFileType: String?, completionHandler handler: (Bool) -> Void)
}
extension AVAssetExportSession {
  var supportedFileTypes: [String] { get }

  /*!
  	@method						determineCompatibleFileTypesWithCompletionHandler:
  	@abstract					Performs an inspection on the AVAsset and Preset the object was initialized with to determine a list of file types the ExportSession can write.
  	@param						handler
  								Called when the inspection completes with an array of file types the ExportSession can write.  Note that this may have a count of zero.
  	@discussion					This method is different than the supportedFileTypes property in that it performs an inspection of the AVAsset in order to determine its compatibility with each of the session's supported file types.
  */
  @available(iOS 6.0, *)
  func determineCompatibleFileTypesWithCompletionHandler(handler: ([String]) -> Void)
}
extension AVAssetExportSession {
  var timeRange: CMTimeRange
  @available(iOS 4.0, *)
  var maxDuration: CMTime { get }
  @available(iOS 5.0, *)
  var estimatedOutputFileLength: Int64 { get }
  @available(iOS 4.0, *)
  var fileLengthLimit: Int64
}
extension AVAssetExportSession {
  var metadata: [AVMetadataItem]?
  @available(iOS 7.0, *)
  var metadataItemFilter: AVMetadataItemFilter?
}
extension AVAssetExportSession {
  @available(iOS 7.0, *)
  var audioTimePitchAlgorithm: String
  @NSCopying var audioMix: AVAudioMix?
  @NSCopying var videoComposition: AVVideoComposition?
  @available(iOS 7.0, *)
  var customVideoCompositor: AVVideoCompositing? { get }
}
extension AVAssetExportSession {

  /*!
  	@property	canPerformMultiplePassesOverSourceMediaData
  	@abstract
  		Determines whether the export session can perform multiple passes over the source media to achieve better results.
   
  	@discussion
  		When the value for this property is YES, the export session can produce higher quality results at the expense of longer export times.  Setting this property to YES may also require the export session to write temporary data to disk during the export.  To control the location of temporary data, use the property directoryForTemporaryFiles.
   
  		The default value is NO.  Not all export session configurations can benefit from performing multiple passes over the source media.  In these cases, setting this property to YES has no effect.
  
  		This property cannot be set after the export has started.
  */
  @available(iOS 8.0, *)
  var canPerformMultiplePassesOverSourceMediaData: Bool

  /*!
  	@property directoryForTemporaryFiles
  	@abstract 
  		Specifies a directory that is suitable for containing temporary files generated during the export process
   
  	@discussion
  		AVAssetExportSession may need to write temporary files when configured in certain ways, such as when canPerformMultiplePassesOverSourceMediaData is set to YES.  This property can be used to control where in the filesystem those temporary files are created.  All temporary files will be deleted when the export is completed, is canceled, or fails.
   
  		When the value of this property is nil, the export session will choose a suitable location when writing temporary files.  The default value is nil.
  	
  		This property cannot be set after the export has started.  The export will fail if the URL points to a location that is not a directory, does not exist, is not on the local file system, or if a file cannot be created in this directory (for example, due to insufficient permissions or sandboxing restrictions).
  */
  @available(iOS 8.0, *)
  @NSCopying var directoryForTemporaryFiles: URL?
}

/*!
	@constant		AVAssetImageGeneratorApertureModeCleanAperture
	@abstract		Both pixel aspect ratio and clean aperture will be applied.
*/
@available(iOS 4.0, *)
let AVAssetImageGeneratorApertureModeCleanAperture: String

/*!
	@constant		AVAssetImageGeneratorApertureModeProductionAperture
	@abstract		Only pixel aspect ratio will be applied.
*/
@available(iOS 4.0, *)
let AVAssetImageGeneratorApertureModeProductionAperture: String

/*!
	@constant		AVAssetImageGeneratorApertureModeEncodedPixels
	@abstract		Neither pixel aspect ratio nor clean aperture will be applied.
*/
@available(iOS 4.0, *)
let AVAssetImageGeneratorApertureModeEncodedPixels: String
enum AVAssetImageGeneratorResult : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Succeeded
  case Failed
  case Cancelled
}
@available(iOS 4.0, *)
class AVAssetImageGenerator : Object {
  @available(iOS 6.0, *)
  var asset: AVAsset { get }
  var appliesPreferredTrackTransform: Bool
  var maximumSize: CGSize
  var apertureMode: String?
  @NSCopying var videoComposition: AVVideoComposition?
  @available(iOS 7.0, *)
  var customVideoCompositor: AVVideoCompositing? { get }
  @available(iOS 5.0, *)
  var requestedTimeToleranceBefore: CMTime
  @available(iOS 5.0, *)
  var requestedTimeToleranceAfter: CMTime

  /*!
  	@method			initWithAsset:
  	@abstract		Initializes an instance of AVAssetImageGenerator for use with the specified asset.
  	@param			asset
  					The asset from which images will be extracted.
  	@result			An instance of AVAssetImageGenerator
  	@discussion		This method may succeed even if the asset possesses no visual tracks at the time of initialization.
  					Clients may wish to test whether an asset has any tracks with the visual characteristic via
  					-[AVAsset tracksWithMediaCharacteristic:].
  					
  					Note also that assets that belong to a mutable subclass of AVAsset, AVMutableComposition or AVMutableMovie,
  					may gain visual tracks after initialization of an associated AVAssetImageGenerator.
  					
  					However, the results of image generation are undefined if mutations of the asset occur while images
  					are being generated. 
  
  					AVAssetImageGenerator will use the default enabled video track(s) to generate images.
  */
  init(asset: AVAsset)

  /*!
  	@method			copyCGImageAtTime:actualTime:error:
  	@abstract		Returns a CFRetained CGImageRef for an asset at or near the specified time.
  	@param			requestedTime
  					The time at which the image of the asset is to be created.
  	@param			actualTime
  					A pointer to a CMTime to receive the time at which the image was actually generated. If you are not interested
  					in this information, pass NULL.
  	@param			outError
  					An error object describing the reason for failure, in the event that this method returns NULL.
  	@result			A CGImageRef.
  	@discussion		Returns the CGImage synchronously. Ownership follows the Create Rule.
  */
  func copyCGImageAt(requestedTime: CMTime, actualTime: UnsafeMutablePointer<CMTime>) throws -> CGImage

  /*!
  	@method			generateCGImagesAsynchronouslyForTimes:completionHandler:
  	@abstract		Returns a series of CGImageRefs for an asset at or near the specified times.
  	@param			requestedTimes
  					An NSArray of NSValues, each containing a CMTime, specifying the asset times at which an image is requested.
  	@param			handler
  					A block that will be called when an image request is complete.
  	@discussion		Employs an efficient "batch mode" for getting images in time order.
  					The client will receive exactly one handler callback for each requested time in requestedTimes.
  					Changes to generator properties (snap behavior, maximum size, etc...) will not affect outstanding asynchronous image generation requests.
  					The generated image is not retained.  Clients should retain the image if they wish it to persist after the completion handler returns.
  */
  func generateCGImagesAsynchronouslyForTimes(requestedTimes: [Value], completionHandler handler: AVAssetImageGeneratorCompletionHandler)

  /*!
  	@method			cancelAllCGImageGeneration
  	@abstract		Cancels all outstanding image generation requests.
  	@discussion		Calls the handler block with AVAssetImageGeneratorCancelled for each image time in every previous invocation of -generateCGImagesAsynchronouslyForTimes:completionHandler:
  					for which images have not yet been supplied.
  */
  func cancelAllCGImageGeneration()
}
typealias AVAssetImageGeneratorCompletionHandler = (CMTime, CGImage?, CMTime, AVAssetImageGeneratorResult, Error?) -> Void

/*!
 @enum AVAssetReaderStatus
 @abstract
	These constants are returned by the AVAssetReader status property to indicate whether it can successfully read samples from its asset.

 @constant	 AVAssetReaderStatusUnknown
	Indicates that the status of the asset reader is not currently known.
 @constant	 AVAssetReaderStatusReading
	Indicates that the asset reader is successfully reading samples from its asset.
 @constant	 AVAssetReaderStatusCompleted
	Indicates that the asset reader has successfully read all of the samples in its time range.
 @constant	 AVAssetReaderStatusFailed
	Indicates that the asset reader can no longer read samples from its asset because of an error. The error is described by the value of the asset reader's error property.
 @constant	 AVAssetReaderStatusCancelled
	Indicates that the asset reader can no longer read samples because reading was canceled with the cancelReading method.
 */
enum AVAssetReaderStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case Reading
  case Completed
  case Failed
  case Cancelled
}

/*!
 @class AVAssetReader
 @abstract
	AVAssetReader provides services for obtaining media data from an asset.
 
 @discussion
	Instances of AVAssetReader read media data from an instance of AVAsset, whether the asset is file-based or represents an assembly of media data from multiple sources, as is the case with AVComposition.
	
	Clients of AVAssetReader can read data from specific tracks of an asset and in specific formats by adding concrete instances of AVAssetReaderOutput to an AVAssetReader instance.
	
	AVAssetReaderTrackOutput, a concrete subclass of AVAssetReaderOutput, can either read the track's media samples in the format in which they are stored by the asset or convert the media samples to a different format.
	
	AVAssetReaderAudioMixOutput mixes multiple audio tracks of the asset after reading them, while AVAssetReaderVideoCompositionOutput composites multiple video tracks after reading them.
 */
@available(iOS 4.1, *)
class AVAssetReader : Object {

  /*!
   @method initWithAsset:error:
   @abstract
  	Creates an instance of AVAssetReader for reading media data from the specified asset.
  
   @param asset
  	The asset from which media data is to be read.
   @param outError
  	On return, if initialization of the AVAssetReader fails, points to an NSError describing the nature of the failure.
   @result
  	An instance of AVAssetReader.
   @discussion
  	If the specified asset belongs to a mutable subclass of AVAsset, AVMutableComposition or AVMutableMovie, the results of any asset reading operation are undefined if you mutate the asset after invoking -startReading.
   */
  init(asset: AVAsset) throws

  /*!
   @property asset
   @abstract
  	The asset from which the receiver's outputs read sample buffers.
  
   @discussion
  	The value of this property is an AVAsset. Concrete instances of AVAssetReader that are created with specific AVAssetTrack instances must obtain those tracks from the asset returned by this property.
   */
  var asset: AVAsset { get }

  /*!
   @property status
   @abstract
  	The status of reading sample buffers from the receiver's asset.
  
   @discussion
  	The value of this property is an AVAssetReaderStatus that indicates whether reading is in progress, has completed successfully, has been canceled, or has failed. Clients of AVAssetReaderOutput objects should check the value of this property after -[AVAssetReaderOutput copyNextSampleBuffer] returns NULL to determine why no more samples could be read. This property is thread safe.
   */
  var status: AVAssetReaderStatus { get }

  /*!
   @property error
   @abstract
  	If the receiver's status is AVAssetReaderStatusFailed, this describes the error that caused the failure.
  
   @discussion
  	The value of this property is an NSError that describes what caused the receiver to no longer be able to read its asset. If the receiver's status is not AVAssetReaderStatusFailed, the value of this property is nil. This property is thread safe.
   */
  var error: Error? { get }

  /*!
   @property timeRange
   @abstract
  	Specifies a range of time that may limit the temporal portion of the receiver's asset from which media data will be read.
  
   @discussion
  	The intersection of the value of timeRange and CMTimeRangeMake(kCMTimeZero, asset.duration) will determine the time range of the asset from which media data will be read. The default value of timeRange is CMTimeRangeMake(kCMTimeZero, kCMTimePositiveInfinity).
  	
  	This property cannot be set after reading has started.
   */
  var timeRange: CMTimeRange

  /*!
   @property outputs
   @abstract
  	The outputs from which clients of receiver can read media data.
  
   @discussion
  	The value of this property is an NSArray containing concrete instances of AVAssetReaderOutput. Outputs can be added to the receiver using the addOutput: method.
   */
  var outputs: [AVAssetReaderOutput] { get }

  /*!
   @method canAddOutput:
   @abstract
  	Tests whether an output can be added to the receiver.
  
   @param output
  	The AVAssetReaderOutput object to be tested.
   @result
  	A BOOL indicating whether the output can be added to the receiver.
  
   @discussion
  	An output that reads from a track of an asset other than the asset used to initialize the receiver cannot be added.
   */
  func canAddOutput(output: AVAssetReaderOutput) -> Bool

  /*!
   @method addOutput:
   @abstract
  	Adds an output to the receiver.
  
   @param output
  	The AVAssetReaderOutput object to be added.
  
   @discussion
  	Outputs are created with a reference to one or more AVAssetTrack objects. These tracks must be owned by the asset returned by the receiver's asset property.
  	
  	Outputs cannot be added after reading has started.
   */
  func addOutput(output: AVAssetReaderOutput)

  /*!
   @method startReading
   @abstract
  	Prepares the receiver for reading sample buffers from the asset.
  
   @result
  	A BOOL indicating whether reading could be started.
   
   @discussion
  	This method validates the entire collection of settings for outputs for tracks, for audio mixing, and for video composition and initiates reading from the receiver's asset.
  	
  	If this method returns NO, clients can determine the nature of the failure by checking the value of the status and error properties.
   */
  func startReading() -> Bool

  /*!
   @method cancelReading
   @abstract
  	Cancels any background work and prevents the receiver's outputs from reading more samples.
  
   @discussion
  	Clients that want to stop reading samples from the receiver before reaching the end of its time range should call this method to stop any background read ahead operations that the may have been in progress.
   
  	This method should not be called concurrently with any calls to -[AVAssetReaderOutput copyNextSampleBuffer].
   */
  func cancelReading()
}

/*!
 @class AVAssetReaderOutput
 @abstract
	AVAssetReaderOutput is an abstract class that defines an interface for reading a single collection of samples of a common media type from an AVAssetReader.
 
 @discussion
	Clients can read the media data of an asset by adding one or more concrete instances of AVAssetReaderOutput to an AVAssetReader using the -[AVAssetReader addOutput:] method.
 */
@available(iOS 4.1, *)
class AVAssetReaderOutput : Object {

  /*!
   @property mediaType
   @abstract
  	The media type of the samples that can be read from the receiver.
  
   @discussion
  	The value of this property is one of the media type strings defined in AVMediaFormat.h.
   */
  var mediaType: String { get }

  /*!
   @property alwaysCopiesSampleData
   @abstract
  	Indicates whether or not the data in buffers gets copied before being vended to the client.
   
   @discussion
  	When the value of this property is YES, the AVAssetReaderOutput will always vend a buffer with copied data to the client.  Data in such buffers can be freely modified by the client. When the value of this property is NO, the buffers vended to the client may not be copied.  Such buffers may still be referenced by other entities. The result of modifying a buffer whose data hasn't been copied is undefined.  Requesting buffers whose data hasn't been copied when possible can lead to performance improvements.
   
  	The default value is YES.
   */
  @available(iOS 5.0, *)
  var alwaysCopiesSampleData: Bool

  /*!
   @method copyNextSampleBuffer
   @abstract
  	Copies the next sample buffer for the output synchronously.
  
   @result
  	A CMSampleBuffer object referencing the output sample buffer.
  
   @discussion
  	The client is responsible for calling CFRelease on the returned CMSampleBuffer object when finished with it. This method will return NULL if there are no more sample buffers available for the receiver within the time range specified by its AVAssetReader's timeRange property, or if there is an error that prevents the AVAssetReader from reading more media data. When this method returns NULL, clients should check the value of the associated AVAssetReader's status property to determine why no more samples could be read.
   */
  func copyNextSampleBuffer() -> CMSampleBuffer?
  init()
}
extension AVAssetReaderOutput {

  /*!
   @property supportsRandomAccess
   @abstract
  	Indicates whether the asset reader output supports reconfiguration of the time ranges to read.
   
   @discussion
  	When the value of this property is YES, the time ranges read by the asset reader output can be reconfigured during reading using the -resetForReadingTimeRanges: method.  This also prevents the attached AVAssetReader from progressing to AVAssetReaderStatusCompleted until -markConfigurationAsFinal has been invoked.
   
  	The default value is NO, which means that the asset reader output may not be reconfigured once reading has begin.  When the value of this property is NO, AVAssetReader may be able to read media data more efficiently, particularly when multiple asset reader outputs are attached.
   
  	This property may not be set after -startReading has been called on the attached asset reader.
   */
  @available(iOS 8.0, *)
  var supportsRandomAccess: Bool

  /*!
   @method resetForReadingTimeRanges:
   @abstract
  	Starts reading over with a new set of time ranges.
   
   @param timeRanges
  	An NSArray of NSValue objects, each representing a single CMTimeRange structure
   
   @discussion
  	This method may only be used if supportsRandomAccess has been set to YES and may not be called after -markConfigurationAsFinal has been invoked.
   
  	This method is often used in conjunction with AVAssetWriter multi-pass (see AVAssetWriterInput category AVAssetWriterInputMultiPass).  In this usage, the caller will invoke -copyNextSampleBuffer until that method returns NULL and then ask the AVAssetWriterInput for a set of time ranges from which it thinks media data should be re-encoded.  These time ranges are then given to this method to set up the asset reader output for the next pass.
   
  	The time ranges set here override the time range set on AVAssetReader.timeRange.  Just as with that property, for each time range in the array the intersection of that time range and CMTimeRangeMake(kCMTimeZero, asset.duration) will take effect.  If the start times of each time range in the array are not strictly increasing or if two or more time ranges in the array overlap, an NSInvalidArgumentException will be raised.  It is an error to include a time range with a non-numeric start time or duration (see CMTIME_IS_NUMERIC), unless the duration is kCMTimePositiveInfinity.
   
  	If this method is invoked after the status of the attached AVAssetReader has become AVAssetReaderStatusFailed or AVAssetReaderStatusCancelled, no change in status will occur and the result of the next call to -copyNextSampleBuffer will be NULL.
   
  	If this method is invoked before all media data has been read (i.e. -copyNextSampleBuffer has not yet returned NULL), an exception will be thrown.  This method may not be called before -startReading has been invoked on the attached asset reader.
   */
  @available(iOS 8.0, *)
  func resetForReadingTimeRanges(timeRanges: [Value])

  /*!
   @method markConfigurationAsFinal
   @abstract
  	Informs the receiver that no more reconfiguration of time ranges is necessary and allows the attached AVAssetReader to advance to AVAssetReaderStatusCompleted.
   
   @discussion
  	When the value of supportsRandomAccess is YES, the attached asset reader will not advance to AVAssetReaderStatusCompleted until this method is called.
   
  	When the destination of media data vended by the receiver is an AVAssetWriterInput configured for multi-pass encoding, a convenient time to invoke this method is after the asset writer input indicates that no more passes will be performed.
   
  	Once this method has been called, further invocations of -resetForReadingTimeRanges: are disallowed.
   */
  @available(iOS 8.0, *)
  func markConfigurationAsFinal()
}

/*!
 @class AVAssetReaderTrackOutput
 @abstract
	AVAssetReaderTrackOutput is a concrete subclass of AVAssetReaderOutput that defines an interface for reading media data from a single AVAssetTrack of an AVAssetReader's AVAsset.
 
 @discussion
	Clients can read the media data of an asset track by adding an instance of AVAssetReaderTrackOutput to an AVAssetReader using the -[AVAssetReader addOutput:] method. The track's media samples can either be read in the format in which they are stored in the asset, or they can be converted to a different format.
 */
@available(iOS 4.1, *)
class AVAssetReaderTrackOutput : AVAssetReaderOutput {

  /*!
   @method initWithTrack:outputSettings:
   @abstract
  	Returns an instance of AVAssetReaderTrackOutput for reading from the specified track and supplying media data according to the specified output settings.
  
   @param track
  	The AVAssetTrack from which the resulting AVAssetReaderTrackOutput should read sample buffers.
   @param outputSettings
  	An NSDictionary of output settings to be used for sample output.  See AVAudioSettings.h for available output settings for audio tracks or AVVideoSettings.h for available output settings for video tracks and also for more information about how to construct an output settings dictionary.
   @result
  	An instance of AVAssetReaderTrackOutput.
  
   @discussion
  	The track must be one of the tracks contained by the target AVAssetReader's asset.
  	
  	A value of nil for outputSettings configures the output to vend samples in their original format as stored by the specified track.  Initialization will fail if the output settings cannot be used with the specified track.
  	
  	AVAssetReaderTrackOutput can only produce uncompressed output.  For audio output settings, this means that AVFormatIDKey must be kAudioFormatLinearPCM.  For video output settings, this means that the dictionary must follow the rules for uncompressed video output, as laid out in AVVideoSettings.h.  AVAssetReaderTrackOutput does not support the AVAudioSettings.h key AVSampleRateConverterAudioQualityKey or the following AVVideoSettings.h keys:
   
  		AVVideoCleanApertureKey
  		AVVideoPixelAspectRatioKey
  		AVVideoScalingModeKey
  
  	When constructing video output settings the choice of pixel format will affect the performance and quality of the decompression. For optimal performance when decompressing video the requested pixel format should be one that the decoder supports natively to avoid unnecessary conversions. Below are some recommendations:
  
  	For H.264 use kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange, or kCVPixelFormatType_420YpCbCr8BiPlanarFullRange if the video is known to be full range.  For JPEG on iOS, use kCVPixelFormatType_420YpCbCr8BiPlanarFullRange.
  
  	For other codecs on OSX, kCVPixelFormatType_422YpCbCr8 is the preferred pixel format for video and is generally the most performant when decoding. If you need to work in the RGB domain then kCVPixelFormatType_32BGRA is recommended on iOS and kCVPixelFormatType_32ARGB is recommended on OSX.
   
  	ProRes encoded media can contain up to 12bits/ch. If your source is ProRes encoded and you wish to preserve more than 8bits/ch during decompression then use one of the following pixel formats: kCVPixelFormatType_4444AYpCbCr16, kCVPixelFormatType_422YpCbCr16, kCVPixelFormatType_422YpCbCr10, or kCVPixelFormatType_64ARGB.  AVAssetReader does not support scaling with any of these high bit depth pixel formats. If you use them then do not specify kCVPixelBufferWidthKey or kCVPixelBufferHeightKey in your outputSettings dictionary. If you plan to append these sample buffers to an AVAssetWriterInput then note that only the ProRes encoders support these pixel formats.
  
  	ProRes 4444 encoded media can contain a mathematically lossless alpha channel. To preserve the alpha channel during decompression use a pixel format with an alpha component such as kCVPixelFormatType_4444AYpCbCr16 or kCVPixelFormatType_64ARGB.  To test whether your source contains an alpha channel check that the track's format description has kCMFormatDescriptionExtension_Depth and that its value is 32.
   */
  init(track: AVAssetTrack, outputSettings: [String : AnyObject]?)

  /*!
   @property track
   @abstract
  	The track from which the receiver reads sample buffers.
  
   @discussion
  	The value of this property is an AVAssetTrack owned by the target AVAssetReader's asset.
   */
  var track: AVAssetTrack { get }

  /*!
   @property outputSettings
   @abstract
  	The output settings used by the receiver.
  
   @discussion
  	The value of this property is an NSDictionary that contains values for keys as specified by either AVAudioSettings.h for audio tracks or AVVideoSettings.h for video tracks.  A value of nil indicates that the receiver will vend samples in their original format as stored in the target track.
   */
  var outputSettings: [String : AnyObject]? { get }

  /*!
   @property audioTimePitchAlgorithm
   @abstract
  	Indicates the processing algorithm used to manage audio pitch for scaled audio edits.
   
   @discussion
  	Constants for various time pitch algorithms, e.g. AVAudioTimePitchAlgorithmSpectral, are defined in AVAudioProcessingSettings.h.  An NSInvalidArgumentException will be raised if this property is set to a value other than the constants defined in that file.
   
  	The default value is AVAudioTimePitchAlgorithmSpectral.
   */
  @available(iOS 7.0, *)
  var audioTimePitchAlgorithm: String
}

/*!
 @class AVAssetReaderAudioMixOutput
 @abstract
	AVAssetReaderAudioMixOutput is a concrete subclass of AVAssetReaderOutput that defines an interface for reading audio samples that result from mixing the audio from one or more AVAssetTracks of an AVAssetReader's AVAsset.
 
 @discussion
	Clients can read the audio data mixed from one or more asset tracks by adding an instance of AVAssetReaderAudioMixOutput to an AVAssetReader using the -[AVAssetReader addOutput:] method.
 */
@available(iOS 4.1, *)
class AVAssetReaderAudioMixOutput : AVAssetReaderOutput {

  /*!
   @method initWithAudioTracks:audioSettings:
   @abstract
  	Creates an instance of AVAssetReaderAudioMixOutput for reading mixed audio from the specified audio tracks, with optional audio settings.
  
   @param tracks
  	An NSArray of AVAssetTrack objects from which the created object should read sample buffers to be mixed.
   @param audioSettings
  	An NSDictionary of audio settings to be used for audio output.
   @result
  	An instance of AVAssetReaderAudioMixOutput.
  
   @discussion
  	Each track must be one of the tracks owned by the target AVAssetReader's asset and must be of media type AVMediaTypeAudio.
  	
  	The audio settings dictionary must contain values for keys in AVAudioSettings.h (linear PCM only). A value of nil configures the output to return samples in a convenient uncompressed format, with sample rate and other properties determined according to the properties of the specified audio tracks. Initialization will fail if the audio settings cannot be used with the specified tracks.  AVSampleRateConverterAudioQualityKey is not supported.
   */
  init(audioTracks: [AVAssetTrack], audioSettings: [String : AnyObject]?)

  /*!
   @property audioTracks
   @abstract
  	The tracks from which the receiver reads mixed audio.
  
   @discussion
  	The value of this property is an NSArray of AVAssetTracks owned by the target AVAssetReader's asset.
   */
  var audioTracks: [AVAssetTrack] { get }

  /*!
   @property audioSettings
   @abstract
  	The audio settings used by the receiver.
  
   @discussion
  	The value of this property is an NSDictionary that contains values for keys from AVAudioSettings.h (linear PCM only).  A value of nil indicates that the receiver will return audio samples in a convenient uncompressed format, with sample rate and other properties determined according to the properties of the receiver's audio tracks.
   */
  var audioSettings: [String : AnyObject]? { get }

  /*!
   @property audioMix
   @abstract
  	The audio mix used by the receiver.
  
   @discussion
  	The value of this property is an AVAudioMix that can be used to specify how the volume of audio samples read from each source track will change over the timeline of the source asset.
   
  	This property cannot be set after reading has started.
   */
  @NSCopying var audioMix: AVAudioMix?

  /*!
   @property audioTimePitchAlgorithm
   @abstract
  	Indicates the processing algorithm used to manage audio pitch for scaled audio edits.
   
   @discussion
  	Constants for various time pitch algorithms, e.g. AVAudioTimePitchAlgorithmSpectral, are defined in AVAudioProcessingSettings.h.  An NSInvalidArgumentException will be raised if this property is set to a value other than the constants defined in that file.
   
  	The default value is AVAudioTimePitchAlgorithmSpectral.
   */
  @available(iOS 7.0, *)
  var audioTimePitchAlgorithm: String
}

/*!
 @class AVAssetReaderVideoCompositionOutput
 @abstract
	AVAssetReaderVideoCompositionOutput is a concrete subclass of AVAssetReaderOutput that defines an interface for reading video frames that have been composited together from the frames in one or more AVAssetTracks of an AVAssetReader's AVAsset.
 
 @discussion
	Clients can read the video frames composited from one or more asset tracks by adding an instance of AVAssetReaderVideoCompositionOutput to an AVAssetReader using the -[AVAssetReader addOutput:] method.
 */
@available(iOS 4.1, *)
class AVAssetReaderVideoCompositionOutput : AVAssetReaderOutput {

  /*!
   @method initWithVideoTracks:videoSettings:
   @abstract
  	Creates an instance of AVAssetReaderVideoCompositionOutput for reading composited video from the specified video tracks and supplying media data according to the specified video settings.
  
   @param tracks
  	An NSArray of AVAssetTrack objects from which the resulting AVAssetReaderVideoCompositionOutput should read video frames for compositing.
   @param videoSettings
  	An NSDictionary of video settings to be used for video output.  See AVVideoSettings.h for more information about how to construct a video settings dictionary.
   @result An instance of AVAssetReaderVideoCompositionOutput.
  
   @discussion
  	Each track must be one of the tracks owned by the target AVAssetReader's asset and must be of media type AVMediaTypeVideo.
   	
  	A value of nil for videoSettings configures the output to return samples in a convenient uncompressed format, with properties determined according to the properties of the specified video tracks.  Initialization will fail if the video settings cannot be used with the specified tracks.
  	
  	AVAssetReaderVideoCompositionOutput can only produce uncompressed output.  This means that the video settings dictionary must follow the rules for uncompressed video output, as laid out in AVVideoSettings.h.  In addition, the following keys are not supported:
   
  		AVVideoCleanApertureKey
  		AVVideoPixelAspectRatioKey
  		AVVideoScalingModeKey
   */
  init(videoTracks: [AVAssetTrack], videoSettings: [String : AnyObject]?)

  /*!
   @property videoTracks
   @abstract
  	The tracks from which the receiver reads composited video.
  
   @discussion
  	The value of this property is an NSArray of AVAssetTracks owned by the target AVAssetReader's asset.
   */
  var videoTracks: [AVAssetTrack] { get }

  /*!
   @property videoSettings
   @abstract
  	The video settings used by the receiver.
  
   @discussion
  	The value of this property is an NSDictionary that contains values for keys as specified by AVVideoSettings.h.  A value of nil indicates that the receiver will return video frames in a convenient uncompressed format, with properties determined according to the properties of the receiver's video tracks.
   */
  var videoSettings: [String : AnyObject]? { get }

  /*!
   @property videoComposition
   @abstract
  	The composition of video used by the receiver.
  
   @discussion
  	The value of this property is an AVVideoComposition that can be used to specify the visual arrangement of video frames read from each source track over the timeline of the source asset.
   
  	This property cannot be set after reading has started.
   */
  @NSCopying var videoComposition: AVVideoComposition?

  /*!
   @property customVideoCompositor
   @abstract
   	Indicates the custom video compositor instance used by the receiver.
  
   @discussion
   	This property is nil if there is no video compositor, or if the internal video compositor is in use.
   */
  @available(iOS 7.0, *)
  var customVideoCompositor: AVVideoCompositing? { get }
}

/*!
 @class AVAssetReaderOutputMetadataAdaptor
 @abstract
	Defines an interface for reading metadata, packaged as instances of AVTimedMetadataGroup, from a single AVAssetReaderTrackOutput object.
 */
@available(iOS 8.0, *)
class AVAssetReaderOutputMetadataAdaptor : Object {

  /*!
   @method initWithAssetReaderTrackOutput:
   @abstract
  	Creates a new timed metadata group adaptor for retrieving timed metadata group objects from an asset reader output.
  
   @param	assetReaderOutput
  	An instance of AVAssetReaderTrackOutput that vends sample buffers containing metadata, e.g. an AVAssetReaderTrackOutput object initialized with a track of media type AVMediaTypeMetadata and nil outputSettings.
   @result
  	An instance of AVAssetReaderOutputMetadataAdaptor
  
   @discussion
  	It is an error to create a timed metadata group adaptor with an asset reader output that does not vend metadata.  It is also an error to create a timed metadata group adaptor with an asset reader output whose asset reader has already started reading, or an asset reader output that already has been used to initialize another timed metadata group adaptor.
  	
  	Clients should not mix calls to -[AVAssetReaderTrackOutput copyNextSampleBuffer] and -[AVAssetReaderOutputMetadataAdaptor nextTimedMetadataGroup].  Once an AVAssetReaderTrackOutput instance has been used to initialize an AVAssetReaderOutputMetadataAdaptor, calling -copyNextSampleBuffer on that instance will result in an exception being thrown.
   */
  init(assetReaderTrackOutput trackOutput: AVAssetReaderTrackOutput)

  /*!
   @property assetReaderTrackOutput
   @abstract
  	The asset reader track output from which the receiver pulls timed metadata groups.
   */
  var assetReaderTrackOutput: AVAssetReaderTrackOutput { get }

  /*!
   @method nextTimedMetadataGroup
   @abstract
  	Returns the next timed metadata group for the asset reader output, synchronously.
  	
   @result
  	An instance of AVTimedMetadataGroup, representing the next logical segment of metadata coming from the source asset reader output.
  	
   @discussion
  	This method will return nil when all timed metadata groups have been read from the asset reader output, or if there is an error that prevents the timed metadata group adaptor from reading more timed metadata groups.  When this method returns nil, clients should check the value of the associated AVAssetReader's status property to determine why no more samples could be read.
  	
  	Unlike -[AVAssetReaderTrackOutput copyNextSampleBuffer], this method returns an autoreleased object.
   
  	Before calling this method, you must ensure that the output which underlies the receiver is attached to an AVAssetReader via a prior call to -addOutput: and that -startReading has been called on the asset reader.
   */
  func nextTimedMetadataGroup() -> AVTimedMetadataGroup?
}

/*!
 @class AVAssetReaderSampleReferenceOutput
 @abstract
	AVAssetReaderSampleReferenceOutput is a concrete subclass of AVAssetReaderOutput that defines an interface for reading sample references from a single AVAssetTrack of an AVAssetReader's AVAsset.
 @discussion
	Clients can extract information about the location (file URL and offset) of samples in a track by adding an instance of AVAssetReaderSampleReferenceOutput to an AVAssetReader using the -[AVAssetReader addOutput:] method. No actual sample data can be extracted using this class. The location of the sample data is described by the kCMSampleBufferAttachmentKey_SampleReferenceURL and kCMSampleBufferAttachmentKey_SampleReferenceByteOffset attachments on the extracted sample buffers. More information about sample buffers describing sample references can be found in the CMSampleBuffer documentation.
 
	Sample buffers extracted using this class can also be appended to an AVAssetWriterInput to create movie tracks that are not self-contained and reference data in the original file instead.  Currently, only instances of AVAssetWriter configured to write files of type AVFileTypeQuickTimeMovie can be used to write tracks that are not self-contained.
 
	Since no sample data is ever returned by instances of AVAssetReaderSampleReferenceOutput, the value of the alwaysCopiesSampleData property is ignored.
 */
@available(iOS 8.0, *)
class AVAssetReaderSampleReferenceOutput : AVAssetReaderOutput {

  /*!
   @method initWithTrack:
   @abstract
  	Returns an instance of AVAssetReaderSampleReferenceOutput for supplying sample references.
   
   @param track
  	The AVAssetTrack for which the resulting AVAssetReaderSampleReferenceOutput should provide sample references.
   @result
  	An instance of AVAssetReaderTrackOutput.
   
   @discussion
  	The track must be one of the tracks contained by the target AVAssetReader's asset.
    */
  init(track: AVAssetTrack)

  /*!
   @property track
   @abstract
  	The track from which the receiver extracts sample references.
   
   @discussion
  	The value of this property is an AVAssetTrack owned by the target AVAssetReader's asset.
   */
  var track: AVAssetTrack { get }
}
@available(iOS 6.0, *)
class AVAssetResourceLoader : Object {

  /*!
   @method 		setDelegate:queue:
   @abstract		Sets the receiver's delegate that will mediate resource loading and the dispatch queue on which delegate methods will be invoked.
   @param			delegate
  				An object conforming to the AVAssetResourceLoaderDelegate protocol.
   @param			delegateQueue
  				A dispatch queue on which all delegate methods will be invoked.
  */
  func setDelegate(delegate: AVAssetResourceLoaderDelegate?, queue delegateQueue: dispatch_queue_t?)

  /*!
   @property 		delegate
   @abstract		The receiver's delegate.
   @discussion
    The value of this property is an object conforming to the AVAssetResourceLoaderDelegate protocol. The delegate is set using the setDelegate:queue: method. The delegate is held using a zeroing-weak reference, so this property will have a value of nil after a delegate that was previously set has been deallocated.
  */
  weak var delegate: @sil_weak AVAssetResourceLoaderDelegate? { get }

  /*!
   @property 		delegateQueue
   @abstract		The dispatch queue on which all delegate methods will be invoked.
   @discussion
    The value of this property is a dispatch_queue_t. The queue is set using the setDelegate:queue: method.
  */
  var delegateQueue: dispatch_queue_t? { get }
}
protocol AVAssetResourceLoaderDelegate : ObjectProtocol {

  /*!
   @method 		resourceLoader:shouldWaitForLoadingOfRequestedResource:
   @abstract		Invoked when assistance is required of the application to load a resource.
   @param 		resourceLoader
  				The instance of AVAssetResourceLoader for which the loading request is being made.
   @param 		loadingRequest
  				An instance of AVAssetResourceLoadingRequest that provides information about the requested resource. 
   @result 		YES if the delegate can load the resource indicated by the AVAssetResourceLoadingRequest; otherwise NO.
   @discussion
    Delegates receive this message when assistance is required of the application to load a resource. For example, this method is invoked to load decryption keys that have been specified using custom URL schemes.
    If the result is YES, the resource loader expects invocation, either subsequently or immediately, of either -[AVAssetResourceLoadingRequest finishLoading] or -[AVAssetResourceLoadingRequest finishLoadingWithError:]. If you intend to finish loading the resource after your handling of this message returns, you must retain the instance of AVAssetResourceLoadingRequest until after loading is finished.
    If the result is NO, the resource loader treats the loading of the resource as having failed.
    Note that if the delegate's implementation of -resourceLoader:shouldWaitForLoadingOfRequestedResource: returns YES without finishing the loading request immediately, it may be invoked again with another loading request before the prior request is finished; therefore in such cases the delegate should be prepared to manage multiple loading requests.
  
  */
  @available(iOS 6.0, *)
  optional func resourceLoader(resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool

  /*!
   @method 		resourceLoader:shouldWaitForRenewalOfRequestedResource:
   @abstract		Invoked when assistance is required of the application to renew a resource.
   @param 		resourceLoader
   The instance of AVAssetResourceLoader for which the loading request is being made.
   @param 		renewalRequest
   An instance of AVAssetResourceRenewalRequest that provides information about the requested resource.
   @result 		YES if the delegate can renew the resource indicated by the AVAssetResourceLoadingRequest; otherwise NO.
   @discussion
   Delegates receive this message when assistance is required of the application to renew a resource previously loaded by resourceLoader:shouldWaitForLoadingOfRequestedResource:. For example, this method is invoked to renew decryption keys that require renewal, as indicated in a response to a prior invocation of resourceLoader:shouldWaitForLoadingOfRequestedResource:.
   If the result is YES, the resource loader expects invocation, either subsequently or immediately, of either -[AVAssetResourceRenewalRequest finishLoading] or -[AVAssetResourceRenewalRequest finishLoadingWithError:]. If you intend to finish loading the resource after your handling of this message returns, you must retain the instance of AVAssetResourceRenewalRequest until after loading is finished.
   If the result is NO, the resource loader treats the loading of the resource as having failed.
   Note that if the delegate's implementation of -resourceLoader:shouldWaitForRenewalOfRequestedResource: returns YES without finishing the loading request immediately, it may be invoked again with another loading request before the prior request is finished; therefore in such cases the delegate should be prepared to manage multiple loading requests.
  */
  @available(iOS 8.0, *)
  optional func resourceLoader(resourceLoader: AVAssetResourceLoader, shouldWaitForRenewalOfRequestedResource renewalRequest: AVAssetResourceRenewalRequest) -> Bool

  /*!
   @method 		resourceLoader:didCancelLoadingRequest:
   @abstract		Informs the delegate that a prior loading request has been cancelled.
   @param 		loadingRequest
  				The loading request that has been cancelled. 
   @discussion	Previously issued loading requests can be cancelled when data from the resource is no longer required or when a loading request is superseded by new requests for data from the same resource. For example, if to complete a seek operation it becomes necessary to load a range of bytes that's different from a range previously requested, the prior request may be cancelled while the delegate is still handling it.
  */
  @available(iOS 7.0, *)
  optional func resourceLoader(resourceLoader: AVAssetResourceLoader, didCancel loadingRequest: AVAssetResourceLoadingRequest)

  /*!
   @method 		resourceLoader:shouldWaitForResponseToAuthenticationChallenge:
   @abstract		Invoked when assistance is required of the application to respond to an authentication challenge.
   @param 		resourceLoader
  				The instance of AVAssetResourceLoader asking for help with an authentication challenge.
   @param 		authenticationChallenge
  				An instance of NSURLAuthenticationChallenge. 
   @discussion
    Delegates receive this message when assistance is required of the application to respond to an authentication challenge.
    If the result is YES, the resource loader expects you to send an appropriate response, either subsequently or immediately, to the NSURLAuthenticationChallenge's sender, i.e. [authenticationChallenge sender], via use of one of the messages defined in the NSURLAuthenticationChallengeSender protocol (see NSAuthenticationChallenge.h). If you intend to respond to the authentication challenge after your handling of -resourceLoader:shouldWaitForResponseToAuthenticationChallenge: returns, you must retain the instance of NSURLAuthenticationChallenge until after your response has been made.
  */
  @available(iOS 8.0, *)
  optional func resourceLoader(resourceLoader: AVAssetResourceLoader, shouldWaitForResponseTo authenticationChallenge: URLAuthenticationChallenge) -> Bool

  /*!
   @method 		resourceLoader:didCancelAuthenticationChallenge:
   @abstract		Informs the delegate that a prior authentication challenge has been cancelled.
   @param 		authenticationChallenge
  				The authentication challenge that has been cancelled. 
  */
  @available(iOS 8.0, *)
  optional func resourceLoader(resourceLoader: AVAssetResourceLoader, didCancel authenticationChallenge: URLAuthenticationChallenge)
}
@available(iOS 6.0, *)
class AVAssetResourceLoadingRequest : Object {

  /*! 
   @property 		request
   @abstract		An NSURLRequest for the requested resource.
  */
  var request: URLRequest { get }

  /*! 
   @property 		finished
   @abstract		Indicates whether loading of the resource has been finished.
   @discussion	The value of this property becomes YES only in response to an invocation of either -finishLoading or -finishLoadingWithError:.
  */
  var isFinished: Bool { get }

  /*! 
   @property 		cancelled
   @abstract		Indicates whether the request has been cancelled.
   @discussion	The value of this property becomes YES when the resource loader cancels the loading of a request, just prior to sending the message -resourceLoader:didCancelLoadingRequest: to its delegate.
  */
  @available(iOS 7.0, *)
  var isCancelled: Bool { get }

  /*! 
   @property 		contentInformationRequest
   @abstract		An instance of AVAssetResourceLoadingContentInformationRequest that you should populate with information about the resource. The value of this property will be nil if no such information is being requested.
  */
  @available(iOS 7.0, *)
  var contentInformationRequest: AVAssetResourceLoadingContentInformationRequest? { get }

  /*! 
   @property 		dataRequest
   @abstract		An instance of AVAssetResourceLoadingDataRequest that indicates the range of resource data that's being requested. The value of this property will be nil if no data is being requested.
  */
  @available(iOS 7.0, *)
  var dataRequest: AVAssetResourceLoadingDataRequest? { get }

  /*! 
   @property 		response
   @abstract		Set the value of this property to an instance of NSURLResponse indicating a response to the loading request. If no response is needed, leave the value of this property set to nil.
  */
  @available(iOS 7.0, *)
  @NSCopying var response: URLResponse?

  /*! 
   @property 		redirect
   @abstract		Set the value of this property to an instance of NSURLRequest indicating a redirection of the loading request to another URL. If no redirection is needed, leave the value of this property set to nil.
   @discussion	AVAssetResourceLoader supports redirects to HTTP URLs only. Redirects to other URLs will result in a loading failure.
  */
  @available(iOS 7.0, *)
  @NSCopying var redirect: URLRequest?

  /*! 
   @method 		finishLoading   
   @abstract		Causes the receiver to treat the processing of the request as complete.
   @discussion	If a dataRequest is present and the resource does not contain the full extent of the data that has been requested according to the values of the requestedOffset and requestedLength properties of the dataRequest, or if requestsAllDataToEndOfResource has a value of YES, you may invoke -finishLoading after you have provided as much of the requested data as the resource contains.
  */
  @available(iOS 7.0, *)
  func finishLoading()

  /*! 
   @method 		finishLoadingWithError:   
   @abstract		Causes the receiver to treat the request as having failed.
   @param			error
   				An instance of NSError indicating the reason for failure.
  */
  func finishLoadingWithError(error: Error?)
}

/*!
 @class		AVAssetResourceRenewalRequest

 @abstract	AVAssetResourceRenewalRequest encapsulates information about a resource request issued by a resource loader for the purpose of renewing a request previously issued.

 @discussion
 When an AVURLAsset needs to renew a resource (because contentInformationRequest.renewalDate has been set on a previous loading request), it asks its AVAssetResourceLoader object to assist. The resource loader encapsulates the request information by creating an instance of this object, which it then hands to its delegate for processing. The delegate uses the information in this object to perform the request and report on the success or failure of the operation.

 */
@available(iOS 8.0, *)
class AVAssetResourceRenewalRequest : AVAssetResourceLoadingRequest {
}
@available(iOS 7.0, *)
class AVAssetResourceLoadingContentInformationRequest : Object {

  /*! 
   @property 		contentType
   @abstract		A UTI that indicates the type of data contained by the requested resource.
   @discussion	Before you finish loading an AVAssetResourceLoadingRequest, if its contentInformationRequest is not nil, you should set the value of this property to a UTI indicating the type of data contained by the requested resource.
  */
  var contentType: String?

  /*! 
   @property 		contentLength
   @abstract		Indicates the length of the requested resource, in bytes.
   @discussion	Before you finish loading an AVAssetResourceLoadingRequest, if its contentInformationRequest is not nil, you should set the value of this property to the number of bytes contained by the requested resource.
  */
  var contentLength: Int64

  /*! 
   @property 		byteRangeAccessSupported
   @abstract		Indicates whether random access to arbitrary ranges of bytes of the resource is supported. Such support also allows portions of the resource to be requested more than once.
   @discussion	Before you finish loading an AVAssetResourceLoadingRequest, if its contentInformationRequest is not nil, you should set the value of this property to YES if you support random access to arbitrary ranges of bytes of the resource. If you do not set this property to YES for resources that must be loaded incrementally, loading of the resource may fail. Such resources include anything that contains media data.
  */
  var isByteRangeAccessSupported: Bool

  /*!
   @property		renewalDate
   @abstract		For resources that expire, the date at which a new AVAssetResourceLoadingRequest will be issued for a renewal of this resource, if the media system still requires it.
   @discussion	Before you finish loading an AVAssetResourceLoadingRequest, if the resource is prone to expiry you should set the value of this property to the date at which a renewal should be triggered. This value should be set sufficiently early enough to allow an AVAssetResourceRenewalRequest, delivered to your delegate via -resourceLoader:shouldWaitForRenewalOfRequestedResource:, to finish before the actual expiry time. Otherwise media playback may fail.
   */
  @available(iOS 8.0, *)
  @NSCopying var renewalDate: Date?
}
@available(iOS 7.0, *)
class AVAssetResourceLoadingDataRequest : Object {

  /*! 
   @property 		requestedOffset
   @abstract		The position within the resource of the first byte requested.
  */
  var requestedOffset: Int64 { get }

  /*! 
   @property 		requestedLength
   @abstract		The length of the data requested.
   @discussion	Note that requestsAllDataToEndOfResource will be set to YES when the entire remaining length of the resource is being requested from requestedOffset to the end of the resource. This can occur even when the content length has not yet been reported by you via a prior finished loading request.
   				When requestsAllDataToEndOfResource has a value of YES, you should disregard the value of requestedLength and incrementally provide as much data starting from the requestedOffset as the resource contains, until you have provided all of the available data successfully and invoked -finishLoading, until you have encountered a failure and invoked -finishLoadingWithError:, or until you have received -resourceLoader:didCancelLoadingRequest: for the AVAssetResourceLoadingRequest from which the AVAssetResourceLoadingDataRequest was obtained.
   				When requestsAllDataToEndOfResource is YES and the content length has not yet been provided by you via a prior finished loading request, the value of requestedLength is set to NSIntegerMax. Starting in OS X 10.11 and iOS 9.0, in 32-bit applications requestedLength is also set to NSIntegerMax when all of the remaining resource data is being requested and the known length of the remaining data exceeds NSIntegerMax.
  */
  var requestedLength: Int { get }

  /*! 
   @property 		requestsAllDataToEndOfResource
   @abstract		Specifies that the entire remaining length of the resource from requestedOffset to the end of the resource is being requested.
   @discussion	When requestsAllDataToEndOfResource has a value of YES, you should disregard the value of requestedLength and incrementally provide as much data starting from the requestedOffset as the resource contains, until you have provided all of the available data successfully and invoked -finishLoading, until you have encountered a failure and invoked -finishLoadingWithError:, or until you have received -resourceLoader:didCancelLoadingRequest: for the AVAssetResourceLoadingRequest from which the AVAssetResourceLoadingDataRequest was obtained.
  */
  @available(iOS 9.0, *)
  var requestsAllDataToEndOfResource: Bool { get }

  /*! 
   @property 		currentOffset
   @abstract		The position within the resource of the next byte within the resource following the bytes that have already been provided via prior invocations of -respondWithData.
  */
  var currentOffset: Int64 { get }

  /*! 
   @method 		respondWithData:   
   @abstract		Provides data to the receiver.
   @param			data
   				An instance of NSData containing some or all of the requested bytes.
   @discussion	May be invoked multiple times on the same instance of AVAssetResourceLoadingDataRequest to provide the full range of requested data incrementally. Upon each invocation, the value of currentOffset will be updated to accord with the amount of data provided.
  */
  func respondWith(data: Data)
}
extension AVAssetResourceLoader {

  /*!
   @property 		preloadsEligibleContentKeys
   @abstract		When YES, eligible content keys will be loaded as eagerly as possible, potentially handled by the delegate. Setting to YES may result in network activity.
   @discussion	Any work done as a result of setting this property will be performed asynchronously.
  */
  @available(iOS 9.0, *)
  var preloadsEligibleContentKeys: Bool
}
extension AVAssetResourceLoadingRequest {

  /*! 
   @method 		streamingContentKeyRequestDataForApp:contentIdentifier:options:error:   
   @abstract		Obtains a streaming content key request for a specific combination of application and content.
   @param			appIdentifier
   				An opaque identifier for the application. The value of this identifier depends on the particular system used to provide the decryption key.
   @param			contentIdentifier
   				An opaque identifier for the content. The value of this identifier depends on the particular system used to provide the decryption key.
   @param			options
   				Additional information necessary to obtain the key, or nil if none.
   @param			error
   				If obtaining the streaming content key request fails, will be set to an instance of NSError describing the failure.
   @result		The key request data that must be transmitted to the key vendor to obtain the content key.
  */
  func streamingContentKeyRequestDataForApp(appIdentifier: Data, contentIdentifier: Data, options: [String : AnyObject]? = [:]) throws -> Data

  /*! 
   @method 		persistentContentKeyFromKeyVendorResponse:options:error:
   @abstract		Obtains a persistable content key from a context.
   @param			keyVendorResponse
   				The response returned from the key vendor as a result of a request generated from streamingContentKeyRequestDataForApp:contentIdentifier:options:error:.
   @param			options
   				Additional information necessary to obtain the persistable content key, or nil if none.
   @param			error
   				If obtaining the persistable content key fails, will be set to an instance of NSError describing the failure.
   @result		The persistable content key data that may be stored offline to answer future loading requests of the same content key.
   @discussion	The data returned from this method may be used to immediately satisfy an AVAssetResourceLoadingDataRequest, as well as any subsequent requests for the same key url. The value of AVAssetResourceLoadingContentInformationRequest.contentType must be set to AVStreamingKeyDeliveryPersistentContentKeyType when responding with data created with this method.
  */
  @available(iOS 9.0, *)
  func persistentContentKeyFromKeyVendorResponse(keyVendorResponse: Data, options: [String : AnyObject]? = [:], error outError: ErrorPointer) -> Data
}

/*!
 @constant		AVAssetResourceLoadingRequestStreamingContentKeyRequestRequiresPersistentKey
 @abstract		Specifies whether the content key request should require a persistable key to be returned from the key vendor. Value should be a NSNumber created with +[NSNumber numberWithBool:].
*/
@available(iOS 9.0, *)
let AVAssetResourceLoadingRequestStreamingContentKeyRequestRequiresPersistentKey: String
extension AVAssetResourceLoadingRequest {
}

/*!
  @class		AVAsset

  @abstract
	An AVAsset is an abstract class that defines AVFoundation's model for timed audiovisual media.

	Each asset contains a collection of tracks that are intended to be presented or processed together, each of a uniform media type, including but not limited to audio, video, text, closed captions, and subtitles.

  @discussion
	AVAssets are often instantiated via its concrete subclass AVURLAsset with NSURLs that refer to audiovisual media resources, such as streams (including HTTP live streams), QuickTime movie files, MP3 files, and files of other types.

	They can also be instantiated using other concrete subclasses that extend the basic model for audiovisual media in useful ways, as AVComposition does for temporal editing.

	Properties of assets as a whole are defined by AVAsset. Additionally, references to instances of AVAssetTracks representing tracks of the collection can be obtained, so that each of these can be examined independently.
					
	Because of the nature of timed audiovisual media, upon successful initialization of an AVAsset some or all of the values for its keys may not be immediately available. The value of any key can be requested at any time, and AVAsset will always return its value synchronously, although it may have to block the calling thread in order to do so.

	In order to avoid blocking, clients can register their interest in particular keys and to become notified when their values become available. For further details, see AVAsynchronousKeyValueLoading.h.

	On iOS, it is particularly important to avoid blocking.  To preserve responsiveness, a synchronous request that blocks for too long (eg, a property request on an asset on a slow HTTP server) may lead to media services being reset.

	To play an instance of AVAsset, initialize an instance of AVPlayerItem with it, use the AVPlayerItem to set up its presentation state (such as whether only a limited timeRange of the asset should be played, etc.), and provide the AVPlayerItem to an AVPlayer according to whether the items is to be played by itself or together with a collection of other items. Full details available in AVPlayerItem.h and AVPlayer.h.
					
	AVAssets can also be inserted into AVMutableCompositions in order to assemble audiovisual constructs from one or more source assets.

*/
@available(iOS 4.0, *)
class AVAssetTrack : Object, Copying, AVAsynchronousKeyValueLoading {
  weak var asset: @sil_weak AVAsset? { get }
  var trackID: CMPersistentTrackID { get }
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject

  /*!
    @method		statusOfValueForKey:
    @abstract		Reports whether the value for a key is immediately available without blocking.
    @param		key
      An instance of NSString containing the specified key.
    @param		outError
      If the status of the value for the key is AVKeyValueStatusFailed, *outError is set to a non-nil NSError that describes the failure that occurred.
    @result		The value's current loading status.
    @discussion
      Clients can use -statusOfValueForKey: to determine the availability of the value of any key of interest. However, this method alone does not prompt the receiver to load the value of a key that's not yet available. To request values for keys that may not already be loaded, without blocking, use -loadValuesAsynchronouslyForKeys:completionHandler:, await invocation of the completion handler, and test the availability of each key via -statusOfValueForKey: before invoking its getter.
   
      Even if access to values of some keys may be readily available, as can occur with receivers initialized with URLs for resources on local volumes, extensive I/O or parsing may be needed for these same receivers to provide values for other keys. A duration for a local MP3 file, for example, may be expensive to obtain, even if the values for other AVAsset properties may be trivial to obtain.
  
      Blocking that may occur when calling the getter for any key should therefore be avoided in the general case by loading values for all keys of interest via -loadValuesAsynchronouslyForKeys:completionHandler: and testing the availability of the requested values before fetching them by calling getters.
        
      The sole exception to this general rule is in usage on Mac OS X on the desktop, where it may be acceptable to block in cases in which the client is preparing objects for use on background threads or in operation queues. On iOS, values should always be loaded asynchronously prior to calling getters for the values, in any usage scenario.
  */
  @available(iOS 4.0, *)
  func statusOfValueForKey(key: String, error outError: ErrorPointer) -> AVKeyValueStatus

  /*!
    @method		loadValuesAsynchronouslyForKeys:completionHandler:
    @abstract		Directs the target to load the values of any of the specified keys that are not already loaded.
    @param		keys
      An instance of NSArray, containing NSStrings for the specified keys.
    @param		completionHandler
      The block to be invoked when loading succeeds, fails, or is cancelled.
  */
  @available(iOS 4.0, *)
  func loadValuesAsynchronouslyForKeys(keys: [String], completionHandler handler: (() -> Void)? = nil)
}
extension AVAssetTrack {
  var mediaType: String { get }
  var formatDescriptions: [AnyObject] { get }
  @available(iOS 5.0, *)
  var isPlayable: Bool { get }
  var isEnabled: Bool { get }
  var isSelfContained: Bool { get }
  var totalSampleDataLength: Int64 { get }

  /*!
  	@method			hasMediaCharacteristic:
  	@abstract		Reports whether the track references media with the specified media characteristic.
  	@param			mediaCharacteristic
  					The media characteristic of interest, e.g. AVMediaCharacteristicVisual, AVMediaCharacteristicAudible, AVMediaCharacteristicLegible, etc.,
  					as defined above.
  	@result			YES if the track references media with the specified characteristic, otherwise NO.
  */
  func hasMediaCharacteristic(mediaCharacteristic: String) -> Bool
}
extension AVAssetTrack {
  var timeRange: CMTimeRange { get }
  var naturalTimeScale: CMTimeScale { get }
  var estimatedDataRate: Float { get }
}
extension AVAssetTrack {
  var languageCode: String { get }
  var extendedLanguageTag: String { get }
}
extension AVAssetTrack {
  var naturalSize: CGSize { get }
  var preferredTransform: CGAffineTransform { get }
}
extension AVAssetTrack {
  var preferredVolume: Float { get }
}
extension AVAssetTrack {

  /*!
  	@property		nominalFrameRate
  	@abstract		For tracks that carry a full frame per media sample, indicates the frame rate of the track in units of frames per second.
  	@discussion		For field-based video tracks that carry one field per media sample, the value of this property is the field rate, not the frame rate.
  */
  var nominalFrameRate: Float { get }
  @available(iOS 7.0, *)
  var minFrameDuration: CMTime { get }

  /*!
  	@property       requiresFrameReordering
  	@abstract       Indicates whether samples in the track may have different values for their presentation and decode timestamps.
  */
  @available(iOS 8.0, *)
  var requiresFrameReordering: Bool { get }
}
extension AVAssetTrack {
  var segments: [AVAssetTrackSegment] { get }

  /*!
  	@method			segmentForTrackTime:
  	@abstract		Supplies the AVAssetTrackSegment from the segments array with a target timeRange that either contains the specified track time or is the closest to it among the target timeRanges of the track's segments.
  	@param			trackTime
  					The trackTime for which an AVAssetTrackSegment is requested.
  	@result			An AVAssetTrackSegment.
  	@discussion		If the trackTime does not map to a sample presentation time (e.g. it's outside the track's timeRange), the segment closest in time to the specified trackTime is returned. 
  */
  func segmentForTrack(trackTime: CMTime) -> AVAssetTrackSegment?

  /*!
  	@method			samplePresentationTimeForTrackTime:
  	@abstract		Maps the specified trackTime through the appropriate time mapping and returns the resulting sample presentation time.
  	@param			trackTime
  					The trackTime for which a sample presentation time is requested.
  	@result			A CMTime; will be invalid if the trackTime is out of range
  */
  func samplePresentationTimeForTrack(trackTime: CMTime) -> CMTime
}
extension AVAssetTrack {
  var commonMetadata: [AVMetadataItem] { get }
  @available(iOS 8.0, *)
  var metadata: [AVMetadataItem] { get }
  var availableMetadataFormats: [String] { get }

  /*!
  	@method			metadataForFormat:
  	@abstract		Provides an NSArray of AVMetadataItems, one for each metadata item in the container of the specified format.
  	@param			format
  					The metadata format for which items are requested.
  	@result			An NSArray containing AVMetadataItems.
  	@discussion		Becomes callable without blocking when the key @"availableMetadataFormats" has been loaded
  */
  func metadataForFormat(format: String) -> [AVMetadataItem]
}
extension AVAssetTrack {
  @available(iOS 7.0, *)
  var availableTrackAssociationTypes: [String] { get }

  /*!
  	@method			associatedTracksOfType:
  	@abstract		Provides an NSArray of AVAssetTracks, one for each track associated with the receiver with the specified type of track association.
  	@param			trackAssociationType
  					The type of track association for which associated tracks are requested.
  	@result			An NSArray containing AVAssetTracks; may be empty if there is no associated tracks of the specified type.
  	@discussion		Becomes callable without blocking when the key @"availableTrackAssociationTypes" has been loaded.
  */
  @available(iOS 7.0, *)
  func associatedTracksOfType(trackAssociationType: String) -> [AVAssetTrack]
}
@available(iOS 7.0, *)
let AVTrackAssociationTypeAudioFallback: String
@available(iOS 7.0, *)
let AVTrackAssociationTypeChapterList: String
@available(iOS 7.0, *)
let AVTrackAssociationTypeForcedSubtitlesOnly: String
@available(iOS 7.0, *)
let AVTrackAssociationTypeSelectionFollower: String
@available(iOS 7.0, *)
let AVTrackAssociationTypeTimecode: String
@available(iOS 8.0, *)
let AVTrackAssociationTypeMetadataReferent: String

/*!
 @constant       AVAssetTrackTimeRangeDidChangeNotification
 @abstract       Posted when the timeRange of an AVFragmentedAssetTrack changes while the associated instance of AVFragmentedAsset is being minded by an AVFragmentedAssetMinder, but only for changes that occur after the status of the value of @"timeRange" has reached AVKeyValueStatusLoaded.
*/
@available(iOS 9.0, *)
let AVAssetTrackTimeRangeDidChangeNotification: String

/*!
 @constant       AVAssetTrackSegmentsDidChangeNotification
 @abstract       Posted when the array of segments of an AVFragmentedAssetTrack changes while the associated instance of AVFragmentedAsset is being minded by an AVFragmentedAssetMinder, but only for changes that occur after the status of the value of @"segments" has reached AVKeyValueStatusLoaded.
*/
@available(iOS 9.0, *)
let AVAssetTrackSegmentsDidChangeNotification: String

/*!
 @constant       AVAssetTrackTrackAssociationsDidChangeNotification
 @abstract       Posted when the collection of track associations of an AVAssetTrack changes, but only for changes that occur after the status of the value of @"availableTrackAssociationTypes" has reached AVKeyValueStatusLoaded.
*/
@available(iOS 9.0, *)
let AVAssetTrackTrackAssociationsDidChangeNotification: String

/*!
 @class AVAssetTrackGroup
 @abstract
	A class whose instances describe a group of tracks in an asset.
 
 @discussion
	Instances of AVAssetTrackGroup describe a single group of related tracks in an asset. For example, a track group can
	describe a set of alternate tracks, which are tracks containing variations of the same content, such as content
	translated into different languages, out of which only one track should be played at a time.
 
	Clients can inspect the track groups contained in an AVAsset by loading and obtaining the value of its trackGroups property.
 */
@available(iOS 7.0, *)
class AVAssetTrackGroup : Object, Copying {

  /*!
   @property trackIDs
   @abstract
  	The IDs of all of the tracks in the group.
   
   @discussion
  	The value of this property is an NSArray of NSNumbers interpreted as CMPersistentTrackIDs, one for each track in the
  	group.
   */
  var trackIDs: [Number] { get }
  init()
  @available(iOS 7.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 4.0, *)
class AVAssetTrackSegment : Object {
  var timeMapping: CMTimeMapping { get }
  var isEmpty: Bool { get }
}

/*!
 @enum AVAssetWriterStatus
 @abstract
	These constants are returned by the AVAssetWriter status property to indicate whether it can successfully write samples to its output file.

 @constant	 AVAssetWriterStatusUnknown
	Indicates that the status of the asset writer is not currently known.
 @constant	 AVAssetWriterStatusWriting
	Indicates that the asset writer is successfully writing samples to its output file.
 @constant	 AVAssetWriterStatusCompleted
	Indicates that the asset writer has successfully written all samples following a call to finishWriting.
 @constant	 AVAssetWriterStatusFailed
	Indicates that the asset writer can no longer write samples to its output file because of an error. The error is described by the value of the asset writer's error property.
 @constant	 AVAssetWriterStatusCancelled
	Indicates that the asset writer can no longer write samples because writing was canceled with the cancelWriting method.
 */
enum AVAssetWriterStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case Writing
  case Completed
  case Failed
  case Cancelled
}

/*!
 @class AVAssetWriter
 @abstract
	 AVAssetWriter provides services for writing media data to a new file,
 
 @discussion
	Instances of AVAssetWriter can write media to new files in formats such as the QuickTime movie file format or the MPEG-4 file format. AVAssetWriter has support for automatic interleaving of media data for multiple concurrent tracks. Source media data can be obtained from instances of AVAssetReader for one or more assets or from other sources outside of AVFoundation.

	Instances of AVAssetWriter can re-encode media samples as they are written. Instances of AVAssetWriter can also optionally write metadata collections to the output file.
 
	A single instance of AVAssetWriter can be used once to write to a single file. Clients that wish to write to files multiple times must use a new instance of AVAssetWriter each time.
 */
@available(iOS 4.1, *)
class AVAssetWriter : Object {

  /*!
   @method initWithURL:fileType:error:
   @abstract
  	Creates an instance of AVAssetWriter configured to write to a file in a specified container format.
   
   @param URL
  	The location of the file to be written. The URL must be a file URL.
   @param fileType
  	A UTI indicating the format of the file to be written.
   @param outError
  	On return, if initialization of the AVAssetWriter fails, points to an NSError describing the nature of the failure.
   @result
  	An instance of AVAssetWriter.
   
   @discussion
  	Writing will fail if a file already exists at the specified URL.
  	
  	UTIs for container formats that can be written are declared in AVMediaFormat.h.
   */
  init(url outputURL: URL, fileType outputFileType: String) throws

  /*!
   @property outputURL
   @abstract
  	The location of the file for which the instance of AVAssetWriter was initialized for writing.
   @discussion
  	You may use UTTypeCopyPreferredTagWithClass(outputFileType, kUTTagClassFilenameExtension) to obtain an appropriate path extension for the outputFileType you have specified. For more information about UTTypeCopyPreferredTagWithClass and kUTTagClassFilenameExtension, on iOS see <MobileCoreServices/UTType.h> and on Mac OS X see <LaunchServices/UTType.h>.
   */
  @NSCopying var outputURL: URL { get }

  /*!
   @property outputFileType
   @abstract
  	The UTI of the file format of the file for which the instance of AVAssetWriter was initialized for writing.
   */
  var outputFileType: String { get }

  /*!
   @property availableMediaTypes
   @abstract
  	The media types for which inputs can be added to the receiver.
  
   @discussion
  	Some media types may not be accepted within the file format with which an AVAssetWriter was initialized.
   */
  var availableMediaTypes: [String] { get }

  /*!
   @property status
   @abstract
  	The status of writing samples to the receiver's output file.
  
   @discussion
  	The value of this property is an AVAssetWriterStatus that indicates whether writing is in progress, has completed successfully, has been canceled, or has failed. Clients of AVAssetWriterInput objects should check the value of this property after appending samples fails to determine why no more samples could be written. This property is thread safe.
   */
  var status: AVAssetWriterStatus { get }

  /*!
   @property error
   @abstract
  	If the receiver's status is AVAssetWriterStatusFailed, this describes the error that caused the failure.
  
   @discussion
  	The value of this property is an NSError that describes what caused the receiver to no longer be able to write to its output file. If the receiver's status is not AVAssetWriterStatusFailed, the value of this property is nil. This property is thread safe.
   */
  var error: Error? { get }

  /*!
   @property metadata
   @abstract
  	A collection of metadata to be written to the receiver's output file.
  
   @discussion
  	The value of this property is an array of AVMetadataItem objects representing the collection of top-level metadata to be written in the output file.
  	
  	This property cannot be set after writing has started.
   */
  var metadata: [AVMetadataItem]

  /*!
   @property shouldOptimizeForNetworkUse
   @abstract
  	Specifies whether the output file should be written in way that makes it more suitable for playback over a network
   
   @discussion
  	When the value of this property is YES, the output file will be written in such a way that playback can start after only a small amount of the file is downloaded.
  	
  	This property cannot be set after writing has started.
   */
  var shouldOptimizeForNetworkUse: Bool

  /*!
   @property directoryForTemporaryFiles
   @abstract 
  	Specifies a directory that is suitable for containing temporary files generated during the process of writing an asset.
   
   @discussion
  	AVAssetWriter may need to write temporary files when configured in certain ways, such as when performsMultiPassEncodingIfSupported is set to YES on one or more of its inputs.  This property can be used to control where in the filesystem those temporary files are created.  All temporary files will be deleted when asset writing is completed, is canceled, or fails.
   
  	When the value of this property is nil, the asset writer will choose a suitable location when writing temporary files.  The default value is nil.
  	
  	This property cannot be set after writing has started.  The asset writer will fail if a file cannot be created in this directory (for example, due to insufficient permissions).
   */
  @available(iOS 8.0, *)
  @NSCopying var directoryForTemporaryFiles: URL?

  /*!
   @property inputs
   @abstract
  	The inputs from which the asset writer receives media data.
   @discussion
  	The value of this property is an NSArray containing concrete instances of AVAssetWriterInput. Inputs can be added to the receiver using the addInput: method.
   */
  var inputs: [AVAssetWriterInput] { get }

  /*!
   @method canApplyOutputSettings:forMediaType:
   @abstract
  	Tests whether output settings for a specific media type are supported by the receiver's file format.
  
   @param outputSettings
  	The output settings that are to be tested.
   @param mediaType
  	The media type for which the output settings are to be tested. Media types are defined in AVMediaFormat.h.
   @result
  	A BOOL indicating whether the given output settings can be used for the given media type.
   
   @discussion
  	This method determines whether the output settings for the specified media type can be used with the receiver's file format. For example, video compression settings that specify H.264 compression are not compatible with file formats that cannot contain H.264-compressed video.
   
  	Attempting to add an input with output settings and a media type for which this method returns NO will cause an exception to be thrown.
  */
  func canApplyOutputSettings(outputSettings: [String : AnyObject]?, forMediaType mediaType: String) -> Bool

  /*!
   @method canAddInput:
   @abstract
  	Tests whether an input can be added to the receiver.
  
   @param input
  	The AVAssetWriterInput object to be tested.
   @result
  	A BOOL indicating whether the input can be added to the receiver.
  
   @discussion
  	An input that accepts media data of a type that is not compatible with the receiver, or with output settings that are not compatible with the receiver, cannot be added.
   */
  func canAddInput(input: AVAssetWriterInput) -> Bool

  /*!
   @method addInput:
   @abstract
  	Adds an input to the receiver.
  
   @param input
  	The AVAssetWriterInput object to be added.
  
   @discussion
  	Inputs are created with a media type and output settings. These both must be compatible with the receiver.
  	
  	Inputs cannot be added after writing has started.
   */
  func addInput(input: AVAssetWriterInput)

  /*!
   @method startWriting
   @abstract
  	Prepares the receiver for accepting input and for writing its output to its output file.
  
   @result
  	A BOOL indicating whether writing successfully started.
   
   @discussion
  	This method must be called after all inputs have been added and other configuration properties have been set in order to tell the receiver to prepare for writing. After this method is called, clients can start writing sessions using startSessionAtSourceTime: and can write media samples using the methods provided by each of the receiver's inputs.
   
  	If writing cannot be started, this method returns NO. Clients can check the values of the status and error properties for more information on why writing could not be started.
   
  	On iOS, if the status of an AVAssetWriter is AVAssetWriterStatusWriting when the client app goes into the background, its status will change to AVAssetWriterStatusFailed and appending to any of its inputs will fail.  You may want to use -[UIApplication beginBackgroundTaskWithExpirationHandler:] to avoid being interrupted in the middle of a writing session and to finish writing the data that has already been appended.  For more information about executing code in the background, see the iOS Application Programming Guide.
   */
  func startWriting() -> Bool

  /*!
   @method startSessionAtSourceTime:
   @abstract
  	Initiates a sample-writing session for the receiver.
   
   @param startTime
  	The starting asset time for the sample-writing session, in the timeline of the source samples.
  
   @discussion
  	Sequences of sample data appended to the asset writer inputs are considered to fall within "sample-writing sessions", initiated with this method. Accordingly, this method must be called after writing has started (using -startWriting) but before any sample data is appended to the receiver's inputs.
  	
  	Each writing session has a start time which, where allowed by the file format being written, defines the mapping from the timeline of source samples to the timeline of the written file. In the case of the QuickTime movie file format, the first session begins at movie time 0, so a sample appended with timestamp T will be played at movie time (T-startTime).  Samples with timestamps earlier than startTime will still be added to the output file but will be edited out (i.e. not presented during playback). If the earliest appended sample for an input has a timestamp later than than startTime, an empty edit will be inserted to preserve synchronization between tracks of the output asset.
  	
  	To end the session started by use of this method, use -endSessionAtSourceTime: or -finishWritingWithCompletionHandler:.  It is an error to invoke -startSessionAtSourceTime: twice in a row without invoking -endSessionAtSourceTime: in between.
   
  	NOTE: Multiple sample-writing sessions are currently not supported. It is an error to call -startSessionAtSourceTime: a second time after calling -endSessionAtSourceTime:.
   */
  func startSessionAtSourceTime(startTime: CMTime)

  /*!
   @method endSessionAtSourceTime:
   @abstract
  	Concludes a sample-writing session.
  
   @param endTime
  	The ending asset time for the sample-writing session, in the timeline of the source samples.
  
   @discussion
  	Call this method to complete a session started with -startSessionAtSourceTime:.
   
  	The endTime defines the moment on the timeline of source samples at which the session ends. In the case of the QuickTime movie file format, each sample-writing session's startTime...endTime pair corresponds to a period of movie time into which the session's samples are inserted. Samples with timestamps that are later than the session end time will still be added to the written file but will be edited out (i.e. not presented during playback). So if the first session has duration D1 = endTime - startTime, it will be inserted into the written file at time 0 through D1; the second session would be inserted into the written file at time D1 through D1+D2, etc. It is legal to have a session with no samples; this will cause creation of an empty edit of the prescribed duration.
  	
  	It is not mandatory to call -endSessionAtSourceTime:; if -finishWritingWithCompletionHandler: is called without first invoking -endSessionAtSourceTime:, the session's effective end time will be the latest end timestamp of the session's appended samples (i.e. no samples will be edited out at the end).
   
  	It is an error to append samples outside of a sample-writing session.  To append more samples after invoking -endSessionAtSourceTime:, you must first start a new session using -startSessionAtSourceTime:.
  	
  	NOTE: Multiple sample-writing sessions are currently not supported. It is an error to call -startSessionAtSourceTime: a second time after calling -endSessionAtSourceTime:.
   */
  func endSessionAtSourceTime(endTime: CMTime)

  /*!
   @method cancelWriting
   @abstract
  	Cancels the creation of the output file.
   
   @discussion
  	If the status of the receiver is "failed" or "completed," -cancelWriting is a no-op.  Otherwise, this method will block until writing is canceled.
   
  	If an output file was created by the receiver during the writing process, -cancelWriting will delete the file.
  	
  	This method should not be called concurrently with -[AVAssetWriterInput appendSampleBuffer:] or -[AVAssetWriterInputPixelBufferAdaptor appendPixelBuffer:withPresentationTime:].
  */
  func cancelWriting()

  /*!
   @method finishWritingWithCompletionHandler:
   @abstract
  	Marks all unfinished inputs as finished and completes the writing of the output file.
  
   @discussion
  	This method returns immediately and causes its work to be performed asynchronously.
  	
  	When the writing of the output file is finished, or if a failure or a cancellation occurs in the meantime, the specified handler will be invoked to indicate completion of the operation. To determine whether the operation succeeded, your handler can check the value of AVAssetWriter.status. If the status is AVAssetWriterStatusFailed, AVAsset.error will contain an instance of NSError that describes the failure.
  	
  	To guarantee that all sample buffers are successfully written, ensure all calls to -[AVAssetWriterInput appendSampleBuffer:] or -[AVAssetWriterInputPixelBufferAdaptor appendPixelBuffer:withPresentationTime:] have returned before invoking this method.
  */
  @available(iOS 6.0, *)
  func finishWritingWithCompletionHandler(handler: () -> Void)
}
extension AVAssetWriter {

  /*!
   @property movieFragmentInterval
   @abstract
  	For file types that support movie fragments, specifies the frequency at which movie fragments should be written.
   
   @discussion
  	When movie fragments are used, a partially written asset whose writing is unexpectedly interrupted can be successfully opened and played up to multiples of the specified time interval. The default value of this property is kCMTimeInvalid, which indicates that movie fragments should not be used.
  
  	This property cannot be set after writing has started.
   */
  var movieFragmentInterval: CMTime

  /*!
   @property overallDurationHint
   @abstract
  	For file types that support movie fragments, provides a hint of the final duration of the file to be written
   
   @discussion
  	The value of this property must be a nonnegative, numeric CMTime.  Alternatively, if the value of this property is an invalid CMTime (e.g. kCMTimeInvalid), no overall duration hint will be written to the file.  The default value is kCMTimeInvalid.
   
  	This property is currently ignored if movie fragments are not being written.  Use the movieFragmentInterval property to enable movie fragments.
   
  	This property cannot be set after writing has started.
   */
  var overallDurationHint: CMTime

  /*!
   @property movieTimeScale
   @abstract
  	For file types that contain a 'moov' atom, such as QuickTime Movie files, specifies the asset-level time scale to be used. 
  
   @discussion
  	The default value is 0, which indicates that the receiver should choose a convenient value, if applicable.
   
  	This property cannot be set after writing has started.
   */
  @available(iOS 4.3, *)
  var movieTimeScale: CMTimeScale
}
extension AVAssetWriter {

  /*!
   @method canAddInputGroup:
   @abstract
  	Tests whether an input group can be added to the receiver.
  
   @param inputGroup
  	The AVAssetWriterInputGroup object to be tested.
   @result
  	A BOOL indicating whether the input group can be added to the receiver.
  
   @discussion
  	If outputFileType specifies a container format that does not support mutually exclusive relationships among tracks, or if the specified instance of AVAssetWriterInputGroup contains inputs with media types that cannot be related, the group cannot be added to the AVAssetWriter.
   */
  @available(iOS 7.0, *)
  func canAddInputGroup(inputGroup: AVAssetWriterInputGroup) -> Bool
  @available(iOS 7.0, *)
  func addInputGroup(inputGroup: AVAssetWriterInputGroup)

  /*!
   @property inputGroups
   @abstract
  	The instances of AVAssetWriterInputGroup that have been added to the AVAssetWriter.
   
   @discussion
  	The value of this property is an NSArray containing concrete instances of AVAssetWriterInputGroup.  Input groups can be added to the receiver using the addInputGroup: method.
   */
  @available(iOS 7.0, *)
  var inputGroups: [AVAssetWriterInputGroup] { get }
}
@available(iOS 7.0, *)
class AVAssetWriterInputGroup : AVMediaSelectionGroup {
  init(inputs: [AVAssetWriterInput], defaultInput: AVAssetWriterInput?)

  /*!
   @property inputs
   @abstract
  	The inputs grouped together by the receiver.
   
   @discussion
  	The value of this property is an NSArray containing concrete instances of AVAssetWriterInput.
   */
  var inputs: [AVAssetWriterInput] { get }

  /*!
   @property defaultInput
   @abstract
  	The input designated at the defaultInput of the receiver.
   
   @discussion
  	The value of this property is a concrete instance of AVAssetWriterInput.
   */
  var defaultInput: AVAssetWriterInput? { get }
}

/*!
 @class AVAssetWriterInput
 @abstract
	AVAssetWriterInput defines an interface for appending either new media samples or references to existing media samples packaged as CMSampleBuffer objects to a single track of the output file of an AVAssetWriter.
 
 @discussion
	Clients that need to write multiple concurrent tracks of media data should use one AVAssetWriterInput instance per track. In order to write multiple concurrent tracks with ideal interleaving of media data, clients should observe the value returned by the readyForMoreMediaData property of each AVAssetWriterInput instance.
	
	AVAssetWriterInput also supports writing per-track metadata collections to the output file.

	As of OS X 10.10 and iOS 8.0 AVAssetWriterInput can also be used to create tracks that are not self-contained.  Such tracks reference sample data that is located in another file. This is currently supported only for instances of AVAssetWriterInput attached to an instance of AVAssetWriter that writes files of type AVFileTypeQuickTimeMovie.
 */
@available(iOS 4.1, *)
class AVAssetWriterInput : Object {

  /*!
   @method initWithMediaType:outputSettings:
   @abstract
  	Creates a new input of the specified media type to receive sample buffers for writing to the output file.
  
   @param mediaType
  	The media type of samples that will be accepted by the input. Media types are defined in AVMediaFormat.h.
   @param outputSettings
  	The settings used for encoding the media appended to the output.  See AVAudioSettings.h for AVMediaTypeAudio or AVVideoSettings.h for AVMediaTypeVideo and for more information on how to construct an output settings dictionary.  If you only require simple preset-based output settings, see AVOutputSettingsAssistant.
   @result
  	An instance of AVAssetWriterInput.
  
   @discussion
  	Each new input accepts data for a new track of the AVAssetWriter's output file.  Inputs are added to an asset writer using -[AVAssetWriter addInput:].
  	
  	Passing nil for output settings instructs the input to pass through appended samples, doing no processing before they are written to the output file.  This is useful if, for example, you are appending buffers that are already in a desirable compressed format.  However, if not writing to a QuickTime Movie file (i.e. the AVAssetWriter was initialized with a file type other than AVFileTypeQuickTimeMovie), AVAssetWriter only supports passing through a restricted set of media types and subtypes.  In order to pass through media data to files other than AVFileTypeQuickTimeMovie, a non-NULL format hint must be provided using -initWithMediaType:outputSettings:sourceFormatHint: instead of this method.
   
  	For AVMediaTypeAudio the following keys are not currently supported in the outputSettings dictionary: AVEncoderAudioQualityKey and AVSampleRateConverterAudioQualityKey.  When using this initializer, an audio settings dictionary must be fully specified, meaning that it must contain AVFormatIDKey, AVSampleRateKey, and AVNumberOfChannelsKey.  If no other channel layout information is available, a value of 1 for AVNumberOfChannelsKey will result in mono output and a value of 2 will result in stereo output.  If AVNumberOfChannelsKey specifies a channel count greater than 2, the dictionary must also specify a value for AVChannelLayoutKey.  For kAudioFormatLinearPCM, all relevant AVLinearPCM*Key keys must be included, and for kAudioFormatAppleLossless, AVEncoderBitDepthHintKey keys must be included.  See -initWithMediaType:outputSettings:sourceFormatHint: for a way to avoid having to specify a value for each of those keys.
   
  	For AVMediaTypeVideo, any output settings dictionary must request a compressed video format.  This means that the value passed in for outputSettings must follow the rules for compressed video output, as laid out in AVVideoSettings.h.  When using this initializer, a video settings dictionary must be fully specified, meaning that it must contain AVVideoCodecKey, AVVideoWidthKey, and AVVideoHeightKey.  See -initWithMediaType:outputSettings:sourceFormatHint: for a way to avoid having to specify a value for each of those keys.  On iOS, the only values currently supported for AVVideoCodecKey are AVVideoCodecH264 and AVVideoCodecJPEG.  AVVideoCodecH264 is not supported on iPhone 3G.  For AVVideoScalingModeKey, the value AVVideoScalingModeFit is not supported.
   */
  convenience init(mediaType: String, outputSettings: [String : AnyObject]?)

  /*!
   @method initWithMediaType:outputSettings:sourceFormatHint:
   @abstract
  	Creates a new input of the specified media type to receive sample buffers for writing to the output file.  This is the designated initializer of AVAssetWriterInput.
   
   @param mediaType
  	The media type of samples that will be accepted by the input. Media types are defined in AVMediaFormat.h.
   @param outputSettings
  	The settings used for encoding the media appended to the output.  See AVAudioSettings.h for AVMediaTypeAudio or AVVideoSettings.h for AVMediaTypeVideo and for more information on how to construct an output settings dictionary.  If you only require simple preset-based output settings, see AVOutputSettingsAssistant.
   @param sourceFormatHint
  	A hint about the format of media data that will be appended to the new input.
   @result
  	An instance of AVAssetWriterInput.
   
   @discussion
  	A version of -initWithMediaType:outputSettings: that includes the ability to hint at the format of media data that will be appended to the new instance of AVAssetWriterInput.  When a source format hint is provided, the outputSettings dictionary is not required to be fully specified.  For AVMediaTypeAudio, this means that AVFormatIDKey is the only required key.  For AVMediaTypeVideo, this means that AVVideoCodecKey is the only required key.  Values for the remaining keys will be chosen by the asset writer input, with consideration given to the attributes of the source format.  To guarantee successful file writing, clients who specify a format hint should ensure that subsequently-appended buffers are of the specified format.
   
  	An NSInvalidArgumentException will be thrown if the media type of the format description does not match the media type string passed into this method.
   */
  @available(iOS 6.0, *)
  init(mediaType: String, outputSettings: [String : AnyObject]?, sourceFormatHint: CMFormatDescription?)

  /*!
   @property mediaType
   @abstract
  	The media type of the samples that can be appended to the receiver.
   
   @discussion
  	The value of this property is one of the media type strings defined in AVMediaFormat.h.
   */
  var mediaType: String { get }

  /*!
   @property outputSettings
   @abstract
  	The settings used for encoding the media appended to the output.
   
   @discussion
  	The value of this property is an NSDictionary that contains values for keys as specified by either AVAudioSettings.h for AVMediaTypeAudio or AVVideoSettings.h for AVMediaTypeVideo.  A value of nil indicates that the receiver will pass through appended samples, doing no processing before they are written to the output file.
  */
  var outputSettings: [String : AnyObject]? { get }

  /*!
   @property sourceFormatHint
   @abstract
  	 The hint given at initialization time about the format of incoming media data.
   
   @discussion
  	AVAssetWriterInput may be able to use this hint to fill in missing output settings or perform more upfront validation.  To guarantee successful file writing, clients who specify a format hint should ensure that subsequently-appended media data are of the specified format.
   */
  @available(iOS 6.0, *)
  var sourceFormatHint: CMFormatDescription? { get }

  /*!
   @property metadata
   @abstract
  	A collection of metadata to be written to the track corresponding to the receiver. 
  
   @discussion
  	The value of this property is an array of AVMetadataItem objects representing the collection of track-level metadata to be written in the output file.
  
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
   */
  var metadata: [AVMetadataItem]

  /*!
   @property readyForMoreMediaData
   @abstract
  	Indicates the readiness of the input to accept more media data.
   
   @discussion
      When there are multiple inputs, AVAssetWriter tries to write media data in an ideal interleaving pattern for efficiency in storage and playback. Each of its inputs signals its readiness to receive media data for writing according to that pattern via the value of readyForMoreMediaData. You can append media data to an input only while its readyForMoreMediaData property is YES.
   
      Clients writing media data from a non-real-time source, such as an instance of AVAssetReader, should hold off on generating or obtaining more media data to append to an input when the value of readyForMoreMediaData is NO. To help with control of the supply of non-real-time media data, such clients can use -requestMediaDataWhenReadyOnQueue:usingBlock in order to specify a block that the input should invoke whenever it's ready for input to be appended.
  
      Clients writing media data from a real-time source, such as an instance of AVCaptureOutput, should set the input's expectsMediaDataInRealTime property to YES to ensure that the value of readyForMoreMediaData is calculated appropriately. When expectsMediaDataInRealTime is YES, readyForMoreMediaData will become NO only when the input cannot process media samples as quickly as they are being provided by the client. If readyForMoreMediaData becomes NO for a real-time source, the client may need to drop samples or consider reducing the data rate of appended samples.
   
  	When the value of canPerformMultiplePasses is YES for any input attached to this input's asset writer, the value for this property may start as NO and/or be NO for long periods of time.
   
      The value of readyForMoreMediaData will often change from NO to YES asynchronously, as previously supplied media data is processed and written to the output.  It is possible for all of an AVAssetWriter's AVAssetWriterInputs temporarily to return NO for readyForMoreMediaData.
  	
      This property is key value observable. Observers should not assume that they will be notified of changes on a specific thread.
   */
  var isReadyForMoreMediaData: Bool { get }

  /*!
   @property expectsMediaDataInRealTime
   @abstract
  	Indicates whether the input should tailor its processing of media data for real-time sources.
  
   @discussion
      Clients appending media data to an input from a real-time source, such as an AVCaptureOutput, should set expectsMediaDataInRealTime to YES. This will ensure that readyForMoreMediaData is calculated appropriately for real-time usage.
   
  	For best results, do not set both this property and performsMultiPassEncodingIfSupported to YES.
   
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
   */
  var expectsMediaDataInRealTime: Bool

  /*!
   @method requestMediaDataWhenReadyOnQueue:usingBlock:
   @abstract
  	Instructs the receiver to invoke a client-supplied block repeatedly, at its convenience, in order to gather media data for writing to the output file.
  
   @param queue
  	The queue on which the block should be invoked.
   @param block
  	The block the input should invoke to obtain media data.
  
   @discussion
  	The block should append media data to the input either until the input's readyForMoreMediaData property becomes NO or until there is no more media data to supply (at which point it may choose to mark the input as finished via -markAsFinished). The block should then exit. After the block exits, if the input has not been marked as finished, once the input has processed the media data it has received and becomes ready for more media data again, it will invoke the block again in order to obtain more.
   
      A typical use of this method, with a block that supplies media data to an input while respecting the input's readyForMoreMediaData property, might look like this:
  
      [myAVAssetWriterInput requestMediaDataWhenReadyOnQueue:myInputSerialQueue usingBlock:^{
          while ([myAVAssetWriterInput isReadyForMoreMediaData])
          {
              CMSampleBufferRef nextSampleBuffer = [self copyNextSampleBufferToWrite];
              if (nextSampleBuffer)
              {
                  [myAVAssetWriterInput appendSampleBuffer:nextSampleBuffer];
                  CFRelease(nextSampleBuffer);
              }
              else
              {
                  [myAVAssetWriterInput markAsFinished];
                  break;
              }
          }
      }];
   
  	This method is not recommended for use with a push-style buffer source, such as AVCaptureAudioDataOutput or AVCaptureVideoDataOutput, because such a combination will likely require intermediate queueing of buffers.  Instead, this method is better suited to a pull-style buffer source such as AVAssetReaderOutput, as illustrated in the above example.
   
  	When using a push-style buffer source, it is generally better to immediately append each buffer to the AVAssetWriterInput, directly via -[AVAssetWriter appendSampleBuffer:], as it is received.  Using this strategy, it is often possible to avoid  having to queue up buffers in between the buffer source and the AVAssetWriterInput.  Note that many of these push-style buffer sources also produce buffers in real-time, in which case the client should set expectsMediaDataInRealTime to YES.
   
  	Before calling this method, you must ensure that the receiver is attached to an AVAssetWriter via a prior call to -addInput: and that -startWriting has been called on the asset writer.
   */
  func requestMediaDataWhenReadyOn(queue: dispatch_queue_t, usingBlock block: () -> Void)

  /*!
   @method appendSampleBuffer:
   @abstract
  	Appends samples to the receiver.
  
   @param sampleBuffer
  	The CMSampleBuffer to be appended.
   @result
  	A BOOL value indicating success of appending the sample buffer. If a result of NO is returned, clients can check the value of AVAssetWriter.status to determine whether the writing operation completed, failed, or was cancelled.  If the status is AVAssetWriterStatusFailed, AVAsset.error will contain an instance of NSError that describes the failure.
   
   @discussion
  	The timing information in the sample buffer, considered relative to the time passed to -[AVAssetWriter startSessionAtSourceTime:], will be used to determine the timing of those samples in the output file.
   
  	The receiver will retain the CMSampleBuffer until it is done with it, and then release it.  Do not modify a CMSampleBuffer or its contents after you have passed it to this method.
   
  	If the sample buffer contains audio data and the AVAssetWriterInput was intialized with an outputSettings dictionary then the format must be linear PCM. If the outputSettings dictionary was nil then audio data can be provided in a compressed format, and it will be passed through to the output without any re-compression. Note that advanced formats like AAC will have encoder delay present in their bitstreams. This data is inserted by the encoder and is necessary for proper decoding, but it is not meant to be played back. Clients who provide compressed audio bitstreams must use kCMSampleBufferAttachmentKey_TrimDurationAtStart to mark the encoder delay (generally restricted to the first sample buffer). Packetization can cause there to be extra audio frames in the last packet which are not meant to be played back. These remainder frames should be marked with kCMSampleBufferAttachmentKey_TrimDurationAtEnd. CMSampleBuffers obtained from AVAssetReader will already have the necessary trim attachments. Please see http://developer.apple.com/mac/library/technotes/tn2009/tn2258.html for more information about encoder delay. When attaching trims make sure that the output PTS of the sample buffer is what you expect. For example if you called -[AVAssetWriter startSessionAtSourceTime:kCMTimeZero] and you want your audio to start at time zero in the output file then make sure that the output PTS of the first non-fully trimmed audio sample buffer is kCMTimeZero.
  	
  	If the sample buffer contains a CVPixelBuffer then the choice of pixel format will affect the performance and quality of the encode. For optimal performance the format of the pixel buffer should match one of the native formats supported by the selected video encoder. Below are some recommendations:
   
  	The H.264 encoder natively supports kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange and kCVPixelFormatType_420YpCbCr8BiPlanarFullRange, which should be used with video and full range input respectively. The JPEG encoder on iOS natively supports kCVPixelFormatType_422YpCbCr8FullRange. For other video codecs on OSX, kCVPixelFormatType_422YpCbCr8 is the preferred pixel format for video and is generally the most performant when encoding. If you need to work in the RGB domain then kCVPixelFormatType_32BGRA is recommended on iOS and kCVPixelFormatType_32ARGB is recommended on OSX.
  
  	Pixel buffers not in a natively supported format will be converted internally prior to encoding when possible. Pixel format conversions within the same range (video or full) are generally faster than conversions between different ranges.
   
  	The ProRes encoders can preserve high bit depth sources, supporting up to 12bits/ch. ProRes 4444 can contain a mathematically lossless alpha channel and it doesn't do any chroma subsampling. This makes ProRes 4444 ideal for quality critical applications. If you are working with 8bit sources ProRes is also a good format to use due to its high image quality. Use either of the recommended pixel formats above. Note that RGB pixel formats by definition have 4:4:4 chroma sampling.
   
   	If you are working with high bit depth sources the following yuv pixel formats are recommended when encoding to ProRes: kCVPixelFormatType_4444AYpCbCr16, kCVPixelFormatType_422YpCbCr16, and kCVPixelFormatType_422YpCbCr10. When working in the RGB domain kCVPixelFormatType_64ARGB is recommended. Scaling and color matching are not currently supported when using AVAssetWriter with any of these high bit depth pixel formats. Please make sure that your track's output settings dictionary specifies the same width and height as the buffers you will be appending. Do not include AVVideoScalingModeKey or AVVideoColorPropertiesKey.
  
  	As of OS X 10.10 and iOS 8.0, this method can be used to add sample buffers that reference existing data in a file instead of containing media data to be appended to the file. This can be used to generate tracks that are not self-contained. In order to append such a sample reference to the track create a CMSampleBufferRef with a NULL dataBuffer and dataReady set to true and set the kCMSampleBufferAttachmentKey_SampleReferenceURL and kCMSampleBufferAttachmentKey_SampleReferenceByteOffset attachments on the sample buffer. Further documentation on how to create such a "sample reference" sample buffer can be found in the description of the kCMSampleBufferAttachmentKey_SampleReferenceURL and kCMSampleBufferAttachmentKey_SampleReferenceByteOffset attachment keys in the CMSampleBuffer documentation.
  
  	Before calling this method, you must ensure that the receiver is attached to an AVAssetWriter via a prior call to -addInput: and that -startWriting has been called on the asset writer.  It is an error to invoke this method before starting a session (via -[AVAssetWriter startSessionAtSourceTime:]) or after ending a session (via -[AVAssetWriter endSessionAtSourceTime:]).
   */
  func append(sampleBuffer: CMSampleBuffer) -> Bool

  /*!
   @method markAsFinished
   @abstract
  	Indicates to the AVAssetWriter that no more buffers will be appended to this input.
  
   @discussion
  	Clients that are monitoring each input's readyForMoreMediaData value must call markAsFinished on an input when they are done appending buffers to it.  This is necessary to prevent other inputs from stalling, as they may otherwise wait forever for that input's media data, attempting to complete the ideal interleaving pattern.
   
  	After invoking this method from the serial queue passed to -requestMediaDataWhenReadyOnQueue:usingBlock:, the receiver is guaranteed to issue no more invocations of the block passed to that method.  The same is true of -respondToEachPassDescriptionOnQueue:usingBlock:.
   
  	Before calling this method, you must ensure that the receiver is attached to an AVAssetWriter via a prior call to -addInput: and that -startWriting has been called on the asset writer.
   */
  func markAsFinished()
}
extension AVAssetWriterInput {

  /*!
   @property languageCode
   @abstract
  	Indicates the language to associate with the track corresponding to the receiver, as an ISO 639-2/T language code; can be nil.
   
   @discussion
  	Also see extendedLanguageTag below.
  
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
   */
  @available(iOS 7.0, *)
  var languageCode: String?

  /*!
   @property extendedLanguageTag
   @abstract
  	Indicates the language tag to associate with the track corresponding to the receiver, as an IETF BCP 47 (RFC 4646) language identifier; can be nil.
   
   @discussion
  	Extended language tags are normally set only when an ISO 639-2/T language code by itself is ambiguous, as in cases in which media data should be distinguished not only by language but also by the regional dialect in use or the writing system employed.
  
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.	
   */
  @available(iOS 7.0, *)
  var extendedLanguageTag: String?
}
extension AVAssetWriterInput {

  /*!
   @property naturalSize
   @abstract
  	The size specified in the output file as the natural dimensions of the visual media data for display purposes.
   
   @discussion
  	If the default value, CGSizeZero, is specified, the naturalSize of the track corresponding to the receiver is set according to dimensions indicated by the format descriptions that are ultimately written to the output track.
  
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
  */
  @available(iOS 7.0, *)
  var naturalSize: CGSize

  /*!
   @property transform
   @abstract
  	The transform specified in the output file as the preferred transformation of the visual media data for display purposes.
   
   @discussion
  	If no value is specified, the identity transform is used.
  
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
  */
  var transform: CGAffineTransform
}
extension AVAssetWriterInput {

  /*!
   @property preferredVolume
   @abstract
  	The preferred volume level to be stored in the output file.
   
   @discussion
  	The value for this property should typically be in the range of 0.0 to 1.0.  The default value is 1.0, which is equivalent to a "normal" volume level for audio media type. For all other media types the default value is 0.0.
   
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
   */
  @available(iOS 7.0, *)
  var preferredVolume: Float
}
extension AVAssetWriterInput {

  /*!
   @property marksOutputTrackAsEnabled
   @abstract
  	For file types that support enabled and disabled tracks, such as QuickTime Movie files, specifies whether the track corresponding to the receiver should be enabled by default for playback and processing. The default value is YES.
   
   @discussion
  	When an input group is added to an AVAssetWriter (see -[AVAssetWriter addInputGroup:]), the value of marksOutputTrackAsEnabled will automatically be set to YES for the default input and set to NO for all of the other inputs in the group.  In this case, if a new value is set on this property then an exception will be raised.
  
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
   */
  @available(iOS 7.0, *)
  var marksOutputTrackAsEnabled: Bool

  /*!
   @property mediaTimeScale
   @abstract
  	For file types that support media time scales, such as QuickTime Movie files, specifies the media time scale to be used.
  
   @discussion
  	The default value is 0, which indicates that the receiver should choose a convenient value, if applicable.  It is an error to set a value other than 0 if the receiver has media type AVMediaTypeAudio.
  
  	This property cannot be set after writing has started.
   */
  @available(iOS 4.3, *)
  var mediaTimeScale: CMTimeScale

  /*!
   @property preferredMediaChunkDuration
   @abstract
  	For file types that support media chunk duration, such as QuickTime Movie files, specifies the duration to be used for each chunk of sample data in the output file.
   
   @discussion
  	Chunk duration can influence the granularity of the I/O performed when reading a media file, e.g. during playback.  A larger chunk duration can result in fewer reads from disk, at the potential expense of a higher memory footprint.
   
  	A "chunk" contains one or more samples.  The total duration of the samples in a chunk is no greater than this preferred chunk duration, or the duration of a single sample if the sample's duration is greater than this preferred chunk duration.
   
  	The default value is kCMTimeInvalid, which means that the receiver will choose an appropriate default value.  It is an error to set a chunk duration that is negative or non-numeric.
  
  	This property cannot be set after -startWriting has been called on the receiver.
   */
  @available(iOS 8.0, *)
  var preferredMediaChunkDuration: CMTime

  /*!
   @property preferredMediaChunkAlignment
   @abstract
  	For file types that support media chunk alignment, such as QuickTime Movie files, specifies the boundary for media chunk alignment in bytes (e.g. 512).
   
   @discussion
  	The default value is 0, which means that the receiver will choose an appropriate default value.  A value of 1 implies that no padding should be used to achieve a particular chunk alignment.  It is an error to set a negative value for chunk alignment.
   
  	This property cannot be set after -startWriting has been called on the receiver.
   */
  @available(iOS 8.0, *)
  var preferredMediaChunkAlignment: Int

  /*!
   @property sampleReferenceBaseURL
   @abstract
  	For file types that support writing sample references, such as QuickTime Movie files, specifies the base URL sample references are relative to.
  
   @discussion
  	If the value of this property can be resolved as an absolute URL, the sample locations written to the file when appending sample references will be relative to this URL. The URL must point to a location that is in a directory that is a parent of the sample reference location. 
  
  	Usage example:
  
  	Setting the sampleReferenceBaseURL property to "file:///User/johnappleseed/Movies/" and appending sample buffers with the kCMSampleBufferAttachmentKey_SampleReferenceURL attachment set to "file:///User/johnappleseed/Movies/data/movie1.mov" will cause the sample reference "data/movie1.mov" to be written to the movie.
  
  	If the value of the property cannot be resolved as an absolute URL or if it points to a location that is not in a parent directory of the sample reference location, the location referenced in the sample buffer will be written unmodified.
  
   	The default value is nil, which means that the location referenced in the sample buffer will be written unmodified.
   
  	This property cannot be set after -startWriting has been called on the receiver.
   */
  @available(iOS 8.0, *)
  @NSCopying var sampleReferenceBaseURL: URL?
}
extension AVAssetWriterInput {

  /*!
   @method canAddTrackAssociationWithTrackOfInput:type:
   @abstract
  	Tests whether an association between the tracks corresponding to a pair of inputs is valid.
  
   @param input
  	The instance of AVAssetWriterInput with a corresponding track to associate with track corresponding with the receiver.
   @param trackAssociationType
  	The type of track association to test. Common track association types, such as AVTrackAssociationTypeTimecode, are defined in AVAssetTrack.h.
  
   @discussion
  	If the type of association requires tracks of specific media types that don't match the media types of the inputs, or if the output file type does not support track associations, -canAddTrackAssociationWithTrackOfInput:type: will return NO.
   */
  @available(iOS 7.0, *)
  func canAddTrackAssociationWithTrackOf(input: AVAssetWriterInput, type trackAssociationType: String) -> Bool

  /*!
   @method addTrackAssociationWithTrackOfInput:type:
   @abstract
  	Associates the track corresponding to the specified input with the track corresponding with the receiver.
  
   @param input
  	The instance of AVAssetWriterInput with a corresponding track to associate with track corresponding to the receiver.
   @param trackAssociationType
  	The type of track association to add. Common track association types, such as AVTrackAssociationTypeTimecode, are defined in AVAssetTrack.h.
  
   @discussion
  	If the type of association requires tracks of specific media types that don't match the media types of the inputs, or if the output file type does not support track associations, an NSInvalidArgumentException is raised.
  
  	Track associations cannot be added after writing on the receiver's AVAssetWriter has started.
   */
  @available(iOS 7.0, *)
  func addTrackAssociationWithTrackOf(input: AVAssetWriterInput, type trackAssociationType: String)
}
extension AVAssetWriterInput {

  /*!
   @property performsMultiPassEncodingIfSupported
   @abstract
  	Indicates whether the input should attempt to encode the source media data using multiple passes.
   
   @discussion
  	The input may be able to achieve higher quality and/or lower data rate by performing multiple passes over the source media.  It does this by analyzing the media data that has been appended and re-encoding certain segments with different parameters.  In order to do this re-encoding, the media data for these segments must be appended again.  See -markCurrentPassAsFinished and the property currentPassDescription for the mechanism by which the input nominates segments for re-appending.
   
  	When the value of this property is YES, the value of readyForMoreMediaData for other inputs attached to the same AVAssetWriter may be NO more often and/or for longer periods of time.  In particular, the value of readyForMoreMediaData for inputs that do not (or cannot) perform multiple passes may start out as NO after -[AVAssetWriter startWriting] has been called and may not change to YES until after all multi-pass inputs have completed their final pass.
   
  	When the value of this property is YES, the input may store data in one or more temporary files before writing compressed samples to the output file.  Use the AVAssetWriter property directoryForTemporaryFiles if you need to control the location of temporary file writing.
   
  	The default value is NO, meaning that no additional analysis will occur and no segments will be re-encoded.  Not all asset writer input configurations (for example, inputs configured with certain media types or to use certain encoders) can benefit from performing multiple passes over the source media.  To determine whether the selected encoder can perform multiple passes, query the value of canPerformMultiplePasses after calling -startWriting.
   
  	For best results, do not set both this property and expectsMediaDataInRealTime to YES.
  
  	This property cannot be set after writing on the receiver's AVAssetWriter has started.
   */
  @available(iOS 8.0, *)
  var performsMultiPassEncodingIfSupported: Bool

  /*!
   @property canPerformMultiplePasses
   @abstract
  	Indicates whether the input might perform multiple passes over appended media data.
  
   @discussion
  	When the value for this property is YES, your source for media data should be configured for random access.  After appending all of the media data for the current pass (as specified by the currentPassDescription property), call -markCurrentPassAsFinished to start the process of determining whether additional passes are needed.  Note that it is still possible in this case for the input to perform only the initial pass, if it determines that there will be no benefit to performing multiple passes.
   
  	When the value for this property is NO, your source for media data only needs to support sequential access.  In this case, append all of the source media once and call -markAsFinished.
   
  	In the default configuration of AVAssetWriterInput, the value for this property will be NO.  Currently the only way for this property to become YES is when performsMultiPassEncodingIfSupported has been set to YES.  The final value will be available after -startWriting is called, when a specific encoder has been choosen.
   
  	This property is key-value observable.
   */
  @available(iOS 8.0, *)
  var canPerformMultiplePasses: Bool { get }

  /*!
   @property currentPassDescription
   @abstract
  	Provides an object that describes the requirements, such as source time ranges to append or re-append, for the current pass.
   
   @discussion
  	If the value of this property is nil, it means there is no request to be fulfilled and -markAsFinished should be called on the asset writer input.
   
  	During the first pass, the request will contain a single time range from zero to positive infinity, indicating that all media from the source should be appended.  This will also be true when canPerformMultiplePasses is NO, in which case only one pass will be performed.
   
  	The value of this property will be nil before -startWriting is called on the attached asset writer.  It will transition to an initial non-nil value during the call to -startWriting.  After that, the value of this property will change only after a call to -markCurrentPassAsFinished.  For an easy way to be notified at the beginning of each pass, see -respondToEachPassDescriptionOnQueue:usingBlock:.
   
  	This property is key-value observable.  Observers should not assume that they will be notified of changes on a specific thread.
   */
  @available(iOS 8.0, *)
  var currentPassDescription: AVAssetWriterInputPassDescription? { get }

  /*!
   @method respondToEachPassDescriptionOnQueue:usingBlock:
   @abstract
  	Instructs the receiver to invoke a client-supplied block whenever a new pass has begun.
   
   @param queue
  	The queue on which the block should be invoked.
   @param block
  	A block the receiver should invoke whenever a new pass has begun.
  
   @discussion
  	A typical block passed to this method will perform the following steps:
  
  		1. Query the value of the receiver's currentPassDescription property and reconfigure the source of media data (e.g. AVAssetReader) accordingly
  		2. Call -requestMediaDataWhenReadyOnQueue:usingBlock: to begin appending data for the current pass
  		3. Exit
  
  	When all media data has been appended for the current request, call -markCurrentPassAsFinished to begin the process of determining whether an additional pass is warranted.  If an additional pass is warranted, the block passed to this method will be invoked to begin the next pass.  If no additional passes are needed, the block passed to this method will be invoked one final time so the client can invoke -markAsFinished in response to the value of currentPassDescription becoming nil.
   
  	Before calling this method, you must ensure that the receiver is attached to an AVAssetWriter via a prior call to -addInput: and that -startWriting has been called on the asset writer.
   */
  @available(iOS 8.0, *)
  func respondToEachPassDescriptionOn(queue: dispatch_queue_t, usingBlock block: dispatch_block_t)

  /*!
   @method markCurrentPassAsFinished
   @abstract
  	Instructs the receiver to analyze the media data that has been appended and determine whether the results could be improved by re-encoding certain segments.
   
   @discussion
  	When the value of canPerformMultiplePasses is YES, call this method after you have appended all of your media data.  After the receiver analyzes whether an additional pass is warranted, the value of currentPassDescription will change (usually asynchronously) to describe how to set up for the next pass.  Although it is possible to use key-value observing to determine when the value of currentPassDescription has changed, it is typically more convenient to invoke -respondToEachPassDescriptionOnQueue:usingBlock: in order to start the work for each pass.
   
  	After re-appending the media data for all of the time ranges of the new pass, call this method again to determine whether additional segments should be re-appended in another pass.
   
  	Calling this method effectively cancels any previous invocation of -requestMediaDataWhenReadyOnQueue:usingBlock:, meaning that -requestMediaDataWhenReadyOnQueue:usingBlock: can be invoked again for each new pass.  -respondToEachPassDescriptionOnQueue:usingBlock: provides a convenient way to consolidate these invocations in your code.
   
  	After each pass, you have the option of keeping the most recent results by calling -markAsFinished instead of this method.  If the value of currentPassDescription is nil at the beginning of a pass, call -markAsFinished to tell the receiver to not expect any further media data.
   
  	If the value of canPerformMultiplePasses is NO, the value of currentPassDescription will immediately become nil after calling this method.
  
  	Before calling this method, you must ensure that the receiver is attached to an AVAssetWriter via a prior call to -addInput: and that -startWriting has been called on the asset writer.
   */
  @available(iOS 8.0, *)
  func markCurrentPassAsFinished()
}

/*!
 @class AVAssetWriterInputPassDescription
 @abstract
	Defines an interface for querying information about the requirements of the current pass, such as the time ranges of media data to append.
 */
@available(iOS 8.0, *)
class AVAssetWriterInputPassDescription : Object {

  /*!
   @property sourceTimeRanges
   @abstract
  	An NSArray of NSValue objects wrapping CMTimeRange structures, each representing one source time range.
   
   @discussion
  	The value of this property is suitable for using as a parameter for -[AVAssetReaderOutput resetForReadingTimeRanges:].
   */
  var sourceTimeRanges: [Value] { get }
}

/*!
 @class AVAssetWriterInputPixelBufferAdaptor
 @abstract
	Defines an interface for appending video samples packaged as CVPixelBuffer objects to a single AVAssetWriterInput object.
 
 @discussion
	Instances of AVAssetWriterInputPixelBufferAdaptor provide a CVPixelBufferPool that can be used to allocate pixel buffers for writing to the output file.  Using the provided pixel buffer pool for buffer allocation is typically more efficient than appending pixel buffers allocated using a separate pool.
 */
@available(iOS 4.1, *)
class AVAssetWriterInputPixelBufferAdaptor : Object {

  /*!
   @method initWithAssetWriterInput:sourcePixelBufferAttributes:
   @abstract
  	Creates a new pixel buffer adaptor to receive pixel buffers for writing to the output file.
  
   @param input
  	An instance of AVAssetWriterInput to which the receiver should append pixel buffers.  Currently, only asset writer inputs that accept media data of type AVMediaTypeVideo can be used to initialize a pixel buffer adaptor.
   @param sourcePixelBufferAttributes
  	Specifies the attributes of pixel buffers that will be vended by the input's CVPixelBufferPool.
   @result
  	An instance of AVAssetWriterInputPixelBufferAdaptor.
  
   @discussion
  	In order to take advantage of the improved efficiency of appending buffers created from the adaptor's pixel buffer pool, clients should specify pixel buffer attributes that most closely accommodate the source format of the video frames being appended.
  
  	Pixel buffer attributes keys for the pixel buffer pool are defined in <CoreVideo/CVPixelBuffer.h>. To specify the pixel format type, the pixelBufferAttributes dictionary should contain a value for kCVPixelBufferPixelFormatTypeKey.  For example, use [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] for 8-bit-per-channel BGRA. See the discussion under appendPixelBuffer:withPresentationTime: for advice on choosing a pixel format.
  
  	Clients that do not need a pixel buffer pool for allocating buffers should set sourcePixelBufferAttributes to nil.
  	
  	It is an error to initialize an instance of AVAssetWriterInputPixelBufferAdaptor with an asset writer input that is already attached to another instance of AVAssetWriterInputPixelBufferAdaptor.  It is also an error to initialize an instance of AVAssetWriterInputPixelBufferAdaptor with an asset writer input whose asset writer has progressed beyond AVAssetWriterStatusUnknown.
   */
  init(assetWriterInput input: AVAssetWriterInput, sourcePixelBufferAttributes: [String : AnyObject]? = [:])

  /*!
   @property assetWriterInput
   @abstract
  	The asset writer input to which the receiver should append pixel buffers.
   */
  var assetWriterInput: AVAssetWriterInput { get }

  /*!
   @property sourcePixelBufferAttributes
   @abstract
  	The pixel buffer attributes of pixel buffers that will be vended by the receiver's CVPixelBufferPool.
  
   @discussion
  	The value of this property is a dictionary containing pixel buffer attributes keys defined in <CoreVideo/CVPixelBuffer.h>.
   */
  var sourcePixelBufferAttributes: [String : AnyObject]? { get }

  /*!
   @property pixelBufferPool
   @abstract
  	A pixel buffer pool that will vend and efficiently recycle CVPixelBuffer objects that can be appended to the receiver.
  
   @discussion
  	For maximum efficiency, clients should create CVPixelBuffer objects for appendPixelBuffer:withPresentationTime: by using this pool with the CVPixelBufferPoolCreatePixelBuffer() function.
  	
  	The value of this property will be NULL before -[AVAssetWriter startWriting] is called on the associated AVAssetWriter object.
  	
  	This property is key value observable.
   */
  var pixelBufferPool: CVPixelBufferPool? { get }

  /*!
   @method appendPixelBuffer:withPresentationTime:
   @abstract
  	Appends a pixel buffer to the receiver.
  
   @param pixelBuffer
  	The CVPixelBuffer to be appended.
   @param presentationTime
  	The presentation time for the pixel buffer to be appended.  This time will be considered relative to the time passed to -[AVAssetWriter startSessionAtSourceTime:] to determine the timing of the frame in the output file.
   @result
  	A BOOL value indicating success of appending the pixel buffer. If a result of NO is returned, clients can check the value of AVAssetWriter.status to determine whether the writing operation completed, failed, or was cancelled.  If the status is AVAssetWriterStatusFailed, AVAsset.error will contain an instance of NSError that describes the failure.
  
   @discussion
  	The receiver will retain the CVPixelBuffer until it is done with it, and then release it.  Do not modify a CVPixelBuffer or its contents after you have passed it to this method.
  	
  	For optimal performance the format of the pixel buffer should match one of the native formats supported by the selected video encoder. Below are some recommendations:
   
  	The H.264 encoder natively supports kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange and kCVPixelFormatType_420YpCbCr8BiPlanarFullRange, which should be used with video and full range input respectively. The JPEG encoder on iOS natively supports kCVPixelFormatType_422YpCbCr8FullRange. For other video codecs on OSX, kCVPixelFormatType_422YpCbCr8 is the preferred pixel format for video and is generally the most performant when encoding. If you need to work in the RGB domain then kCVPixelFormatType_32BGRA is recommended on iOS and kCVPixelFormatType_32ARGB is recommended on OSX.
  
  	Pixel buffers not in a natively supported format will be converted internally prior to encoding when possible. Pixel format conversions within the same range (video or full) are generally faster than conversions between different ranges.
  
  	The ProRes encoders can preserve high bit depth sources, supporting up to 12bits/ch. ProRes 4444 can contain a mathematically lossless alpha channel and it doesn't do any chroma subsampling. This makes ProRes 4444 ideal for quality critical applications. If you are working with 8bit sources ProRes is also a good format to use due to its high image quality. Use either of the recommended pixel formats above. Note that RGB pixel formats by definition have 4:4:4 chroma sampling.
   
   	If you are working with high bit depth sources the following yuv pixel formats are recommended when encoding to ProRes: kCVPixelFormatType_4444AYpCbCr16, kCVPixelFormatType_422YpCbCr16, and kCVPixelFormatType_422YpCbCr10. When working in the RGB domain kCVPixelFormatType_64ARGB is recommended. Scaling and color matching are not currently supported when using AVAssetWriter with any of these high bit depth pixel formats. Please make sure that your track's output settings dictionary specifies the same width and height as the buffers you will be appending. Do not include AVVideoScalingModeKey or AVVideoColorPropertiesKey.
   
  	Before calling this method, you must ensure that the input that underlies the receiver is attached to an AVAssetWriter via a prior call to -addInput: and that -startWriting has been called on the asset writer.  It is an error to invoke this method before starting a session (via -[AVAssetWriter startSessionAtSourceTime:]) or after ending a session (via -[AVAssetWriter endSessionAtSourceTime:]).
   */
  func append(pixelBuffer: CVPixelBuffer, withPresentationTime presentationTime: CMTime) -> Bool
}

/*!
 @class AVAssetWriterInputMetadataAdaptor
 @abstract
	Defines an interface for writing metadata, packaged as instances of AVTimedMetadataGroup, to a single AVAssetWriterInput object.
 */
@available(iOS 8.0, *)
class AVAssetWriterInputMetadataAdaptor : Object {

  /*!
   @method initWithAssetWriterInput:
   @abstract
  	Creates a new timed metadator group adaptor to receive instances of AVTimedMetadataGroup for writing to the output file.
   
   @param input
  	An instance of AVAssetWriterInput to which the receiver should append groups of timed metadata. Only asset writer inputs that accept media data of type AVMediaTypeMetadata can be used to initialize a timed metadata group adaptor.
   @result
  	An instance of AVAssetWriterInputMetadataAdaptor.
   
   @discussion
  	The instance of AVAssetWriterInput passed in to this method must have been created with a format hint indicating all possible combinations of identifier (or, alternatively, key and keySpace), dataType, and extendedLanguageTag that will be appended to the metadata adaptor.  It is an error to append metadata items not represented in the input's format hint.  For help creating a suitable format hint, see -[AVTimedMetadataGroup copyFormatDescription].
  
  	It is an error to initialize an instance of AVAssetWriterInputMetadataAdaptor with an asset writer input that is already attached to another instance of AVAssetWriterInputMetadataAdaptor.  It is also an error to initialize an instance of AVAssetWriterInputMetadataAdaptor with an asset writer input whose asset writer has progressed beyond AVAssetWriterStatusUnknown.
   */
  init(assetWriterInput input: AVAssetWriterInput)

  /*!
   @property assetWriterInput
   @abstract
  	The asset writer input to which the receiver should append timed metadata groups.
   */
  var assetWriterInput: AVAssetWriterInput { get }

  /*!
   @method appendTimedMetadataGroup:
   @abstract
  	Appends a timed metadata group to the receiver.
   
   @param timedMetadataGroup
  	The AVTimedMetadataGroup to be appended.
   @result
  	A BOOL value indicating success of appending the timed metadata group.  If a result of NO is returned, AVAssetWriter.error will contain more information about why apending the timed metadata group failed.
   
   @discussion
  	The receiver will retain the AVTimedMetadataGroup until it is done with it, and then release it.
   
  	The timing of the metadata items in the output asset will correspond to the timeRange of the AVTimedMetadataGroup, regardless of the values of the time and duration properties of the individual items.
   
  	Before calling this method, you must ensure that the input that underlies the receiver is attached to an AVAssetWriter via a prior call to -addInput: and that -startWriting has been called on the asset writer.  It is an error to invoke this method before starting a session (via -[AVAssetWriter startSessionAtSourceTime:]) or after ending a session (via -[AVAssetWriter endSessionAtSourceTime:]).
   */
  func append(timedMetadataGroup: AVTimedMetadataGroup) -> Bool
}
enum AVKeyValueStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case Loading
  case Loaded
  case Failed
  case Cancelled
}

/*!
	@protocol	AVAsynchronousKeyValueLoading
 
	@abstract	The AVAsynchronousKeyValueLoading protocol defines methods that let clients use an AVAsset or AVAssetTrack object without blocking a thread. Using methods in the protocol, one can find out the current status of a key (for example, whether the corresponding value has been loaded); and ask the object to load values asynchronously, informing the client when the operation has completed.
 
	@discussion
		Because of the nature of timed audiovisual media, successful initialization of an asset does not necessarily mean that all its data is immediately available. Instead, an asset will wait to load data until an operation is performed on it (for example, directly invoking any relevant AVAsset methods, playback via an AVPlayerItem object, export using AVAssetExportSession, reading using an instance of AVAssetReader, and so on). This means that although you can request the value of any key at any time, and its value will be returned synchronously, the calling thread may be blocked until the request can be satisfied. To avoid blocking, you can:

			1. First, determine whether the value for a given key is available using statusOfValueForKey:error:.
			2. If a value has not been loaded yet, you can ask for to load one or more values and be notified when they become available using loadValuesAsynchronouslyForKeys:completionHandler:.
		
		Even for use cases that may typically support ready access to some keys (such as for assets initialized with URLs for files in the local filesystem), slow I/O may require AVAsset to block before returning their values. Although blocking may be acceptable for OS X API clients in cases where assets are being prepared on background threads or in operation queues, in all cases in which blocking should be avoided you should use loadValuesAsynchronouslyForKeys:completionHandler:. For iOS clients, blocking to obtain the value of a key synchronously is never recommended under any circumstances.
*/
protocol AVAsynchronousKeyValueLoading {

  /*!
    @method		statusOfValueForKey:
    @abstract		Reports whether the value for a key is immediately available without blocking.
    @param		key
      An instance of NSString containing the specified key.
    @param		outError
      If the status of the value for the key is AVKeyValueStatusFailed, *outError is set to a non-nil NSError that describes the failure that occurred.
    @result		The value's current loading status.
    @discussion
      Clients can use -statusOfValueForKey: to determine the availability of the value of any key of interest. However, this method alone does not prompt the receiver to load the value of a key that's not yet available. To request values for keys that may not already be loaded, without blocking, use -loadValuesAsynchronouslyForKeys:completionHandler:, await invocation of the completion handler, and test the availability of each key via -statusOfValueForKey: before invoking its getter.
   
      Even if access to values of some keys may be readily available, as can occur with receivers initialized with URLs for resources on local volumes, extensive I/O or parsing may be needed for these same receivers to provide values for other keys. A duration for a local MP3 file, for example, may be expensive to obtain, even if the values for other AVAsset properties may be trivial to obtain.
  
      Blocking that may occur when calling the getter for any key should therefore be avoided in the general case by loading values for all keys of interest via -loadValuesAsynchronouslyForKeys:completionHandler: and testing the availability of the requested values before fetching them by calling getters.
        
      The sole exception to this general rule is in usage on Mac OS X on the desktop, where it may be acceptable to block in cases in which the client is preparing objects for use on background threads or in operation queues. On iOS, values should always be loaded asynchronously prior to calling getters for the values, in any usage scenario.
  */
  func statusOfValueForKey(key: String, error outError: ErrorPointer) -> AVKeyValueStatus

  /*!
    @method		loadValuesAsynchronouslyForKeys:completionHandler:
    @abstract		Directs the target to load the values of any of the specified keys that are not already loaded.
    @param		keys
      An instance of NSArray, containing NSStrings for the specified keys.
    @param		completionHandler
      The block to be invoked when loading succeeds, fails, or is cancelled.
  */
  func loadValuesAsynchronouslyForKeys(keys: [String], completionHandler handler: (() -> Void)? = nil)
}

/*!
	@class AVAudioBuffer
	@abstract A buffer of audio data, with a format.
	@discussion
		AVAudioBuffer represents a buffer of audio data and its format.
*/
@available(iOS 8.0, *)
class AVAudioBuffer : Object, Copying, MutableCopying {

  /*!
  	@property format
  	@abstract The format of the audio in the buffer.
  */
  var format: AVAudioFormat { get }

  /*!	@property audioBufferList
  	@abstract The buffer's underlying AudioBufferList.
  	@discussion
  		For compatibility with lower-level CoreAudio and AudioToolbox API's, this method accesses
  		the buffer implementation's internal AudioBufferList. The buffer list structure must
  		not be modified, though you may modify buffer contents.
  		
  		The mDataByteSize fields of this AudioBufferList express the buffer's current frameLength.
  */
  var audioBufferList: UnsafePointer<AudioBufferList> { get }

  /*!	@property mutableAudioBufferList
  	@abstract A mutable version of the buffer's underlying AudioBufferList.
  	@discussion
  		Some lower-level CoreAudio and AudioToolbox API's require a mutable AudioBufferList,
  		for example, AudioConverterConvertComplexBuffer.
  		
  		The mDataByteSize fields of this AudioBufferList express the buffer's current frameCapacity.
  		If they are altered, you should modify the buffer's frameLength to match.
  */
  var mutableAudioBufferList: UnsafeMutablePointer<AudioBufferList> { get }
  init()
  @available(iOS 8.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 8.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}

/*!
	@class AVAudioPCMBuffer
	@abstract A subclass of AVAudioBuffer for use with PCM audio formats.
	@discussion
		AVAudioPCMBuffer provides a number of methods useful for manipulating buffers of
		audio in PCM format.
*/
@available(iOS 8.0, *)
class AVAudioPCMBuffer : AVAudioBuffer {

  /*!	@method initWithPCMFormat:frameCapacity:
  	@abstract Initialize a buffer that is to contain PCM audio samples.
  	@param format
  		The format of the PCM audio to be contained in the buffer.
  	@param frameCapacity
  		The capacity of the buffer in PCM sample frames.
  	@discussion
  		An exception is raised if the format is not PCM.
  */
  init(pcmFormat format: AVAudioFormat, frameCapacity: AVAudioFrameCount)

  /*! @property frameCapacity
  	@abstract
  		The buffer's capacity, in audio sample frames.
  */
  var frameCapacity: AVAudioFrameCount { get }

  /*!	@property frameLength
  	@abstract The current number of valid sample frames in the buffer.
  	@discussion
  		You may modify the length of the buffer as part of an operation that modifies its contents.
  		The length must be less than or equal to the frameCapacity. Modifying frameLength will update
  		the mDataByteSize in each of the underlying AudioBufferList's AudioBuffer's correspondingly,
  		and vice versa. Note that in the case of deinterleaved formats, mDataByteSize will refers
  		the size of one channel's worth of audio samples.
  */
  var frameLength: AVAudioFrameCount

  /*!	@property stride
  	@abstract The buffer's number of interleaved channels.
  	@discussion
  		Useful in conjunction with floatChannelData etc.
  */
  var stride: Int { get }

  /*! @property floatChannelData
  	@abstract Access the buffer's float audio samples.
  	@discussion
  		floatChannelData returns pointers to the buffer's audio samples if the buffer's format is
  		32-bit float, or nil if it is another format.
  	
  		The returned pointer is to format.channelCount pointers to float. Each of these pointers
  		is to "frameLength" valid samples, which are spaced by "stride" samples.
  		
  		If format.interleaved is false (as with the standard deinterleaved float format), then 
  		the pointers will be to separate chunks of memory. "stride" is 1.
  		
  		If format.interleaved is true, then the pointers will refer into the same chunk of interleaved
  		samples, each offset by 1 frame. "stride" is the number of interleaved channels.
  */
  var floatChannelData: UnsafePointer<UnsafeMutablePointer<Float>> { get }

  /*!	@property int16ChannelData
  	@abstract Access the buffer's int16_t audio samples.
  	@discussion
  		int16ChannelData returns the buffer's audio samples if the buffer's format has 2-byte
  		integer samples, or nil if it is another format.
  		
  		See the discussion of floatChannelData.
  */
  var int16ChannelData: UnsafePointer<UnsafeMutablePointer<Int16>> { get }

  /*!	@property int32ChannelData
  	@abstract Access the buffer's int32_t audio samples.
  	@discussion
  		int32ChannelData returns the buffer's audio samples if the buffer's format has 4-byte
  		integer samples, or nil if it is another format.
  		
  		See the discussion of floatChannelData.
  */
  var int32ChannelData: UnsafePointer<UnsafeMutablePointer<Int32>> { get }
  convenience init()
}

/*!
	@class AVAudioCompressedBuffer
	@abstract A subclass of AVAudioBuffer for use with compressed audio formats.
*/
@available(iOS 9.0, *)
class AVAudioCompressedBuffer : AVAudioBuffer {

  /*!	@method initWithFormat:packetCapacity:maximumPacketSize:
  	@abstract Initialize a buffer that is to contain compressed audio data. 
  	@param format
  		The format of the audio to be contained in the buffer.
  	@param packetCapacity
  		The capacity of the buffer in packets.
  	@param maximumPacketSize
  		The maximum size in bytes of a compressed packet. 
  		The maximum packet size can be obtained from the maximumOutputPacketSize property of an AVAudioConverter configured for encoding this format.
  	@discussion
  		An exception is raised if the format is PCM.
  */
  init(format: AVAudioFormat, packetCapacity: AVAudioPacketCount, maximumPacketSize: Int)

  /*!	@method initWithFormat:packetCapacity:
  	@abstract Initialize a buffer that is to contain constant bytes per packet compressed audio data.
  	@param format
  		The format of the audio to be contained in the buffer.
  	@param packetCapacity
  		The capacity of the buffer in packets.
  	@discussion
  		This fails if the format is PCM or if the format has variable bytes per packet (format.streamDescription->mBytesPerPacket == 0).
  */
  init(format: AVAudioFormat, packetCapacity: AVAudioPacketCount)

  /*! @property packetCapacity
  	@abstract
  		The number of compressed packets the buffer can contain.
  */
  var packetCapacity: AVAudioPacketCount { get }

  /*!	@property packetCount
  	@abstract The current number of compressed packets in the buffer.
  	@discussion
  		You may modify the packet length as part of an operation that modifies its contents.
  		The packet length must be less than or equal to the packetCapacity.
  */
  var packetCount: AVAudioPacketCount

  /*!	@property maximumPacketSize
  	@abstract The maximum size of a compressed packet in bytes.
  */
  var maximumPacketSize: Int { get }

  /*! @property data
  	@abstract Access the buffer's data bytes.
  */
  var data: UnsafeMutablePointer<Void> { get }

  /*! @property packetDescriptions
  	@abstract Access the buffer's array of packet descriptions, if any.
  	@discussion
  		If the format has constant bytes per packet (format.streamDescription->mBytesPerPacket != 0), then this will return nil.
  */
  var packetDescriptions: UnsafeMutablePointer<AudioStreamPacketDescription> { get }
  init()
}

/*!
	@class AVAudioChannelLayout
	@abstract A description of the roles of a set of audio channels.
	@discussion
		This object is a thin wrapper for the AudioChannelLayout structure, described
		in <CoreAudio/CoreAudioTypes.h>.
*/
@available(iOS 8.0, *)
class AVAudioChannelLayout : Object, SecureCoding {

  /*!	@method initWithLayoutTag:
  	@abstract Initialize from a layout tag.
  	@param layoutTag
  		The tag.
  */
  convenience init(layoutTag: AudioChannelLayoutTag)

  /*!	@method initWithLayout:
  	@abstract Initialize from an AudioChannelLayout.
  	@param layout
  		The AudioChannelLayout.
  	@discussion
  		If the provided layout's tag is kAudioChannelLayoutTag_UseChannelDescriptions, this
  		initializer attempts to convert it to a more specific tag.
  */
  init(layout: UnsafePointer<AudioChannelLayout>)

  /*!	@method isEqual:
  	@abstract Determine whether another AVAudioChannelLayout is exactly equal to this layout.
  	@param object
  		The AVAudioChannelLayout to compare against.
  	@discussion
  		The underlying AudioChannelLayoutTag and AudioChannelLayout are compared for equality.
  */
  func isEqual(object: AnyObject) -> Bool

  /*!	@property layoutTag
  	@abstract The layout's tag. */
  var layoutTag: AudioChannelLayoutTag { get }

  /*!	@property layout
  	@abstract The underlying AudioChannelLayout. */
  var layout: UnsafePointer<AudioChannelLayout> { get }

  /*! @property channelCount
  	@abstract The number of channels of audio data.
  */
  var channelCount: AVAudioChannelCount { get }
  convenience init()
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*! @class AVAudioConnectionPoint
	@abstract A representation of either a source or destination connection point in AVAudioEngine.
	@discussion
		AVAudioConnectionPoint describes either a source or destination connection point (node, bus)
		in AVAudioEngine's graph.
	
		Instances of this class are immutable.
*/
@available(iOS 9.0, *)
class AVAudioConnectionPoint : Object {

  /*! @method initWithNode:bus:
  	@abstract Create a connection point object.
  	@param node the source or destination node
  	@param bus the output or input bus on the node
  	@discussion
  		If the node is nil, this method fails (returns nil).
  */
  init(node: AVAudioNode, bus: AVAudioNodeBus)

  /*!	@property node
  	@abstract Returns the node in the connection point.
  */
  weak var node: @sil_weak AVAudioNode? { get }

  /*!	@property bus
  	@abstract Returns the bus on the node in the connection point.
  */
  var bus: AVAudioNodeBus { get }
  convenience init()
}

/*! @enum AVAudioConverterPrimeMethod
    @abstract values for the primeMethod property. See further discussion under AVAudioConverterPrimeInfo.
     
        AVAudioConverterPrimeMethod_Pre
            Primes with leading + trailing input frames.
     
        AVAudioConverterPrimeMethod_Normal
			Only primes with trailing (zero latency). Leading frames are assumed to be silence.
     
        AVAudioConverterPrimeMethod_None
			Acts in "latency" mode. Both leading and trailing frames assumed to be silence.
*/
enum AVAudioConverterPrimeMethod : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Pre
  case Normal
  case None
}

/*!
    @struct     AVAudioConverterPrimeInfo
    @abstract   This struct is the value of the primeInfo property and specifies priming information.
    
    @field      leadingFrames
        Specifies the number of leading (previous) input frames, relative to the normal/desired
        start input frame, required by the converter to perform a high quality conversion. If
        using AVAudioConverterPrimeMethod_Pre, the client should "pre-seek" the input stream provided
        through the input proc by leadingFrames. If no frames are available previous to the
        desired input start frame (because, for example, the desired start frame is at the very
        beginning of available audio), then provide "leadingFrames" worth of initial zero frames
        in the input proc.  Do not "pre-seek" in the default case of
        AVAudioConverterPrimeMethod_Normal or when using AVAudioConverterPrimeMethod_None.

    @field      trailingFrames
        Specifies the number of trailing input frames (past the normal/expected end input frame)
        required by the converter to perform a high quality conversion.  The client should be
        prepared to provide this number of additional input frames except when using
        AVAudioConverterPrimeMethod_None. If no more frames of input are available in the input stream
        (because, for example, the desired end frame is at the end of an audio file), then zero
        (silent) trailing frames will be synthesized for the client.
            
    @discussion
        When using convertToBuffer:error:withInputFromBlock: (either a single call or a series of calls), some
        conversions, particularly involving sample-rate conversion, ideally require a certain
        number of input frames previous to the normal start input frame and beyond the end of
        the last expected input frame in order to yield high-quality results.
        
        These are expressed in the leadingFrames and trailingFrames members of the structure.
        
        The very first call to convertToBuffer:error:withInputFromBlock:, or first call after
        reset, will request additional input frames beyond those normally
        expected in the input proc callback to fulfill this first AudioConverterFillComplexBuffer()
        request. The number of additional frames requested, depending on the prime method, will
        be approximately:

        <pre>
            AVAudioConverterPrimeMethod_Pre       leadingFrames + trailingFrames
            AVAudioConverterPrimeMethod_Normal    trailingFrames
            AVAudioConverterPrimeMethod_None      0
        </pre>

        Thus, in effect, the first input proc callback(s) may provide not only the leading
        frames, but also may "read ahead" by an additional number of trailing frames depending
        on the prime method.

        AVAudioConverterPrimeMethod_None is useful in a real-time application processing live input,
        in which case trailingFrames (relative to input sample rate) of through latency will be
        seen at the beginning of the output of the AudioConverter.  In other real-time
        applications such as DAW systems, it may be possible to provide these initial extra
        audio frames since they are stored on disk or in memory somewhere and
        AVAudioConverterPrimeMethod_Pre may be preferable.  The default method is
        AVAudioConverterPrimeMethod_Normal, which requires no pre-seeking of the input stream and
        generates no latency at the output.
*/
struct AVAudioConverterPrimeInfo {
  var leadingFrames: AVAudioFrameCount
  var trailingFrames: AVAudioFrameCount
  init()
  init(leadingFrames: AVAudioFrameCount, trailingFrames: AVAudioFrameCount)
}

/*! @enum AVAudioConverterInputStatus
    @abstract You must return one of these codes from your AVAudioConverterInputBlock.
     
        AVAudioConverterInputStatus_HaveData
            This is the normal case where you supply data to the converter.
     
        AVAudioConverterInputStatus_NoDataNow
			If you are out of data for now, set *ioNumberOfPackets = 0 and return AVAudioConverterInputStatus_NoDataNow and the 
			conversion routine will return as much output as could be converted with the input already supplied.
     
        AVAudioConverterInputStatus_EndOfStream
			If you are at the end of stream, set *ioNumberOfPackets = 0 and return AVAudioConverterInputStatus_EndOfStream.
*/
@available(iOS 9.0, *)
enum AVAudioConverterInputStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case HaveData
  case NoDataNow
  case EndOfStream
}

/*! @enum AVAudioConverterOutputStatus
    @abstract These values are returned from convertToBuffer:error:withInputFromBlock:

		AVAudioConverterOutputStatus_HaveData
			All of the requested data was returned.

		AVAudioConverterOutputStatus_InputRanDry
			Not enough input was available to satisfy the request at the current time. The output buffer contains as much as could be converted.
			
		AVAudioConverterOutputStatus_EndOfStream
			The end of stream has been reached. No data was returned.
		
		AVAudioConverterOutputStatus_Error
			An error occurred.
*/
@available(iOS 9.0, *)
enum AVAudioConverterOutputStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case HaveData
  case InputRanDry
  case EndOfStream
  case Error
}

/*! @typedef AVAudioConverterInputBlock
    @abstract A block which will be called by convertToBuffer:error:withInputFromBlock: to get input data as needed. 
	@param  inNumberOfPackets
		This will be the number of packets required to complete the request.
		You may supply more or less that this amount. If less, then the input block will get called again.
	@param outStatus
		The block must set the appropriate AVAudioConverterInputStatus enum value.
		If you have supplied data, set outStatus to AVAudioConverterInputStatus_HaveData and return an AVAudioBuffer.
		If you are out of data for now, set outStatus to AVAudioConverterInputStatus_NoDataNow and return nil, and the
		conversion routine will return as much output as could be converted with the input already supplied.
		If you are at the end of stream, set outStatus to AVAudioConverterInputStatus_EndOfStream, and return nil.
	@return
		An AVAudioBuffer containing data to be converted, or nil if at end of stream or no data is available.
		The data in the returned buffer must not be cleared or re-filled until the input block is called again or the conversion has finished.
	@discussion
		convertToBuffer:error:withInputFromBlock: will return as much output as could be converted with the input already supplied.
*/
typealias AVAudioConverterInputBlock = (AVAudioPacketCount, UnsafeMutablePointer<AVAudioConverterInputStatus>) -> AVAudioBuffer?

/*!
	@class AVAudioConverter
	@abstract
		AVAudioConverter converts streams of audio between various formats.
	@discussion
*/
@available(iOS 9.0, *)
class AVAudioConverter : Object {

  /*!	@method initFromFormat:toFormat:
  	@abstract Initialize from input and output formats.
  	@param fromFormat 
  		The input format.
  	@param toFormat 
  		The output format.
  */
  init(from fromFormat: AVAudioFormat, to toFormat: AVAudioFormat)

  /*! @method reset
      @abstract Resets the converter so that a new stream may be converted.
  */
  func reset()

  /*! @property inputFormat
      @abstract The format of the input audio stream. (NB. AVAudioFormat includes the channel layout)
  */
  var inputFormat: AVAudioFormat { get }

  /*! @property outputFormat
      @abstract The format of the output audio stream. (NB. AVAudioFormat includes the channel layout)
  */
  var outputFormat: AVAudioFormat { get }

  /*! @property channelMap
      @abstract An array of integers indicating from which input to derive each output.
  	@discussion 
  		The array has size equal to the number of output channels. Each element's value is
  		the input channel number, starting with zero, that is to be copied to that output. A negative value means 
  		that the output channel will have no source and will be silent.
  		Setting a channel map overrides channel mapping due to any channel layouts in the input and output formats that may have been supplied.
  */
  var channelMap: [Number]

  /*! @property magicCookie
      @abstract Decoders require some data in the form of a magicCookie in order to decode properly. Encoders will produce a magicCookie.
  */
  var magicCookie: Data?

  /*! @property downmix
      @abstract If YES and channel remapping is necessary, then channels will be mixed as appropriate instead of remapped. Default value is NO.
  */
  var downmix: Bool

  /*! @property dither
      @abstract Setting YES will turn on dither, if dither makes sense in given the current formats and settings. Default value is NO.
  */
  var dither: Bool

  /*! @property sampleRateConverterQuality
      @abstract An AVAudioQuality value as defined in AVAudioSettings.h.
  */
  var sampleRateConverterQuality: Int

  /*! @property sampleRateConverterAlgorithm
      @abstract An AVSampleRateConverterAlgorithmKey value as defined in AVAudioSettings.h.
  */
  var sampleRateConverterAlgorithm: String

  /*! @property primeMethod
      @abstract Indicates the priming method to be used by the sample rate converter or decoder.
  */
  var primeMethod: AVAudioConverterPrimeMethod

  /*! @property primeInfo
      @abstract Indicates the the number of priming frames .
  */
  var primeInfo: AVAudioConverterPrimeInfo

  /*! @method convertToBuffer:fromBuffer:error:
      @abstract Perform a simple conversion. That is, a conversion which does not involve codecs or sample rate conversion.
  	@param inputBuffer 
  		The input buffer.
  	@param outputBuffer 
  		The output buffer.
  	@param outError 
  		An error if the conversion fails.
  	@return 
  		YES is returned on success, NO when an error has occurred.
  	@discussion 
  		The output buffer's frameCapacity should be at least at large as the inputBuffer's frameLength.
  		If the conversion involves a codec or sample rate conversion, you instead must use
  		convertToBuffer:error:withInputFromBlock:.
  */
  func convertTo(outputBuffer: AVAudioPCMBuffer, from inputBuffer: AVAudioPCMBuffer) throws

  /*! @method convertToBuffer:error:withInputFromBlock:
      @abstract Perform any supported conversion. 
  	@param inputBlock
  		A block which will be called to get input data as needed. See description for AVAudioConverterInputBlock.
  	@param outputBuffer 
  		The output buffer.
  	@param outError 
  		An error if the conversion fails.
  	@return 
  		An AVAudioConverterOutputStatus is returned.
  	@discussion 
  		It attempts to fill the buffer to its capacity. On return, the buffer's length indicates the number of 
  		sample frames successfully converted.
  */
  func convertTo(outputBuffer: AVAudioBuffer, error outError: ErrorPointer, withInputFrom inputBlock: AVAudioConverterInputBlock) -> AVAudioConverterOutputStatus
  init()
}
extension AVAudioConverter {

  /*! @property bitRate
      @abstract bitRate in bits per second. Only applies when encoding.
  */
  var bitRate: Int

  /*! @property bitRateStrategy
      @abstract When encoding, an AVEncoderBitRateStrategyKey value constant as defined in AVAudioSettings.h. Returns nil if not encoding.
  */
  var bitRateStrategy: String?

  /*! @property maximumOutputPacketSize
      @abstract When encoding it is useful to know how large a packet can be in order to allocate a buffer to receive the output.
  */
  var maximumOutputPacketSize: Int { get }

  /*! @property availableEncodeBitRates
      @abstract When encoding, an NSArray of NSNumber of all bit rates provided by the codec. Returns nil if not encoding.
  */
  var availableEncodeBitRates: [Number]? { get }

  /*! @property applicableEncodeBitRates
      @abstract When encoding, an NSArray of NSNumber of bit rates that can be applied based on the current formats and settings. Returns nil if not encoding.
  */
  var applicableEncodeBitRates: [Number]? { get }

  /*! @property availableEncodeSampleRates
      @abstract When encoding, an NSArray of NSNumber of all output sample rates provided by the codec. Returns nil if not encoding.
  */
  var availableEncodeSampleRates: [Number]? { get }

  /*! @property applicableEncodeSampleRates
      @abstract When encoding, an NSArray of NSNumber of output sample rates that can be applied based on the current formats and settings. Returns nil if not encoding.
  */
  var applicableEncodeSampleRates: [Number]? { get }

  /*! @property availableEncodeChannelLayoutTags
      @abstract When encoding, an NSArray of NSNumber of all output channel layout tags provided by the codec. Returns nil if not encoding.
  */
  var availableEncodeChannelLayoutTags: [Number]? { get }
}

/*!
	@class AVAudioEngine
	@discussion
		An AVAudioEngine contains a group of connected AVAudioNodes ("nodes"), each of which performs
		an audio signal generation, processing, or input/output task.
		
		Nodes are created separately and attached to the engine.

		The engine supports dynamic connection, disconnection and removal of nodes while running,
		with only minor limitations:
		- all dynamic reconnections must occur upstream of a mixer
		- while removals of effects will normally result in the automatic connection of the adjacent
			nodes, removal of a node which has differing input vs. output channel counts, or which
			is a mixer, is likely to result in a broken graph.
*/
@available(iOS 8.0, *)
class AVAudioEngine : Object {

  /*! @method init
  	@abstract
  		Initialize a new engine.
  */
  init()

  /*!	@method attachNode:
  	@abstract
  		Take ownership of a new node.
  	@param node
  		The node to be attached to the engine.
  	@discussion
  		To support the instantiation of arbitrary AVAudioNode subclasses, instances are created
  		externally to the engine, but are not usable until they are attached to the engine via
  		this method. Thus the idiom, without ARC, is:
  
  <pre>
  // when building engine:
  AVAudioNode *_player;	// member of controller class (for example)
  ...
  _player = [[AVAudioPlayerNode alloc] init];
  [engine attachNode: _player];
  ...
  // when destroying engine (without ARC)
  [_player release];
  </pre>
  */
  func attach(node: AVAudioNode)

  /*!	@method detachNode:
  	@abstract
  		Detach a node previously attached to the engine.
  	@discussion
  		If necessary, the engine will safely disconnect the node before detaching it.
  */
  func detach(node: AVAudioNode)

  /*! @method connect:to:fromBus:toBus:format:
  	@abstract
  		Establish a connection between two nodes.
  	@param node1 the source node
  	@param node2 the destination node
  	@param bus1 the output bus on the source node
  	@param bus2 the input bus on the destination node
  	@param format if non-nil, the format of the source node's output bus is set to this
  		format. In all cases, the format of the destination node's input bus is set to
  		match that of the source node's output bus.
  	@discussion
  		Nodes have input and output buses (AVAudioNodeBus). Use this method to establish
  		one-to-one connections betweeen nodes. Connections made using this method are always
  		one-to-one, never one-to-many or many-to-one.
  	
  		Note that any pre-existing connection(s) involving the source's output bus or the
  		destination's input bus will be broken.
  */
  func connect(node1: AVAudioNode, to node2: AVAudioNode, fromBus bus1: AVAudioNodeBus, toBus bus2: AVAudioNodeBus, format: AVAudioFormat?)

  /*!	@method connect:to:format:
  	@abstract
  		Establish a connection between two nodes
  	@discussion
  		This calls connect:to:fromBus:toBus:format: using bus 0 on the source node,
  		and bus 0 on the destination node, except in the case of a destination which is a mixer,
  		in which case the destination is the mixer's nextAvailableInputBus.
  */
  func connect(node1: AVAudioNode, to node2: AVAudioNode, format: AVAudioFormat?)

  /*! @method connect:toConnectionPoints:fromBus:format:
  	@abstract
  		Establish connections between a source node and multiple destination nodes.
  	@param sourceNode the source node
  	@param destNodes an array of AVAudioConnectionPoint objects specifying destination 
  		nodes and busses
  	@param sourceBus the output bus on source node
  	@param format if non-nil, the format of the source node's output bus is set to this
  		format. In all cases, the format of the destination nodes' input bus is set to
  		match that of the source node's output bus
  	@discussion
  		Use this method to establish connections from a source node to multiple destination nodes.
  		Connections made using this method are either one-to-one (when a single destination
  		connection is specified) or one-to-many (when multiple connections are specified), but 
  		never many-to-one.
  
  		To incrementally add a new connection to a source node, use this method with an array
  		of AVAudioConnectionPoint objects comprising of pre-existing connections (obtained from
  		`outputConnectionPointsForNode:outputBus:`) and the new connection.
   
  		Note that any pre-existing connection involving the destination's input bus will be 
  		broken. And, any pre-existing connection on source node which is not a part of the
  		specified destination connection array will also be broken.
  
  		Also note that when the output of a node is split into multiple paths, all the paths
  		must render at the same rate until they reach a common mixer.
  		In other words, starting from the split node until the common mixer node where all split 
  		paths terminate, you cannot have:
  			- any AVAudioUnitTimeEffect
  			- any sample rate conversion
  */
  @available(iOS 9.0, *)
  func connect(sourceNode: AVAudioNode, to destNodes: [AVAudioConnectionPoint], fromBus sourceBus: AVAudioNodeBus, format: AVAudioFormat?)

  /*! @method disconnectNodeInput:bus:
  	@abstract
  		Remove a connection between two nodes.
  	@param node the node whose input is to be disconnected
  	@param bus the destination's input bus to disconnect
  */
  func disconnectNodeInput(node: AVAudioNode, bus: AVAudioNodeBus)

  /*!	@method disconnectNodeInput:
  	@abstract
  		Remove a connection between two nodes.
  	@param node the node whose inputs are to be disconnected
  	@discussion
  		Connections are broken on each of the node's input busses.
  */
  func disconnectNodeInput(node: AVAudioNode)

  /*! @method disconnectNodeOutput:bus:
  	@abstract
  		Remove a connection between two nodes.
  	@param node the node whose output is to be disconnected
  	@param bus the source's output bus to disconnect
  */
  func disconnectNodeOutput(node: AVAudioNode, bus: AVAudioNodeBus)

  /*!	@method disconnectNodeOutput:
  	@abstract
  		Remove a connection between two nodes.
  	@param node the node whose outputs are to be disconnected
  	@discussion
  		Connections are broken on each of the node's output busses.
  */
  func disconnectNodeOutput(node: AVAudioNode)

  /*!	@method prepare
  	@abstract
  		Prepare the engine for starting.
  	@discussion
  		This method preallocates many of the resources the engine requires in order to start.
  		It can be used to be able to start more responsively.
  */
  func prepare()

  /*! @method startAndReturnError:
  	@abstract
  		Start the engine.
  	@return
  		YES for success
  	@discussion
  		Calls prepare if it has not already been called since stop.
  	
  		Starts the audio hardware via the AVAudioInputNode and/or AVAudioOutputNode instances in
  		the engine. Audio begins flowing through the engine.
  	
  		Reasons for potential failure include:
  		
  		1. There is problem in the structure of the graph. Input can't be routed to output or to a
  			recording tap through converter type nodes.
  		2. An AVAudioSession error.
  		3. The driver failed to start the hardware.
  */
  func start() throws

  /*!	@method pause
  	@abstract
  		Pause the engine.
  	@discussion
  		Stops the flow of audio through the engine, but does not deallocate the resources allocated
  		by prepare. Resume the engine by invoking start again.
  */
  func pause()

  /*!	@method reset
  	@abstract reset
  		Reset all of the nodes in the engine.
  	@discussion
  		This will reset all of the nodes in the engine. This is useful, for example, for silencing
  		reverb and delay tails.
  */
  func reset()

  /*! @method stop
  	@abstract
  		Stop the engine. Releases the resources allocated by prepare.
  */
  func stop()

  /*! @method inputConnectionPointForNode:inputBus:
  	@abstract 
  		Get connection information on a node's input bus.
  	@param node the node whose input connection is being queried.
  	@param bus the node's input bus on which the connection is being queried.
  	@return	
  		An AVAudioConnectionPoint object with connection information on the node's
  		specified input bus.
  	@discussion
  		Connections are always one-to-one or one-to-many, never many-to-one.
   
  		Returns nil if there is no connection on the node's specified input bus.
  */
  @available(iOS 9.0, *)
  func inputConnectionPointFor(node: AVAudioNode, inputBus bus: AVAudioNodeBus) -> AVAudioConnectionPoint?

  /*! @method outputConnectionPointsForNode:outputBus:
  	@abstract
  		Get connection information on a node's output bus.
  	@param node the node whose output connections are being queried.
  	@param bus the node's output bus on which connections are being queried.
  	@return
  		An array of AVAudioConnectionPoint objects with connection information on the node's
  		specified output bus.
  	@discussion
  		Connections are always one-to-one or one-to-many, never many-to-one.
   
  		Returns an empty array if there are no connections on the node's specified output bus.
  */
  @available(iOS 9.0, *)
  func outputConnectionPointsFor(node: AVAudioNode, outputBus bus: AVAudioNodeBus) -> [AVAudioConnectionPoint]

  /*! @property musicSequence
  	@abstract
  		The MusicSequence previously attached to the engine (if any).
   */
  var musicSequence: MusicSequence

  /*! @property outputNode
  	@abstract
  		The engine's singleton output node.
  	@discussion
  		Audio output is performed via an output node. The engine creates a singleton on demand when
  		this property is first accessed. Connect another node to the input of the output node, or obtain
  		a mixer that is connected there by default, using the "mainMixerNode" property.
   
  		The AVAudioSesssion category and/or availability of hardware determine whether an app can
  		perform output. Check the output format of output node (i.e. hardware format) for non-zero
  		sample rate and channel count to see if output is enabled.
  */
  var outputNode: AVAudioOutputNode { get }

  /*! @property inputNode
  	@abstract
  		The engine's singleton input node.
  	@discussion
  		Audio input is performed via an input node. The engine creates a singleton on demand when
  		this property is first accessed. To receive input, connect another node from the output of 
  		the input node, or create a recording tap on it.
   
  		The AVAudioSesssion category and/or availability of hardware determine whether an app can
  		perform input. Check for non-nil input node and its input format (i.e. hardware format) for non-zero
  		sample rate and channel count to see if input is enabled.
  */
  var inputNode: AVAudioInputNode? { get }

  /*! @property mainMixerNode
  	@abstract
  		The engine's optional singleton main mixer node.
  	@discussion
  		The engine will construct a singleton main mixer and connect it to the outputNode on demand,
  		when this property is first accessed. You can then connect additional nodes to the mixer.
  		
  		By default, the mixer's output format (sample rate and channel count) will track the format 
  		of the output node. You may however make the connection explicitly with a different format.
  */
  var mainMixerNode: AVAudioMixerNode { get }

  /*! @property running
  	@abstract
  		The engine's running state.
  */
  var isRunning: Bool { get }
}

/*!	@constant AVAudioEngineConfigurationChangeNotification
	@abstract
		A notification generated on engine configuration changes.
	@discussion
		Register for this notification on your engine instances, as follows:
		
		[[NSNotificationCenter defaultCenter] addObserver: myObject 
			 selector:    @selector(handleInterruption:)
			 name:        AVAudioEngineConfigurationChangeNotification
			 object:      engine];

		When the engine's I/O unit observes a change to the audio input or output hardware's
		channel count or sample rate, the engine stops, uninitializes itself, and issues this 
		notification.	
*/
@available(iOS 8.0, *)
let AVAudioEngineConfigurationChangeNotification: String

/*! @enum AVAudioEnvironmentDistanceAttenuationModel
    @abstract Types of distance attenuation models
    @discussion
        Distance attenuation is the natural attenuation of sound when traveling from the source to 
        the listener. The different attenuation models listed below describe the drop-off in gain as 
        the source moves away from the listener.
     
        AVAudioEnvironmentDistanceAttenuationModelExponential
            distanceGain = (distance / referenceDistance) ^ (-rolloffFactor)
     
        AVAudioEnvironmentDistanceAttenuationModelInverse
            distanceGain = referenceDistance /  (referenceDistance + rolloffFactor *
                                                (distance – referenceDistance))
     
        AVAudioEnvironmentDistanceAttenuationModelLinear
            distanceGain = (1 – rolloffFactor * (distance – referenceDistance) /
                                                (maximumDistance – referenceDistance))
     
        With all the distance models, if the formula can not be evaluated then the source will not 
        be attenuated. For example, if a linear model is being used with referenceDistance equal 
        to maximumDistance, then the gain equation will have a divide-by-zero error in it. In this case,
        there is no attenuation for that source.
     
        All the values for distance are specified in meters.
*/
@available(iOS 8.0, *)
enum AVAudioEnvironmentDistanceAttenuationModel : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Exponential
  case Inverse
  case Linear
}

/*! @class AVAudioEnvironmentDistanceAttenuationParameters
    @abstract Parameters specifying the amount of distance attenuation
    @discussion
        A standalone instance of AVAudioEnvironmentDistanceAttenuationParameters cannot be created. 
        Only an instance vended out by a source object (e.g. AVAudioEnvironmentNode) can be used.
*/
@available(iOS 8.0, *)
class AVAudioEnvironmentDistanceAttenuationParameters : Object {

  /*! @property distanceAttenuationModel
      @abstract Type of distance attenuation model
      @discussion
          Default:    AVAudioEnvironmentDistanceAttenuationModelInverse
  */
  var distanceAttenuationModel: AVAudioEnvironmentDistanceAttenuationModel

  /*! @property referenceDistance
      @abstract The minimum distance at which attenuation is applied
      @discussion
          Default:    1.0 meter
          Models:     AVAudioEnvironmentDistanceAttenuationModelInverse,
                      AVAudioEnvironmentDistanceAttenuationModelLinear
  */
  var referenceDistance: Float

  /*! @property maximumDistance
      @abstract The distance beyond which no further attenuation is applied
      @discussion
          Default:    100000.0 meters
          Models:     AVAudioEnvironmentDistanceAttenuationModelLinear
  */
  var maximumDistance: Float

  /*! @property rolloffFactor
      @abstract Determines the attenuation curve
      @discussion
          A higher value results in a steeper attenuation curve.
          The rolloff factor should be a value greater than 0.
          Default:    1.0
          Models:     AVAudioEnvironmentDistanceAttenuationModelExponential
                      AVAudioEnvironmentDistanceAttenuationModelInverse
                      AVAudioEnvironmentDistanceAttenuationModelLinear
  */
  var rolloffFactor: Float
  init()
}

/*! @class AVAudioEnvironmentReverbParameters
    @abstract Parameters used to control the reverb in AVAudioEnvironmentNode
    @discussion
        Reverberation can be used to simulate the acoustic characteristics of an environment.
        AVAudioEnvironmentNode has a built in reverb that describes the space that the listener 
        is in.
 
        The reverb also has a single filter that sits at the end of the chain. This filter is useful 
        to shape the overall sound of the reverb. For instance, one of the reverb presets can be 
        selected to simulate the general space and then the filter can be used to brighten or darken 
        the overall sound.
 
        A standalone instance of AVAudioEnvironmentReverbParameters cannot be created.
        Only an instance vended out by a source object (e.g. AVAudioEnvironmentNode) can be used.
*/
@available(iOS 8.0, *)
class AVAudioEnvironmentReverbParameters : Object {

  /*! @property enable
      @abstract Turns on/off the reverb
      @discussion
          Default:    NO
  */
  var enable: Bool

  /*! @property level
      @abstract Controls the master level of the reverb
      @discussion
          Range:      -40 to 40 dB
          Default:    0.0
  */
  var level: Float

  /*! @property filterParameters
      @abstract filter that applies to the output of the reverb
  */
  var filterParameters: AVAudioUnitEQFilterParameters { get }

  /*! @method loadFactoryReverbPreset:
      @abstract Load one of the reverb's factory presets
      @param preset
          Reverb preset to be set.
      @discussion
          Loading a factory reverb preset changes the sound of the reverb. This works independently
          of the filter which follows the reverb in the signal chain.
  */
  func loadFactoryReverbPreset(preset: AVAudioUnitReverbPreset)
  init()
}

/*!
    @class AVAudioEnvironmentNode
    @abstract Mixer node that simulates a 3D environment
    @discussion
        AVAudioEnvironmentNode is a mixer node that simulates a 3D audio environment. Any node that 
        conforms to the AVAudioMixing protocol (e.g. AVAudioPlayerNode) can act as a source in this
        environment.
 
        The environment has an implicit "listener". By controlling the listener's position and
        orientation, the application controls the way the user experiences the virtual world. 
        In addition, this node also defines properties for distance attenuation and reverberation 
        that help characterize the environment.
 
        It is important to note that only inputs with a mono channel connection format to the 
        environment node are spatialized. If the input is stereo, the audio is passed through 
        without being spatialized. Currently inputs with connection formats of more than 2 channels 
        are not supported.
 
        In order to set the environment node’s output to a multichannel format, use an AVAudioFormat 
        having one of the following AudioChannelLayoutTags.
 
        kAudioChannelLayoutTag_AudioUnit_4
        kAudioChannelLayoutTag_AudioUnit_5_0;
        kAudioChannelLayoutTag_AudioUnit_6_0;
        kAudioChannelLayoutTag_AudioUnit_7_0;
        kAudioChannelLayoutTag_AudioUnit_7_0_Front;
        kAudioChannelLayoutTag_AudioUnit_8;
*/
@available(iOS 8.0, *)
class AVAudioEnvironmentNode : AVAudioNode, AVAudioMixing {

  /*! @property outputVolume
  	@abstract The mixer's output volume.
  	@discussion
          This accesses the mixer's output volume (0.0-1.0, inclusive).
  */
  var outputVolume: Float

  /*! @property nextAvailableInputBus
      @abstract Find an unused input bus
      @discussion
          This will find and return the first input bus to which no other node is connected.
  */
  var nextAvailableInputBus: AVAudioNodeBus { get }

  /*! @property listenerPosition
      @abstract Sets the listener's position in the 3D environment
      @discussion
          The coordinates are specified in meters.
          Default:
              The default poistion of the listener is at the origin.
              x: 0.0
              y: 0.0
              z: 0.0
  */
  var listenerPosition: AVAudio3DPoint

  /*! @property listenerVectorOrientation
      @abstract The listener's orientation in the environment
      @discussion
      Changing listenerVectorOrientation will result in a corresponding change in listenerAngularOrientation.
          Default:
              The default orientation is with the listener looking directly along the negative Z axis.
              forward: (0, 0, -1)
              up:      (0, 1, 0)
  */
  var listenerVectorOrientation: AVAudio3DVectorOrientation

  /*! @property listenerAngularOrientation
      @abstract The listener's orientation in the environment
      @discussion
      Changing listenerAngularOrientation will result in a corresponding change in listenerVectorOrientation.
          All angles are specified in degrees.
          Default:
              The default orientation is with the listener looking directly along the negative Z axis.
              yaw: 0.0
              pitch: 0.0
              roll: 0.0
  */
  var listenerAngularOrientation: AVAudio3DAngularOrientation

  /*! @property distanceAttenuationParameters
      @abstract The distance attenuation parameters for the environment
  */
  var distanceAttenuationParameters: AVAudioEnvironmentDistanceAttenuationParameters { get }

  /*! @property reverbParameters
      @abstract The reverb parameters for the environment
  */
  var reverbParameters: AVAudioEnvironmentReverbParameters { get }

  /*! @property applicableRenderingAlgorithms
      @abstract Returns an array of AVAudio3DMixingRenderingAlgorithm values based on the current output format
      @discussion
          AVAudioEnvironmentNode supports several rendering algorithms per input bus which are defined 
          in <AVFoundation/AVAudioMixing.h>.
   
          Depending on the current output format of the environment node, this method returns 
          an immutable array of the applicable rendering algorithms. This is important when the
          environment node has been configured to a multichannel output format because only a subset
          of the available rendering algorithms are designed to render to all of the channels.
          
          This information should be retrieved after a successful connection to the destination node 
          via the engine's connect method.
  */
  var applicableRenderingAlgorithms: [Number] { get }
  init()

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var volume: Float

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  @available(iOS 8.0, *)
  var pan: Float

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var rate: Float

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var reverbBlend: Float

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var obstruction: Float

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var occlusion: Float

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var position: AVAudio3DPoint
}

/*!
	@class AVAudioFile
	@abstract
		AVAudioFile represents an audio file opened for reading or writing.
	@discussion
		Regardless of the file's actual format, reading and writing the file is done via 
		`AVAudioPCMBuffer` objects, containing samples in an `AVAudioCommonFormat`,
		referred to as the file's "processing format." Conversions are performed to and from
		the file's actual format.
		
		Reads and writes are always sequential, but random access is possible by setting the
		framePosition property.
*/
@available(iOS 8.0, *)
class AVAudioFile : Object {

  /*! @method initForReading:error:
  	@abstract Open a file for reading.
  	@param fileURL
  		the file to open
  	@param outError
  		on exit, if an error occurs, a description of the error
  	@discussion
  		This opens the file for reading using the standard format (deinterleaved floating point).
  */
  init(forReading fileURL: URL) throws

  /*!	@method initForReading:commonFormat:interleaved:error:
  	@abstract Open a file for reading, using a specified processing format.
  	@param fileURL
  		the file to open
  	@param format
  		the processing format to use when reading from the file
  	@param interleaved
  		whether to use an interleaved processing format
  	@param outError
  		on exit, if an error occurs, a description of the error
  */
  init(forReading fileURL: URL, commonFormat format: AVAudioCommonFormat, interleaved: Bool) throws

  /*! @method initForWriting:settings:error:
  	@abstract Open a file for writing.
  	@param fileURL
  		the path at which to create the file
  	@param settings
  		the format of the file to create (See `AVAudioRecorder`.)
  	@param outError
  		on exit, if an error occurs, a description of the error
  	@discussion
  		The file type to create is inferred from the file extension. Will overwrite a file at the
  		specified URL if a file exists.
  
  		This opens the file for writing using the standard format (deinterleaved floating point).
  */
  init(forWriting fileURL: URL, settings: [String : AnyObject]) throws

  /*! @method initForWriting:settings:commonFormat:interleaved:error:
  	@abstract Open a file for writing.
  	@param fileURL
  		the path at which to create the file
  	@param settings
  		the format of the file to create (See `AVAudioRecorder`.)
  	@param format
  		the processing format to use when writing to the file
  	@param interleaved
  		whether to use an interleaved processing format
  	@param outError
  		on exit, if an error occurs, a description of the error
  	@discussion
  		The file type to create is inferred from the file extension. Will overwrite a file at the
  		specified URL if a file exists.
  */
  init(forWriting fileURL: URL, settings: [String : AnyObject], commonFormat format: AVAudioCommonFormat, interleaved: Bool) throws

  /*! @method readIntoBuffer:error:
  	@abstract Read an entire buffer.
  	@param buffer
  		The buffer into which to read from the file. Its format must match the file's
  		processing format.
  	@param outError
  		on exit, if an error occurs, a description of the error
  	@return
  		YES for success.
  	@discussion
  		Reading sequentially from framePosition, attempts to fill the buffer to its capacity. On
  		return, the buffer's length indicates the number of sample frames successfully read.
  */
  func readInto(buffer: AVAudioPCMBuffer) throws

  /*! @method readIntoBuffer:frameCount:error:
  	@abstract Read a portion of a buffer.
  	@param frames
  		The number of frames to read.
  	@param buffer
  		The buffer into which to read from the file. Its format must match the file's
  		processing format.
  	@param outError
  		on exit, if an error occurs, a description of the error
  	@return
  		YES for success.
  	@discussion
  		Like `readIntoBuffer:error:`, but can be used to read fewer frames than buffer.frameCapacity.
  */
  func readInto(buffer: AVAudioPCMBuffer, frameCount frames: AVAudioFrameCount) throws

  /*! @method writeFromBuffer:error:
  	@abstract Write a buffer.
  	@param buffer
  		The buffer from which to write to the file. Its format must match the file's
  		processing format.
  	@param outError
  		on exit, if an error occurs, a description of the error
  	@return
  		YES for success.
  	@discussion
  		Writes sequentially. The buffer's frameLength signifies how much of the buffer is to be written.
  */
  func writeFrom(buffer: AVAudioPCMBuffer) throws

  /*!	@property url
  	@abstract The URL the file is reading or writing.
  */
  var url: URL { get }

  /*! @property fileFormat
  	@abstract The on-disk format of the file.
  */
  var fileFormat: AVAudioFormat { get }

  /*! @property processingFormat
  	@abstract The processing format of the file.
  */
  var processingFormat: AVAudioFormat { get }

  /*! @property length
  	@abstract The number of sample frames in the file.
  	@discussion
  		 Note: this can be expensive to compute for the first time.
  */
  var length: AVAudioFramePosition { get }

  /*! @property framePosition
  	@abstract The position in the file at which the next read or write will occur.
  	@discussion
  		Set framePosition to perform a seek before a read or write. A read or write operation advances the frame position by the number of frames read or written.
  */
  var framePosition: AVAudioFramePosition
  init()
}

/*!	
	@enum		AVAudioCommonFormat
	@constant	AVAudioOtherFormat
					A format other than one of the common ones below.
	@constant	AVAudioPCMFormatFloat32
					Native-endian floats (this is the standard format).
	@constant	AVAudioPCMFormatFloat64
					Native-endian doubles.
	@constant	AVAudioPCMFormatInt16
					Signed 16-bit native-endian integers.
	@constant	AVAudioPCMFormatInt32
					Signed 32-bit native-endian integers.
*/
@available(iOS 8.0, *)
enum AVAudioCommonFormat : UInt {
  init?(rawValue: UInt)
  var rawValue: UInt { get }
  case OtherFormat
  case PCMFormatFloat32
  case PCMFormatFloat64
  case PCMFormatInt16
  case PCMFormatInt32
}

/*! @class AVAudioFormat
	@abstract A representation of an audio format.
	@discussion
		AVAudioFormat wraps a Core Audio AudioStreamBasicDescription struct, with convenience
		initializers and accessors for common formats, including Core Audio's standard deinterleaved
		32-bit floating point.
	
		Instances of this class are immutable.
*/
@available(iOS 8.0, *)
class AVAudioFormat : Object, SecureCoding {

  /*! @method initWithStreamDescription:
  	@abstract Initialize from an AudioStreamBasicDescription.
  	@param asbd
  		the AudioStreamBasicDescription
  	@discussion
  		If the format specifies more than 2 channels, this method fails (returns nil).
  */
  init(streamDescription asbd: UnsafePointer<AudioStreamBasicDescription>)

  /*! @method initWithStreamDescription:channelLayout:
  	@abstract Initialize from an AudioStreamBasicDescription and optional channel layout.
  	@param asbd
  		the AudioStreamBasicDescription
  	@param layout
  		the channel layout. Can be nil only if asbd specifies 1 or 2 channels.
  	@discussion
  		If the format specifies more than 2 channels, this method fails (returns nil) unless layout
  		is non-nil.
  */
  init(streamDescription asbd: UnsafePointer<AudioStreamBasicDescription>, channelLayout layout: AVAudioChannelLayout?)

  /*! @method initStandardFormatWithSampleRate:channels:
  	@abstract Initialize to deinterleaved float with the specified sample rate and channel count.
  	@param sampleRate
  		the sample rate
  	@param channels
  		the channel count
  	@discussion
  		If the format specifies more than 2 channels, this method fails (returns nil).
  */
  init(standardFormatWithSampleRate sampleRate: Double, channels: AVAudioChannelCount)

  /*! @method initStandardFormatWithSampleRate:channelLayout:
  	@abstract Initialize to deinterleaved float with the specified sample rate and channel layout.
  	@param sampleRate
  		the sample rate
  	@param layout
  		the channel layout. must not be nil.
  */
  init(standardFormatWithSampleRate sampleRate: Double, channelLayout layout: AVAudioChannelLayout)

  /*! @method initWithCommonFormat:sampleRate:channels:interleaved:
  	@abstract Initialize to float with the specified sample rate, channel count and interleavedness.
  	@param format
  		the common format type
  	@param sampleRate
  		the sample rate
  	@param channels
  		the channel count
  	@param interleaved
  		true if interleaved
  	@discussion
  		If the format specifies more than 2 channels, this method fails (returns nil).
  */
  init(commonFormat format: AVAudioCommonFormat, sampleRate: Double, channels: AVAudioChannelCount, interleaved: Bool)

  /*! @method initWithCommonFormat:sampleRate:interleaved:channelLayout:
  	@abstract Initialize to float with the specified sample rate, channel layout and interleavedness.
  	@param format
  		the common format type
  	@param sampleRate
  		the sample rate
  	@param interleaved
  		true if interleaved
  	@param layout
  		the channel layout. must not be nil.
  */
  init(commonFormat format: AVAudioCommonFormat, sampleRate: Double, interleaved: Bool, channelLayout layout: AVAudioChannelLayout)

  /*! @method initWithSettings:
  	@abstract Initialize using a settings dictionary.
  	@discussion
  		See AVAudioSettings.h. Note that many settings dictionary elements pertain to encoder
  		settings, not the basic format, and will be ignored.
  */
  init(settings: [String : AnyObject])

  /*!
   	@method initWithCMAudioFormatDescription:
   	@abstract initialize from a CMAudioFormatDescriptionRef.
   	@param formatDescription
   		the CMAudioFormatDescriptionRef.
   	@discussion
   		If formatDescription is invalid, this method fails (returns nil).
   */
  @available(iOS 9.0, *)
  init(cmAudioFormatDescription formatDescription: CMAudioFormatDescription)

  /*!	@method isEqual:
  	@abstract Determine whether another format is functionally equivalent.
  	@param object
  		the format to compare against
  	@discussion
  		For PCM, interleavedness is ignored for mono. Differences in the AudioStreamBasicDescription
  		alignment and packedness are ignored when they are not significant (e.g. with 1 channel, 2
  		bytes per frame and 16 bits per channel, neither alignment, the format is implicitly packed
  		and can be interpreted as either high- or low-aligned.)
  		For AVAudioChannelLayout, a layout with standard mono/stereo tag is considered to be 
  		equivalent to a nil layout. Otherwise, the layouts are compared for equality.
  */
  func isEqual(object: AnyObject) -> Bool

  /*!	@property standard
  	@abstract Describes whether the format is deinterleaved native-endian float.
  */
  var isStandard: Bool { get }

  /*!	@property commonFormat
  	@abstract An `AVAudioCommonFormat` identifying the format
  */
  var commonFormat: AVAudioCommonFormat { get }

  /*! @property channelCount
  	@abstract The number of channels of audio data.
  */
  var channelCount: AVAudioChannelCount { get }

  /*! @property sampleRate
  	@abstract A sampling rate in Hertz.
  */
  var sampleRate: Double { get }

  /*!	@property interleaved
  	@abstract Describes whether the samples are interleaved.
  	@discussion
  		For non-PCM formats, the value is undefined.
  */
  var isInterleaved: Bool { get }

  /*!	@property streamDescription
  	@abstract Returns the AudioStreamBasicDescription, for use with lower-level audio API's.
  */
  var streamDescription: UnsafePointer<AudioStreamBasicDescription> { get }

  /*!	@property channelLayout
  	@abstract The underlying AVAudioChannelLayout, if any.
  	@discussion
  		Only formats with more than 2 channels are required to have channel layouts.
  */
  var channelLayout: AVAudioChannelLayout? { get }

  /*!	@property settings
  	@abstract Returns the format represented as a dictionary with keys from AVAudioSettings.h.
  */
  var settings: [String : AnyObject] { get }

  /*!
  	 @property formatDescription
  	 @abstract Converts to a CMAudioFormatDescriptionRef, for use with Core Media API's.
   */
  @available(iOS 9.0, *)
  var formatDescription: CMAudioFormatDescription { get }
  init()
  @available(iOS 8.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 8.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!	@class AVAudioIONode
	@abstract Base class for a node that connects to the system's audio input or output.
	@discussion
		On OS X, AVAudioInputNode and AVAudioOutputNode communicate with the system's default
		input and output devices. On iOS, they communicate with the devices appropriate to
		the app's AVAudioSession category and other configuration, also considering the user's
		actions such as connecting/disconnecting external devices.
*/
@available(iOS 8.0, *)
class AVAudioIONode : AVAudioNode {

  /*!	@property presentationLatency
  	@abstract The presentation, or hardware, latency.
  	@discussion
  		This corresponds to kAudioDevicePropertyLatency and kAudioStreamPropertyLatency.
  		See <CoreAudio/AudioHardwareBase.h>.
  */
  var presentationLatency: TimeInterval { get }

  /*!	@property audioUnit
  	@abstract The node's underlying AudioUnit, if any.
  	@discussion
  		This is only necessary for certain advanced usages.
  */
  var audioUnit: AudioUnit { get }
  init()
}

/*! @class AVAudioInputNode
	@abstract A node that connects to the system's audio input.
	@discussion
		This node has one element. The format of the input scope reflects the audio hardware sample
		rate and channel count. The format of the output scope is initially the same as that of the
		input, but you may set it to a different format, in which case the node will convert.
*/
@available(iOS 8.0, *)
class AVAudioInputNode : AVAudioIONode, AVAudioMixing {
  init()

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var volume: Float

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  @available(iOS 8.0, *)
  var pan: Float

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var rate: Float

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var reverbBlend: Float

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var obstruction: Float

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var occlusion: Float

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var position: AVAudio3DPoint
}

/*! @class AVAudioOutputNode
	@abstract A node that connects to the system's audio input.
	@discussion
		This node has one element. The format of the output scope reflects the audio hardware sample
		rate and channel count. The format of the input scope is initially the same as that of the
		output, but you may set it to a different format, in which case the node will convert.
*/
@available(iOS 8.0, *)
class AVAudioOutputNode : AVAudioIONode {
  init()
}
@available(iOS 4.0, *)
class AVAudioMix : Object, Copying, MutableCopying {
  var inputParameters: [AVAudioMixInputParameters] { get }
  init()
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 4.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 4.0, *)
class AVMutableAudioMix : AVAudioMix {

  /*!
   @property		inputParameters
   @abstract		Indicates parameters for inputs to the mix; an NSArray of instances of AVAudioMixInputParameters.
   @discussion	Note that an instance of AVAudioMixInputParameters is not required for each audio track that contributes to the mix; audio for those without associated AVAudioMixInputParameters will be included in the mix, processed according to default behavior.
  */
  var inputParameters: [AVAudioMixInputParameters]
  init()
}
@available(iOS 4.0, *)
class AVAudioMixInputParameters : Object, Copying, MutableCopying {

  /*!
   @property		trackID
   @abstract		Indicates the trackID of the audio track to which the parameters should be applied.
  */
  var trackID: CMPersistentTrackID { get }

  /*!
   @property		audioTimePitchAlgorithm
   @abstract		Indicates the processing algorithm used to manage audio pitch at varying rates and for scaled audio edits.
   @discussion
     Constants for various time pitch algorithms, e.g. AVAudioTimePitchSpectral, are defined in AVAudioProcessingSettings.h.
     Can be nil, in which case the audioTimePitchAlgorithm set on the AVPlayerItem, AVAssetExportSession, or AVAssetReaderAudioMixOutput on which the AVAudioMix is set will be used for the associated track.
  */
  @available(iOS 7.0, *)
  var audioTimePitchAlgorithm: String? { get }

  /*!
   @property		audioTapProcessor
   @abstract		Indicates the audio processing tap that will be used for the audio track.
  */
  @available(iOS 6.0, *)
  var audioTapProcessor: MTAudioProcessingTap? { get }
  func getVolumeRampFor(time: CMTime, startVolume: UnsafeMutablePointer<Float>, endVolume: UnsafeMutablePointer<Float>, timeRange: UnsafeMutablePointer<CMTimeRange>) -> Bool
  init()
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 4.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 4.0, *)
class AVMutableAudioMixInputParameters : AVAudioMixInputParameters {
  convenience init(track: AVAssetTrack?)

  /*!
   @property		trackID
   @abstract		Indicates the trackID of the audio track to which the parameters should be applied.
  */
  var trackID: CMPersistentTrackID

  /*!
   @property		audioTimePitchAlgorithm
   @abstract		Indicates the processing algorithm used to manage audio pitch at varying rates and for scaled audio edits.
   @discussion
     Constants for various time pitch algorithms, e.g. AVAudioTimePitchSpectral, are defined in AVAudioProcessingSettings.h.
     Can be nil, in which case the audioTimePitchAlgorithm set on the AVPlayerItem, AVAssetExportSession, or AVAssetReaderAudioMixOutput on which the AVAudioMix is set will be used for the associated track.
  */
  @available(iOS 7.0, *)
  var audioTimePitchAlgorithm: String?

  /*!
   @property		audioTapProcessor
   @abstract		Indicates the audio processing tap that will be used for the audio track.
  */
  @available(iOS 6.0, *)
  var audioTapProcessor: MTAudioProcessingTap?
  func setVolumeRampFromStartVolume(startVolume: Float, toEndVolume endVolume: Float, timeRange: CMTimeRange)
  func setVolume(volume: Float, at time: CMTime)
  init()
}

/*! @class AVAudioMixerNode
	@abstract A node that mixes its inputs to a single output.
	@discussion
		Mixers may have any number of inputs.
	
		The mixer accepts input at any sample rate and efficiently combines sample rate
		conversions. It also accepts any channel count and will correctly upmix or downmix
		to the output channel count.
*/
@available(iOS 8.0, *)
class AVAudioMixerNode : AVAudioNode, AVAudioMixing {

  /*! @property outputVolume
  	@abstract The mixer's output volume.
  	@discussion
  		This accesses the mixer's output volume (0.0-1.0, inclusive).
  */
  var outputVolume: Float

  /*! @property nextAvailableInputBus
  	@abstract Find an unused input bus.
  	@discussion
  		This will find and return the first input bus to which no other node is connected.
  */
  var nextAvailableInputBus: AVAudioNodeBus { get }
  init()

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var volume: Float

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  @available(iOS 8.0, *)
  var pan: Float

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var rate: Float

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var reverbBlend: Float

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var obstruction: Float

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var occlusion: Float

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var position: AVAudio3DPoint
}

/*! @protocol   AVAudioMixing
    @abstract   Protocol that defines properties applicable to the input bus of a mixer
                node
    @discussion
        Nodes that conforms to the AVAudioMixing protocol can talk to a mixer node downstream,
        specifically of type AVAudioMixerNode or AVAudioEnvironmentNode. The properties defined 
        by this protocol apply to the respective input bus of the mixer node that the source node is 
        connected to. Note that effect nodes cannot talk to their downstream mixer.

		Properties can be set either on the source node, or directly on individual mixer connections.
		Source node properties are:
		- applied to all existing mixer connections when set
		- applied to new mixer connections
		- preserved upon disconnection from mixers
		- not affected by connections/disconnections to/from mixers
		- not affected by any direct changes to properties on individual mixer connections

		Individual mixer connection properties, when set, will override any values previously derived 
		from the corresponding source node properties. However, if a source node property is 
		subsequently set, it will override the corresponding property value of all individual mixer 
		connections.
		Unlike source node properties, individual mixer connection properties are not preserved upon
		disconnection (see `AVAudioMixing(destinationForMixer:bus:)` and `AVAudioMixingDestination`).

		Source nodes that are connected to a mixer downstream can be disconnected from
		one mixer and connected to another mixer with source node's mixing settings intact.
		For example, an AVAudioPlayerNode that is being used in a gaming scenario can set up its 
		3D mixing settings and then move from one environment to another.
*/
@available(iOS 8.0, *)
protocol AVAudioMixing : AVAudioStereoMixing, AVAudio3DMixing {

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  var volume: Float { get set }
}

/*! @protocol   AVAudioStereoMixing
    @abstract   Protocol that defines stereo mixing properties
*/
@available(iOS 8.0, *)
protocol AVAudioStereoMixing : ObjectProtocol {

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  var pan: Float { get set }
}

/*! @enum AVAudio3DMixingRenderingAlgorithm
    @abstract   Types of rendering algorithms available per input bus of the environment node
    @discussion
        The rendering algorithms differ in terms of quality and cpu cost. 
        AVAudio3DMixingRenderingAlgorithmEqualPowerPanning is the simplest panning algorithm and also 
        the least expensive computationally.
 
        With the exception of AVAudio3DMixingRenderingAlgorithmSoundField, while the mixer is
        rendering to multi channel hardware, audio data will only be rendered to channels 1 & 2.
 
        AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
            EqualPowerPanning merely pans the data of the mixer bus into a stereo field. This 
            algorithm is analogous to the pan knob found on a mixing board channel strip. 
 
        AVAudio3DMixingRenderingAlgorithmSphericalHead
            SphericalHead is designed to emulate 3 dimensional space in headphones by simulating 
            inter-aural time delays and other spatial cues. SphericalHead is slightly less CPU 
            intensive than the HRTF algorithm.
 
        AVAudio3DMixingRenderingAlgorithmHRTF
            HRTF (Head Related Transfer Function) is a high quality algorithm using filtering to 
            emulate 3 dimensional space in headphones. HRTF is a cpu intensive algorithm.
 
        AVAudio3DMixingRenderingAlgorithmSoundField
            SoundField is designed for rendering to multi channel hardware. The mixer takes data 
            being rendered with SoundField and distributes it amongst all the output channels with 
            a weighting toward the location in which the sound derives. It is very effective for 
            ambient sounds, which may derive from a specific location in space, yet should be heard 
            through the listener's entire space.
 
        AVAudio3DMixingRenderingAlgorithmStereoPassThrough
            StereoPassThrough should be used when no localization is desired for the source data. 
            Setting this algorithm tells the mixer to take mono/stereo input and pass it directly to 
            channels 1 & 2 without localization.
 
*/
@available(iOS 8.0, *)
enum AVAudio3DMixingRenderingAlgorithm : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case EqualPowerPanning
  case SphericalHead
  case HRTF
  case SoundField
  case StereoPassThrough
}

/*! @protocol   AVAudio3DMixing
    @abstract   Protocol that defines 3D mixing properties
*/
protocol AVAudio3DMixing : ObjectProtocol {

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm { get set }

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  var rate: Float { get set }

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  var reverbBlend: Float { get set }

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  var obstruction: Float { get set }

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  var occlusion: Float { get set }

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  var position: AVAudio3DPoint { get set }
}

/*! @class AVAudioMixingDestination
	@abstract An object representing a connection to a mixer node from a node that
		conforms to AVAudioMixing protocol
	@discussion
		A standalone instance of AVAudioMixingDestination cannot be created.
		Only an instance vended by a source node (e.g. AVAudioPlayerNode) can be used
		(see `AVAudioMixing`).
*/
@available(iOS 9.0, *)
class AVAudioMixingDestination : Object, AVAudioMixing {

  /*! @property connectionPoint
  	@abstract Returns the underlying mixer connection point
  */
  var connectionPoint: AVAudioConnectionPoint { get }
  init()

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var volume: Float

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  @available(iOS 8.0, *)
  var pan: Float

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 9.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 9.0, *)
  var rate: Float

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 9.0, *)
  var reverbBlend: Float

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 9.0, *)
  var obstruction: Float

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 9.0, *)
  var occlusion: Float

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 9.0, *)
  var position: AVAudio3DPoint
}

/*!	@typedef AVAudioNodeTapBlock
	@abstract A block that receives copies of the output of an AVAudioNode.
	@param buffer
		a buffer of audio captured from the output of an AVAudioNode
	@param when
		the time at which the buffer was captured
	@discussion
		CAUTION: This callback may be invoked on a thread other than the main thread.
*/
typealias AVAudioNodeTapBlock = (AVAudioPCMBuffer, AVAudioTime) -> Void

/*!
	@class AVAudioNode
	@abstract Base class for an audio generation, processing, or I/O block.
	@discussion
		`AVAudioEngine` objects contain instances of various AVAudioNode subclasses. This
		base class provides certain common functionality.
		
		Nodes have input and output busses, which can be thought of as connection points.
		For example, an effect typically has one input bus and one output bus. A mixer
		typically has multiple input busses and one output bus.
		
		Busses have formats, expressed in terms of sample rate and channel count. When making
		connections between nodes, often the format must match exactly. There are exceptions
		(e.g. `AVAudioMixerNode` and `AVAudioOutputNode`).

		Nodes do not currently provide useful functionality until attached to an engine.
*/
@available(iOS 8.0, *)
class AVAudioNode : Object {

  /*! @method reset
  	@abstract Clear a unit's previous processing state.
  */
  func reset()

  /*! @method inputFormatForBus:
  	@abstract Obtain an input bus's format.
  */
  func inputFormatForBus(bus: AVAudioNodeBus) -> AVAudioFormat

  /*! @method outputFormatForBus:
  	@abstract Obtain an output bus's format.
  */
  func outputFormatForBus(bus: AVAudioNodeBus) -> AVAudioFormat

  /*!	@method nameForInputBus:
  	@abstract Return the name of an input bus.
  */
  func nameForInputBus(bus: AVAudioNodeBus) -> String

  /*!	@method nameForOutputBus:
  	@abstract Return the name of an output bus.
  */
  func nameForOutputBus(bus: AVAudioNodeBus) -> String

  /*! @method installTapOnBus:bufferSize:format:block:
  	@abstract Create a "tap" to record/monitor/observe the output of the node.
  	@param bus
  		the node output bus to which to attach the tap
  	@param bufferSize
  		the requested size of the incoming buffers. The implementation may choose another size.
  	@param format
  		If non-nil, attempts to apply this as the format of the specified output bus. This should
  		only be done when attaching to an output bus which is not connected to another node; an
  		error will result otherwise.
  		The tap and connection formats (if non-nil) on the specified bus should be identical. 
  		Otherwise, the latter operation will override any previously set format.
  		Note that for AVAudioOutputNode, tap format must be specified as nil.
  	@param tapBlock
  		a block to be called with audio buffers
  	
  	@discussion
  		Only one tap may be installed on any bus. Taps may be safely installed and removed while
  		the engine is running.
  		
  		E.g. to capture audio from input node:
  <pre>
  AVAudioEngine *engine = [[AVAudioEngine alloc] init];
  AVAudioInputNode *input = [engine inputNode];
  AVAudioFormat *format = [input outputFormatForBus: 0];
  [input installTapOnBus: 0 bufferSize: 8192 format: format block: ^(AVAudioPCMBuffer *buf, AVAudioTime *when) {
  // ‘buf' contains audio captured from input node at time 'when'
  }];
  ....
  // start engine
  </pre>
  */
  func installTapOnBus(bus: AVAudioNodeBus, bufferSize: AVAudioFrameCount, format: AVAudioFormat?, block tapBlock: AVAudioNodeTapBlock)

  /*!	@method removeTapOnBus:
  	@abstract Destroy a tap.
  	@param bus
  		the node output bus whose tap is to be destroyed
  	@return
  		YES for success.
  */
  func removeTapOnBus(bus: AVAudioNodeBus)

  /*!	@property engine
  	@abstract The engine to which the node is attached (or nil).
  */
  var engine: AVAudioEngine? { get }

  /*! @property numberOfInputs
  	@abstract The node's number of input busses.
  */
  var numberOfInputs: Int { get }

  /*! @property numberOfOutputs
  	@abstract The node's number of output busses.
  */
  var numberOfOutputs: Int { get }

  /*! @property lastRenderTime
  	@abstract Obtain the time for which the node most recently rendered.
  	@discussion
  		Will return nil if the engine is not running or if the node is not connected to an input or
  		output node.
  */
  var lastRenderTime: AVAudioTime? { get }
  init()
}
@available(iOS 2.2, *)
class AVAudioPlayer : Object {
  init(contentsOf url: URL) throws
  init(data: Data) throws
  @available(iOS 7.0, *)
  init(contentsOf url: URL, fileTypeHint utiString: String?) throws
  @available(iOS 7.0, *)
  init(data: Data, fileTypeHint utiString: String?) throws
  func prepareToPlay() -> Bool
  func play() -> Bool
  @available(iOS 4.0, *)
  func playAtTime(time: TimeInterval) -> Bool
  func pause()
  func stop()
  var isPlaying: Bool { get }
  var numberOfChannels: Int { get }
  var duration: TimeInterval { get }
  unowned(unsafe) var delegate: @sil_unmanaged AVAudioPlayerDelegate?
  var url: URL? { get }
  var data: Data? { get }
  @available(iOS 4.0, *)
  var pan: Float
  var volume: Float
  @available(iOS 5.0, *)
  var enableRate: Bool
  @available(iOS 5.0, *)
  var rate: Float
  var currentTime: TimeInterval
  @available(iOS 4.0, *)
  var deviceCurrentTime: TimeInterval { get }
  var numberOfLoops: Int
  @available(iOS 4.0, *)
  var settings: [String : AnyObject] { get }
  var isMeteringEnabled: Bool
  func updateMeters()
  func peakPowerForChannel(channelNumber: Int) -> Float
  func averagePowerForChannel(channelNumber: Int) -> Float
  @available(iOS 7.0, *)
  var channelAssignments: [Number]?
  init()
}
protocol AVAudioPlayerDelegate : ObjectProtocol {
  @available(iOS 2.2, *)
  optional func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool)
  @available(iOS 2.2, *)
  optional func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: Error?)
  @available(iOS, introduced=2.2, deprecated=8.0)
  optional func audioPlayerBeginInterruption(player: AVAudioPlayer)
  @available(iOS, introduced=6.0, deprecated=8.0)
  optional func audioPlayerEndInterruption(player: AVAudioPlayer, withOptions flags: Int)
}

/*!
	@enum AVAudioPlayerNodeBufferOptions
	@abstract	Options controlling buffer scheduling.
	
	@constant	AVAudioPlayerNodeBufferLoops
					The buffer loops indefinitely.
	@constant	AVAudioPlayerNodeBufferInterrupts
					The buffer interrupts any buffer already playing.
	@constant	AVAudioPlayerNodeBufferInterruptsAtLoop
					The buffer interrupts any buffer already playing, at its loop point.
*/
@available(iOS 8.0, *)
struct AVAudioPlayerNodeBufferOptions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var Loops: AVAudioPlayerNodeBufferOptions { get }
  static var Interrupts: AVAudioPlayerNodeBufferOptions { get }
  static var InterruptsAtLoop: AVAudioPlayerNodeBufferOptions { get }
}

/*!
	@class AVAudioPlayerNode
	@abstract Play buffers or segments of audio files.
	@discussion
		AVAudioPlayerNode supports scheduling the playback of `AVAudioBuffer` instances,
		or segments of audio files opened via `AVAudioFile`. Buffers and segments may be
		scheduled at specific points in time, or to play immediately following preceding segments.
	
		FORMATS
		
		Normally, you will want to configure the node's output format with the same number of
		channels as are in the files and buffers to be played. Otherwise, channels will be dropped
		or added as required. It is usually better to use an `AVAudioMixerNode` to
		do this.
	
		Similarly, when playing file segments, the node will sample rate convert if necessary, but
		it is often preferable to configure the node's output sample rate to match that of the file(s)
		and use a mixer to perform the rate conversion.
		
		When playing buffers, there is an implicit assumption that the buffers are at the same
		sample rate as the node's output format.
		
		TIMELINES
	
		The usual `AVAudioNode` sample times (as observed by `lastRenderTime`)
		have an arbitrary zero point. AVAudioPlayerNode superimposes a second "player timeline" on
		top of this, to reflect when the player was started, and intervals during which it was
		paused. The methods `nodeTimeForPlayerTime:` and `playerTimeForNodeTime:`
		convert between the two.

		This class' `stop` method unschedules all previously scheduled buffers and
		file segments, and returns the player timeline to sample time 0.

		TIMESTAMPS
		
		The "schedule" methods all take an `AVAudioTime` "when" parameter. This is
		interpreted as follows:
		
		1. nil:
			- if there have been previous commands, the new one is played immediately following the
				last one.
			- otherwise, if the node is playing, the event is played in the very near future.
			- otherwise, the command is played at sample time 0.
		2. sample time:
			- relative to the node's start time (which begins at 0 when the node is started).
		3. host time:
			- ignored unless sample time not valid.
		
		ERRORS
		
		The "schedule" methods can fail if:
		
		1. a buffer's channel count does not match that of the node's output format.
		2. a file can't be accessed.
		3. an AVAudioTime specifies neither a valid sample time or host time.
		4. a segment's start frame or frame count is negative.
*/
@available(iOS 8.0, *)
class AVAudioPlayerNode : AVAudioNode, AVAudioMixing {

  /*! @method scheduleBuffer:completionHandler:
  	@abstract Schedule playing samples from an AVAudioBuffer.
  	@param buffer
  		the buffer to play
  	@param completionHandler
  		called after the buffer has completely played or the player is stopped. may be nil.
  	@discussion
  		Schedules the buffer to be played following any previously scheduled commands.
  */
  func scheduleBuffer(buffer: AVAudioPCMBuffer, completionHandler: AVAudioNodeCompletionHandler? = nil)

  /*! @method scheduleBuffer:atTime:options:completionHandler:
  	@abstract Schedule playing samples from an AVAudioBuffer.
  	@param buffer
  		the buffer to play
  	@param when 
  		the time at which to play the buffer. see the discussion of timestamps, above.
  	@param options
  		options for looping, interrupting other buffers, etc.
  	@param completionHandler
  		called after the buffer has completely played or the player is stopped. may be nil.
  	@discussion
  */
  func scheduleBuffer(buffer: AVAudioPCMBuffer, at when: AVAudioTime?, options: AVAudioPlayerNodeBufferOptions = [], completionHandler: AVAudioNodeCompletionHandler? = nil)

  /*! @method scheduleFile:atTime:completionHandler:
  	@abstract Schedule playing of an entire audio file.
  	@param file
  		the file to play
  	@param when 
  		the time at which to play the file. see the discussion of timestamps, above.
  	@param completionHandler
  		called after the file has completely played or the player is stopped. may be nil.
  */
  func scheduleFile(file: AVAudioFile, at when: AVAudioTime?, completionHandler: AVAudioNodeCompletionHandler? = nil)

  /*! @method scheduleSegment:startingFrame:frameCount:atTime:completionHandler:
  	@abstract Schedule playing a segment of an audio file.
  	@param file
  		the file to play
  	@param startFrame
  		the starting frame position in the stream
  	@param numberFrames
  		the number of frames to play
  	@param when
  		the time at which to play the region. see the discussion of timestamps, above.
  	@param completionHandler
  		called after the segment has completely played or the player is stopped. may be nil.
  */
  func scheduleSegment(file: AVAudioFile, startingFrame startFrame: AVAudioFramePosition, frameCount numberFrames: AVAudioFrameCount, at when: AVAudioTime?, completionHandler: AVAudioNodeCompletionHandler? = nil)

  /*!	@method stop
  	@abstract Clear all of the node's previously scheduled events and stop playback.
  	@discussion
  		All of the node's previously scheduled events are cleared, including any that are in the
  		middle of playing. The node's sample time (and therefore the times to which new events are 
  		to be scheduled) is reset to 0, and will not proceed until the node is started again (via
  		play or playAtTime).
  */
  func stop()

  /*! @method prepareWithFrameCount:
  	@abstract Prepares previously scheduled file regions or buffers for playback.
  	@param frameCount
  		The number of sample frames of data to be prepared before returning.
  	@discussion
  */
  func prepareWithFrameCount(frameCount: AVAudioFrameCount)

  /*!	@method play
  	@abstract Start or resume playback immediately.
  	@discussion
  		equivalent to playAtTime:nil
  */
  func play()

  /*!	@method playAtTime:
  	@abstract Start or resume playback at a specific time.
  	@param when
  		the node time at which to start or resume playback. nil signifies "now".
  	@discussion
  		This node is initially paused. Requests to play buffers or file segments are enqueued, and
  		any necessary decoding begins immediately. Playback does not begin, however, until the player
  		has started playing, via this method.
   
  		E.g. To start a player X seconds in future:
  <pre>
  // start engine and player
  NSError *nsErr = nil;
  [_engine startAndReturnError:&nsErr];
  if (!nsErr) {
  	const float kStartDelayTime = 0.5; // sec
  	AVAudioFormat *outputFormat = [_player outputFormatForBus:0];
  	AVAudioFramePosition startSampleTime = _player.lastRenderTime.sampleTime + kStartDelayTime * outputFormat.sampleRate;
  	AVAudioTime *startTime = [AVAudioTime timeWithSampleTime:startSampleTime atRate:outputFormat.sampleRate];
  	[_player playAtTime:startTime];
  }
  </pre>
  */
  func playAt(when: AVAudioTime?)

  /*! @method pause
  	@abstract Pause playback.
  	@discussion
  		The player's sample time does not advance while the node is paused.
  */
  func pause()

  /*!	@method nodeTimeForPlayerTime:
  	@abstract
  		Convert from player time to node time.
  	@param playerTime
  		a time relative to the player's start time
  	@return
  		a node time
  	@discussion
  		This method and its inverse `playerTimeForNodeTime:` are discussed in the
  		introduction to this class.
  	
  		If the player is not playing when this method is called, nil is returned.
  */
  func nodeTimeForPlayerTime(playerTime: AVAudioTime) -> AVAudioTime?

  /*!	@method playerTimeForNodeTime:
  	@abstract
  		Convert from node time to player time.
  	@param nodeTime
  		a node time
  	@return
  		a time relative to the player's start time
  	@discussion
  		This method and its inverse `nodeTimeForPlayerTime:` are discussed in the
  		introduction to this class.
  	
  		If the player is not playing when this method is called, nil is returned.
  */
  func playerTimeForNodeTime(nodeTime: AVAudioTime) -> AVAudioTime?

  /*!	@property playing
  	@abstract Indicates whether or not the player is playing.
  */
  var isPlaying: Bool { get }
  init()

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var volume: Float

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  @available(iOS 8.0, *)
  var pan: Float

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var rate: Float

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var reverbBlend: Float

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var obstruction: Float

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var occlusion: Float

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var position: AVAudio3DPoint
}

/*!
 @abstract		Values for time pitch algorithm
 
 @constant      AVAudioTimePitchAlgorithmLowQualityZeroLatency
				Low quality, very inexpensive. Suitable for brief fast-forward/rewind effects, low quality voice.
                Rate snapped to {0.5, 0.666667, 0.8, 1.0, 1.25, 1.5, 2.0}.

 @constant      AVAudioTimePitchAlgorithmTimeDomain
				Modest quality, less expensive. Suitable for voice.
                Variable rate from 1/32 to 32.

 @constant      AVAudioTimePitchAlgorithmSpectral
				Highest quality, most computationally expensive. Suitable for music.
                Variable rate from 1/32 to 32.

 @constant      AVAudioTimePitchAlgorithmVarispeed
				High quality, no pitch correction. Pitch varies with rate.
                Variable rate from 1/32 to 32.
 
 @discussion
	On OS X, the default algorithm for all time pitch operations is AVAudioTimePitchAlgorithmSpectral.  On iOS, the default algorithm for playback is AVAudioTimePitchAlgorithmLowQualityZeroLatency and the default for export & other offline processing is AVAudioTimePitchAlgorithmSpectral.

	For scaled audio edits, i.e. when the timeMapping of an AVAssetTrackSegment is between timeRanges of unequal duration, it is important to choose an algorithm that supports the full range of edit rates present in the source media.  AVAudioTimePitchAlgorithmSpectral is often the best choice due to the highly inclusive range of rates it supports, assuming that it is desirable to maintain a constant pitch regardless of the edit rate.  If it is instead desirable to allow the pitch to vary with the edit rate, AVAudioTimePitchAlgorithmVarispeed is the best choice.
 
*/
@available(iOS 7.0, *)
let AVAudioTimePitchAlgorithmLowQualityZeroLatency: String
@available(iOS 7.0, *)
let AVAudioTimePitchAlgorithmTimeDomain: String
@available(iOS 7.0, *)
let AVAudioTimePitchAlgorithmSpectral: String
@available(iOS 7.0, *)
let AVAudioTimePitchAlgorithmVarispeed: String
@available(iOS 3.0, *)
class AVAudioRecorder : Object {
  init(url: URL, settings: [String : AnyObject]) throws
  func prepareToRecord() -> Bool
  func record() -> Bool
  @available(iOS 6.0, *)
  func recordAtTime(time: TimeInterval) -> Bool
  func recordForDuration(duration: TimeInterval) -> Bool
  @available(iOS 6.0, *)
  func recordAtTime(time: TimeInterval, forDuration duration: TimeInterval) -> Bool
  func pause()
  func stop()
  func deleteRecording() -> Bool
  var isRecording: Bool { get }
  var url: URL { get }
  var settings: [String : AnyObject] { get }
  unowned(unsafe) var delegate: @sil_unmanaged AVAudioRecorderDelegate?
  var currentTime: TimeInterval { get }
  @available(iOS 6.0, *)
  var deviceCurrentTime: TimeInterval { get }
  var isMeteringEnabled: Bool
  func updateMeters()
  func peakPowerForChannel(channelNumber: Int) -> Float
  func averagePowerForChannel(channelNumber: Int) -> Float
  @available(iOS 7.0, *)
  var channelAssignments: [Number]?
  init()
}
protocol AVAudioRecorderDelegate : ObjectProtocol {
  @available(iOS 3.0, *)
  optional func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool)
  @available(iOS 3.0, *)
  optional func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: Error?)
  @available(iOS, introduced=2.2, deprecated=8.0)
  optional func audioRecorderBeginInterruption(recorder: AVAudioRecorder)
  @available(iOS, introduced=6.0, deprecated=8.0)
  optional func audioRecorderEndInterruption(recorder: AVAudioRecorder, withOptions flags: Int)
}

/*!	@typedef AVMusicTimeStamp
	@abstract A fractional number of beats
	
	@discussion
 		This is used for all sequencer timeline-related methods.  The relationship between this
 		value and time in seconds is determined by the sequence's tempo.
 */
typealias AVMusicTimeStamp = Float64

/*! @typedef AVMusicSequenceLoadOptions
 	@abstract Determines whether data on different MIDI channels is mapped to multiple tracks, or if the tracks are preserved as-is.
 	@discussion
		If AVMusicSequenceLoadSMF_ChannelsToTracks is set, the loaded MIDI Sequence will contain a tempo track,
		one track for each MIDI channel that is found in the SMF, and one track for SysEx and/or MetaEvents (this will
 		be the last track in the sequence).
 		If AVMusicSequenceLoadSMF_PreserveTracks is set, the loadad MIDI Sequence will contain one track for each track
 		that is found in the SMF, plus a tempo track (if not found in the SMF).
*/
@available(iOS 9.0, *)
struct AVMusicSequenceLoadOptions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var SMF_PreserveTracks: AVMusicSequenceLoadOptions { get }
  static var SMF_ChannelsToTracks: AVMusicSequenceLoadOptions { get }
}

/*! @typedef AVBeatRange
 	@abstract Used to describe a specific time range within an AVMusicTrack.
*/
struct _AVBeatRange {
  var start: AVMusicTimeStamp
  var length: AVMusicTimeStamp
  init()
  init(start: AVMusicTimeStamp, length: AVMusicTimeStamp)
}
typealias AVBeatRange = _AVBeatRange
func AVMakeBeatRange(startBeat: AVMusicTimeStamp, _ lengthInBeats: AVMusicTimeStamp) -> AVBeatRange

/*! @class AVAudioSequencer
    @abstract A collection of MIDI events organized into AVMusicTracks, plus a player to play back the events.
 */
@available(iOS 9.0, *)
class AVAudioSequencer : Object {

  /*! @method init
  	@abstract
  		Initialize a new sequencer, which will not be connected to an audio engine.
   	@discussion
   		This is used to create a sequencer whose tracks will only send events to external MIDI endpoints.
   */
  init()

  /*! @method initWithAudioEngine:
  	@abstract
  		Initialize a new sequencer, handing it the audio engine.
  */
  init(audioEngine engine: AVAudioEngine)

  /*! @method loadFromURL:options:error:
  	@abstract Load the file referenced by the URL and add the events to the sequence
   	@param fileURL
   	@param options
   		determines how the file's contents are mapped to tracks inside the sequence
  	@param outError
  */
  func loadFrom(fileURL: URL, options: AVMusicSequenceLoadOptions = []) throws

  /*! @method loadFromData:options:error:
  	@abstract Parse the data and add the its events to the sequence
  	@param data
  	@param options
   		determines how the contents are mapped to tracks inside the sequence
  	@param outError
  */
  func loadFrom(data: Data, options: AVMusicSequenceLoadOptions = []) throws

  /*! @method writeToURL:SMPTEResolution:replaceExisting:error:
  	@abstract Create and write a MIDI file from the events in the sequence
   	@param fileURL
   		the path for the file to be created
  	@param resolution
  		the relationship between "tick" and quarter note for saving to a Standard MIDI File - pass in
  		zero to use default - this will be the value that is currently set on the tempo track
  	@param replace
  		if the file already exists, YES will cause it to be overwritten with the new data.
  		Otherwise the call will fail with a permission error.
  	@param outError
  	@discussion
  		Only MIDI events are written when writing to the MIDI file. MIDI files are normally beat
   		based, but can also have a SMPTE (or real-time rather than beat time) representation.
   		The relationship between "tick" and quarter note for saving to Standard MIDI File
  		- pass in zero to use default - this will be the value that is currently set on the tempo track
   */
  func writeTo(fileURL: URL, smpteResolution resolution: Int, replaceExisting replace: Bool) throws

  /*!	@method dataWithSMPTEResolution:error:
   	@abstract Return a data object containing the events from the sequence
   	@discussion
   		All details regarding the SMPTE resolution apply here as well.
   		The returned NSData lifetime is controlled by the client.
  */
  func dataWithSMPTEResolution(SMPTEResolution: Int, error outError: ErrorPointer) -> Data

  /*!	@method secondsForBeats:
  	@abstract Get the time in seconds for the given beat position (timestamp) in the track
  */
  func secondsForBeats(beats: AVMusicTimeStamp) -> TimeInterval

  /*!	@method beatsForSeconds:
  	@abstract Get the beat position (timestamp) for the given time in the track
  */
  func beatsForSeconds(seconds: TimeInterval) -> AVMusicTimeStamp

  /*!	@property tracks
  	@abstract An NSArray containing all the tracks in the sequence
  	@discussion
  		Track indices count from 0, and do not include the tempo track.
   */
  var tracks: [AVMusicTrack] { get }

  /*!	@property tempoTrack
  	@abstract The tempo track
  	 @discussion
  		 Each sequence has a single tempo track. All tempo events are placed into this track (as well
  		 as other appropriate events (for instance, the time signature from a MIDI file). The tempo
  		 track can be edited and iterated upon as any other track. Non-tempo events in a tempo track
  		 are ignored.
  */
  var tempoTrack: AVMusicTrack { get }

  /*!	@property userInfo
   	@abstract A dictionary containing meta-data derived from a sequence
   	@discussion
   		The dictionary can contain one or more of the kAFInfoDictionary_* keys
  		specified in <AudioToolbox/AudioFile.h>
  */
  var userInfo: [String : AnyObject] { get }
}
extension AVAudioSequencer {

  /*! @property currentPositionInSeconds
  	@abstract The current playback position in seconds
  	@discussion
  		Setting this positions the sequencer's player to the specified time.  This can be set while
  		the player is playing, in which case playback will resume at the new position.
   */
  var currentPositionInSeconds: TimeInterval

  /*! @property currentPositionInBeats
  	@abstract The current playback position in beats
  	@discussion
  		Setting this positions the sequencer's player to the specified beat.  This can be set while
  		the player is playing, in which case playback will resume at the new position.
   */
  var currentPositionInBeats: TimeInterval

  /*! @property playing
  	@abstract Indicates whether or not the sequencer's player is playing
  	@discussion
  		Returns TRUE if the sequencer's player has been started and not stopped. It may have
  		"played" past the end of the events in the sequence, but it is still considered to be
  		playing (and its time value increasing) until it is explicitly stopped.
   */
  var isPlaying: Bool { get }

  /*! @property rate
  	@abstract The playback rate of the sequencer's player
  	@discussion
  		1.0 is normal playback rate.  Rate must be > 0.0.
   */
  var rate: Float

  /*!	@method hostTimeForBeats:error:
  	@abstract Returns the host time that will be (or was) played at the specified beat.
      @discussion
  		This call is only valid if the player is playing and will return 0 with an error if the
  		player is not playing or if the starting position of the player (its "starting beat") was 
  		after the specified beat.  The method uses the sequence's tempo map to translate a beat
  		time from the starting time and beat of the player.
  */
  func hostTimeForBeats(inBeats: AVMusicTimeStamp, error outError: ErrorPointer) -> UInt64

  /*!	@method beatsForHostTime:error:
  	@abstract Returns the beat that will be (or was) played at the specified host time.
      @discussion
  		This call is only valid if the player is playing and will return 0 with an error if the
  		player is not playing or if the starting time of the player was after the specified host
  		time.  The method uses the sequence's tempo map to retrieve a beat time from the starting
  		and specified host time.
  */
  func beatsForHostTime(inHostTime: UInt64, error outError: ErrorPointer) -> AVMusicTimeStamp

  /*! @method prepareToPlay
  	@abstract Get ready to play the sequence by prerolling all events
  	@discussion
  		Happens automatically on play if it has not already been called, but may produce a delay in startup.
   */
  func prepareToPlay()

  /*!	@method	startAndReturnError:
  	@abstract	Start the sequencer's player
  	@discussion
  		If the AVAudioSequencer has not been prerolled, it will pre-roll itself and then start.
  */
  func start() throws

  /*!	@method	stop
  	@abstract	Stop the sequencer's player
  	@discussion
   		Stopping the player leaves it in an un-prerolled state, but stores the playback position so that
   		a subsequent call to startAndReturnError will resume where it left off.
   		This action will not stop an associated audio engine.
  */
  func stop()
}

/*! @class AVMusicTrack
    @abstract A collection of music events which will be sent to a given destination, and which can be 
 				offset, muted, etc. independently of events in other tracks.
 */
@available(iOS 9.0, *)
class AVMusicTrack : Object {

  /*!	@property destinationAudioUnit
  	@abstract The AVAudioUnit which will receive the track's events
  	@discussion
  		This is mutually exclusive with setting a destination MIDIEndpoint.  The AU must already
  		be attached to an audio engine, and the track must be part of the AVAudioSequencer
  		associated with that engine. When playing, the track will send its events to that AVAudioUnit.
  		The destination AU cannot be changed while the track's sequence is playing.
   */
  var destinationAudioUnit: AVAudioUnit?
  var destinationMIDIEndpoint: MIDIEndpointRef

  /*!	@property loopRange
   	@abstract The timestamp range in beats for the loop
   	@discussion
  		The loop is set by specifying its beat range.
  */
  var loopRange: AVBeatRange

  /*!	@property loopingEnabled
  	@abstract Determines whether or not the track is looped.
  	@discussion
  		If loopRange has not been set, the full track will be looped.
  */
  var isLoopingEnabled: Bool

  /*!	@property numberOfLoops
   	@abstract The number of times that the track's loop will repeat
   	@discussion
   		If set to AVMusicTrackLoopCountForever, the track will loop forever.
   		Otherwise, legal values start with 1.
  */
  var numberOfLoops: Int

  /*! @property offsetTime
      @abstract Offset the track's start time to the specified time in beats
   	@discussion
          By default this value is zero.
  */
  var offsetTime: AVMusicTimeStamp

  /*! @property muted
      @abstract Whether the track is muted
  */
  var isMuted: Bool

  /*! @property soloed
      @abstract Whether the track is soloed
  */
  var isSoloed: Bool

  /*! @property lengthInBeats
      @abstract The total duration of the track in beats
      @discussion
  		This will return the beat of the last event in the track plus any additional time that may be
  		needed for fading out of ending notes or round a loop point to musical bar, etc.  If this
  		has not been set by the user, the track length will always be adjusted to the end of the
  		last active event in a track and is adjusted dynamically as events are added or removed.
  
  		The property will return the maximum of the user-set track length, or the calculated length.
  */
  var lengthInBeats: AVMusicTimeStamp

  /*! @property lengthInSeconds
      @abstract The total duration of the track in seconds
      @discussion
  		This will return time of the last event in the track plus any additional time that may be
  		needed for fading out of ending notes or round a loop point to musical bar, etc.  If this
  		has not been set by the user, the track length will always be adjusted to the end of the
  		last active event in a track and is adjusted dynamically as events are added or removed.
   
   The property will return the maximum of the user-set track length, or the calculated length.
   */
  var lengthInSeconds: TimeInterval

  /*! @property timeResolution
      @abstract The time resolution value for the sequence, in ticks (pulses) per quarter note (PPQN)
      @discussion
  		If a MIDI file was used to construct the containing sequence, the resolution will be what
  		was in the file. If you want to keep a time resolution when writing a new file, you can
  		retrieve this value and then specify it when calling -[AVAudioSequencer
  		writeToFile:flags:withResolution]. It has no direct bearing on the rendering or notion of
  		time of the sequence itself, just its representation in MIDI files. By default this is set
  		to either 480 if the sequence was created manually, or a value based on what was in a MIDI
  		file if the sequence was created from a MIDI file.
  		This can only be retrieved from the tempo track.
  */
  var timeResolution: Int { get }
  init()
}
@available(iOS 8.0, *)
enum AVMusicTrackLoopCount : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Forever
}
@available(iOS 6.0, *)
struct AVAudioSessionInterruptionOptions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var ShouldResume: AVAudioSessionInterruptionOptions { get }
}
@available(iOS 6.0, *)
struct AVAudioSessionSetActiveOptions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var NotifyOthersOnDeactivation: AVAudioSessionSetActiveOptions { get }
}
@available(iOS 6.0, *)
enum AVAudioSessionPortOverride : UInt {
  init?(rawValue: UInt)
  var rawValue: UInt { get }
  case None
  case Speaker
}
@available(iOS 6.0, *)
enum AVAudioSessionRouteChangeReason : UInt {
  init?(rawValue: UInt)
  var rawValue: UInt { get }
  case Unknown
  case NewDeviceAvailable
  case OldDeviceUnavailable
  case CategoryChange
  case Override
  case WakeFromSleep
  case NoSuitableRouteForCategory
  @available(iOS 7.0, *)
  case RouteConfigurationChange
}
@available(iOS 6.0, *)
struct AVAudioSessionCategoryOptions : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var MixWithOthers: AVAudioSessionCategoryOptions { get }
  static var DuckOthers: AVAudioSessionCategoryOptions { get }
  static var AllowBluetooth: AVAudioSessionCategoryOptions { get }
  static var DefaultToSpeaker: AVAudioSessionCategoryOptions { get }
  @available(iOS 9.0, *)
  static var InterruptSpokenAudioAndMixWithOthers: AVAudioSessionCategoryOptions { get }
}
@available(iOS 6.0, *)
enum AVAudioSessionInterruptionType : UInt {
  init?(rawValue: UInt)
  var rawValue: UInt { get }
  case Began
  case Ended
}
@available(iOS 8.0, *)
enum AVAudioSessionSilenceSecondaryAudioHintType : UInt {
  init?(rawValue: UInt)
  var rawValue: UInt { get }
  case Begin
  case End
}

/*!
	@enum AVAudioSessionRecordPermission values
	@abstract   These are the values returned by recordPermission.
	@constant   AVAudioSessionRecordPermissionUndetermined
		The user has not yet been asked for permission.
	@constant   AVAudioSessionRecordPermissionDenied
 		The user has been asked and has denied permission.
	@constant   AVAudioSessionRecordPermissionGranted
 		The user has been asked and has granted permission.
*/
@available(iOS 8.0, *)
struct AVAudioSessionRecordPermission : OptionSetType {
  init(rawValue: UInt)
  let rawValue: UInt
  static var Undetermined: AVAudioSessionRecordPermission { get }
  static var Denied: AVAudioSessionRecordPermission { get }
  static var Granted: AVAudioSessionRecordPermission { get }
}

/*!
	@enum AVAudioSession error codes
	@abstract   These are the error codes returned from the AVAudioSession API.
	@constant   AVAudioSessionErrorCodeNone
		Operation succeeded.
	@constant   AVAudioSessionErrorCodeMediaServicesFailed
		The app attempted to use the audio session during or after a Media Services failure.  App should
 		wait for a AVAudioSessionMediaServicesWereResetNotification and then rebuild all its state.
	@constant	AVAudioSessionErrorCodeIsBusy
 		The app attempted to set its audio session inactive, but it is still actively playing and/or recording.
 	@constant	AVAudioSessionErrorCodeIncompatibleCategory
 		The app tried to perform an operation on a session but its category does not support it.
 		For instance, if the app calls setPreferredInputNumberOfChannels: while in a playback-only category.
	@constant	AVAudioSessionErrorCodeCannotInterruptOthers
		The app's audio session is non-mixable and trying to go active while in the background.
 		This is allowed only when the app is the NowPlaying app.
	@constant	AVAudioSessionErrorCodeMissingEntitlement
		The app does not have the required entitlements to perform an operation.
	@constant	AVAudioSessionErrorCodeSiriIsRecording
 		The app tried to do something with the audio session that is not allowed while Siri is recording.
 	@constant	AVAudioSessionErrorCodeCannotStartPlaying
		The app is not allowed to start recording and/or playing, usually because of a lack of audio key in
 		its Info.plist.  This could also happen if the app has this key but uses a category that can't record 
 		and/or play in the background (AVAudioSessionCategoryAmbient, AVAudioSessionCategorySoloAmbient, etc.).
	@constant	AVAudioSessionErrorCodeCannotStartRecording
		The app is not allowed to start recording, usually because it is starting a mixable recording from the
 		background and is not an Inter-App Audio app.
	@constant	AVAudioSessionErrorCodeBadParam
 		An illegal value was used for a property.
	@constant	AVAudioSessionErrorInsufficientPriority
 		The app was not allowed to set the audio category because another app (Phone, etc.) is controlling it.
	@constant	AVAudioSessionErrorCodeResourceNotAvailable
		The operation failed because the device does not have sufficient hardware resources to complete the action. 
		For example, the operation requires audio input hardware, but the device has no audio input available.
	@constant	AVAudioSessionErrorCodeUnspecified
 		An unspecified error has occurred.
*/
@available(iOS 7.0, *)
enum AVAudioSessionErrorCode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case CodeNone
  case CodeMediaServicesFailed
  case CodeIsBusy
  case CodeIncompatibleCategory
  case CodeCannotInterruptOthers
  case CodeMissingEntitlement
  case CodeSiriIsRecording
  case CodeCannotStartPlaying
  case CodeCannotStartRecording
  case CodeBadParam
  case InsufficientPriority
  case CodeResourceNotAvailable
  case CodeUnspecified
}
@available(iOS 3.0, *)
class AVAudioSession : Object {
  class func sharedInstance() -> AVAudioSession
  func setActive(active: Bool) throws
  @available(iOS 6.0, *)
  func setActive(active: Bool, withOptions options: AVAudioSessionSetActiveOptions = []) throws
  @available(iOS 9.0, *)
  var availableCategories: [String] { get }
  func setCategory(category: String) throws
  @available(iOS 6.0, *)
  func setCategory(category: String, withOptions options: AVAudioSessionCategoryOptions = []) throws
  var category: String { get }
  @available(iOS 8.0, *)
  func recordPermission() -> AVAudioSessionRecordPermission
  @available(iOS 7.0, *)
  func requestRecordPermission(response: PermissionBlock)
  @available(iOS 6.0, *)
  var categoryOptions: AVAudioSessionCategoryOptions { get }
  @available(iOS 9.0, *)
  var availableModes: [String] { get }
  @available(iOS 5.0, *)
  func setMode(mode: String) throws
  @available(iOS 5.0, *)
  var mode: String { get }
  @available(iOS 6.0, *)
  func overrideOutputAudioPort(portOverride: AVAudioSessionPortOverride) throws
  @available(iOS 6.0, *)
  var isOtherAudioPlaying: Bool { get }
  @available(iOS 8.0, *)
  var secondaryAudioShouldBeSilencedHint: Bool { get }
  @available(iOS 6.0, *)
  var currentRoute: AVAudioSessionRouteDescription { get }
  @available(iOS 7.0, *)
  func setPreferredInput(inPort: AVAudioSessionPortDescription?) throws
  @available(iOS 7.0, *)
  var preferredInput: AVAudioSessionPortDescription? { get }
  @available(iOS 7.0, *)
  var availableInputs: [AVAudioSessionPortDescription]? { get }
  init()
}
typealias PermissionBlock = (Bool) -> Void
extension AVAudioSession {
  @available(iOS 6.0, *)
  func setPreferredSampleRate(sampleRate: Double) throws
  @available(iOS 6.0, *)
  var preferredSampleRate: Double { get }
  func setPreferredIOBufferDuration(duration: TimeInterval) throws
  var preferredIOBufferDuration: TimeInterval { get }
  @available(iOS 7.0, *)
  func setPreferredInputNumberOfChannels(count: Int) throws
  @available(iOS 7.0, *)
  var preferredInputNumberOfChannels: Int { get }
  @available(iOS 7.0, *)
  func setPreferredOutputNumberOfChannels(count: Int) throws
  @available(iOS 7.0, *)
  var preferredOutputNumberOfChannels: Int { get }
  @available(iOS 7.0, *)
  var maximumInputNumberOfChannels: Int { get }
  @available(iOS 7.0, *)
  var maximumOutputNumberOfChannels: Int { get }
  @available(iOS 6.0, *)
  func setInputGain(gain: Float) throws
  @available(iOS 6.0, *)
  var inputGain: Float { get }
  @available(iOS 6.0, *)
  var isInputGainSettable: Bool { get }
  @available(iOS 6.0, *)
  var isInputAvailable: Bool { get }
  @available(iOS 6.0, *)
  var inputDataSources: [AVAudioSessionDataSourceDescription]? { get }
  @available(iOS 6.0, *)
  var inputDataSource: AVAudioSessionDataSourceDescription? { get }
  @available(iOS 6.0, *)
  func setInputDataSource(dataSource: AVAudioSessionDataSourceDescription?) throws
  @available(iOS 6.0, *)
  var outputDataSources: [AVAudioSessionDataSourceDescription]? { get }
  @available(iOS 6.0, *)
  var outputDataSource: AVAudioSessionDataSourceDescription? { get }
  @available(iOS 6.0, *)
  func setOutputDataSource(dataSource: AVAudioSessionDataSourceDescription?) throws
  @available(iOS 6.0, *)
  var sampleRate: Double { get }
  @available(iOS 6.0, *)
  var inputNumberOfChannels: Int { get }
  @available(iOS 6.0, *)
  var outputNumberOfChannels: Int { get }
  @available(iOS 6.0, *)
  var outputVolume: Float { get }
  @available(iOS 6.0, *)
  var inputLatency: TimeInterval { get }
  @available(iOS 6.0, *)
  var outputLatency: TimeInterval { get }
  @available(iOS 6.0, *)
  var ioBufferDuration: TimeInterval { get }
}
extension AVAudioSession {
}
@available(iOS 6.0, *)
let AVAudioSessionInterruptionNotification: String
@available(iOS 6.0, *)
let AVAudioSessionRouteChangeNotification: String
@available(iOS 7.0, *)
let AVAudioSessionMediaServicesWereLostNotification: String
@available(iOS 6.0, *)
let AVAudioSessionMediaServicesWereResetNotification: String
@available(iOS 8.0, *)
let AVAudioSessionSilenceSecondaryAudioHintNotification: String
@available(iOS 6.0, *)
let AVAudioSessionInterruptionTypeKey: String
@available(iOS 6.0, *)
let AVAudioSessionInterruptionOptionKey: String
@available(iOS 6.0, *)
let AVAudioSessionRouteChangeReasonKey: String
@available(iOS 6.0, *)
let AVAudioSessionRouteChangePreviousRouteKey: String
@available(iOS 8.0, *)
let AVAudioSessionSilenceSecondaryAudioHintTypeKey: String
let AVAudioSessionCategoryAmbient: String
let AVAudioSessionCategorySoloAmbient: String
let AVAudioSessionCategoryPlayback: String
let AVAudioSessionCategoryRecord: String
let AVAudioSessionCategoryPlayAndRecord: String
let AVAudioSessionCategoryAudioProcessing: String
@available(iOS 6.0, *)
let AVAudioSessionCategoryMultiRoute: String

/*!
@abstract      Modes modify the audio category in order to introduce behavior that is tailored to the specific
use of audio within an application.  Available in iOS 5.0 and greater.
 */
@available(iOS 5.0, *)
let AVAudioSessionModeDefault: String
@available(iOS 5.0, *)
let AVAudioSessionModeVoiceChat: String
@available(iOS 5.0, *)
let AVAudioSessionModeGameChat: String
@available(iOS 5.0, *)
let AVAudioSessionModeVideoRecording: String
@available(iOS 5.0, *)
let AVAudioSessionModeMeasurement: String
@available(iOS 6.0, *)
let AVAudioSessionModeMoviePlayback: String
@available(iOS 7.0, *)
let AVAudioSessionModeVideoChat: String
@available(iOS 9.0, *)
let AVAudioSessionModeSpokenAudio: String
@available(iOS 6.0, *)
let AVAudioSessionPortLineIn: String
@available(iOS 6.0, *)
let AVAudioSessionPortBuiltInMic: String
@available(iOS 6.0, *)
let AVAudioSessionPortHeadsetMic: String
@available(iOS 6.0, *)
let AVAudioSessionPortLineOut: String
@available(iOS 6.0, *)
let AVAudioSessionPortHeadphones: String
@available(iOS 6.0, *)
let AVAudioSessionPortBluetoothA2DP: String
@available(iOS 6.0, *)
let AVAudioSessionPortBuiltInReceiver: String
@available(iOS 6.0, *)
let AVAudioSessionPortBuiltInSpeaker: String
@available(iOS 6.0, *)
let AVAudioSessionPortHDMI: String
@available(iOS 6.0, *)
let AVAudioSessionPortAirPlay: String
@available(iOS 7.0, *)
let AVAudioSessionPortBluetoothLE: String
@available(iOS 6.0, *)
let AVAudioSessionPortBluetoothHFP: String
@available(iOS 6.0, *)
let AVAudioSessionPortUSBAudio: String
@available(iOS 7.0, *)
let AVAudioSessionPortCarAudio: String
@available(iOS 7.0, *)
let AVAudioSessionLocationUpper: String
@available(iOS 7.0, *)
let AVAudioSessionLocationLower: String
@available(iOS 7.0, *)
let AVAudioSessionOrientationTop: String
@available(iOS 7.0, *)
let AVAudioSessionOrientationBottom: String
@available(iOS 7.0, *)
let AVAudioSessionOrientationFront: String
@available(iOS 7.0, *)
let AVAudioSessionOrientationBack: String
@available(iOS 8.0, *)
let AVAudioSessionOrientationLeft: String
@available(iOS 8.0, *)
let AVAudioSessionOrientationRight: String
@available(iOS 7.0, *)
let AVAudioSessionPolarPatternOmnidirectional: String
@available(iOS 7.0, *)
let AVAudioSessionPolarPatternCardioid: String
@available(iOS 7.0, *)
let AVAudioSessionPolarPatternSubcardioid: String
@available(iOS 6.0, *)
class AVAudioSessionChannelDescription : Object {
  var channelName: String { get }
  var owningPortUID: String { get }
  var channelNumber: Int { get }
  var channelLabel: AudioChannelLabel { get }
  init()
}
@available(iOS 6.0, *)
class AVAudioSessionPortDescription : Object {
  var portType: String { get }
  var portName: String { get }
  var uid: String { get }
  var channels: [AVAudioSessionChannelDescription]? { get }
  @available(iOS 7.0, *)
  var dataSources: [AVAudioSessionDataSourceDescription]? { get }
  @available(iOS 7.0, *)
  var selectedDataSource: AVAudioSessionDataSourceDescription? { get }
  @available(iOS 7.0, *)
  var preferredDataSource: AVAudioSessionDataSourceDescription? { get }
  @available(iOS 7.0, *)
  func setPreferredDataSource(dataSource: AVAudioSessionDataSourceDescription?) throws
  init()
}
@available(iOS 6.0, *)
class AVAudioSessionRouteDescription : Object {
  var inputs: [AVAudioSessionPortDescription] { get }
  var outputs: [AVAudioSessionPortDescription] { get }
  init()
}
@available(iOS 6.0, *)
class AVAudioSessionDataSourceDescription : Object {
  var dataSourceID: Number { get }
  var dataSourceName: String { get }
  @available(iOS 7.0, *)
  var location: String? { get }
  @available(iOS 7.0, *)
  var orientation: String? { get }
  @available(iOS 7.0, *)
  var supportedPolarPatterns: [String]? { get }
  @available(iOS 7.0, *)
  var selectedPolarPattern: String? { get }
  @available(iOS 7.0, *)
  var preferredPolarPattern: String? { get }
  @available(iOS 7.0, *)
  func setPreferredPolarPattern(pattern: String?) throws
  init()
}
protocol AVAudioSessionDelegate : ObjectProtocol {
  optional func beginInterruption()
  @available(iOS 4.0, *)
  optional func endInterruptionWithFlags(flags: Int)
  optional func endInterruption()
  optional func inputIsAvailableChanged(isInputAvailable: Bool)
}
var AVAudioSessionInterruptionFlags_ShouldResume: Int { get }
var AVAudioSessionSetActiveFlags_NotifyOthersOnDeactivation: Int { get }
let AVFormatIDKey: String
let AVSampleRateKey: String
let AVNumberOfChannelsKey: String
let AVLinearPCMBitDepthKey: String
let AVLinearPCMIsBigEndianKey: String
let AVLinearPCMIsFloatKey: String
@available(iOS 4.0, *)
let AVLinearPCMIsNonInterleaved: String
let AVEncoderAudioQualityKey: String
@available(iOS 7.0, *)
let AVEncoderAudioQualityForVBRKey: String
let AVEncoderBitRateKey: String
@available(iOS 4.0, *)
let AVEncoderBitRatePerChannelKey: String
@available(iOS 7.0, *)
let AVEncoderBitRateStrategyKey: String
let AVEncoderBitDepthHintKey: String
@available(iOS 7.0, *)
let AVSampleRateConverterAlgorithmKey: String
let AVSampleRateConverterAudioQualityKey: String
@available(iOS 4.0, *)
let AVChannelLayoutKey: String
@available(iOS 7.0, *)
let AVAudioBitRateStrategy_Constant: String
@available(iOS 7.0, *)
let AVAudioBitRateStrategy_LongTermAverage: String
@available(iOS 7.0, *)
let AVAudioBitRateStrategy_VariableConstrained: String
@available(iOS 7.0, *)
let AVAudioBitRateStrategy_Variable: String
@available(iOS 7.0, *)
let AVSampleRateConverterAlgorithm_Normal: String
@available(iOS 7.0, *)
let AVSampleRateConverterAlgorithm_Mastering: String
enum AVAudioQuality : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Min
  case Low
  case Medium
  case High
  case Max
}

/*!
	@class AVAudioTime
	@abstract Represent a moment in time.
	@discussion
		AVAudioTime is used in AVAudioEngine to represent time. Instances are immutable.
		
		A single moment in time may be represented in two different ways:
		1. mach_absolute_time(), the system's basic clock. Commonly referred to as "host time."
		2. audio samples at a particular sample rate
		
		A single AVAudioTime instance may contain either or both representations; it might
		represent only a sample time, only a host time, or both.
		
Rationale for using host time:
[a] internally we are using AudioTimeStamp, which uses host time, and it seems silly to divide
[b] it is consistent with a standard system timing service
[c] we do provide conveniences to convert between host ticks and seconds (host time divided by
	frequency) so client code wanting to do what should be straightforward time computations can at 
	least not be cluttered by ugly multiplications and divisions by the host clock frequency.
*/
@available(iOS 8.0, *)
class AVAudioTime : Object {

  /*!	@method initWithAudioTimeStamp:sampleRate:
  */
  init(audioTimeStamp ts: UnsafePointer<AudioTimeStamp>, sampleRate: Double)

  /*! @method initWithHostTime:
  */
  init(hostTime: UInt64)

  /*! @method initWithSampleTime:atRate:
  */
  init(sampleTime: AVAudioFramePosition, atRate sampleRate: Double)

  /*! @method initWithHostTime:sampleTime:atRate:
  */
  init(hostTime: UInt64, sampleTime: AVAudioFramePosition, atRate sampleRate: Double)

  /*!	@method hostTimeForSeconds:
  	@abstract Convert seconds to host time.
  */
  class func hostTimeForSeconds(seconds: TimeInterval) -> UInt64

  /*!	@method secondsForHostTime:
  	@abstract Convert host time to seconds.
  */
  class func secondsForHostTime(hostTime: UInt64) -> TimeInterval

  /*!	@method extrapolateTimeFromAnchor:
  	@abstract Converts between host and sample time.
  	@param anchorTime
  		An AVAudioTime with a more complete AudioTimeStamp than that of the receiver (self).
  	@return
  		the extrapolated time
  	@discussion
  		If anchorTime is an AVAudioTime where both host time and sample time are valid,
  		and self is another timestamp where only one of the two is valid, this method
  		returns a new AVAudioTime copied from self and where any additional valid fields provided by
  		the anchor are also valid.
  
  <pre>
  // time0 has a valid audio sample representation, but no host time representation.
  AVAudioTime *time0 = [AVAudioTime timeWithSampleTime: 0.0 atRate: 44100.0];
  // anchor has a valid host time representation and sample time representation.
  AVAudioTime *anchor = [player playerTimeForNodeTime: player.lastRenderTime];
  // fill in valid host time representation
  AVAudioTime *fullTime0 = [time0 extrapolateTimeFromAnchor: anchor];
  </pre>
  */
  func extrapolateTimeFromAnchor(anchorTime: AVAudioTime) -> AVAudioTime

  /*! @property hostTimeValid
  	@abstract Whether the hostTime property is valid.
  */
  var isHostTimeValid: Bool { get }

  /*! @property hostTime
  	@abstract The host time.
  */
  var hostTime: UInt64 { get }

  /*! @property sampleTimeValid
  	@abstract Whether the sampleTime and sampleRate properties are valid.
  */
  var isSampleTimeValid: Bool { get }

  /*!	@property sampleTime
  	@abstract The time as a number of audio samples, as tracked by the current audio device.
  */
  var sampleTime: AVAudioFramePosition { get }

  /*!	@property sampleRate
  	@abstract The sample rate at which sampleTime is being expressed.
  */
  var sampleRate: Double { get }

  /*! @property audioTimeStamp
  	@abstract The time expressed as an AudioTimeStamp structure.
  	@discussion
  		This may be useful for compatibility with lower-level CoreAudio and AudioToolbox API's.
  */
  var audioTimeStamp: AudioTimeStamp { get }
  init()
}

/*! @typedef AVAudioFramePosition
	@abstract A position in an audio file or stream.
*/
typealias AVAudioFramePosition = Int64

/*!	@typedef AVAudioFrameCount
	@abstract A number of audio sample frames.
	
	@discussion
		Rationale: making this a potentially larger-than-32-bit type like NSUInteger would open the
		door to a large set of runtime failures due to underlying implementations' use of UInt32.
		
		TODO: Remove rationales.
*/
typealias AVAudioFrameCount = UInt32

/*!	@typedef AVAudioPacketCount
	@abstract A number of packets of compressed audio data.
	
	@discussion
		Rationale: making this a potentially larger-than-32-bit type like NSUInteger would open the
		door to a large set of runtime failures due to underlying implementations' use of UInt32.
		
		TODO: Remove rationales.
*/
typealias AVAudioPacketCount = UInt32

/*!	@typedef AVAudioChannelCount
	@abstract A number of audio channels.
	
	@discussion
		Rationale: making this a potentially larger-than-32-bit type like NSUInteger would open the
		door to a large set of runtime failures due to underlying implementations' use of UInt32.
*/
typealias AVAudioChannelCount = UInt32

/*! @typedef AVAudioNodeCompletionHandler
	@abstract Generic callback handler.
	@discussion
		Various AVAudioEngine objects issue callbacks to generic blocks of this type. In general
		the callback arrives on a non-main thread and it is the client's responsibility to handle it
		in a thread-safe manner.
*/
typealias AVAudioNodeCompletionHandler = () -> Void

/*!	@typedef AVAudioNodeBus
	@abstract The index of a bus on an AVAudioNode.
	@discussion
		@link AVAudioNode @/link objects potentially have multiple input and/or output busses.
		AVAudioNodeBus represents a bus as a zero-based index.
*/
typealias AVAudioNodeBus = Int

/*!	@struct AVAudio3DPoint
    @abstract Struct representing a point in 3D space
    @discussion
        This struct is used by classes dealing with 3D audio such as `AVAudioMixing`
        and `AVAudioEnvironmentNode` and represents a point in 3D space.
*/
struct AVAudio3DPoint {
  var x: Float
  var y: Float
  var z: Float
  init()
  init(x: Float, y: Float, z: Float)
}

/*!	@method AVAudioMake3DPoint
    @abstract Creates and returns an AVAudio3DPoint object
*/
func AVAudioMake3DPoint(x: Float, _ y: Float, _ z: Float) -> AVAudio3DPoint

/*!	@typedef AVAudio3DVector
    @abstract Struct representing a vector in 3D space
    @discussion
        This struct is used by classes dealing with 3D audio such as @link AVAudioMixing @/link
        and @link AVAudioEnvironmentNode @/link and represents a vector in 3D space.
*/
typealias AVAudio3DVector = AVAudio3DPoint

/*!	@method AVAudio3DVector
    @abstract Creates and returns an AVAudio3DVector object
*/
func AVAudioMake3DVector(x: Float, _ y: Float, _ z: Float) -> AVAudio3DVector

/*!	@struct AVAudio3DVectorOrientation
    @abstract Struct representing the orientation of the listener in 3D space
    @discussion
        Two orthogonal vectors describe the orientation of the listener. The forward
        vector points in the direction that the listener is facing. The up vector is orthogonal
        to the forward vector and points upwards from the listener's head.
*/
struct AVAudio3DVectorOrientation {
  var forward: AVAudio3DVector
  var up: AVAudio3DVector
  init()
  init(forward: AVAudio3DVector, up: AVAudio3DVector)
}

/*!	@method AVAudioMake3DVectorOrientation
    @abstract Creates and returns an AVAudio3DVectorOrientation object
*/
func AVAudioMake3DVectorOrientation(forward: AVAudio3DVector, _ up: AVAudio3DVector) -> AVAudio3DVectorOrientation

/*!	@struct AVAudio3DAngularOrientation
    @abstract Struct representing the orientation of the listener in 3D space
    @discussion
        Three angles describe the orientation of a listener's head - yaw, pitch and roll.
 
        Yaw describes the side to side movement of the listener's head.
        The yaw axis is perpendicular to the plane of the listener's ears with its origin at the 
        center of the listener's head and directed towards the bottom of the listener's head. A 
        positive yaw is in the clockwise direction going from 0 to 180 degrees. A negative yaw is in 
        the counter-clockwise direction going from 0 to -180 degrees.
 
        Pitch describes the up-down movement of the listener's head.
        The pitch axis is perpendicular to the yaw axis and is parallel to the plane of the 
        listener's ears with its origin at the center of the listener's head and directed towards 
        the right ear. A positive pitch is the upwards direction going from 0 to 180 degrees. A 
        negative pitch is in the downwards direction going from 0 to -180 degrees.
 
        Roll describes the tilt of the listener's head.
        The roll axis is perpendicular to the other two axes with its origin at the center of the 
        listener's head and is directed towards the listener's nose. A positive roll is to the right 
        going from 0 to 180 degrees. A negative roll is to the left going from 0 to -180 degrees.
*/
struct AVAudio3DAngularOrientation {
  var yaw: Float
  var pitch: Float
  var roll: Float
  init()
  init(yaw: Float, pitch: Float, roll: Float)
}

/*!	@method AVAudioMake3DAngularOrientation
    @abstract Creates and returns an AVAudio3DAngularOrientation object
*/
func AVAudioMake3DAngularOrientation(yaw: Float, _ pitch: Float, _ roll: Float) -> AVAudio3DAngularOrientation

/*! @class AVAudioUnit
    @abstract An AVAudioNode implemented by an audio unit.
    @discussion
        An AVAudioUnit is an AVAudioNode implemented by an audio unit. Depending on the type of
        the audio unit, audio is processed either in real-time or non real-time.
*/
@available(iOS 8.0, *)
class AVAudioUnit : AVAudioNode {

  /*!	@method	instantiateWithComponentDescription:options:completionHandler:
  	@abstract Asynchronously create an instance of an audio unit component, wrapped in an AVAudioUnit.
  	@param audioComponentDescription
  		The component to instantiate.
  	@param options
  		Instantiation options.
  	@param completionHandler
  		Called in an arbitrary thread/queue context when instantiation is complete. The client
  		should retain the provided AVAudioUnit.
  	@discussion
  		Components whose flags include kAudioComponentFlag_RequiresAsyncInstantiation must be 
  		instantiated asynchronously, via this method if they are to be used with AVAudioEngine.
  		See the discussion of this flag in AudioUnit/AudioComponent.h.
  		
  		The returned AVAudioUnit instance normally will be of a subclass (AVAudioUnitEffect,
  		AVAudioUnitGenerator, AVAudioUnitMIDIInstrument, or AVAudioUnitTimeEffect), selected
  		according to the component's type.
  */
  @available(iOS 9.0, *)
  class func instantiateWith(audioComponentDescription: AudioComponentDescription, options: AudioComponentInstantiationOptions = [], completionHandler: (AVAudioUnit?, Error?) -> Void)

  /*! @method loadAudioUnitPresetAtURL:error:
      @abstract Load an audio unit preset.
      @param url
          NSURL of the .aupreset file.
  	@param outError
      @discussion
          If the .aupreset file cannot be successfully loaded, an error is returned.
  */
  func loadPresetAt(url: URL) throws

  /*! @property audioComponentDescription
      @abstract AudioComponentDescription of the underlying audio unit.
  */
  var audioComponentDescription: AudioComponentDescription { get }

  /*! @property audioUnit
      @abstract Reference to the underlying audio unit.
      @discussion
          A reference to the underlying audio unit is provided so that parameters that are not
          exposed by AVAudioUnit subclasses can be modified using the AudioUnit C API.
   
          No operations that may conflict with state maintained by the engine should be performed
          directly on the audio unit. These include changing initialization state, stream formats,
          channel layouts or connections to other audio units.
  */
  var audioUnit: AudioUnit { get }

  /*! @property AUAudioUnit
      @abstract An AUAudioUnit wrapping or underlying the implementation's AudioUnit.
      @discussion
          This provides an AUAudioUnit which either wraps or underlies the implementation's
          AudioUnit, depending on how that audio unit is packaged. Applications can interact with this
          AUAudioUnit to control custom properties, select presets, change parameters, etc.
   
          As with the audioUnit property, no operations that may conflict with state maintained by the
          engine should be performed directly on the audio unit. These include changing initialization
          state, stream formats, channel layouts or connections to other audio units.
  */
  @available(iOS 9.0, *)
  var auAudioUnit: AUAudioUnit { get }

  /*! @property name
      @abstract Name of the audio unit.
  */
  var name: String { get }

  /*! @property manufacturerName
      @abstract Manufacturer name of the audio unit.
  */
  var manufacturerName: String { get }

  /*! @property version
      @abstract Version number of the audio unit.
  */
  var version: Int { get }
  init()
}
@available(iOS 9.0, *)
let AVAudioUnitTypeOutput: String
@available(iOS 9.0, *)
let AVAudioUnitTypeMusicDevice: String
@available(iOS 9.0, *)
let AVAudioUnitTypeMusicEffect: String
@available(iOS 9.0, *)
let AVAudioUnitTypeFormatConverter: String
@available(iOS 9.0, *)
let AVAudioUnitTypeEffect: String
@available(iOS 9.0, *)
let AVAudioUnitTypeMixer: String
@available(iOS 9.0, *)
let AVAudioUnitTypePanner: String
@available(iOS 9.0, *)
let AVAudioUnitTypeGenerator: String
@available(iOS 9.0, *)
let AVAudioUnitTypeOfflineEffect: String
@available(iOS 9.0, *)
let AVAudioUnitTypeMIDIProcessor: String
@available(iOS 9.0, *)
let AVAudioUnitManufacturerNameApple: String

/*!
 @class AVAudioUnitComponent
 @discussion
	 AVAudioUnitComponent provides details about an audio unit such as type, subtype, manufacturer, 
	 location etc. User tags can be added to the AVAudioUnitComponent which can be queried later
 	 for display.
 */
@available(iOS 9.0, *)
class AVAudioUnitComponent : Object {

  /*! @property name
  	@abstract the name of an audio component
   */
  var name: String { get }

  /*! @property typeName
  	@abstract standard audio component types returned as strings
   */
  var typeName: String { get }

  /*! @property typeName
  	@abstract localized string of typeName for display
   */
  var localizedTypeName: String { get }

  /*! @property manufacturerName
  	@abstract the manufacturer name, extracted from the manufacturer key defined in Info.plist dictionary
   */
  var manufacturerName: String { get }

  /*! @property version
  	@abstract version number comprised of a hexadecimal number with major, minor, dot-release format: 0xMMMMmmDD
   */
  var version: Int { get }

  /*! @property versionString
  	@abstract version number as string
   */
  var versionString: String { get }

  /*! @property sandboxSafe
  	@abstract On OSX, YES if the AudioComponent can be loaded into a sandboxed process otherwise NO.
  			  On iOS, this is always YES.
   */
  var isSandboxSafe: Bool { get }

  /*! @property hasMIDIInput
  	@abstract YES if AudioComponent has midi input, otherwise NO
   */
  var hasMIDIInput: Bool { get }

  /*! @property hasMIDIOutput
  	@abstract YES if AudioComponent has midi output, otherwise NO
   */
  var hasMIDIOutput: Bool { get }

  /*! @property audioComponent
  	@abstract the audioComponent that can be used in AudioComponent APIs.
   */
  var audioComponent: AudioComponent { get }

  /*! @property allTagNames
  	@abstract represent the tags from the current user and the system tags defined by AudioComponent.
   */
  var allTagNames: [String] { get }

  /*! @property audioComponentDescription
  	@abstract description of the audio component that can be used in AudioComponent APIs.
   */
  var audioComponentDescription: AudioComponentDescription { get }
  init()
}
@available(iOS 9.0, *)
let AVAudioUnitComponentTagsDidChangeNotification: String

/*!
 @class AVAudioUnitComponentManager
 @discussion 
 		AVAudioUnitComponentManager is a singleton object that provides an easy way to find
 		audio components that are registered with the system. It provides methods to search and
 		query various information about the audio components without opening them.
 
 		Currently audio components that are audio units can only be searched.
 
 		The class also supports predefined system tags and arbitrary user tags. Each audio unit can be 
 		tagged as part of its definition. Refer to AudioComponent.h for more details. AudioUnit Hosts
 		such as Logic or GarageBand can present groupings of audio units based on the tags.
 
 		Searching for audio units can be done in various ways
 			- using a NSPredicate that contains search strings for tags or descriptions
 			- using a block to match on custom criteria 
			- using an AudioComponentDescription
 */
@available(iOS 9.0, *)
class AVAudioUnitComponentManager : Object {

  /*! @discussion 
   		returns all tags associated with the current user as well as all system tags defined by 
  		the audio unit(s).
   */
  var tagNames: [String] { get }

  /*! @discussion
  		returns the localized standard system tags defined by the audio unit(s).
   */
  var standardLocalizedTagNames: [String] { get }
  class func shared() -> Self

  /*!
   @method componentsMatchingPredicate:
   @abstract	returns an array of AVAudioUnitComponent objects that match the search predicate.
   @discussion
   		AudioComponent's information or tags can be used to build a search criteria. 
   		For example, "typeName CONTAINS 'Effect'" or tags IN {'Sampler', 'MIDI'}"
   */
  func componentsMatching(predicate: Predicate) -> [AVAudioUnitComponent]

  /*!
   @method componentsPassingTest:
   @abstract	returns an array of AVAudioUnitComponent objects that pass the user provided block method.
   @discussion
  		For each AudioComponent found by the manager, the block method will be called. If the return
   		value is YES then the AudioComponent is added to the resulting array else it will excluded. 
   		This gives more control to the block provider to filter out the components returned.
   */
  func componentsPassingTest(testHandler: (AVAudioUnitComponent, UnsafeMutablePointer<ObjCBool>) -> Bool) -> [AVAudioUnitComponent]

  /*!
   @method componentsMatchingDescription:
   @abstract	returns an array of AVAudioUnitComponent objects that match the description.
   @discussion
   		This method provides a mechanism to search for AudioComponents using AudioComponentDescription
  		structure. The type, subtype and manufacturer fields are used to search for audio units. A 
   		value of 0 for any of these fields is a wildcard and returns the first match found.
   */
  func componentsMatching(desc: AudioComponentDescription) -> [AVAudioUnitComponent]
  init()
}

/*! @class AVAudioUnitDelay
    @abstract an AVAudioUnitEffect that implements a delay effect
    @discussion
        A delay unit delays the input signal by the specified time interval
        and then blends it with the input signal. The amount of high frequency
        roll-off can also be controlled in order to simulate the effect of
        a tape delay.
 
*/
@available(iOS 8.0, *)
class AVAudioUnitDelay : AVAudioUnitEffect {

  /*! @property delayTime
      Time taken by the delayed input signal to reach the output
      @abstract
      Range:      0 -> 2
      Default:    1
      Unit:       Seconds
   */
  var delayTime: TimeInterval

  /*! @property feedback
      @abstract
      Amount of the output signal fed back into the delay line
      Range:      -100 -> 100
      Default:    50
      Unit:       Percent
  */
  var feedback: Float

  /*! @property lowPassCutoff
      @abstract
      Cutoff frequency above which high frequency content is rolled off
      Range:      10 -> (samplerate/2)
      Default:    15000
      Unit:       Hertz
  */
  var lowPassCutoff: Float

  /*! @property wetDryMix
      @abstract
      Blend of the wet and dry signals
      Range:      0 (all dry) -> 100 (all wet)
      Default:    100
      Unit:       Percent
  */
  var wetDryMix: Float

  /*! @method initWithAudioComponentDescription:
      @abstract Create an AVAudioUnitEffect object.
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be instantiated.
      @discussion
      The componentType must be one of these types
      kAudioUnitType_Effect
      kAudioUnitType_MusicEffect
      kAudioUnitType_Panner
      kAudioUnitType_RemoteEffect
      kAudioUnitType_RemoteMusicEffect
  
  */
  init(audioComponentDescription: AudioComponentDescription)
  init()
}
@available(iOS 8.0, *)
enum AVAudioUnitDistortionPreset : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case DrumsBitBrush
  case DrumsBufferBeats
  case DrumsLoFi
  case MultiBrokenSpeaker
  case MultiCellphoneConcert
  case MultiDecimated1
  case MultiDecimated2
  case MultiDecimated3
  case MultiDecimated4
  case MultiDistortedFunk
  case MultiDistortedCubed
  case MultiDistortedSquared
  case MultiEcho1
  case MultiEcho2
  case MultiEchoTight1
  case MultiEchoTight2
  case MultiEverythingIsBroken
  case SpeechAlienChatter
  case SpeechCosmicInterference
  case SpeechGoldenPi
  case SpeechRadioTower
  case SpeechWaves
}

/*! @class AVAudioUnitDistortion
    @abstract An AVAudioUnitEffect that implements a multi-stage distortion effect.
 
*/
@available(iOS 8.0, *)
class AVAudioUnitDistortion : AVAudioUnitEffect {

  /*! @method loadFactoryPreset:
      @abstract Load a distortion preset.
      Default:    AVAudioUnitDistortionPresetDrumsBitBrush
  */
  func loadFactoryPreset(preset: AVAudioUnitDistortionPreset)

  /*! @property preGain
      @abstract
      Gain applied to the signal before being distorted
      Range:      -80 -> 20
      Default:    -6
      Unit:       dB
  */
  var preGain: Float

  /*! @property wetDryMix
      @abstract
      Blend of the distorted and dry signals
      Range:      0 (all dry) -> 100 (all distorted)
      Default:    50
      Unit:       Percent
  */
  var wetDryMix: Float

  /*! @method initWithAudioComponentDescription:
      @abstract Create an AVAudioUnitEffect object.
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be instantiated.
      @discussion
      The componentType must be one of these types
      kAudioUnitType_Effect
      kAudioUnitType_MusicEffect
      kAudioUnitType_Panner
      kAudioUnitType_RemoteEffect
      kAudioUnitType_RemoteMusicEffect
  
  */
  init(audioComponentDescription: AudioComponentDescription)
  init()
}

/*! @enum AVAudioUnitEQFilterType
    @abstract Filter types available to use with AVAudioUnitEQ.
    @discussion
        Depending on the filter type, a combination of one or all of the filter parameters defined 
        in AVAudioUnitEQFilterParameters are used to set the filter.
     
        AVAudioUnitEQFilterTypeParametric
            Parametric filter based on Butterworth analog prototype.
            Required parameters: frequency (center), bandwidth, gain
     
        AVAudioUnitEQFilterTypeLowPass
            Simple Butterworth 2nd order low pass filter
            Required parameters: frequency (-3 dB cutoff at specified frequency)
        
        AVAudioUnitEQFilterTypeHighPass
            Simple Butterworth 2nd order high pass filter
            Required parameters: frequency (-3 dB cutoff at specified frequency)
     
        AVAudioUnitEQFilterTypeResonantLowPass
            Low pass filter with resonance support (via bandwidth parameter)
            Required parameters: frequency (-3 dB cutoff at specified frequency), bandwidth
     
        AVAudioUnitEQFilterTypeResonantHighPass
            High pass filter with resonance support (via bandwidth parameter)
            Required parameters: frequency (-3 dB cutoff at specified frequency), bandwidth
     
        AVAudioUnitEQFilterTypeBandPass
            Band pass filter
            Required parameters: frequency (center), bandwidth
     
        AVAudioUnitEQFilterTypeBandStop
            Band stop filter (aka "notch filter")
            Required parameters: frequency (center), bandwidth
     
        AVAudioUnitEQFilterTypeLowShelf
            Low shelf filter
            Required parameters: frequency (center), gain
     
        AVAudioUnitEQFilterTypeHighShelf
            High shelf filter
            Required parameters: frequency (center), gain
     
        AVAudioUnitEQFilterTypeResonantLowShelf
            Low shelf filter with resonance support (via bandwidth parameter)
            Required parameters: frequency (center), bandwidth, gain
     
        AVAudioUnitEQFilterTypeResonantHighShelf
            High shelf filter with resonance support (via bandwidth parameter)
            Required parameters: frequency (center), bandwidth, gain
 
*/
@available(iOS 8.0, *)
enum AVAudioUnitEQFilterType : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Parametric
  case LowPass
  case HighPass
  case ResonantLowPass
  case ResonantHighPass
  case BandPass
  case BandStop
  case LowShelf
  case HighShelf
  case ResonantLowShelf
  case ResonantHighShelf
}

/*! @class AVAudioUnitEQFilterParameters
    @abstract Filter parameters used by AVAudioUnitEQ.
    @discussion
        A standalone instance of AVAudioUnitEQFilterParameters cannot be created. Only an instance
        vended out by a source object (e.g. AVAudioUnitEQ) can be used.
*/
@available(iOS 8.0, *)
class AVAudioUnitEQFilterParameters : Object {

  /*! @property filterType
      @abstract AVAudioUnitEQFilterType
      @discussion
      Default:    AVAudioUnitEQFilterTypeParametric
  */
  var filterType: AVAudioUnitEQFilterType

  /*! @property frequency
      @abstract Frequency in Hertz.
      @discussion
      Range:      20 -> (SampleRate/2)
      Unit:       Hertz
  */
  var frequency: Float

  /*! @property bandwidth
      @abstract Bandwidth in octaves.
      @discussion
      Range:      0.05 -> 5.0
      Unit:       Octaves
  */
  var bandwidth: Float

  /*! @property gain
      @abstract Gain in dB.
      @discussion
      Range:      -96 -> 24
      Default:    0
      Unit:       dB
  */
  var gain: Float

  /*! @property bypass
      @abstract bypass state of band.
      @discussion
      Default:    YES
  */
  var bypass: Bool
  init()
}

/*! @class AVAudioUnitEQ
    @abstract An AVAudioUnitEffect that implements a Multi-Band Equalizer.
 
*/
@available(iOS 8.0, *)
class AVAudioUnitEQ : AVAudioUnitEffect {

  /*! @method initWithNumberOfBands:
      @abstract Initialize the EQ with number of bands.
      @param numberOfBands
          The number of bands created by the EQ.
  */
  init(numberOfBands: Int)

  /*! @property bands
      @abstract Array of AVAudioUnitEQFilterParameters objects.
      @discussion
          The number of elements in the array is equal to the number of bands.
  */
  var bands: [AVAudioUnitEQFilterParameters] { get }

  /*! @property globalGain
      @abstract Overall gain adjustment applied to the signal.
      @discussion
          Range:     -96 -> 24
          Default:   0
          Unit:      dB
  */
  var globalGain: Float

  /*! @method initWithAudioComponentDescription:
      @abstract Create an AVAudioUnitEffect object.
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be instantiated.
      @discussion
      The componentType must be one of these types
      kAudioUnitType_Effect
      kAudioUnitType_MusicEffect
      kAudioUnitType_Panner
      kAudioUnitType_RemoteEffect
      kAudioUnitType_RemoteMusicEffect
  
  */
  init(audioComponentDescription: AudioComponentDescription)
  init()
}

/*! @class AVAudioUnitEffect
    @abstract an AVAudioUnit that processes audio in real-time
    @discussion
    An AVAudioUnitEffect represents an audio unit of type kAudioUnitType_Effect,
    kAudioUnitType_MusicEffect, kAudioUnitType_Panner, kAudioUnitType_RemoteEffect or 
    kAudioUnitType_RemoteMusicEffect.

    These effects run in real-time and process some x number of audio input 
    samples to produce x number of audio output samples. A delay unit is an 
    example of an effect unit.
 
*/
@available(iOS 8.0, *)
class AVAudioUnitEffect : AVAudioUnit {

  /*! @method initWithAudioComponentDescription:
      @abstract Create an AVAudioUnitEffect object.
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be instantiated.
      @discussion
      The componentType must be one of these types
      kAudioUnitType_Effect
      kAudioUnitType_MusicEffect
      kAudioUnitType_Panner
      kAudioUnitType_RemoteEffect
      kAudioUnitType_RemoteMusicEffect
  
  */
  init(audioComponentDescription: AudioComponentDescription)

  /*! @property bypass
      @abstract Bypass state of the audio unit.
  */
  var bypass: Bool
  init()
}

/*! @class AVAudioUnitGenerator
    @abstract an AVAudioUnit that generates audio output
    @discussion
    An AVAudioUnitGenerator represents an audio unit of type kAudioUnitType_Generator or
	kAudioUnitType_RemoteGenerator.
    A generator will have no audio input, but will just produce audio output.
    A tone generator is an example of this. 
*/
@available(iOS 8.0, *)
class AVAudioUnitGenerator : AVAudioUnit, AVAudioMixing {

  /*! @method initWithAudioComponentDescription:
      @abstract Create an AVAudioUnitGenerator object.
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be instantiated.
      @discussion
      The componentType must be kAudioUnitType_Generator or kAudioUnitType_RemoteGenerator
  */
  init(audioComponentDescription: AudioComponentDescription)

  /*! @property bypass
      @abstract Bypass state of the audio unit.
  */
  var bypass: Bool
  init()

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var volume: Float

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  @available(iOS 8.0, *)
  var pan: Float

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var rate: Float

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var reverbBlend: Float

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var obstruction: Float

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var occlusion: Float

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var position: AVAudio3DPoint
}

/*!
 @class AVAudioUnitMIDIInstrument
 @abstract Base class for sample synthesizers.
 @discussion
    This base class represents audio units of type kAudioUnitType_MusicDevice or kAudioUnitType_RemoteInstrument. This can be used in a chain
    that processes realtime input (live) and has general concept of music events i.e. notes.
 */
@available(iOS 8.0, *)
class AVAudioUnitMIDIInstrument : AVAudioUnit, AVAudioMixing {

  /*! @method initWithAudioComponentDescription:
   @abstract initialize the node with the component description
   @param description
      audio component description structure that describes the audio component of type kAudioUnitType_MusicDevice
      or kAudioUnitType_RemoteInstrument.
   */
  init(audioComponentDescription description: AudioComponentDescription)

  /*! @method startNote:withVelocity:onChannel:
   @abstract sends a MIDI Note On event to the instrument
   @param note
      the note number (key) to play.
      Range: 0 -> 127
   @param velocity
      specifies the volume with which the note is played.
      Range: 0 -> 127
   @param channel
      the channel number to which the event is sent.
   */
  func startNote(note: UInt8, withVelocity velocity: UInt8, onChannel channel: UInt8)

  /*! @method stopNote:onChannel:
   @abstract sends a MIDI Note Off event to the instrument
   @param note
      the note number (key) to stop
      Range: 0 -> 127
   @param channel
      the channel number to which the event is sent. 
  
   */
  func stopNote(note: UInt8, onChannel channel: UInt8)

  /*! @method sendController:withValue:onChannel:
   @abstract send a MIDI controller event to the instrument.
   @param controller
      a standard MIDI controller number. 
      Range: 0 -> 127
   @param  value
      value for the controller. 
      Range: 0 -> 127
   @param channel
      the channel number to which the event is sent. 
   
   */
  func sendController(controller: UInt8, withValue value: UInt8, onChannel channel: UInt8)

  /*! @method sendPitchBend:onChannel:
   @abstract sends MIDI Pitch Bend event to the instrument.
   @param pitchbend
      value of the pitchbend
      Range: 0 -> 16383
   @param channel
      the channel number to which the pitch bend message is sent
   
   */
  func sendPitchBend(pitchbend: UInt16, onChannel channel: UInt8)

  /*! @method sendPressure:onChannel:
   @abstract sends MIDI channel pressure event to the instrument.
   @param pressure 
      value of the pressure.
      Range: 0 -> 127
   @param channel
      the channel number to which the event is sent. 
  
   */
  func sendPressure(pressure: UInt8, onChannel channel: UInt8)

  /*! @method sendPressureForKey:withValue:onChannel:
   @abstract sends MIDI Polyphonic key pressure event to the instrument
   @param key
      the key (note) number to which the pressure event applies
      Range: 0 -> 127
   @param value
      value of the pressure
      Range: 0 -> 127
   @param channel
      channel number to which the event is sent. 
  
   */
  func sendPressureForKey(key: UInt8, withValue value: UInt8, onChannel channel: UInt8)

  /*! @method sendProgramChange:onChannel:
   @abstract sends MIDI Program Change event to the instrument
   @param program
      the program number.
      Range: 0 -> 127
   @param channel
      channel number to which the event is sent.
   @discussion
      the instrument will be loaded from the bank that has been previous set by MIDI Bank Select
      controller messages (0 and 31). If none has been set, bank 0 will be used. 
   */
  func sendProgramChange(program: UInt8, onChannel channel: UInt8)

  /*! @method sendProgramChange:bankMSB:bankLSB:onChannel:
   @abstract sends a MIDI Program Change and Bank Select events to the instrument
   @param program
      specifies the program (preset) number within the bank to load.
      Range: 0 -> 127
   @param bankMSB
      specifies the most significant byte value for the bank to select.
      Range: 0 -> 127
   @param bankLSB
      specifies the least significant byte value for the bank to select.
      Range: 0 -> 127
   @param channel
      channel number to which the events are sent.
   @discussion
   
   */
  func sendProgramChange(program: UInt8, bankMSB: UInt8, bankLSB: UInt8, onChannel channel: UInt8)

  /*! @method sendMIDIEvent:data1:data2:
   @abstract sends a MIDI event which contains two data bytes to the instrument.
   @param midiStatus
      the STATUS value of the MIDI event
   @param data1
      the first data byte of the MIDI event
   @param data2
      the second data byte of the MIDI event.
    */
  func sendMIDIEvent(midiStatus: UInt8, data1: UInt8, data2: UInt8)

  /*! @method sendMIDIEvent:data1:
   @abstract sends a MIDI event which contains one data byte to the instrument.
   @param midiStatus
      the STATUS value of the MIDI event
   @param data1
      the first data byte of the MIDI event
   */
  func sendMIDIEvent(midiStatus: UInt8, data1: UInt8)

  /*! @method sendMIDISysExEvent:
   @abstract sends a MIDI System Exclusive event to the instrument.
   @param midiData
      a NSData object containing the complete SysEx data including start(F0) and termination(F7) bytes.
   
   */
  func sendMIDISysExEvent(midiData: Data)
  init()

  /*! @method destinationForMixer:bus:
  	@abstract Returns the AVAudioMixingDestination object corresponding to specified mixer node and
  		its input bus
  	@discussion
  		When a source node is connected to multiple mixers downstream, setting AVAudioMixing 
  		properties directly on the source node will apply the change to all the mixers downstream. 
  		If you want to set/get properties on a specific mixer, use this method to get the 
  		corresponding AVAudioMixingDestination and set/get properties on it. 
   
  		Note:
  		- Properties set on individual AVAudioMixingDestination instances will not reflect at the
  			source node level.
  
  		- AVAudioMixingDestination reference returned by this method could become invalid when
  			there is any disconnection between the source and the mixer node. Hence this reference
  			should not be retained and should be fetched every time you want to set/get properties 
  			on a specific mixer.
   
  		If the source node is not connected to the specified mixer/input bus, this method
  		returns nil.
  		Calling this on an AVAudioMixingDestination instance returns self if the specified
  		mixer/input bus match its connection point, otherwise returns nil.
  */
  @available(iOS 9.0, *)
  func destinationForMixer(mixer: AVAudioNode, bus: AVAudioNodeBus) -> AVAudioMixingDestination?

  /*! @property volume
      @abstract Set a bus's input volume
      @discussion
          Range:      0.0 -> 1.0
          Default:    1.0
          Mixers:     AVAudioMixerNode, AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var volume: Float

  /*! @property pan
      @abstract Set a bus's stereo pan
      @discussion
          Range:      -1.0 -> 1.0
          Default:    0.0
          Mixer:      AVAudioMixerNode
  */
  @available(iOS 8.0, *)
  var pan: Float

  /*! @property renderingAlgorithm
      @abstract Type of rendering algorithm used
      @discussion
          Depending on the current output format of the AVAudioEnvironmentNode, only a subset of the 
          rendering algorithms may be supported. An array of valid rendering algorithms can be 
          retrieved by calling applicableRenderingAlgorithms on AVAudioEnvironmentNode.
   
          Default:    AVAudio3DMixingRenderingAlgorithmEqualPowerPanning
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var renderingAlgorithm: AVAudio3DMixingRenderingAlgorithm

  /*! @property rate
      @abstract Changes the playback rate of the input signal
      @discussion
          A value of 2.0 results in the output audio playing one octave higher.
          A value of 0.5, results in the output audio playing one octave lower.
       
          Range:      0.5 -> 2.0
          Default:    1.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var rate: Float

  /*! @property reverbBlend
      @abstract Controls the blend of dry and reverb processed audio
      @discussion
          This property controls the amount of the source's audio that will be processed by the reverb 
          in AVAudioEnvironmentNode. A value of 0.5 will result in an equal blend of dry and processed 
          (wet) audio.
   
          Range:      0.0 (completely dry) -> 1.0 (completely wet)
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var reverbBlend: Float

  /*! @property obstruction
      @abstract Simulates filtering of the direct path of sound due to an obstacle
      @discussion
          Only the direct path of sound between the source and listener is blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var obstruction: Float

  /*! @property occlusion
      @abstract Simulates filtering of the direct and reverb paths of sound due to an obstacle
      @discussion
          Both the direct and reverb paths of sound between the source and listener are blocked.
   
          Range:      -100.0 -> 0.0 dB
          Default:    0.0
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var occlusion: Float

  /*! @property position
      @abstract The location of the source in the 3D environment
      @discussion
          The coordinates are specified in meters.
   
          Mixer:      AVAudioEnvironmentNode
  */
  @available(iOS 8.0, *)
  var position: AVAudio3DPoint
}
@available(iOS 8.0, *)
enum AVAudioUnitReverbPreset : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case SmallRoom
  case MediumRoom
  case LargeRoom
  case MediumHall
  case LargeHall
  case Plate
  case MediumChamber
  case LargeChamber
  case Cathedral
  case LargeRoom2
  case MediumHall2
  case MediumHall3
  case LargeHall2
}

/*! @class AVAudioUnitReverb
    @abstract an AVAudioUnitEffect that implements a reverb
    @discussion
        A reverb simulates the acoustic characteristics of a particular environment.
        Use the different presets to simulate a particular space and blend it in with
        the original signal using the wetDryMix parameter.
 
*/
@available(iOS 8.0, *)
class AVAudioUnitReverb : AVAudioUnitEffect {

  /*! @method loadFactoryPreset:
      @abstract load a reverb preset
      Default:    AVAudioUnitReverbPresetMediumHall
  */
  func loadFactoryPreset(preset: AVAudioUnitReverbPreset)

  /*! @property wetDryMix
      @abstract
      Blend of the wet and dry signals
      Range:      0 (all dry) -> 100 (all wet)
      Unit:       Percent
  */
  var wetDryMix: Float

  /*! @method initWithAudioComponentDescription:
      @abstract Create an AVAudioUnitEffect object.
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be instantiated.
      @discussion
      The componentType must be one of these types
      kAudioUnitType_Effect
      kAudioUnitType_MusicEffect
      kAudioUnitType_Panner
      kAudioUnitType_RemoteEffect
      kAudioUnitType_RemoteMusicEffect
  
  */
  init(audioComponentDescription: AudioComponentDescription)
  init()
}

/*!
 @class AVAudioUnitSampler
 @abstract Apple's sampler audio unit.
 @discussion
    An AVAudioUnit for Apple's Sampler Audio Unit. The sampler can be configured by loading
    instruments from different types of files such as an aupreset, a DLS or SF2 sound bank,
    an EXS24 instrument, a single audio file, or an array of audio files.

    The output is a single stereo bus. 
*/
@available(iOS 8.0, *)
class AVAudioUnitSampler : AVAudioUnitMIDIInstrument {

  /*! @method loadSoundBankInstrumentAtURL:program:bankMSB:bankLSB:error:
  	@abstract loads a specific instrument from the specified sound bank
  	@param bankURL
  		URL for a Soundbank file. The file can be either a DLS bank (.dls) or a SoundFont bank (.sf2).
  	@param program
  		program number for the instrument to load
  	@param bankMSB
  		MSB for the bank number for the instrument to load.  This is usually 0x79 for melodic
  		instruments and 0x78 for percussion instruments.
  	@param bankLSB
  		LSB for the bank number for the instrument to load.  This is often 0, and represents the "bank variation".
  	@param outError
      	the status of the operation
  	@discussion
   		This method reads from file and allocates memory, so it should not be called on a real time thread.
   */
  func loadSoundBankInstrumentAt(bankURL: URL, program: UInt8, bankMSB: UInt8, bankLSB: UInt8) throws

  /*! @method loadInstrumentAtURL:error:
  	@abstract configures the sampler by loading the specified preset file.
  	@param instrumentURL
      	URL to the preset file or audio file
  	@param outError
  		the status of the operation
  	@discussion
  		The file can be of one of the following types: Logic/GarageBand EXS24 instrument,
  		the Sampler AU's native aupreset, or an audio file (eg. .caf, .aiff, .wav, .mp3).
  	 
  		If an audio file URL is loaded, it will become the sole sample in a new default instrument.
  		Any information contained in the file regarding its keyboard placement (e.g. root key,
  		key range) will be used.
  		This method reads from file and allocates memory, so it should not be called on a real time thread.
   
   */
  func loadInstrumentAt(instrumentURL: URL) throws

  /*! @method loadAudioFilesAtURLs:error:
  	@abstract configures the sampler by loading a set of audio files.
  	@param audioFiles
  		array of URLs for audio files to be loaded
  	@param outError
  		the status of the operation
  	@discussion
  		The audio files are loaded into a new default instrument with each audio file placed
  		into its own sampler zone. Any information contained in the audio file regarding
  		their placement on the keyboard (e.g. root key, key range) will be used.
  		This method reads from file and allocates memory, so it should not be called on a real time thread.
   
   */
  func loadAudioFilesAtURLs(audioFiles: [URL]) throws

  /*! @property stereoPan
  	@abstract
  		adjusts the pan for all the notes played.
  		Range:     -1 -> +1
  		Default:   0
   */
  var stereoPan: Float

  /*! @property masterGain
  	@abstract
      	adjusts the gain of all the notes played
  		Range:     -90.0 -> +12 db
  		Default: 0 db
   */
  var masterGain: Float

  /*! @property globalTuning
  	@abstract
  		adjusts the tuning of all the notes played.
  		Range:     -2400 -> +2400 cents
  		Default:   0
   */
  var globalTuning: Float

  /*! @method initWithAudioComponentDescription:
   @abstract initialize the node with the component description
   @param description
      audio component description structure that describes the audio component of type kAudioUnitType_MusicDevice
      or kAudioUnitType_RemoteInstrument.
   */
  init(audioComponentDescription description: AudioComponentDescription)
  init()
}

/*! @class AVAudioUnitTimeEffect
    @abstract an AVAudioUnit that processes audio in non real-time
    @discussion
    An AVAudioUnitTimeEffect represents an audio unit of type aufc.
    These effects do not process audio in real-time. The varispeed
    unit is an example of a time effect unit.
 
*/
@available(iOS 8.0, *)
class AVAudioUnitTimeEffect : AVAudioUnit {

  /*! @method initWithAudioComponentDescription:
      @abstract create an AVAudioUnitTimeEffect object
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be initialized
      @discussion 
      The componentType must be kAudioUnitType_FormatConverter
  */
  init(audioComponentDescription: AudioComponentDescription)

  /*! @property bypass
      @abstract bypass state of the audio unit
  */
  var bypass: Bool
  init()
}

/*! @class AVAudioUnitTimePitch
    @abstract an AVAudioUnitTimeEffect that provides good quality time stretching and pitch shifting
    @discussion
        In this time effect, the playback rate and pitch parameters function independently of each other
 
*/
@available(iOS 8.0, *)
class AVAudioUnitTimePitch : AVAudioUnitTimeEffect {

  /*! @property rate
      @abstract playback rate of the input signal
   
      Range:      1/32 -> 32.0
      Default:    1.0
      Unit:       Generic
  */
  var rate: Float

  /*! @property pitch
      @abstract amount by which the input signal is pitch shifted
      @discussion
                1 octave  = 1200 cents
      1 musical semitone  = 100 cents
   
      Range:      -2400 -> 2400
      Default:    1.0
      Unit:       Cents
  */
  var pitch: Float

  /*! @property overlap
      @abstract amount of overlap between segments of the input audio signal
      @discussion
      A higher value results in fewer artifacts in the output signal.
      This parameter also impacts the amount of CPU used.
   
      Range:      3.0 -> 32.0
      Default:    8.0
      Unit:       Generic
  */
  var overlap: Float

  /*! @method initWithAudioComponentDescription:
      @abstract create an AVAudioUnitTimeEffect object
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be initialized
      @discussion 
      The componentType must be kAudioUnitType_FormatConverter
  */
  init(audioComponentDescription: AudioComponentDescription)
  init()
}

/*! @class AVAudioUnitVarispeed
    @abstract an AVAudioUnitTimeEffect that can be used to control the playback rate 
*/
@available(iOS 8.0, *)
class AVAudioUnitVarispeed : AVAudioUnitTimeEffect {

  /*! @property rate
      @abstract controls the playback rate of the audio signal
      @discussion
      Since this unit resamples the input signal, changing the playback rate also changes the pitch.
      
      i.e. changing the rate to 2.0 results in the output audio playing one octave higher.
      Similarly changing the rate to 0.5, results in the output audio playing one octave lower.
   
      The playback rate and pitch can be calculated as
                    rate  = pow(2, cents/1200.0)
          pitch in cents  = 1200.0 * log2(rate)
      
      Where,    1 octave  = 1200 cents
      1 musical semitone  = 100 cents
   
      Range:      0.25 -> 4.0
      Default:    1.0
      Unit:       Generic
  */
  var rate: Float

  /*! @method initWithAudioComponentDescription:
      @abstract create an AVAudioUnitTimeEffect object
      
      @param audioComponentDescription
      @abstract AudioComponentDescription of the audio unit to be initialized
      @discussion 
      The componentType must be kAudioUnitType_FormatConverter
  */
  init(audioComponentDescription: AudioComponentDescription)
  init()
}

/*!
 @constant AVCaptureDeviceWasConnectedNotification
 @abstract
    Posted when a device becomes available on the system.

 @discussion
    The notification object is an AVCaptureDevice instance representing the device that became available.
*/
@available(iOS 4.0, *)
let AVCaptureDeviceWasConnectedNotification: String

/*!
 @constant AVCaptureDeviceWasDisconnectedNotification
 @abstract
    Posted when a device becomes unavailable on the system.

 @discussion
    The notification object is an AVCaptureDevice instance representing the device that became unavailable.
*/
@available(iOS 4.0, *)
let AVCaptureDeviceWasDisconnectedNotification: String

/*!
 @constant  AVCaptureDeviceSubjectAreaDidChangeNotification
 @abstract
	Posted when the instance of AVCaptureDevice has detected a substantial change
	to the video subject area.
 
 @discussion
	Clients may observe the AVCaptureDeviceSubjectAreaDidChangeNotification to know
	when an instance of AVCaptureDevice has detected a substantial change
	to the video subject area.  This notification is only sent if you first set
	subjectAreaChangeMonitoringEnabled to YES.
 */
@available(iOS 5.0, *)
let AVCaptureDeviceSubjectAreaDidChangeNotification: String

/*!
 @class AVCaptureDevice
 @abstract
    An AVCaptureDevice represents a physical device that provides realtime input media data, such as video and audio.

 @discussion
    Each instance of AVCaptureDevice corresponds to a device, such as a camera or microphone. Instances of
    AVCaptureDevice cannot be created directly. An array of all currently available devices can also be obtained using
    the devices class method. Devices can provide one or more streams of a given media type. Applications can search
    for devices that provide media of a specific type using the devicesWithMediaType: and defaultDeviceWithMediaType:
    class methods.

    Instances of AVCaptureDevice can be used to provide media data to an AVCaptureSession by creating an
    AVCaptureDeviceInput with the device and adding that to the capture session.
*/
@available(iOS 4.0, *)
class AVCaptureDevice : Object {

  /*!
   @method devices
   @abstract
      Returns an array of devices currently available for use as media input sources.
   
   @result
      An NSArray of AVCaptureDevice instances for each available device.
  
   @discussion
      This method returns an array of AVCaptureDevice instances for input devices currently connected and available for
      capture. The returned array contains all devices that are available at the time the method is called. Applications
      should observe AVCaptureDeviceWasConnectedNotification and AVCaptureDeviceWasDisconnectedNotification to be notified
      when the list of available devices has changed.
  */
  class func devices() -> [AnyObject]!

  /*!
   @method devicesWithMediaType:
   @abstract
      Returns an array of devices currently available for use as sources of media with the given media type.
  
   @param mediaType
      The media type, such as AVMediaTypeVideo, AVMediaTypeAudio, or AVMediaTypeMuxed, supported by each returned device.
   @result
      An NSArray of AVCaptureDevice instances for each available device.
  
   @discussion
      This method returns an array of AVCaptureDevice instances for input devices currently connected and available for
      capture that provide media of the given type. Media type constants are defined in AVMediaFormat.h. The returned
      array contains all devices that are available at the time the method is called. Applications should observe
      AVCaptureDeviceWasConnectedNotification and AVCaptureDeviceWasDisconnectedNotification to be notified when the list
      of available devices has changed.
  */
  class func devicesWithMediaType(mediaType: String!) -> [AnyObject]!

  /*!
   @method defaultDeviceWithMediaType:
   @abstract
      Returns an AVCaptureDevice instance for the default device of the given media type.
  
   @param mediaType
      The media type, such as AVMediaTypeVideo, AVMediaTypeAudio, or AVMediaTypeMuxed, supported by the returned device.
   @result
      The default device with the given media type, or nil if no device with that media type exists.
  
   @discussion
      This method returns the default device of the given media type currently available on the system. For example, for
      AVMediaTypeVideo, this method will return the built in camera that is primarily used for capture and recording.
      Media type constants are defined in AVMediaFormat.h.
  */
  class func defaultDeviceWithMediaType(mediaType: String!) -> AVCaptureDevice!

  /*!
   @method deviceWithUniqueID:
   @abstract
      Returns an AVCaptureDevice instance with the given unique ID.
  
   @param deviceUniqueID
      The unique ID of the device instance to be returned.
   @result
      An AVCaptureDevice instance with the given unique ID, or nil if no device with that unique ID is available.
  
   @discussion
      Every available capture device has a unique ID that persists on one system across device connections and
      disconnections, application restarts, and reboots of the system itself. This method can be used to recall or track
      the status of a specific device whose unique ID has previously been saved.
  */
  /*not inherited*/ init!(uniqueID deviceUniqueID: String!)

  /*!
   @property uniqueID
   @abstract
      An ID unique to the model of device corresponding to the receiver.
  
   @discussion
      Every available capture device has a unique ID that persists on one system across device connections and
      disconnections, application restarts, and reboots of the system itself. Applications can store the value returned by
      this property to recall or track the status of a specific device in the future.
  */
  var uniqueID: String! { get }

  /*!
   @property modelID
   @abstract
      The model ID of the receiver.
  
   @discussion
      The value of this property is an identifier unique to all devices of the same model. The value is persistent across
      device connections and disconnections, and across different systems. For example, the model ID of the camera built
      in to two identical iPhone models will be the same even though they are different physical devices.
  */
  var modelID: String! { get }

  /*!
   @property localizedName
   @abstract
      A localized human-readable name for the receiver.
   
   @discussion
      This property can be used for displaying the name of a capture device in a user interface.
  */
  var localizedName: String! { get }

  /*!
   @method hasMediaType:
   @abstract
      Returns whether the receiver provides media with the given media type.
  
   @param mediaType
      A media type, such as AVMediaTypeVideo, AVMediaTypeAudio, or AVMediaTypeMuxed.
   @result
      YES if the device outputs the given media type, NO otherwise.
   
   @discussion
      Media type constants are defined in AVMediaFormat.h.
  */
  func hasMediaType(mediaType: String!) -> Bool

  /*!
   @method lockForConfiguration:
   @abstract
      Requests exclusive access to configure device hardware properties.
  
   @param outError
      On return, if the device could not be locked, points to an NSError describing why the failure occurred.
   @result
      A BOOL indicating whether the device was successfully locked for configuration.
  
   @discussion
      In order to set hardware properties on an AVCaptureDevice, such as focusMode and exposureMode, clients must first
      acquire a lock on the device.  Clients should only hold the device lock if they require settable device properties
      to remain unchanged.  Holding the device lock unnecessarily may degrade capture quality in other applications
      sharing the device.
  */
  func lockForConfiguration() throws

  /*!
   @method unlockForConfiguration
   @abstract
      Release exclusive control over device hardware properties.
  
   @discussion
      This method should be called to match an invocation of lockForConfiguration: when an application no longer needs to
      keep device hardware properties from changing automatically.
  */
  func unlockForConfiguration()

  /*!
   @method supportsAVCaptureSessionPreset:
   @abstract
      Returns whether the receiver can be used in an AVCaptureSession configured with the given preset.
  
   @param preset
      An AVCaptureSession preset.
   @result
      YES if the receiver can be used with the given preset, NO otherwise.
  
   @discussion
      An AVCaptureSession instance can be associated with a preset that configures its inputs and outputs to fulfill common
      use cases. This method can be used to determine if the receiver can be used in a capture session with the given
      preset. Presets are defined in AVCaptureSession.h.
  */
  func supportsAVCaptureSessionPreset(preset: String!) -> Bool

  /*!
   @property connected
   @abstract
      Indicates whether the device is connected and available to the system.
  
   @discussion
      The value of this property is a BOOL indicating whether the device represented by the receiver is connected and
      available for use as a capture device. Clients can key value observe the value of this property to be notified when
      a device is no longer available. When the value of this property becomes NO for a given instance, it will not become
      YES again. If the same physical device again becomes available to the system, it will be represented using a new
      instance of AVCaptureDevice.
  */
  var isConnected: Bool { get }

  /*!
   @property formats
   @abstract
      An array of AVCaptureDeviceFormat objects supported by the receiver.
  
   @discussion
      This property can be used to enumerate the formats natively supported by the receiver.  The
      capture device's activeFormat property may be set to one of the formats in this array.  Clients 
      can observe automatic changes to the receiver's formats by key value observing this property.
  */
  @available(iOS 7.0, *)
  var formats: [AnyObject]! { get }

  /*!
   @property activeFormat
   @abstract
      The currently active format of the receiver.
  
   @discussion
      This property can be used to get or set the currently active device format.
      -setActiveFormat: throws an NSInvalidArgumentException if set to a format not present in the formats
      array.  -setActiveFormat: throws an NSGenericException if called without first obtaining exclusive
      access to the receiver using lockForConfiguration:.  Clients can observe automatic changes to the 
      receiver's activeFormat by key value observing this property.
   
      On iOS, use of AVCaptureDevice's setActiveFormat: and AVCaptureSession's setSessionPreset: are mutually
      exclusive.  If you set a capture device's active format, the session to which it is attached changes its
      preset to AVCaptureSessionPresetInputPriority.  Likewise if you set the AVCaptureSession's sessionPreset
      property, the session assumes control of its input devices, and configures their activeFormat appropriately.
      Note that audio devices do not expose any user-configurable formats on iOS.  To configure audio input on
      iOS, you should use the AVAudioSession APIs instead (see AVAudioSession.h).
      
      The activeFormat, activeVideoMinFrameDuration, and activeVideoMaxFrameDuration properties may be set simultaneously
      by using AVCaptureSession's begin/commitConfiguration methods:
   
      [session beginConfiguration]; // the session to which the receiver's AVCaptureDeviceInput is added.
      if ( [device lockForConfiguration:&error] ) {
          [device setActiveFormat:newFormat];
          [device setActiveVideoMinFrameDuration:newMinDuration];
          [device setActiveVideoMaxFrameDuration:newMaxDuration];
  	    [device unlockForConfiguration];
      }
      [session commitConfiguration]; // The new format and frame rates are applied together in commitConfiguration
   
  	Note that when configuring a session to use an active format intended for high resolution still photography and applying one or more of the
  	following operations to an AVCaptureVideoDataOutput, the system may not meet the target framerate: zoom, orientation changes, format conversion.
  */
  @available(iOS 7.0, *)
  var activeFormat: AVCaptureDeviceFormat!

  /*!
   @property activeVideoMinFrameDuration
   @abstract
      A property indicating the receiver's current active minimum frame duration (the reciprocal of its max frame rate).
  
   @discussion
      An AVCaptureDevice's activeVideoMinFrameDuration property is the reciprocal of its active
      maximum frame rate.  To limit the max frame rate of the capture device, clients may
      set this property to a value supported by the receiver's activeFormat (see AVCaptureDeviceFormat's 
      videoSupportedFrameRateRanges property).  Clients may set this property's value to kCMTimeInvalid to
      return activeVideoMinFrameDuration to its default value for the given activeFormat.
      -setActiveVideoMinFrameDuration: throws an NSInvalidArgumentException if set to an unsupported value.  
      -setActiveVideoMinFrameDuration: throws an NSGenericException if called without first obtaining exclusive 
      access to the receiver using lockForConfiguration:.  Clients can observe automatic changes to the receiver's 
      activeVideoMinFrameDuration by key value observing this property.
   
      On iOS, the receiver's activeVideoMinFrameDuration resets to its default value under the following conditions:
  	    - The receiver's activeFormat changes
          - The receiver's AVCaptureDeviceInput's session's sessionPreset changes
          - The receiver's AVCaptureDeviceInput is added to a session
   
      When exposureMode is AVCaptureExposureModeCustom, setting the activeVideoMinFrameDuration affects max frame
      rate, but not exposureDuration. You may use setExposureModeCustomWithDuration:ISO:completionHandler:
      to set a shorter exposureDuration than your activeVideoMinFrameDuration, if desired.
  */
  @available(iOS 7.0, *)
  var activeVideoMinFrameDuration: CMTime

  /*!
   @property activeVideoMaxFrameDuration
   @abstract
      A property indicating the receiver's current active maximum frame duration (the reciprocal of its min frame rate).
  
   @discussion
      An AVCaptureDevice's activeVideoMaxFrameDuration property is the reciprocal of its active
      minimum frame rate.  To limit the min frame rate of the capture device, clients may
      set this property to a value supported by the receiver's activeFormat (see AVCaptureDeviceFormat's 
      videoSupportedFrameRateRanges property).  Clients may set this property's value to kCMTimeInvalid to
      return activeVideoMaxFrameDuration to its default value for the given activeFormat.
      -setActiveVideoMaxFrameDuration: throws an NSInvalidArgumentException if set to an unsupported value.  
      -setActiveVideoMaxFrameDuration: throws an NSGenericException if called without first obtaining exclusive 
      access to the receiver using lockForConfiguration:.  Clients can observe automatic changes to the receiver's 
      activeVideoMaxFrameDuration by key value observing this property.
   
      On iOS, the receiver's activeVideoMaxFrameDuration resets to its default value under the following conditions:
  	    - The receiver's activeFormat changes
          - The receiver's AVCaptureDeviceInput's session's sessionPreset changes
          - The receiver's AVCaptureDeviceInput is added to a session
   
      When exposureMode is AVCaptureExposureModeCustom, frame rate and exposure duration are interrelated.
      If you call setExposureModeCustomWithDuration:ISO:completionHandler: with an exposureDuration longer 
      than the current activeVideoMaxFrameDuration, the activeVideoMaxFrameDuration will be lengthened to
      accommodate the longer exposure time.  Setting a shorter exposure duration does not automatically
      change the activeVideoMinFrameDuration or activeVideoMaxFrameDuration. To explicitly increase the
      frame rate in custom exposure mode, you must set the activeVideoMaxFrameDuration to a shorter value.
      If your new max frame duration is shorter than the current exposureDuration, the exposureDuration will
      shorten as well to accommodate the new frame rate.
  */
  @available(iOS 7.0, *)
  var activeVideoMaxFrameDuration: CMTime
  init()
}

/*!
 @enum AVCaptureDevicePosition
 @abstract
    Constants indicating the physical position of an AVCaptureDevice's hardware on the system.

 @constant AVCaptureDevicePositionUnspecified
    Indicates that the device's position relative to the system hardware is unspecified.
 @constant AVCaptureDevicePositionBack
    Indicates that the device is physically located on the back of the system hardware.
 @constant AVCaptureDevicePositionFront
    Indicates that the device is physically located on the front of the system hardware.
*/
@available(iOS 4.0, *)
enum AVCaptureDevicePosition : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unspecified
  case Back
  case Front
}
extension AVCaptureDevice {

  /*!
   @property position
   @abstract
      Indicates the physical position of an AVCaptureDevice's hardware on the system.
  
   @discussion
      The value of this property is an AVCaptureDevicePosition indicating where the receiver's device is physically
      located on the system hardware.
  */
  var position: AVCaptureDevicePosition { get }
}

/*!
 @enum AVCaptureFlashMode
 @abstract
    Constants indicating the mode of the flash on the receiver's device, if it has one.

 @constant AVCaptureFlashModeOff
    Indicates that the flash should always be off.
 @constant AVCaptureFlashModeOn
    Indicates that the flash should always be on.
 @constant AVCaptureFlashModeAuto
    Indicates that the flash should be used automatically depending on ambient light conditions.
*/
@available(iOS 4.0, *)
enum AVCaptureFlashMode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Off
  case On
  case Auto
}
extension AVCaptureDevice {

  /*!
   @property hasFlash
   @abstract
      Indicates whether the receiver has a flash.
  
   @discussion
      The value of this property is a BOOL indicating whether the receiver has a flash. The receiver's flashMode property
      can only be set when this property returns YES.
  */
  var hasFlash: Bool { get }

  /*!
   @property flashAvailable
   @abstract
      Indicates whether the receiver's flash is currently available for use.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver's flash is 
      currently available. The flash may become unavailable if, for example, the device
      overheats and needs to cool off. This property is key-value observable.
  */
  @available(iOS 5.0, *)
  var isFlashAvailable: Bool { get }

  /*!
   @property flashActive
   @abstract
      Indicates whether the receiver's flash is currently active.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver's flash is 
      currently active. When the flash is active, it will flash if a still image is
      captured. When a still image is captured with the flash active, exposure and
      white balance settings are overridden for the still. This is true even when
      using AVCaptureExposureModeCustom and/or AVCaptureWhiteBalanceModeLocked.
      This property is key-value observable.
  */
  @available(iOS 5.0, *)
  var isFlashActive: Bool { get }

  /*!
   @method isFlashModeSupported:
   @abstract
      Returns whether the receiver supports the given flash mode.
  
   @param flashMode
      An AVCaptureFlashMode to be checked.
   @result
      YES if the receiver supports the given flash mode, NO otherwise.
  
   @discussion
      The receiver's flashMode property can only be set to a certain mode if this method returns YES for that mode.
  */
  func isFlashModeSupported(flashMode: AVCaptureFlashMode) -> Bool

  /*!
   @property flashMode
   @abstract
      Indicates current mode of the receiver's flash, if it has one.
  
   @discussion
      The value of this property is an AVCaptureFlashMode that determines the mode of the 
      receiver's flash, if it has one.  -setFlashMode: throws an NSInvalidArgumentException
      if set to an unsupported value (see -isFlashModeSupported:).  -setFlashMode: throws an NSGenericException 
      if called without first obtaining exclusive access to the receiver using lockForConfiguration:.
      Clients can observe automatic changes to the receiver's flashMode by key value observing this property.
  */
  var flashMode: AVCaptureFlashMode
}

/*!
 @enum AVCaptureTorchMode
 @abstract
    Constants indicating the mode of the torch on the receiver's device, if it has one.

 @constant AVCaptureTorchModeOff
    Indicates that the torch should always be off.
 @constant AVCaptureTorchModeOn
    Indicates that the torch should always be on.
 @constant AVCaptureTorchModeAuto
    Indicates that the torch should be used automatically depending on ambient light conditions.
*/
@available(iOS 4.0, *)
enum AVCaptureTorchMode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Off
  case On
  case Auto
}

/*!
  @constant AVCaptureMaxAvailableTorchLevel
    A special value that may be passed to -setTorchModeWithLevel:error: to set the torch to the
    maximum level currently available. Under thermal duress, the maximum available torch level
    may be less than 1.0.
*/
let AVCaptureMaxAvailableTorchLevel: Float
extension AVCaptureDevice {

  /*!
   @property hasTorch
   @abstract
      Indicates whether the receiver has a torch.
  
   @discussion
      The value of this property is a BOOL indicating whether the receiver has a torch. The receiver's torchMode property
      can only be set when this property returns YES.
  */
  var hasTorch: Bool { get }

  /*!
   @property torchAvailable
   @abstract
      Indicates whether the receiver's torch is currently available for use.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver's torch is 
      currently available. The torch may become unavailable if, for example, the device
      overheats and needs to cool off. This property is key-value observable.
  */
  @available(iOS 5.0, *)
  var isTorchAvailable: Bool { get }

  /*!
   @property torchActive
   @abstract
      Indicates whether the receiver's torch is currently active.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver's torch is 
      currently active. If the current torchMode is AVCaptureTorchModeAuto and isTorchActive
      is YES, the torch will illuminate once a recording starts (see AVCaptureOutput.h 
      -startRecordingToOutputFileURL:recordingDelegate:). This property is key-value observable.
  */
  @available(iOS 6.0, *)
  var isTorchActive: Bool { get }

  /*!
   @property torchLevel
   @abstract
      Indicates the receiver's current torch brightness level as a floating point value.
  
   @discussion
      The value of this property is a float indicating the receiver's torch level 
      from 0.0 (off) -> 1.0 (full). This property is key-value observable.
  */
  @available(iOS 5.0, *)
  var torchLevel: Float { get }

  /*!
   @method isTorchModeSupported:
   @abstract
      Returns whether the receiver supports the given torch mode.
  
   @param torchMode
      An AVCaptureTorchMode to be checked.
   @result
      YES if the receiver supports the given torch mode, NO otherwise.
  
   @discussion
      The receiver's torchMode property can only be set to a certain mode if this method returns YES for that mode.
  */
  func isTorchModeSupported(torchMode: AVCaptureTorchMode) -> Bool

  /*!
   @property torchMode
   @abstract
      Indicates current mode of the receiver's torch, if it has one.
  
   @discussion
      The value of this property is an AVCaptureTorchMode that determines the mode of the 
      receiver's torch, if it has one.  -setTorchMode: throws an NSInvalidArgumentException
      if set to an unsupported value (see -isTorchModeSupported:).  -setTorchMode: throws an NSGenericException 
      if called without first obtaining exclusive access to the receiver using lockForConfiguration:.
      Clients can observe automatic changes to the receiver's torchMode by key value observing this property.
  */
  var torchMode: AVCaptureTorchMode

  /*!
   @method setTorchModeOnWithLevel:error:
   @abstract
      Sets the current mode of the receiver's torch to AVCaptureTorchModeOn at the specified level.
  
   @discussion
      This method sets the torch mode to AVCaptureTorchModeOn at a specified level.  torchLevel must be 
      a value between 0 and 1, or the special value AVCaptureMaxAvailableTorchLevel.  The specified value
      may not be available if the iOS device is too hot. This method throws an NSInvalidArgumentException
      if set to an unsupported level. If the specified level is valid, but unavailable, the method returns
      NO with AVErrorTorchLevelUnavailable.  -setTorchModeOnWithLevel:error: throws an NSGenericException 
      if called without first obtaining exclusive access to the receiver using lockForConfiguration:.
      Clients can observe automatic changes to the receiver's torchMode by key value observing the torchMode 
      property.
  */
  @available(iOS 6.0, *)
  func setTorchModeOnWithLevel(torchLevel: Float) throws
}

/*!
 @enum AVCaptureFocusMode
 @abstract
    Constants indicating the mode of the focus on the receiver's device, if it has one.

 @constant AVCaptureFocusModeLocked
    Indicates that the focus should be locked at the lens' current position.
 @constant AVCaptureFocusModeAutoFocus
    Indicates that the device should autofocus once and then change the focus mode to AVCaptureFocusModeLocked.
 @constant AVCaptureFocusModeContinuousAutoFocus
    Indicates that the device should automatically focus when needed.
*/
@available(iOS 4.0, *)
enum AVCaptureFocusMode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Locked
  case AutoFocus
  case ContinuousAutoFocus
}

/*!
 @enum AVCaptureAutoFocusRangeRestriction
 @abstract
	Constants indicating the restriction of the receiver's autofocus system to a particular range of focus scan, if it supports range restrictions.
 
 @constant AVCaptureAutoFocusRangeRestrictionNone
	Indicates that the autofocus system should not restrict the focus range.
 @constant AVCaptureAutoFocusRangeRestrictionNear
	Indicates that the autofocus system should restrict the focus range for subject matter that is near to the camera.
 @constant AVCaptureAutoFocusRangeRestrictionFar
	Indicates that the autofocus system should restrict the focus range for subject matter that is far from the camera.
*/
@available(iOS 7.0, *)
enum AVCaptureAutoFocusRangeRestriction : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case None
  case Near
  case Far
}
extension AVCaptureDevice {

  /*!
   @method isFocusModeSupported:
   @abstract
      Returns whether the receiver supports the given focus mode.
  
   @param focusMode
      An AVCaptureFocusMode to be checked.
   @result
      YES if the receiver supports the given focus mode, NO otherwise.
  
   @discussion
      The receiver's focusMode property can only be set to a certain mode if this method returns YES for that mode.
  */
  func isFocusModeSupported(focusMode: AVCaptureFocusMode) -> Bool

  /*!
   @property focusMode
   @abstract
      Indicates current focus mode of the receiver, if it has one.
  
   @discussion
      The value of this property is an AVCaptureFocusMode that determines the receiver's focus mode, if it has one.
      -setFocusMode: throws an NSInvalidArgumentException if set to an unsupported value (see -isFocusModeSupported:).  
      -setFocusMode: throws an NSGenericException if called without first obtaining exclusive access to the receiver 
      using lockForConfiguration:.  Clients can observe automatic changes to the receiver's focusMode by key value 
      observing this property.
  */
  var focusMode: AVCaptureFocusMode

  /*!
   @property focusPointOfInterestSupported
   @abstract
      Indicates whether the receiver supports focus points of interest.
  
   @discussion
      The receiver's focusPointOfInterest property can only be set if this property returns YES.
  */
  var isFocusPointOfInterestSupported: Bool { get }

  /*!
   @property focusPointOfInterest
   @abstract
      Indicates current focus point of interest of the receiver, if it has one.
  
   @discussion
      The value of this property is a CGPoint that determines the receiver's focus point of interest, if it has one. A
      value of (0,0) indicates that the camera should focus on the top left corner of the image, while a value of (1,1)
      indicates that it should focus on the bottom right. The default value is (0.5,0.5).  -setFocusPointOfInterest:
      throws an NSInvalidArgumentException if isFocusPointOfInterestSupported returns NO.  -setFocusPointOfInterest: throws 
      an NSGenericException if called without first obtaining exclusive access to the receiver using lockForConfiguration:.  
      Clients can observe automatic changes to the receiver's focusPointOfInterest by key value observing this property.  Note that
      setting focusPointOfInterest alone does not initiate a focus operation.  After setting focusPointOfInterest, call
      -setFocusMode: to apply the new point of interest.
  */
  var focusPointOfInterest: CGPoint

  /*!
   @property adjustingFocus
   @abstract
      Indicates whether the receiver is currently performing a focus scan to adjust focus.
  
   @discussion
      The value of this property is a BOOL indicating whether the receiver's camera focus is being automatically
      adjusted by means of a focus scan, because its focus mode is AVCaptureFocusModeAutoFocus or
  	AVCaptureFocusModeContinuousAutoFocus.
      Clients can observe the value of this property to determine whether the camera's focus is stable.
  	@seealso lensPosition
  	@seealso AVCaptureAutoFocusSystem
  */
  var isAdjustingFocus: Bool { get }

  /*!
   @property autoFocusRangeRestrictionSupported
   @abstract
  	Indicates whether the receiver supports autofocus range restrictions.
   
   @discussion
  	The receiver's autoFocusRangeRestriction property can only be set if this property returns YES.
   */
  @available(iOS 7.0, *)
  var isAutoFocusRangeRestrictionSupported: Bool { get }

  /*!
   @property autoFocusRangeRestriction
   @abstract
  	Indicates current restriction of the receiver's autofocus system to a particular range of focus scan, if it supports range restrictions.
   
   @discussion
  	The value of this property is an AVCaptureAutoFocusRangeRestriction indicating how the autofocus system
  	should limit its focus scan.  The default value is AVCaptureAutoFocusRangeRestrictionNone.
  	-setAutoFocusRangeRestriction: throws an NSInvalidArgumentException if isAutoFocusRangeRestrictionSupported
  	returns NO.  -setAutoFocusRangeRestriction: throws an NSGenericException if called without first obtaining exclusive
  	access to the receiver using lockForConfiguration:.  This property only has an effect when the focusMode property is
  	set to AVCaptureFocusModeAutoFocus or AVCaptureFocusModeContinuousAutoFocus.  Note that setting autoFocusRangeRestriction 
  	alone does not initiate a focus operation.  After setting autoFocusRangeRestriction, call -setFocusMode: to apply the new restriction.
   */
  @available(iOS 7.0, *)
  var autoFocusRangeRestriction: AVCaptureAutoFocusRangeRestriction

  /*!
   @property smoothAutoFocusSupported
   @abstract
  	Indicates whether the receiver supports smooth autofocus.
   
   @discussion
  	The receiver's smoothAutoFocusEnabled property can only be set if this property returns YES.
   */
  @available(iOS 7.0, *)
  var isSmoothAutoFocusSupported: Bool { get }

  /*!
   @property smoothAutoFocusEnabled
   @abstract
  	Indicates whether the receiver should use smooth autofocus.
   
   @discussion
  	On a receiver where -isSmoothAutoFocusSupported returns YES and smoothAutoFocusEnabled is set to YES,
  	a smooth autofocus will be engaged when the focus mode is set to AVCaptureFocusModeAutoFocus or
  	AVCaptureFocusModeContinuousAutoFocus.  Enabling smooth autofocus is appropriate for movie recording.
  	Smooth autofocus is slower and less visually invasive. Disabling smooth autofocus is more appropriate
  	for video processing where a fast autofocus is necessary.  The default value is NO.
  	Setting this property throws an NSInvalidArgumentException if -isSmoothAutoFocusSupported returns NO.
  	The receiver must be locked for configuration using lockForConfiguration: before clients can set this method,
  	otherwise an NSGenericException is thrown. Note that setting smoothAutoFocusEnabled alone does not initiate a
  	focus operation.  After setting smoothAutoFocusEnabled, call -setFocusMode: to apply the new smooth autofocus mode.
   */
  @available(iOS 7.0, *)
  var isSmoothAutoFocusEnabled: Bool

  /*!
   @property lensPosition
   @abstract
      Indicates the focus position of the lens.
   
   @discussion
      The range of possible positions is 0.0 to 1.0, with 0.0 being the shortest distance at which the lens can focus and
      1.0 the furthest. Note that 1.0 does not represent focus at infinity. The default value is 1.0.
      Note that a given lens position value does not correspond to an exact physical distance, nor does it represent a
      consistent focus distance from device to device. This property is key-value observable. It can be read at any time, 
      regardless of focus mode, but can only be set via setFocusModeLockedWithLensPosition:completionHandler:.
  */
  @available(iOS 8.0, *)
  var lensPosition: Float { get }

  /*!
   @method setFocusModeLockedWithLensPosition:completionHandler:
   @abstract
      Sets focusMode to AVCaptureFocusModeLocked and locks lensPosition at an explicit value.
   
   @param lensPosition
      The lens position, as described in the documentation for the lensPosition property. A value of AVCaptureLensPositionCurrent can be used
      to indicate that the caller does not wish to specify a value for lensPosition.
   @param handler
      A block to be called when lensPosition has been set to the value specified and focusMode is set to AVCaptureFocusModeLocked. If
      setFocusModeLockedWithLensPosition:completionHandler: is called multiple times, the completion handlers will be called in FIFO order. 
      The block receives a timestamp which matches that of the first buffer to which all settings have been applied. Note that the timestamp 
      is synchronized to the device clock, and thus must be converted to the master clock prior to comparison with the timestamps of buffers 
      delivered via an AVCaptureVideoDataOutput. The client may pass nil for the handler parameter if knowledge of the operation's completion 
      is not required.
   
   @discussion
      This is the only way of setting lensPosition.
      This method throws an NSRangeException if lensPosition is set to an unsupported level.
      This method throws an NSGenericException if called without first obtaining exclusive access to the receiver using lockForConfiguration:.
  */
  @available(iOS 8.0, *)
  func setFocusModeLockedWithLensPosition(lensPosition: Float, completionHandler handler: ((CMTime) -> Void)!)
}

/*!
 @constant AVCaptureLensPositionCurrent
    A special value that may be passed as the lensPosition parameter of setFocusModeLockedWithLensPosition:completionHandler: to
    indicate that the caller does not wish to specify a value for the lensPosition property, and that it should instead be set 
    to its current value. Note that the device may be adjusting lensPosition at the time of the call, in which case the value at 
    which lensPosition is locked may differ from the value obtained by querying the lensPosition property.
*/
@available(iOS 8.0, *)
let AVCaptureLensPositionCurrent: Float

/*!
 @enum AVCaptureExposureMode
 @abstract
    Constants indicating the mode of the exposure on the receiver's device, if it has adjustable exposure.

 @constant AVCaptureExposureModeLocked
    Indicates that the exposure should be locked at its current value.
 @constant AVCaptureExposureModeAutoExpose
    Indicates that the device should automatically adjust exposure once and then change the exposure mode to 
    AVCaptureExposureModeLocked.
 @constant AVCaptureExposureModeContinuousAutoExposure
    Indicates that the device should automatically adjust exposure when needed.
 @constant AVCaptureExposureModeCustom
    Indicates that the device should only adjust exposure according to user provided ISO, exposureDuration values.
*/
@available(iOS 4.0, *)
enum AVCaptureExposureMode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Locked
  case AutoExpose
  case ContinuousAutoExposure
  @available(iOS 8.0, *)
  case Custom
}
extension AVCaptureDevice {

  /*!
   @method isExposureModeSupported:
   @abstract
      Returns whether the receiver supports the given exposure mode.
  
   @param exposureMode
      An AVCaptureExposureMode to be checked.
   @result
      YES if the receiver supports the given exposure mode, NO otherwise.
  
   @discussion
      The receiver's exposureMode property can only be set to a certain mode if this method returns YES for that mode.
  */
  func isExposureModeSupported(exposureMode: AVCaptureExposureMode) -> Bool

  /*!
   @property exposureMode
   @abstract
      Indicates current exposure mode of the receiver, if it has adjustable exposure.
  
   @discussion
      The value of this property is an AVCaptureExposureMode that determines the receiver's exposure mode, if it has
      adjustable exposure.  -setExposureMode: throws an NSInvalidArgumentException if set to an unsupported value 
      (see -isExposureModeSupported:).  -setExposureMode: throws an NSGenericException if called without first obtaining 
      exclusive access to the receiver using lockForConfiguration:. When using AVCaptureStillImageOutput with
      automaticallyEnablesStillImageStabilizationWhenAvailable set to YES (the default behavior), the receiver's ISO and 
      exposureDuration values may be overridden by automatic still image stabilization values if the scene is dark enough 
      to warrant still image stabilization. To ensure that the receiver's ISO and exposureDuration values are honored while
      in AVCaptureExposureModeCustom or AVCaptureExposureModeLocked, you must set AVCaptureStillImageOutput's
      automaticallyEnablesStillImageStabilizationWhenAvailable property to NO. Clients can observe automatic changes to 
      the receiver's exposureMode by key value observing this property.
  */
  var exposureMode: AVCaptureExposureMode

  /*!
   @property exposurePointOfInterestSupported:
   @abstract
      Indicates whether the receiver supports exposure points of interest.
   
   @discussion
      The receiver's exposurePointOfInterest property can only be set if this property returns YES.
  */
  var isExposurePointOfInterestSupported: Bool { get }

  /*!
   @property exposurePointOfInterest
   @abstract
      Indicates current exposure point of interest of the receiver, if it has one.
  
   @discussion
      The value of this property is a CGPoint that determines the receiver's exposure point of interest, if it has
      adjustable exposure. A value of (0,0) indicates that the camera should adjust exposure based on the top left
      corner of the image, while a value of (1,1) indicates that it should adjust exposure based on the bottom right corner. The
      default value is (0.5,0.5). -setExposurePointOfInterest: throws an NSInvalidArgumentException if isExposurePointOfInterestSupported 
      returns NO.  -setExposurePointOfInterest: throws an NSGenericException if called without first obtaining exclusive access 
      to the receiver using lockForConfiguration:.  Note that setting exposurePointOfInterest alone does not initiate an exposure
      operation.  After setting exposurePointOfInterest, call -setExposureMode: to apply the new point of interest.
  */
  var exposurePointOfInterest: CGPoint

  /*!
   @property adjustingExposure
   @abstract
      Indicates whether the receiver is currently adjusting camera exposure.
  
   @discussion
      The value of this property is a BOOL indicating whether the receiver's camera exposure is being automatically
      adjusted because its exposure mode is AVCaptureExposureModeAutoExpose or AVCaptureExposureModeContinuousAutoExposure.
      Clients can observe the value of this property to determine whether the camera exposure is stable or is being
      automatically adjusted.
  */
  var isAdjustingExposure: Bool { get }

  /*!
   @property lensAperture
   @abstract
      The size of the lens diaphragm.
   
   @discussion
      The value of this property is a float indicating the size (f number) of the lens diaphragm.
      This property does not change.
  */
  @available(iOS 8.0, *)
  var lensAperture: Float { get }

  /*!
   @property exposureDuration
   @abstract
      The length of time over which exposure takes place.
   
   @discussion
      Only exposure duration values between activeFormat.minExposureDuration and activeFormat.maxExposureDuration are supported.
      This property is key-value observable. It can be read at any time, regardless of exposure mode, but can only be set
      via setExposureModeCustomWithDuration:ISO:completionHandler:.
  */
  @available(iOS 8.0, *)
  var exposureDuration: CMTime { get }

  /*!
   @property ISO
   @abstract
      The current exposure ISO value.
   
   @discussion
      This property controls the sensor's sensitivity to light by means of a gain value applied to the signal. Only ISO values
      between activeFormat.minISO and activeFormat.maxISO are supported. Higher values will result in noisier images.
      This property is key-value observable. It can be read at any time, regardless of exposure mode, but can only be set
      via setExposureModeCustomWithDuration:ISO:completionHandler:.
  */
  @available(iOS 8.0, *)
  var iso: Float { get }

  /*!
   @method setExposureModeCustomWithDuration:ISO:completionHandler:
   @abstract
      Sets exposureMode to AVCaptureExposureModeCustom and locks exposureDuration and ISO at explicit values.
   
   @param duration
      The exposure duration, as described in the documentation for the exposureDuration property. A value of AVCaptureExposureDurationCurrent
      can be used to indicate that the caller does not wish to specify a value for exposureDuration.
      Note that changes to this property may result in changes to activeVideoMinFrameDuration and/or activeVideoMaxFrameDuration.
   @param ISO
      The exposure ISO value, as described in the documentation for the ISO property. A value of AVCaptureISOCurrent
      can be used to indicate that the caller does not wish to specify a value for ISO.
   @param handler
      A block to be called when both exposureDuration and ISO have been set to the values specified and exposureMode is set to
      AVCaptureExposureModeCustom. If setExposureModeCustomWithDuration:ISO:completionHandler: is called multiple times, the completion handlers 
      will be called in FIFO order. The block receives a timestamp which matches that of the first buffer to which all settings have been applied.
      Note that the timestamp is synchronized to the device clock, and thus must be converted to the master clock prior to comparison with the
      timestamps of buffers delivered via an AVCaptureVideoDataOutput. The client may pass nil for the handler parameter if knowledge of the 
      operation's completion is not required.
   
   @discussion
      This is the only way of setting exposureDuration and ISO.
      This method throws an NSRangeException if either exposureDuration or ISO is set to an unsupported level.
      This method throws an NSGenericException if called without first obtaining exclusive access to the receiver using lockForConfiguration:.
      When using AVCaptureStillImageOutput with automaticallyEnablesStillImageStabilizationWhenAvailable set to YES (the default behavior),
      the receiver's ISO and exposureDuration values may be overridden by automatic still image stabilization values if the scene is dark
      enough to warrant still image stabilization.  To ensure that the receiver's ISO and exposureDuration values are honored while
      in AVCaptureExposureModeCustom or AVCaptureExposureModeLocked, you must set AVCaptureStillImageOutput's
      automaticallyEnablesStillImageStabilizationWhenAvailable property to NO.
  */
  @available(iOS 8.0, *)
  func setExposureModeCustomWithDuration(duration: CMTime, iso ISO: Float, completionHandler handler: ((CMTime) -> Void)!)

  /*!
   @property exposureTargetOffset
   @abstract
      Indicates the metered exposure level's offset from the target exposure value, in EV units.
   
   @discussion
      The value of this read-only property indicates the difference between the metered exposure level of the current scene and the target exposure value.
      This property is key-value observable.
  */
  @available(iOS 8.0, *)
  var exposureTargetOffset: Float { get }

  /*!
   @property exposureTargetBias
   @abstract
      Bias applied to the target exposure value, in EV units.
   
   @discussion
      When exposureMode is AVCaptureExposureModeContinuousAutoExposure or AVCaptureExposureModeLocked, the bias will affect
      both metering (exposureTargetOffset), and the actual exposure level (exposureDuration and ISO). When the exposure mode
      is AVCaptureExposureModeCustom, it will only affect metering.
      This property is key-value observable. It can be read at any time, but can only be set via setExposureTargetBias:completionHandler:.
  */
  @available(iOS 8.0, *)
  var exposureTargetBias: Float { get }

  /*!
   @property minExposureTargetBias
   @abstract
      A float indicating the minimum supported exposure bias, in EV units.
   
   @discussion
      This read-only property indicates the minimum supported exposure bias.
  */
  @available(iOS 8.0, *)
  var minExposureTargetBias: Float { get }

  /*!
   @property maxExposureTargetBias
   @abstract
      A float indicating the maximum supported exposure bias, in EV units.
   
   @discussion
      This read-only property indicates the maximum supported exposure bias.
  */
  @available(iOS 8.0, *)
  var maxExposureTargetBias: Float { get }

  /*!
   @method setExposureTargetBias:completionHandler:
   @abstract
      Sets the bias to be applied to the target exposure value.
   
   @param bias
      The bias to be applied to the exposure target value, as described in the documentation for the exposureTargetBias property.
   @param handler
      A block to be called when exposureTargetBias has been set to the value specified. If setExposureTargetBias:completionHandler:
      is called multiple times, the completion handlers will be called in FIFO order. The block receives a timestamp which matches 
      that of the first buffer to which the setting has been applied. Note that the timestamp is synchronized to the device clock, 
      and thus must be converted to the master clock prior to comparison with the timestamps of buffers delivered via an 
      AVCaptureVideoDataOutput. The client may pass nil for the handler parameter if knowledge of the operation's completion is not 
      required.
   
   @discussion
      This is the only way of setting exposureTargetBias.
      This method throws an NSRangeException if exposureTargetBias is set to an unsupported level.
      This method throws an NSGenericException if called without first obtaining exclusive access to the receiver using lockForConfiguration:.
  */
  @available(iOS 8.0, *)
  func setExposureTargetBias(bias: Float, completionHandler handler: ((CMTime) -> Void)!)
}

/*!
 @constant AVCaptureExposureDurationCurrent
    A special value that may be passed as the duration parameter of setExposureModeCustomWithDuration:ISO:completionHandler: to
    indicate that the caller does not wish to specify a value for the exposureDuration property, and that it should instead be set to its 
    current value. Note that the device may be adjusting exposureDuration at the time of the call, in which case the value to which
    exposureDuration is set may differ from the value obtained by querying the exposureDuration property.
*/
@available(iOS 8.0, *)
let AVCaptureExposureDurationCurrent: CMTime

/*!
 @constant AVCaptureISOCurrent
    A special value that may be passed as the ISO parameter of setExposureModeCustomWithDuration:ISO:completionHandler: to indicate
    that the caller does not wish to specify a value for the ISO property, and that it should instead be set to its current value. Note that the
    device may be adjusting ISO at the time of the call, in which case the value to which ISO is set may differ from the value obtained by querying
    the ISO property.
*/
@available(iOS 8.0, *)
let AVCaptureISOCurrent: Float

/*!
 @constant AVCaptureExposureTargetBiasCurrent
    A special value that may be passed as the bias parameter of setExposureTargetBias:completionHandler: to indicate that the
    caller does not wish to specify a value for the exposureTargetBias property, and that it should instead be set to its current
    value.
*/
@available(iOS 8.0, *)
let AVCaptureExposureTargetBiasCurrent: Float

/*!
 @enum AVCaptureWhiteBalanceMode
 @abstract
    Constants indicating the mode of the white balance on the receiver's device, if it has adjustable white balance.

 @constant AVCaptureWhiteBalanceModeLocked
    Indicates that the white balance should be locked at its current value.
 @constant AVCaptureWhiteBalanceModeAutoWhiteBalance
    Indicates that the device should automatically adjust white balance once and then change the white balance mode to 
    AVCaptureWhiteBalanceModeLocked.
 @constant AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance
    Indicates that the device should automatically adjust white balance when needed.
*/
@available(iOS 4.0, *)
enum AVCaptureWhiteBalanceMode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Locked
  case AutoWhiteBalance
  case ContinuousAutoWhiteBalance
}

/*!
 @typedef	AVCaptureWhiteBalanceGains
 @abstract	Structure containing RGB white balance gain values.
*/
@available(iOS 8.0, *)
struct AVCaptureWhiteBalanceGains {
  var redGain: Float
  var greenGain: Float
  var blueGain: Float
  init()
  init(redGain: Float, greenGain: Float, blueGain: Float)
}

/*!
 @typedef	AVCaptureWhiteBalanceChromaticityValues
 @abstract	Structure containing CIE 1931 xy chromaticity values
*/
@available(iOS 8.0, *)
struct AVCaptureWhiteBalanceChromaticityValues {
  var x: Float
  var y: Float
  init()
  init(x: Float, y: Float)
}

/*!
 @typedef	AVCaptureWhiteBalanceTemperatureAndTintValues
 @abstract	Structure containing a white balance color correlated temperature in kelvin, plus a tint value in the range of [-150 - +150].
*/
@available(iOS 8.0, *)
struct AVCaptureWhiteBalanceTemperatureAndTintValues {
  var temperature: Float
  var tint: Float
  init()
  init(temperature: Float, tint: Float)
}
extension AVCaptureDevice {

  /*!
   @method isWhiteBalanceModeSupported:
   @abstract
      Returns whether the receiver supports the given white balance mode.
  
   @param whiteBalanceMode
      An AVCaptureWhiteBalanceMode to be checked.
   @result
      YES if the receiver supports the given white balance mode, NO otherwise.
  
   @discussion
      The receiver's whiteBalanceMode property can only be set to a certain mode if this method returns YES for that mode.
  */
  func isWhiteBalanceModeSupported(whiteBalanceMode: AVCaptureWhiteBalanceMode) -> Bool

  /*!
   @property whiteBalanceMode
   @abstract
      Indicates current white balance mode of the receiver, if it has adjustable white balance.
  
   @discussion
      The value of this property is an AVCaptureWhiteBalanceMode that determines the receiver's white balance mode, if it
      has adjustable white balance. -setWhiteBalanceMode: throws an NSInvalidArgumentException if set to an unsupported value 
      (see -isWhiteBalanceModeSupported:).  -setWhiteBalanceMode: throws an NSGenericException if called without first obtaining 
      exclusive access to the receiver using lockForConfiguration:.  Clients can observe automatic changes to the receiver's 
      whiteBalanceMode by key value observing this property.
  */
  var whiteBalanceMode: AVCaptureWhiteBalanceMode

  /*!
   @property adjustingWhiteBalance
   @abstract
      Indicates whether the receiver is currently adjusting camera white balance.
  
   @discussion
      The value of this property is a BOOL indicating whether the receiver's camera white balance is being
      automatically adjusted because its white balance mode is AVCaptureWhiteBalanceModeAutoWhiteBalance or
      AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance. Clients can observe the value of this property to determine
      whether the camera white balance is stable or is being automatically adjusted.
  */
  var isAdjustingWhiteBalance: Bool { get }

  /*!
   @property deviceWhiteBalanceGains
   @abstract
      Indicates the current device-specific RGB white balance gain values in use.
   
   @discussion
      This property specifies the current red, green, and blue gain values used for white balance.  The values
      can be used to adjust color casts for a given scene.
   
      For each channel, only values between 1.0 and -maxWhiteBalanceGain are supported.
   
      This property is key-value observable. It can be read at any time, regardless of white balance mode, but can only be
      set via setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:completionHandler:.
  */
  @available(iOS 8.0, *)
  var deviceWhiteBalanceGains: AVCaptureWhiteBalanceGains { get }

  /*!
   @property grayWorldDeviceWhiteBalanceGains
   @abstract
      Indicates the current device-specific Gray World RGB white balance gain values in use.
   
   @discussion
      This property specifies the current red, green, and blue gain values derived from the current scene to deliver
      a neutral (or "Gray World") white point for white balance.
   
      Gray World values assume a neutral subject (e.g. a gray card) has been placed in the middle of the subject area and
      fills the center 50% of the frame.  Clients can read these values and apply them to the device using
      setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:completionHandler:.
   
      For each channel, only values between 1.0 and -maxWhiteBalanceGain are supported.
   
      This property is key-value observable. It can be read at any time, regardless of white balance mode.
  */
  @available(iOS 8.0, *)
  var grayWorldDeviceWhiteBalanceGains: AVCaptureWhiteBalanceGains { get }

  /*!
   @property maxWhiteBalanceGain
   @abstract
      Indicates the maximum supported value to which a channel in the AVCaptureWhiteBalanceGains may be set.
   
   @discussion
      This property does not change for the life of the receiver.
  */
  @available(iOS 8.0, *)
  var maxWhiteBalanceGain: Float { get }

  /*!
   @method setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:completionHandler:
   @abstract
      Sets white balance to locked mode with explicit deviceWhiteBalanceGains values.
   
   @param whiteBalanceGains
      The white balance gain values, as described in the documentation for the deviceWhiteBalanceGains property. A value of
      AVCaptureWhiteBalanceGainsCurrent can be used to indicate that the caller does not wish to specify a value for deviceWhiteBalanceGains.
   @param handler
      A block to be called when white balance gains have been set to the values specified and whiteBalanceMode is set to
      AVCaptureWhiteBalanceModeLocked. If setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:completionHandler: is called multiple times, 
      the completion handlers will be called in FIFO order. The block receives a timestamp which matches that of the first buffer to which 
      all settings have been applied. Note that the timestamp is synchronized to the device clock, and thus must be converted to the master 
      clock prior to comparison  with the timestamps of buffers delivered via an AVCaptureVideoDataOutput. This parameter may be nil if 
      synchronization is not required.
   
   @discussion
      For each channel in the whiteBalanceGains struct, only values between 1.0 and -maxWhiteBalanceGain are supported.
      Gain values are normalized to the minimum channel value to avoid brightness changes (e.g. R:2 G:2 B:4 will be
  	normalized to R:1 G:1 B:2).
      This method throws an NSRangeException if any of the whiteBalanceGains are set to an unsupported level.
      This method throws an NSGenericException if called without first obtaining exclusive access to the receiver using lockForConfiguration:.
  */
  @available(iOS 8.0, *)
  func setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains(whiteBalanceGains: AVCaptureWhiteBalanceGains, completionHandler handler: ((CMTime) -> Void)!)

  /*!
   @method chromaticityValuesForDeviceWhiteBalanceGains:
   @abstract
      Converts device-specific white balance RGB gain values to device-independent chromaticity values.
   
   @param whiteBalanceGains
      White balance gain values, as described in the documentation for the deviceWhiteBalanceGains property.
      A value of AVCaptureWhiteBalanceGainsCurrent may not be used in this function.
   @return
      A fully populated AVCaptureWhiteBalanceChromaticityValues structure containing device-independent values.
   
   @discussion
      This method may be called on the receiver to convert device-specific white balance RGB gain values to
      device-independent chromaticity (little x, little y) values.
   
      For each channel in the whiteBalanceGains struct, only values between 1.0 and -maxWhiteBalanceGain are supported.
      This method throws an NSRangeException if any of the whiteBalanceGains are set to unsupported values.
  */
  @available(iOS 8.0, *)
  func chromaticityValuesForDeviceWhiteBalanceGains(whiteBalanceGains: AVCaptureWhiteBalanceGains) -> AVCaptureWhiteBalanceChromaticityValues

  /*!
   @method deviceWhiteBalanceGainsForChromaticityValues:
   @abstract
      Converts device-independent chromaticity values to device-specific white balance RGB gain values.
   
   @param chromaticityValues
      Little x, little y chromaticity values as described in the documentation for AVCaptureWhiteBalanceChromaticityValues.
   
   @return
      A fully populated AVCaptureWhiteBalanceGains structure containing device-specific RGB gain values.
   
   @discussion
      This method may be called on the receiver to convert device-independent chromaticity values to device-specific RGB white
      balance gain values.
   
      This method throws an NSRangeException if any of the chromaticityValues are set outside the range [0,1].
  	Note that some x,y combinations yield out-of-range device RGB values that will cause an exception to be thrown
      if passed directly to -setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:completionHandler:.  Be sure to check that 
      red, green, and blue gain values are within the range of [1.0 - maxWhiteBalanceGain].
  */
  @available(iOS 8.0, *)
  func deviceWhiteBalanceGainsFor(chromaticityValues: AVCaptureWhiteBalanceChromaticityValues) -> AVCaptureWhiteBalanceGains

  /*!
   @method temperatureAndTintValuesForDeviceWhiteBalanceGains:
   @abstract
      Converts device-specific white balance RGB gain values to device-independent temperature and tint values.
   
   @param whiteBalanceGains
      White balance gain values, as described in the documentation for the deviceWhiteBalanceGains property.
      A value of AVCaptureWhiteBalanceGainsCurrent may not be used in this function.
   @return
      A fully populated AVCaptureWhiteBalanceTemperatureAndTintValues structure containing device-independent values.
   
   @discussion
      This method may be called on the receiver to convert device-specific white balance RGB gain values to
      device-independent temperature (in kelvin) and tint values.
   
      For each channel in the whiteBalanceGains struct, only values between 1.0 and -maxWhiteBalanceGain are supported.
      This method throws an NSRangeException if any of the whiteBalanceGains are set to unsupported values.
  */
  @available(iOS 8.0, *)
  func temperatureAndTintValuesForDeviceWhiteBalanceGains(whiteBalanceGains: AVCaptureWhiteBalanceGains) -> AVCaptureWhiteBalanceTemperatureAndTintValues

  /*!
   @method deviceWhiteBalanceGainsForTemperatureAndTintValues:
   @abstract
      Converts device-independent temperature and tint values to device-specific white balance RGB gain values.
   
   @param tempAndTintValues
      Temperature and tint values as described in the documentation for AVCaptureWhiteBalanceTemperatureAndTintValues.
   
   @return
      A fully populated AVCaptureWhiteBalanceGains structure containing device-specific RGB gain values.
   
   @discussion
      This method may be called on the receiver to convert device-independent temperature and tint values to device-specific RGB white
      balance gain values.
   
      You may pass any temperature and tint values and corresponding white balance gains will be produced. Note though that
      some temperature and tint combinations yield out-of-range device RGB values that will cause an exception to be thrown
      if passed directly to -setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:completionHandler:.  Be sure to check that 
      red, green, and blue gain values are within the range of [1.0 - maxWhiteBalanceGain].
  */
  @available(iOS 8.0, *)
  func deviceWhiteBalanceGainsFor(tempAndTintValues: AVCaptureWhiteBalanceTemperatureAndTintValues) -> AVCaptureWhiteBalanceGains
}

/*!
 @constant AVCaptureWhiteBalanceGainsCurrent
    A special value that may be passed as a parameter of setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:completionHandler: to
    indicate that the caller does not wish to specify a value for deviceWhiteBalanceGains, and that gains should instead be
    locked at their value at the moment that white balance is locked.
*/
@available(iOS 8.0, *)
let AVCaptureWhiteBalanceGainsCurrent: AVCaptureWhiteBalanceGains
extension AVCaptureDevice {

  /*!
   @property subjectAreaChangeMonitoringEnabled
   @abstract
  	Indicates whether the receiver should monitor the subject area for changes.
   
   @discussion
  	The value of this property is a BOOL indicating whether the receiver should
  	monitor the video subject area for changes, such as lighting changes, substantial
  	movement, etc.  If subject area change monitoring is enabled, the receiver
  	sends an AVCaptureDeviceSubjectAreaDidChangeNotification whenever it detects
  	a change to the subject area, at which time an interested client may wish
  	to re-focus, adjust exposure, white balance, etc.  The receiver must be locked 
  	for configuration using lockForConfiguration: before clients can set
  	the value of this property.
  */
  @available(iOS 5.0, *)
  var isSubjectAreaChangeMonitoringEnabled: Bool
}
extension AVCaptureDevice {

  /*!
   @property lowLightBoostSupported
   @abstract
      Indicates whether the receiver supports boosting images in low light conditions.
   
   @discussion
      The receiver's automaticallyEnablesLowLightBoostWhenAvailable property can only be set if this property returns YES.
  */
  @available(iOS 6.0, *)
  var isLowLightBoostSupported: Bool { get }

  /*!
   @property lowLightBoostEnabled
   @abstract
      Indicates whether the receiver's low light boost feature is enabled.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver is currently enhancing
      images to improve quality due to low light conditions. When -isLowLightBoostEnabled returns
      YES, the receiver has switched into a special mode in which more light can be perceived in images.
      This property is key-value observable.
  */
  @available(iOS 6.0, *)
  var isLowLightBoostEnabled: Bool { get }

  /*!
   @property automaticallyEnablesLowLightBoostWhenAvailable
   @abstract
      Indicates whether the receiver should automatically switch to low light boost mode when necessary.
   
   @discussion
      On a receiver where -isLowLightBoostSupported returns YES, a special low light boost mode may be
      engaged to improve image quality. When the automaticallyEnablesLowLightBoostWhenAvailable
      property is set to YES, the receiver switches at its discretion to a special boost mode under
      low light, and back to normal operation when the scene becomes sufficiently lit.  An AVCaptureDevice that
      supports this feature may only engage boost mode for certain source formats or resolutions.
      Clients may observe changes to the lowLightBoostEnabled property to know when the mode has engaged.
      The switch between normal operation and low light boost mode may drop one or more video frames.
      The default value is NO. Setting this property throws an NSInvalidArgumentException if -isLowLightBoostSupported
      returns NO. The receiver must be locked for configuration using lockForConfiguration: before clients
      can set this method, otherwise an NSGenericException is thrown.
  */
  @available(iOS 6.0, *)
  var automaticallyEnablesLowLightBoostWhenAvailable: Bool
}
extension AVCaptureDevice {

  /*!
   @property videoZoomFactor
   @abstract
   Controls zoom level of image outputs
   
   @discussion
   Applies a centered crop for all image outputs, scaling as necessary to maintain output
   dimensions.  Minimum value of 1.0 yields full field of view, increasing values will increase
   magnification, up to a maximum value specified in the activeFormat's videoMaxZoomFactor property.
   Modifying the zoom factor will cancel any active rampToVideoZoomFactor:withRate:, and snap
   directly to the assigned value.  Assigning values outside the acceptable range will generate
   an NSRangeException.  Clients can key value observe the value of this property.
   
   -setVideoZoomFactor: throws an NSGenericException if called without first obtaining exclusive
   access to the receiver using lockForConfiguration:.
   
   @seealso AVCaptureDeviceFormat AVCaptureDeviceFormat - videoMaxZoomFactor and videoZoomFactorUpscaleThreshold
   */
  @available(iOS 7.0, *)
  var videoZoomFactor: CGFloat

  /*!
   @method rampToVideoZoomFactor:withRate:
   @abstract
   Provides smooth changes in zoom factor.
   
   @discussion
   This method provides a change in zoom by compounding magnification at the specified
   rate over time.  Although the zoom factor will grow exponentially, this yields a
   visually linear zoom in the image over time.
   
   The zoom transition will stop at the specified factor, which must be in the valid range for
   videoZoomFactor.  Assignments to videoZoomFactor while a ramp is in progress will cancel the
   ramp and snap to the assigned value.
   
   The zoom factor is continuously scaled by pow(2,rate * time).  A rate of 0 causes no
   change in zoom factor, equivalent to calling cancelVideoZoomRamp.  A rate of 1 will
   cause the magnification to double every second (or halve every second if zooming out),
   and similarly larger or smaller values will zoom faster or slower respectively.  Only
   the absolute value of the rate is significant--sign is corrected for the direction
   of the target.  Changes in rate will be smoothed by an internal acceleration limit.
   
   -rampToVideoZoomFactor:withRate: throws an NSGenericException if called without first
   obtaining exclusive access to the receiver using lockForConfiguration:.
   */
  @available(iOS 7.0, *)
  func rampToVideoZoomFactor(factor: CGFloat, withRate rate: Float)

  /*!
   @property rampingVideoZoom
   @abstract
   Indicates if the zoom factor is transitioning to a value set by rampToVideoZoomFactor:withRate:
   
   @discussion
   Clients can observe this value to determine when a ramp begins or completes.
   */
  @available(iOS 7.0, *)
  var isRampingVideoZoom: Bool { get }

  /*!
   @method cancelVideoZoomRamp
   @abstract
   Eases out of any video zoom transitions initiated by rampToVideoZoomFactor:withRate:
   
   @discussion
   This method is equivalent to calling rampToVideoZoomFactor:withRate: using the current zoom factor
   target and a rate of 0.  This allows a smooth stop to any changes in zoom which were in progress.
   
   -cancelVideoZoomRamp: throws an NSGenericException if called without first
   obtaining exclusive access to the receiver using lockForConfiguration:.
   */
  @available(iOS 7.0, *)
  func cancelVideoZoomRamp()
}

/*!
 @enum AVAuthorizationStatus
 @abstract
    Constants indicating the client's authorization to the underlying hardware supporting a media type.
 
 @constant AVAuthorizationStatusNotDetermined
    Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
 @constant AVAuthorizationStatusRestricted
    The client is not authorized to access the hardware for the media type. The user cannot change
    the client's status, possibly due to active restrictions such as parental controls being in place.
 @constant AVAuthorizationStatusDenied
    The user explicitly denied access to the hardware supporting a media type for the client.
 @constant AVAuthorizationStatusAuthorized
    The client is authorized to access the hardware supporting a media type.
 */
@available(iOS 7.0, *)
enum AVAuthorizationStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case NotDetermined
  case Restricted
  case Denied
  case Authorized
}
extension AVCaptureDevice {

  /*!
   @method authorizationStatusForMediaType:
   @abstract
      Returns the client's authorization status for accessing the underlying hardware that supports a given media type.
   
   @param mediaType
      The media type, either AVMediaTypeVideo or AVMediaTypeAudio
   
   @result
      The authorization status of the client
   
   @discussion
      This method returns the AVAuthorizationStatus of the client for accessing the underlying hardware supporting
      the media type.  Media type constants are defined in AVMediaFormat.h.  If any media type other than AVMediaTypeVideo or
      AVMediaTypeAudio is supplied, an NSInvalidArgumentException will be thrown.  If the status is AVAuthorizationStatusNotDetermined,
      you may use the +requestAccessForMediaType:completionHandler: method to request access by prompting the user.
   */
  @available(iOS 7.0, *)
  class func authorizationStatusForMediaType(mediaType: String!) -> AVAuthorizationStatus

  /*!
   @method requestAccessForMediaType:completionHandler:
   @abstract
      Requests access to the underlying hardware for the media type, showing a dialog to the user if necessary.
   
   @param mediaType
      The media type, either AVMediaTypeVideo or AVMediaTypeAudio
   @param handler
      A block called with the result of requesting access
   
   @discussion
      Use this function to request access to the hardware for a given media type.   Media type constants are defined in AVMediaFormat.h.
      If any media type other than AVMediaTypeVideo or AVMediaTypeAudio is supplied, an NSInvalidArgumentException will be thrown.
   
      This call will not block while the user is being asked for access, allowing the client to continue running.  Until access has been granted,
      any AVCaptureDevices for the media type will vend silent audio samples or black video frames.  The user is only asked for permission
      the first time the client requests access.  Later calls use the permission granted by the user.
   
      Note that the authorization dialog will automatically be shown if the status is AVAuthorizationStatusNotDetermined when
      creating an AVCaptureDeviceInput.
   
      Invoking this method with AVMediaTypeAudio is equivalent to calling -[AVAudioSession requestRecordPermission:].
  
      The completion handler is called on an arbitrary dispatch queue.  Is it the client's responsibility to ensure that
      any UIKit-related updates are called on the main queue or main thread as a result.
   */
  @available(iOS 7.0, *)
  class func requestAccessForMediaType(mediaType: String!, completionHandler handler: ((Bool) -> Void)!)
}
extension AVCaptureDevice {

  /*!
   @property automaticallyAdjustsVideoHDREnabled
   @abstract
      Indicates whether the receiver is allowed to turn high dynamic range streaming on or off.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver is free to turn
      high dynamic range streaming on or off.  This property defaults to YES. By default, AVCaptureDevice
      always turns off videoHDREnabled when a client uses the -setActiveFormat: API to set a new format.
      When the client uses AVCaptureSession's setSessionPreset: API instead, AVCaptureDevice turns
      videoHDR on automatically if it's a good fit for the preset.  -setAutomaticallyAdjustsVideoHDREnabled:
      throws an NSGenericException if called without first obtaining exclusive access to the receiver using
      -lockForConfiguration:.  Clients can key-value observe videoHDREnabled to know when the receiver has automatically
      changed the value.
  */
  @available(iOS 8.0, *)
  var automaticallyAdjustsVideoHDREnabled: Bool

  /*!
   @property videoHDREnabled
   @abstract
      Indicates whether the receiver's streaming high dynamic range feature is enabled.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver is currently streaming
      high dynamic range video buffers. The property may only be set if you first set 
      automaticallyAdjustsVideoHDREnabled to NO, otherwise an NSGenericException is thrown.
      videoHDREnabled may only be set to YES if the receiver's activeFormat.isVideoHDRSupported property
      returns YES, otherwise an NSGenericException is thrown.  This property may be key-value observed.
   
      Note that setting this property may cause a lengthy reconfiguration of the receiver,
      similar to setting a new active format or AVCaptureSession sessionPreset.  If you are setting either the
      active format or the AVCaptureSession's sessionPreset AND this property, you should bracket these operations
      with [session beginConfiguration] and [session commitConfiguration] to minimize reconfiguration time.
  */
  @available(iOS 8.0, *)
  var isVideoHDREnabled: Bool
}

/*!
 @class AVFrameRateRange
 @abstract
    An AVFrameRateRange expresses a range of valid frame rates as min and max
    rate and min and max duration.

 @discussion
    An AVCaptureDevice exposes an array of formats, and its current activeFormat may be queried.  The
    payload for the formats property is an array of AVCaptureDeviceFormat objects and the activeFormat property
    payload is an AVCaptureDeviceFormat.  AVCaptureDeviceFormat wraps a CMFormatDescription and
    expresses a range of valid video frame rates as an NSArray of AVFrameRateRange objects.
    AVFrameRateRange expresses min and max frame rate as a rate in frames per second and
    duration (CMTime).  An AVFrameRateRange object is immutable.  Its values do not change for the life of the object.
*/
@available(iOS 7.0, *)
class AVFrameRateRange : Object {

  /*!
   @property minFrameRate
   @abstract
      A Float64 indicating the minimum frame rate supported by this range.
  
   @discussion
      This read-only property indicates the minimum frame rate supported by
      this range in frames per second.
  */
  var minFrameRate: Float64 { get }

  /*!
   @property maxFrameRate
   @abstract
      A Float64 indicating the maximum frame rate supported by this range.
  
   @discussion
      This read-only property indicates the maximum frame rate supported by
      this range in frames per second.
  */
  var maxFrameRate: Float64 { get }

  /*!
   @property maxFrameDuration
   @abstract
      A CMTime indicating the maximum frame duration supported by this range.
  
   @discussion
      This read-only property indicates the maximum frame duration supported by
      this range.  It is the reciprocal of minFrameRate, and expresses minFrameRate
      as a duration.
  */
  var maxFrameDuration: CMTime { get }

  /*!
   @property minFrameDuration
   @abstract
      A CMTime indicating the minimum frame duration supported by this range.
  
   @discussion
      This read-only property indicates the minimum frame duration supported by
      this range.  It is the reciprocal of maxFrameRate, and expresses maxFrameRate
      as a duration.
  */
  var minFrameDuration: CMTime { get }
  init()
}

/*!
 @enum AVCaptureVideoStabilizationMode
 @abstract
    Constants indicating the modes of video stabilization supported by the device's format.
 
 @constant AVCaptureVideoStabilizationModeOff
    Indicates that video should not be stabilized.
 @constant AVCaptureVideoStabilizationModeStandard
    Indicates that video should be stabilized using the standard video stabilization algorithm introduced with iOS 5.0.
    Standard video stabilization has a reduced field of view.  Enabling video stabilization may introduce additional
    latency into the video capture pipeline.
 @constant AVCaptureVideoStabilizationModeCinematic
    Indicates that video should be stabilized using the cinematic stabilization algorithm for more dramatic results.
    Cinematic video stabilization has a reduced field of view compared to standard video stabilization.
    Enabling cinematic video stabilization introduces much more latency into the video capture pipeline than
    standard video stabilization and consumes significantly more system memory.  Use narrow or identical min and max
    frame durations in conjunction with this mode.
 @constant AVCaptureVideoStabilizationModeAuto
    Indicates that the most appropriate video stabilization mode for the device and format should be chosen.
*/
@available(iOS 8.0, *)
enum AVCaptureVideoStabilizationMode : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Off
  case Standard
  case Cinematic
  case Auto
}

/*!
 @enum AVCaptureAutoFocusSystem
 @abstract
    Constants indicating the autofocus system.
 
 @constant AVCaptureAutoFocusSystemNone
    Indicates that autofocus is not available.
 @constant AVCaptureAutoFocusSystemContrastDetection
    Indicates that autofocus is achieved by contrast detection. 
    Contrast detection performs a focus scan to find the optimal position.
 @constant AVCaptureAutoFocusSystemPhaseDetection
    Indicates that autofocus is achieved by phase detection. 
    Phase detection has the ability to achieve focus in many cases without a focus scan.
    Phase detection autofocus is typically less visually intrusive than contrast detection autofocus.
*/
@available(iOS 8.0, *)
enum AVCaptureAutoFocusSystem : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case None
  case ContrastDetection
  case PhaseDetection
}

/*!
 @class AVCaptureDeviceFormat
 @abstract
    An AVCaptureDeviceFormat wraps a CMFormatDescription and other format-related information, such
    as min and max framerate.

 @discussion
    An AVCaptureDevice exposes an array of formats, and its current activeFormat may be queried.  The
    payload for the formats property is an array of AVCaptureDeviceFormat objects and the activeFormat property
    payload is an AVCaptureDeviceFormat.  AVCaptureDeviceFormat is a thin wrapper around a 
    CMFormatDescription, and can carry associated device format information that doesn't go in a
    CMFormatDescription, such as min and max frame rate.  An AVCaptureDeviceFormat object is immutable.
    Its values do not change for the life of the object.
*/
@available(iOS 7.0, *)
class AVCaptureDeviceFormat : Object {

  /*!
   @property mediaType
   @abstract
      An NSString describing the media type of an AVCaptureDevice active or supported format.
  
   @discussion
      Supported mediaTypes are listed in AVMediaFormat.h.  This is a read-only
      property.  The caller assumes no ownership of the returned value and should not CFRelease it.
  */
  var mediaType: String! { get }

  /*!
   @property formatDescription
   @abstract
      A CMFormatDescription describing an AVCaptureDevice active or supported format.
  
   @discussion
      A CMFormatDescription describing an AVCaptureDevice active or supported format.  This is a read-only
      property.  The caller assumes no ownership of the returned value and should not CFRelease it.
  */
  var formatDescription: CMFormatDescription! { get }

  /*!
   @property videoSupportedFrameRateRanges
   @abstract
      A property indicating the format's supported frame rate ranges.
  
   @discussion
      videoSupportedFrameRateRanges is an array of AVFrameRateRange objects, one for
      each of the format's supported video frame rate ranges.
  */
  var videoSupportedFrameRateRanges: [AnyObject]! { get }

  /*!
   @property videoFieldOfView
   @abstract
      A property indicating the format's field of view.
  
   @discussion
      videoFieldOfView is a float value indicating the receiver's field of view in degrees.
      If field of view is unknown, a value of 0 is returned.
  */
  @available(iOS 7.0, *)
  var videoFieldOfView: Float { get }

  /*!
   @property videoBinned
   @abstract
      A property indicating whether the format is binned.
  
   @discussion
      videoBinned is a BOOL indicating whether the format is a binned format.
      Binning is a pixel-combining process which can result in greater low light sensitivity at the cost of reduced resolution.
  */
  @available(iOS 7.0, *)
  var isVideoBinned: Bool { get }

  /*!
   @method isVideoStabilizationModeSupported
   @abstract
      Returns whether the format supports the given video stabilization mode.
   
   @param videoStabilizationMode
      An AVCaptureVideoStabilizationMode to be checked.
   
   @discussion
      isVideoStabilizationModeSupported: returns a boolean value indicating whether the format can be stabilized using
      the given mode with -[AVCaptureConnection setPreferredVideoStabilizationMode:].
  */
  @available(iOS 8.0, *)
  func isVideoStabilizationModeSupported(videoStabilizationMode: AVCaptureVideoStabilizationMode) -> Bool

  /*!
   @property videoStabilizationSupported
   @abstract
      A property indicating whether the format supports video stabilization.
  
   @discussion
      videoStabilizationSupported is a BOOL indicating whether the format can be stabilized using 
      AVCaptureConnection -setEnablesVideoStabilizationWhenAvailable.
      This property is deprecated.  Use isVideoStabilizationModeSupported: instead.
  */
  @available(iOS, introduced=7.0, deprecated=8.0, message="Use isVideoStabilizationModeSupported: instead.")
  var isVideoStabilizationSupported: Bool { get }

  /*!
   @property videoMaxZoomFactor
   @abstract
      Indicates the maximum zoom factor available for the AVCaptureDevice's videoZoomFactor property.
   
   @discussion
      If the device's videoZoomFactor property is assigned a larger value, an NSRangeException will
      be thrown. A maximum zoom factor of 1 indicates no zoom is available.
   */
  @available(iOS 7.0, *)
  var videoMaxZoomFactor: CGFloat { get }

  /*!
   @property videoZoomFactorUpscaleThreshold
   @abstract
      Indicates the value of AVCaptureDevice's videoZoomFactor property at which the image output
      begins to require upscaling.
   
   @discussion
      In some cases the image sensor's dimensions are larger than the dimensions reported by the video
      AVCaptureDeviceFormat.  As long as the sensor crop is larger than the reported dimensions of the
      AVCaptureDeviceFormat, the image will be downscaled.  Setting videoZoomFactor to the value of
      videoZoomFactorUpscalingThreshold will provide a center crop of the sensor image data without
      any scaling.  If a greater zoom factor is used, then the sensor data will be upscaled to the
      device format's dimensions.
   */
  @available(iOS 7.0, *)
  var videoZoomFactorUpscaleThreshold: CGFloat { get }

  /*!
   @property minExposureDuration
   @abstract
      A CMTime indicating the minimum supported exposure duration.
   
   @discussion
      This read-only property indicates the minimum supported exposure duration.
  */
  @available(iOS 8.0, *)
  var minExposureDuration: CMTime { get }

  /*!
   @property maxExposureDuration
   @abstract
      A CMTime indicating the maximum supported exposure duration.
   
   @discussion
      This read-only property indicates the maximum supported exposure duration.
  */
  @available(iOS 8.0, *)
  var maxExposureDuration: CMTime { get }

  /*!
   @property minISO
   @abstract
      A float indicating the minimum supported exposure ISO value.
   
   @discussion
      This read-only property indicates the minimum supported exposure ISO value.
  */
  @available(iOS 8.0, *)
  var minISO: Float { get }

  /*!
   @property maxISO
   @abstract
      An float indicating the maximum supported exposure ISO value.
   
   @discussion
      This read-only property indicates the maximum supported exposure ISO value.
  */
  @available(iOS 8.0, *)
  var maxISO: Float { get }

  /*!
   @property videoHDRSupported
   @abstract
      A property indicating whether the format supports high dynamic range streaming.
  
   @discussion
      videoHDRSupported is a BOOL indicating whether the format supports
      high dynamic range streaming.  See AVCaptureDevice's videoHDREnabled property.
  */
  @available(iOS 8.0, *)
  var isVideoHDRSupported: Bool { get }

  /*!
   @property highResolutionStillImageDimensions
   @abstract
      CMVideoDimensions indicating the highest resolution still image that can be produced by this format.
   
   @discussion
      Normally, AVCaptureStillImageOutput emits images with the same dimensions as its source AVCaptureDevice's
      activeFormat.  However, if you set highResolutionStillImageOutputEnabled to YES, AVCaptureStillImageOutput
      emits still images with its source AVCaptureDevice's activeFormat.highResolutionStillImageDimensions.
  */
  @available(iOS 8.0, *)
  var highResolutionStillImageDimensions: CMVideoDimensions { get }

  /*!
   @property autoFocusSystem
   @abstract
      A property indicating the autofocus system.
   
   @discussion
      This read-only property indicates the autofocus system.
  */
  @available(iOS 8.0, *)
  var autoFocusSystem: AVCaptureAutoFocusSystem { get }
  init()
}

/*!
 @class AVCaptureInput
 @abstract
    AVCaptureInput is an abstract class that provides an interface for connecting capture input sources to an
    AVCaptureSession.

 @discussion
    Concrete instances of AVCaptureInput representing input sources such as cameras can be added to instances of
    AVCaptureSession using the -[AVCaptureSession addInput:] method. An AVCaptureInput vends one or more streams of
    media data. For example, input devices can provide both audio and video data. Each media stream provided by an input
    is represented by an AVCaptureInputPort object. Within a capture session, connections are made between
    AVCaptureInput instances and AVCaptureOutput instances via AVCaptureConnection objects that define the mapping
    between a set of AVCaptureInputPort objects and a single AVCaptureOutput.
*/
@available(iOS 4.0, *)
class AVCaptureInput : Object {

  /*!
   @property ports
   @abstract
      The ports owned by the receiver.
  
   @discussion
      The value of this property is an array of AVCaptureInputPort objects, each exposing an interface to a single stream
      of media data provided by an input.
  */
  var ports: [AnyObject]! { get }
  init()
}

/*!
 @constant AVCaptureInputPortFormatDescriptionDidChangeNotification
 @abstract
    This notification is posted when the value of an AVCaptureInputPort instance's formatDescription property changes.

 @discussion
    The notification object is the AVCaptureInputPort instance whose format description changed.
*/
@available(iOS 4.0, *)
let AVCaptureInputPortFormatDescriptionDidChangeNotification: String

/*!
 @class AVCaptureInputPort
 @abstract
    An AVCaptureInputPort describes a single stream of media data provided by an AVCaptureInput and provides an
    interface for connecting that stream to AVCaptureOutput instances via AVCaptureConnection.

 @discussion
    Instances of AVCaptureInputPort cannot be created directly. An AVCaptureInput exposes its input ports via its ports
    property. Input ports provide information about the format of their media data via the mediaType and
    formatDescription properties, and allow clients to control the flow of data via the enabled property. Input ports
    are used by an AVCaptureConnection to define the mapping between inputs and outputs in an AVCaptureSession.
*/
@available(iOS 4.0, *)
class AVCaptureInputPort : Object {

  /*!
   @property input
   @abstract
      The input that owns the receiver.
  
   @discussion
      The value of this property is an AVCaptureInput instance that owns the receiver.
  */
  var input: AVCaptureInput! { get }

  /*!
   @property mediaType
   @abstract
      The media type of the data provided by the receiver.
  
   @discussion
      The value of this property is a constant describing the type of media, such as AVMediaTypeVideo or AVMediaTypeAudio,
      provided by the receiver. Media type constants are defined in AVMediaFormat.h.
  */
  var mediaType: String! { get }

  /*!
   @property formatDescription
   @abstract
      The format of the data provided by the receiver.
  
   @discussion
      The value of this property is a CMFormatDescription that describes the format of the media data currently provided
      by the receiver. Clients can be notified of changes to the format by observing the
      AVCaptureInputPortFormatDescriptionDidChangeNotification.
  */
  var formatDescription: CMFormatDescription! { get }

  /*!
   @property enabled
   @abstract
      Whether the receiver should provide data.
  
   @discussion
      The value of this property is a BOOL that determines whether the receiver should provide data to outputs when a
      session is running. Clients can set this property to fine tune which media streams from a given input will be used
      during capture. The default value is YES.
  */
  var isEnabled: Bool

  /*!
   @property clock
   @abstract
  	Provides access to the "native" clock used by the input port.
   @discussion
  	The clock is read-only.
   */
  @available(iOS 7.0, *)
  var clock: CMClock! { get }
  init()
}

/*!
 @class AVCaptureDeviceInput
 @abstract
    AVCaptureDeviceInput is a concrete subclass of AVCaptureInput that provides an interface for capturing media from an
    AVCaptureDevice.

 @discussion
    Instances of AVCaptureDeviceInput are input sources for AVCaptureSession that provide media data from devices
    connected to the system, represented by instances of AVCaptureDevice.
*/
@available(iOS 4.0, *)
class AVCaptureDeviceInput : AVCaptureInput {

  /*!
   @method initWithDevice:error:
   @abstract
      Creates an AVCaptureDeviceInput instance that provides media data from the given device.
  
   @param device
      An AVCaptureDevice instance to be used for capture.
   @param outError
      On return, if the given device cannot be used for capture, points to an NSError describing the problem.
   @result
      An AVCaptureDeviceInput instance that provides data from the given device, or nil, if the device could not be used
      for capture.
  
   @discussion
      This method creates an instance of AVCaptureDeviceInput that can be used to capture data from an AVCaptureDevice in
      an AVCaptureSession. This method attempts to open the device for capture, taking exclusive control of it if
      necessary. If the device cannot be opened because it is no longer available or because it is in use, for example,
      this method returns nil, and the optional outError parameter points to an NSError describing the problem.
  */
  init(device: AVCaptureDevice!) throws

  /*!
   @property device
   @abstract
      The device from which the receiver provides data.
  
   @discussion
      The value of this property is the AVCaptureDevice instance that was used to create the receiver.
  */
  var device: AVCaptureDevice! { get }
  init()
}

/*!
 @class AVCaptureMetadataInput
 @abstract
    AVCaptureMetadataInput is a concrete subclass of AVCaptureInput that provides a way for
    clients to supply AVMetadataItems to an AVCaptureSession.

 @discussion
    Instances of AVCaptureMetadataInput are input sources for AVCaptureSession that provide
    AVMetadataItems to an AVCaptureSession.  AVCaptureMetadataInputs present one and only one
    AVCaptureInputPort, which currently may only be connected to an AVCaptureMovieFileOutput.
    The metadata supplied over the input port is provided by the client, and must conform to a
    client-supplied CMFormatDescription.  The AVMetadataItems are supplied in an AVTimedMetadataGroup.
*/
@available(iOS 9.0, *)
class AVCaptureMetadataInput : AVCaptureInput {

  /*!
   @method initWithFormatDescription:clock:
   @abstract
      Creates an AVCaptureMetadataInput instance that allows a client to provide
      AVTimedMetadataGroups to an AVCaptureSession.
  
   @param desc
      A CMFormatDescription that defines the metadata to be supplied by the client.
      Throws NSInvalidArgumentException if NULL is passed.
   @param clock
      A CMClock that provided the timebase for the supplied samples.
      Throws NSInvalidArgumentException if NULL is passed.
   @result
      An AVCaptureMetadataInput instance, or nil, if the device could not be used
      for capture.
  
   @discussion
      This method creates an instance of AVCaptureMetadataInput that can be used to capture
      AVTimedMetadataGroups supplied by the client to an AVCaptureSession.
  */
  init!(formatDescription desc: CMMetadataFormatDescription!, clock: CMClock!)

  /*!
   @method appendTimedMetadataGroup:
   @abstract
      Provides metadata to the AVCaptureSession.
  
   @param metadata
      An AVTimedMetadataGroup of metadata.  Will throw an exception if nil.
      In order to denote a period of no metadata, an empty AVTimedMetadataGroup should
      be passed.
  
   @discussion
      The provided AVTimedMetadataGroup will be provided to the AVCaptureSession.  The group's
      presentation timestamp is expressed in the context of the clock supplied to the initializer.
      It is not required that the AVTimedMetadataGroup have a duration;  an empty AVTimedMetadataGroup
      can be supplied to denote a period of no metadata.
  */
  func append(metadata: AVTimedMetadataGroup!) throws
  init()
}

/*!
 @class AVCaptureOutput
 @abstract
    AVCaptureOutput is an abstract class that defines an interface for an output destination of an AVCaptureSession.
 
 @discussion
    AVCaptureOutput provides an abstract interface for connecting capture output destinations, such as files and video
    previews, to an AVCaptureSession.

    An AVCaptureOutput can have multiple connections represented by AVCaptureConnection objects, one for each stream of
    media that it receives from an AVCaptureInput. An AVCaptureOutput does not have any connections when it is first
    created. When an output is added to an AVCaptureSession, connections are created that map media data from that
    session's inputs to its outputs.

    Concrete AVCaptureOutput instances can be added to an AVCaptureSession using the -[AVCaptureSession addOutput:] and
    -[AVCaptureSession addOutputWithNoConnections:] methods.
*/
@available(iOS 4.0, *)
class AVCaptureOutput : Object {

  /*!
   @property connections
   @abstract
      The connections that describe the flow of media data to the receiver from AVCaptureInputs.
  
   @discussion
      The value of this property is an NSArray of AVCaptureConnection objects, each describing the mapping between the
      receiver and the AVCaptureInputPorts of one or more AVCaptureInputs.
  */
  var connections: [AnyObject]! { get }

  /*!
   @method connectionWithMediaType:
   @abstract
      Returns the first connection in the connections array with an inputPort of the specified mediaType.
  
   @param mediaType
      An AVMediaType constant from AVMediaFormat.h, e.g. AVMediaTypeVideo.
  
   @discussion
      This convenience method returns the first AVCaptureConnection in the receiver's
      connections array that has an AVCaptureInputPort of the specified mediaType.  If no
      connection with the specified mediaType is found, nil is returned.
  */
  @available(iOS 5.0, *)
  func connectionWithMediaType(mediaType: String!) -> AVCaptureConnection!

  /*!
   @method transformedMetadataObjectForMetadataObject:connection:
   @abstract
      Converts an AVMetadataObject's visual properties to the receiver's coordinates.
  
   @param metadataObject
      An AVMetadataObject originating from the same AVCaptureInput as the receiver.
   
   @param connection
      The receiver's connection whose AVCaptureInput matches that of the metadata object to be converted.
  
   @result
      An AVMetadataObject whose properties are in output coordinates.
  
   @discussion
      AVMetadataObject bounds may be expressed as a rect where {0,0} represents the top left of the picture area,
      and {1,1} represents the bottom right on an unrotated picture.  Face metadata objects likewise express
      yaw and roll angles with respect to an unrotated picture.  -transformedMetadataObjectForMetadataObject:connection: 
  	converts the visual properties in the coordinate space of the supplied AVMetadataObject to the coordinate space of 
      the receiver.  The conversion takes orientation, mirroring, and scaling into consideration.
      If the provided metadata object originates from an input source other than the preview layer's, nil will be returned.
   
      If an AVCaptureVideoDataOutput instance's connection's videoOrientation or videoMirrored properties are set to
      non-default values, the output applies the desired mirroring and orientation by physically rotating and or flipping 
      sample buffers as they pass through it.  AVCaptureStillImageOutput, on the other hand, does not physically rotate its buffers.
      It attaches an appropriate kCGImagePropertyOrientation number to captured still image buffers (see ImageIO/CGImageProperties.h)
      indicating how the image should be displayed on playback.  Likewise, AVCaptureMovieFileOutput does not physically
      apply orientation/mirroring to its sample buffers -- it uses a QuickTime track matrix to indicate how the buffers
      should be rotated and/or flipped on playback.
   
      transformedMetadataObjectForMetadataObject:connection: alters the visual properties of the provided metadata object 
      to match the physical rotation / mirroring of the sample buffers provided by the receiver through the indicated 
      connection.  I.e., for video data output, adjusted metadata object coordinates are rotated/mirrored.  For still image 
      and movie file output, they are not.
  */
  @available(iOS 6.0, *)
  func transformedMetadataObjectFor(metadataObject: AVMetadataObject!, connection: AVCaptureConnection!) -> AVMetadataObject!

  /*!
   @method metadataOutputRectOfInterestForRect:
   @abstract
  	Converts a rectangle in the receiver's coordinate space to a rectangle of interest in the coordinate space of an AVCaptureMetadataOutput
  	whose capture device is providing input to the receiver.
   
   @param rectInOutputCoordinates
  	A CGRect in the receiver's coordinates.
   
   @result
  	A CGRect in the coordinate space of the metadata output whose capture device is providing input to the receiver.
   
   @discussion
  	AVCaptureMetadataOutput rectOfInterest is expressed as a CGRect where {0,0} represents the top left of the picture area,
  	and {1,1} represents the bottom right on an unrotated picture.  This convenience method converts a rectangle in
  	the coordinate space of the receiver to a rectangle of interest in the coordinate space of an AVCaptureMetadataOutput
  	whose AVCaptureDevice is providing input to the receiver.  The conversion takes orientation, mirroring, and scaling into 
  	consideration.  See -transformedMetadataObjectForMetadataObject:connection: for a full discussion of how orientation and mirroring
  	are applied to sample buffers passing through the output.	
   */
  @available(iOS 7.0, *)
  func metadataOutputRectOfInterestFor(rectInOutputCoordinates: CGRect) -> CGRect

  /*!
   @method rectForMetadataOutputRectOfInterest:
   @abstract
  	Converts a rectangle of interest in the coordinate space of an AVCaptureMetadataOutput whose capture device is
  	providing input to the receiver to a rectangle in the receiver's coordinates.
   
   @param rectInMetadataOutputCoordinates
  	A CGRect in the coordinate space of the metadata output whose capture device is providing input to the receiver.
   
   @result
  	A CGRect in the receiver's coordinates.
   
   @discussion
  	AVCaptureMetadataOutput rectOfInterest is expressed as a CGRect where {0,0} represents the top left of the picture area,
  	and {1,1} represents the bottom right on an unrotated picture.  This convenience method converts a rectangle in the coordinate 
  	space of an AVCaptureMetadataOutput whose AVCaptureDevice is providing input to the coordinate space of the receiver.  The 
  	conversion takes orientation, mirroring, and scaling into consideration. See -transformedMetadataObjectForMetadataObject:connection: 
  	for a full discussion of how orientation and mirroring are applied to sample buffers passing through the output.
   */
  @available(iOS 7.0, *)
  func rectForMetadataOutputRectOfInterest(rectInMetadataOutputCoordinates: CGRect) -> CGRect
  init()
}

/*!
 @class AVCaptureVideoDataOutput
 @abstract
    AVCaptureVideoDataOutput is a concrete subclass of AVCaptureOutput that can be used to process uncompressed or
    compressed frames from the video being captured.

 @discussion
    Instances of AVCaptureVideoDataOutput produce video frames suitable for processing using other media APIs.
    Applications can access the frames with the captureOutput:didOutputSampleBuffer:fromConnection: delegate method.
*/
@available(iOS 4.0, *)
class AVCaptureVideoDataOutput : AVCaptureOutput {

  /*!
   @method setSampleBufferDelegate:queue:
   @abstract
      Sets the receiver's delegate that will accept captured buffers and dispatch queue on which the delegate will be
      called.
  
   @param sampleBufferDelegate
      An object conforming to the AVCaptureVideoDataOutputSampleBufferDelegate protocol that will receive sample buffers
      after they are captured.
   @param sampleBufferCallbackQueue
      A dispatch queue on which all sample buffer delegate methods will be called.
  
   @discussion
      When a new video sample buffer is captured it will be vended to the sample buffer delegate using the
      captureOutput:didOutputSampleBuffer:fromConnection: delegate method. All delegate methods will be called on the
      specified dispatch queue. If the queue is blocked when new frames are captured, those frames will be automatically
      dropped at a time determined by the value of the alwaysDiscardsLateVideoFrames property. This allows clients to
      process existing frames on the same queue without having to manage the potential memory usage increases that would
      otherwise occur when that processing is unable to keep up with the rate of incoming frames. If their frame processing
      is consistently unable to keep up with the rate of incoming frames, clients should consider using the
      minFrameDuration property, which will generally yield better performance characteristics and more consistent frame
      rates than frame dropping alone.
  
      Clients that need to minimize the chances of frames being dropped should specify a queue on which a sufficiently
      small amount of processing is being done outside of receiving sample buffers. However, if such clients migrate extra
      processing to another queue, they are responsible for ensuring that memory usage does not grow without bound from
      frames that have not been processed.
  
      A serial dispatch queue must be used to guarantee that video frames will be delivered in order.
      The sampleBufferCallbackQueue parameter may not be NULL, except when setting the sampleBufferDelegate
      to nil.
  */
  func setSampleBufferDelegate(sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate!, queue sampleBufferCallbackQueue: dispatch_queue_t!)

  /*!
   @property sampleBufferDelegate
   @abstract
      The receiver's delegate.
  
   @discussion
      The value of this property is an object conforming to the AVCaptureVideoDataOutputSampleBufferDelegate protocol that
      will receive sample buffers after they are captured. The delegate is set using the setSampleBufferDelegate:queue:
      method.
  */
  var sampleBufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate! { get }

  /*!
   @property sampleBufferCallbackQueue
   @abstract
      The dispatch queue on which all sample buffer delegate methods will be called.
  
   @discussion
      The value of this property is a dispatch_queue_t. The queue is set using the setSampleBufferDelegate:queue: method.
  */
  var sampleBufferCallbackQueue: dispatch_queue_t! { get }

  /*!
   @property videoSettings
   @abstract
      Specifies the settings used to decode or re-encode video before it is output by the receiver.
  
   @discussion
      See AVVideoSettings.h for more information on how to construct a video settings dictionary.  To receive samples in their 
      device native format, set this property to an empty dictionary (i.e. [NSDictionary dictionary]).  To receive samples in
      a default uncompressed format, set this property to nil.  Note that after this property is set to nil, subsequent
      querying of this property will yield a non-nil dictionary reflecting the settings used by the AVCaptureSession's current 
      sessionPreset.
  
      On iOS, the only supported key is kCVPixelBufferPixelFormatTypeKey. Supported pixel formats are
      kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange, kCVPixelFormatType_420YpCbCr8BiPlanarFullRange and kCVPixelFormatType_32BGRA.
  */
  var videoSettings: [Object : AnyObject]!

  /*!
   @method recommendedVideoSettingsForAssetWriterWithOutputFileType:
   @abstract
      Specifies the recommended settings for use with an AVAssetWriterInput.
  
   @param outputFileType
      Specifies the UTI of the file type to be written (see AVMediaFormat.h for a list of file format UTIs).
   
   @return
      A fully populated dictionary of keys and values that are compatible with AVAssetWriter.
   
   @discussion
      The value of this property is an NSDictionary containing values for compression settings keys defined in
      AVVideoSettings.h.  This dictionary is suitable for use as the "outputSettings" parameter when creating an AVAssetWriterInput, such as,
          
         [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:outputSettings sourceFormatHint:hint];
      
  	The dictionary returned contains all necessary keys and values needed by AVAssetWriter (see AVAssetWriterInput.h, 
      -initWithMediaType:outputSettings: for a more in depth discussion). For QuickTime movie and ISO file types,
      the recommended video settings will produce output comparable to that of AVCaptureMovieFileOutput.
  
      Note that the dictionary of settings is dependent on the current configuration of the receiver's AVCaptureSession
      and its inputs.  The settings dictionary may change if the session's configuration changes.  As such, you should
      configure your session first, then query the recommended video settings.  As of iOS 8.3, movies produced with these
      settings successfully import into the iOS camera roll and sync to and from like devices via iTunes.
  */
  @available(iOS 7.0, *)
  func recommendedVideoSettingsForAssetWriterWithOutputFileType(outputFileType: String!) -> [Object : AnyObject]!

  /*!
   @property availableVideoCVPixelFormatTypes
   @abstract
      Indicates the supported video pixel formats that can be specified in videoSettings.
  
   @discussion
      The value of this property is an NSArray of NSNumbers that can be used as values for the 
      kCVPixelBufferPixelFormatTypeKey in the receiver's videoSettings property.  The first
      format in the returned list is the most efficient output format.
  */
  @available(iOS 5.0, *)
  var availableVideoCVPixelFormatTypes: [AnyObject]! { get }

  /*!
   @property availableVideoCodecTypes
   @abstract
      Indicates the supported video codec formats that can be specified in videoSettings.
  
   @discussion
      The value of this property is an NSArray of NSStrings that can be used as values for the 
      AVVideoCodecKey in the receiver's videoSettings property.
  */
  @available(iOS 5.0, *)
  var availableVideoCodecTypes: [AnyObject]! { get }

  /*!
   @property alwaysDiscardsLateVideoFrames
   @abstract
      Specifies whether the receiver should always discard any video frame that is not processed before the next frame is
      captured.
  
   @discussion
      When the value of this property is YES, the receiver will immediately discard frames that are captured while the
      dispatch queue handling existing frames is blocked in the captureOutput:didOutputSampleBuffer:fromConnection:
      delegate method. When the value of this property is NO, delegates will be allowed more time to process old frames
      before new frames are discarded, but application memory usage may increase significantly as a result. The default
      value is YES.
  */
  var alwaysDiscardsLateVideoFrames: Bool
  init()
}

/*!
 @protocol AVCaptureVideoDataOutputSampleBufferDelegate
 @abstract
    Defines an interface for delegates of AVCaptureVideoDataOutput to receive captured video sample buffers and be
    notified of late sample buffers that were dropped.
*/
protocol AVCaptureVideoDataOutputSampleBufferDelegate : ObjectProtocol {

  /*!
   @method captureOutput:didOutputSampleBuffer:fromConnection:
   @abstract
      Called whenever an AVCaptureVideoDataOutput instance outputs a new video frame.
  
   @param captureOutput
      The AVCaptureVideoDataOutput instance that output the frame.
   @param sampleBuffer
      A CMSampleBuffer object containing the video frame data and additional information about the frame, such as its
      format and presentation time.
   @param connection
      The AVCaptureConnection from which the video was received.
  
   @discussion
      Delegates receive this message whenever the output captures and outputs a new video frame, decoding or re-encoding it
      as specified by its videoSettings property. Delegates can use the provided video frame in conjunction with other APIs
      for further processing. This method will be called on the dispatch queue specified by the output's
      sampleBufferCallbackQueue property. This method is called periodically, so it must be efficient to prevent capture
      performance problems, including dropped frames.
  
      Clients that need to reference the CMSampleBuffer object outside of the scope of this method must CFRetain it and
      then CFRelease it when they are finished with it.
  
      Note that to maintain optimal performance, some sample buffers directly reference pools of memory that may need to be
      reused by the device system and other capture inputs. This is frequently the case for uncompressed device native
      capture where memory blocks are copied as little as possible. If multiple sample buffers reference such pools of
      memory for too long, inputs will no longer be able to copy new samples into memory and those samples will be dropped.
      If your application is causing samples to be dropped by retaining the provided CMSampleBuffer objects for too long,
      but it needs access to the sample data for a long period of time, consider copying the data into a new buffer and
      then calling CFRelease on the sample buffer if it was previously retained so that the memory it references can be
      reused.
  */
  @available(iOS 4.0, *)
  optional func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)

  /*!
   @method captureOutput:didDropSampleBuffer:fromConnection:
   @abstract
      Called once for each frame that is discarded.
  
   @param captureOutput
      The AVCaptureVideoDataOutput instance that dropped the frame.
   @param sampleBuffer
      A CMSampleBuffer object containing information about the dropped frame, such as its format and presentation time.
      This sample buffer will contain none of the original video data.
   @param connection
      The AVCaptureConnection from which the dropped video frame was received.
  
   @discussion
      Delegates receive this message whenever a video frame is dropped. This method is called once 
      for each dropped frame. The CMSampleBuffer object passed to this delegate method will contain metadata 
      about the dropped video frame, such as its duration and presentation time stamp, but will contain no 
      actual video data. On iOS, Included in the sample buffer attachments is the kCMSampleBufferAttachmentKey_DroppedFrameReason,
      which indicates why the frame was dropped.  This method will be called on the dispatch queue specified by the output's
      sampleBufferCallbackQueue property. Because this method will be called on the same dispatch queue that is responsible
      for outputting video frames, it must be efficient to prevent further capture performance problems, such as additional
      dropped video frames.
   */
  @available(iOS 6.0, *)
  optional func captureOutput(captureOutput: AVCaptureOutput!, didDrop sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)
}

/*!
 @class AVCaptureAudioDataOutput
 @abstract
    AVCaptureAudioDataOutput is a concrete subclass of AVCaptureOutput that can be used to process uncompressed or
    compressed samples from the audio being captured.
 
 @discussion
    Instances of AVCaptureAudioDataOutput produce audio sample buffers suitable for processing using other media APIs.
    Applications can access the sample buffers with the captureOutput:didOutputSampleBuffer:fromConnection: delegate
    method.
*/
@available(iOS 4.0, *)
class AVCaptureAudioDataOutput : AVCaptureOutput {

  /*!
   @method setSampleBufferDelegate:queue:
   @abstract
      Sets the receiver's delegate that will accept captured buffers and dispatch queue on which the delegate will be
      called.
  
   @param sampleBufferDelegate
      An object conforming to the AVCaptureAudioDataOutputSampleBufferDelegate protocol that will receive sample buffers
      after they are captured.
   @param sampleBufferCallbackQueue
      A dispatch queue on which all sample buffer delegate methods will be called.
  
   @discussion
      When a new audio sample buffer is captured it will be vended to the sample buffer delegate using the
      captureOutput:didOutputSampleBuffer:fromConnection: delegate method. All delegate methods will be called on the
      specified dispatch queue. If the queue is blocked when new samples are captured, those samples will be automatically
      dropped when they become sufficiently late. This allows clients to process existing samples on the same queue without
      having to manage the potential memory usage increases that would otherwise occur when that processing is unable to
      keep up with the rate of incoming samples.
  
      Clients that need to minimize the chances of samples being dropped should specify a queue on which a sufficiently
      small amount of processing is being done outside of receiving sample buffers. However, if such clients migrate extra
      processing to another queue, they are responsible for ensuring that memory usage does not grow without bound from
      samples that have not been processed.
  
      A serial dispatch queue must be used to guarantee that audio samples will be delivered in order.
      The sampleBufferCallbackQueue parameter may not be NULL, except when setting sampleBufferDelegate to nil.
  */
  func setSampleBufferDelegate(sampleBufferDelegate: AVCaptureAudioDataOutputSampleBufferDelegate!, queue sampleBufferCallbackQueue: dispatch_queue_t!)

  /*!
   @property sampleBufferDelegate
   @abstract
      The receiver's delegate.
  
   @discussion
      The value of this property is an object conforming to the AVCaptureAudioDataOutputSampleBufferDelegate protocol that
      will receive sample buffers after they are captured. The delegate is set using the setSampleBufferDelegate:queue:
      method.
  */
  var sampleBufferDelegate: AVCaptureAudioDataOutputSampleBufferDelegate! { get }

  /*!
   @property sampleBufferCallbackQueue
   @abstract
      The dispatch queue on which all sample buffer delegate methods will be called.
  
   @discussion
      The value of this property is a dispatch_queue_t. The queue is set using the setSampleBufferDelegate:queue: method.
  */
  var sampleBufferCallbackQueue: dispatch_queue_t! { get }

  /*!
   @method recommendedAudioSettingsForAssetWriterWithOutputFileType:
   @abstract
      Specifies the recommended settings for use with an AVAssetWriterInput.
  
   @param outputFileType
      Specifies the UTI of the file type to be written (see AVMediaFormat.h for a list of file format UTIs).
   
   @return
      A fully populated dictionary of keys and values that are compatible with AVAssetWriter.
   
   @discussion
      The value of this property is an NSDictionary containing values for compression settings keys defined in
      AVAudioSettings.h.  This dictionary is suitable for use as the "outputSettings" parameter when creating an AVAssetWriterInput, such as,
          
         [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:outputSettings sourceFormatHint:hint];
      
  	The dictionary returned contains all necessary keys and values needed by AVAssetWriter (see AVAssetWriterInput.h, 
      -initWithMediaType:outputSettings: for a more in depth discussion).  For QuickTime movie and ISO files, the 
      recommended audio settings will always produce output comparable to that of AVCaptureMovieFileOutput.
  
  	Note that the dictionary of settings is dependent on the current configuration of the receiver's AVCaptureSession
      and its inputs.  The settings dictionary may change if the session's configuration changes.  As such, you should
      configure your session first, then query the recommended audio settings.
  */
  @available(iOS 7.0, *)
  func recommendedAudioSettingsForAssetWriterWithOutputFileType(outputFileType: String!) -> [Object : AnyObject]!
  init()
}

/*!
 @protocol AVCaptureAudioDataOutputSampleBufferDelegate
 @abstract
    Defines an interface for delegates of AVCaptureAudioDataOutput to receive captured audio sample buffers.
*/
protocol AVCaptureAudioDataOutputSampleBufferDelegate : ObjectProtocol {

  /*!
   @method captureOutput:didOutputSampleBuffer:fromConnection:
   @abstract
      Called whenever an AVCaptureAudioDataOutput instance outputs a new audio sample buffer.
  
   @param captureOutput
      The AVCaptureAudioDataOutput instance that output the samples.
   @param sampleBuffer
      A CMSampleBuffer object containing the audio samples and additional information about them, such as their format and
      presentation time.
   @param connection
      The AVCaptureConnection from which the audio was received.
  
   @discussion
      Delegates receive this message whenever the output captures and outputs new audio samples, decoding or re-encoding
      as specified by the audioSettings property. Delegates can use the provided sample buffer in conjunction with other
      APIs for further processing. This method will be called on the dispatch queue specified by the output's
      sampleBufferCallbackQueue property. This method is called periodically, so it must be efficient to prevent capture
      performance problems, including dropped audio samples.
  
      Clients that need to reference the CMSampleBuffer object outside of the scope of this method must CFRetain it and
      then CFRelease it when they are finished with it.
  */
  @available(iOS 4.0, *)
  optional func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)
}

/*!
 @class AVCaptureFileOutput
 @abstract
    AVCaptureFileOutput is an abstract subclass of AVCaptureOutput that provides an interface for writing captured media
    to files.
 
 @discussion
    This abstract superclass defines the interface for outputs that record media samples to files. File outputs can start
    recording to a new file using the startRecordingToOutputFileURL:recordingDelegate: method. On successive invocations of this method on
    Mac OS X, the output file can by changed dynamically without losing media samples. A file output can stop recording
    using the stopRecording method. Because files are recorded in the background, applications will need to specify a
    delegate for each new file so that they can be notified when recorded files are finished.

    On Mac OS X, clients can also set a delegate on the file output itself that can be used to control recording along
    exact media sample boundaries using the captureOutput:didOutputSampleBuffer:fromConnection: method.

    The concrete subclasses of AVCaptureFileOutput are AVCaptureMovieFileOutput, which records media to a QuickTime movie
    file, and AVCaptureAudioFileOutput, which writes audio media to a variety of audio file formats.
*/
@available(iOS 4.0, *)
class AVCaptureFileOutput : AVCaptureOutput {

  /*!
   @property outputFileURL
   @abstract
      The file URL of the file to which the receiver is currently recording incoming buffers.
  
   @discussion
      The value of this property is an NSURL object containing the file URL of the file currently being written by the
      receiver. Returns nil if the receiver is not recording to any file.
  */
  var outputFileURL: URL! { get }

  /*!
   @method startRecordingToOutputFileURL:recordingDelegate:
   @abstract
      Tells the receiver to start recording to a new file, and specifies a delegate that will be notified when recording is
      finished.
   
   @param outputFileURL
      An NSURL object containing the URL of the output file. This method throws an NSInvalidArgumentException if the URL is
      not a valid file URL.
   @param delegate
      An object conforming to the AVCaptureFileOutputRecordingDelegate protocol. Clients must specify a delegate so that
      they can be notified when recording to the given URL is finished.
  
   @discussion
      The method sets the file URL to which the receiver is currently writing output media. If a file at the given URL
      already exists when capturing starts, recording to the new file will fail.
  
      Clients need not call stopRecording before calling this method while another recording is in progress. On Mac OS X,
      if this method is invoked while an existing output file was already being recorded, no media samples will be
      discarded between the old file and the new file.
  
      When recording is stopped either by calling stopRecording, by changing files using this method, or because of an
      error, the remaining data that needs to be included to the file will be written in the background. Therefore, clients
      must specify a delegate that will be notified when all data has been written to the file using the
      captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error: method. The recording delegate can also
      optionally implement methods that inform it when data starts being written, when recording is paused and resumed, and
      when recording is about to be finished.
  
      On Mac OS X, if this method is called within the captureOutput:didOutputSampleBuffer:fromConnection: delegate method,
      the first samples written to the new file are guaranteed to be those contained in the sample buffer passed to that
      method.
  
      Note: AVCaptureAudioFileOutput does not support -startRecordingToOutputFileURL:recordingDelegate:.  Use
      -startRecordingToOutputFileURL:outputFileType:recordingDelegate: instead.
  */
  func startRecordingToOutputFileURL(outputFileURL: URL!, recordingDelegate delegate: AVCaptureFileOutputRecordingDelegate!)

  /*!
   @method stopRecording
   @abstract
      Tells the receiver to stop recording to the current file.
  
   @discussion
      Clients can call this method when they want to stop recording new samples to the current file, and do not want to
      continue recording to another file. Clients that want to switch from one file to another should not call this method.
      Instead they should simply call startRecordingToOutputFileURL:recordingDelegate: with the new file URL.
  
      When recording is stopped either by calling this method, by changing files using
      startRecordingToOutputFileURL:recordingDelegate:, or because of an error, the remaining data that needs to be
      included to the file will be written in the background. Therefore, before using the file, clients must wait until the
      delegate that was specified in startRecordingToOutputFileURL:recordingDelegate: is notified when all data has been
      written to the file using the captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error: method.
  
      On Mac OS X, if this method is called within the captureOutput:didOutputSampleBuffer:fromConnection: delegate method,
      the last samples written to the current file are guaranteed to be those that were output immediately before those in
      the sample buffer passed to that method.
  */
  func stopRecording()

  /*!
   @property recording
   @abstract
      Indicates whether the receiver is currently recording.
  
   @discussion
      The value of this property is YES when the receiver currently has a file to which it is writing new samples, NO
      otherwise.
  */
  var isRecording: Bool { get }

  /*!
   @property recordedDuration
   @abstract
      Indicates the duration of the media recorded to the current output file.
  
   @discussion
      If recording is in progress, this property returns the total time recorded so far.
  */
  var recordedDuration: CMTime { get }

  /*!
   @property recordedFileSize
   @abstract
      Indicates the size, in bytes, of the data recorded to the current output file.
  
   @discussion
      If a recording is in progress, this property returns the size in bytes of the data recorded so far.
  */
  var recordedFileSize: Int64 { get }

  /*!
   @property maxRecordedDuration
   @abstract
      Specifies the maximum duration of the media that should be recorded by the receiver.
  
   @discussion
      This property specifies a hard limit on the duration of recorded files. Recording is stopped when the limit is
      reached and the captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error: delegate method is invoked
      with an appropriate error. The default value of this property is kCMTimeInvalid, which indicates no limit.
  */
  var maxRecordedDuration: CMTime

  /*!
   @property maxRecordedFileSize
   @abstract
      Specifies the maximum size, in bytes, of the data that should be recorded by the receiver.
   
   @discussion
      This property specifies a hard limit on the data size of recorded files. Recording is stopped when the limit is
      reached and the captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error: delegate method is invoked
      with an appropriate error. The default value of this property is 0, which indicates no limit.
  */
  var maxRecordedFileSize: Int64

  /*!
   @property minFreeDiskSpaceLimit
   @abstract
      Specifies the minimum amount of free space, in bytes, required for recording to continue on a given volume.
  
   @discussion
      This property specifies a hard lower limit on the amount of free space that must remain on a target volume for
      recording to continue. Recording is stopped when the limit is reached and the
      captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error: delegate method is invoked with an
      appropriate error.
  */
  var minFreeDiskSpaceLimit: Int64
  init()
}

/*!
 @protocol AVCaptureFileOutputRecordingDelegate
 @abstract
    Defines an interface for delegates of AVCaptureFileOutput to respond to events that occur in the process of recording
    a single file.
*/
protocol AVCaptureFileOutputRecordingDelegate : ObjectProtocol {

  /*!
   @method captureOutput:didStartRecordingToOutputFileAtURL:fromConnections:
   @abstract
      Informs the delegate when the output has started writing to a file.
  
   @param captureOutput
      The capture file output that started writing the file.
   @param fileURL
      The file URL of the file that is being written.
   @param connections
      An array of AVCaptureConnection objects attached to the file output that provided the data that is being written to
      the file.
  
   @discussion
      This method is called when the file output has started writing data to a file. If an error condition prevents any
      data from being written, this method may not be called.
      captureOutput:willFinishRecordingToOutputFileAtURL:fromConnections:error: and
      captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error: will always be called, even if no data is
      written.
  
      Clients should not assume that this method will be called on a specific thread, and should also try to make this
      method as efficient as possible.
  */
  @available(iOS 4.0, *)
  optional func capture(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [AnyObject]!)

  /*!
   @method captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:
   @abstract
      Informs the delegate when all pending data has been written to an output file.
  
   @param captureOutput
      The capture file output that has finished writing the file.
   @param fileURL
      The file URL of the file that has been written.
   @param connections
      An array of AVCaptureConnection objects attached to the file output that provided the data that was written to the
      file.
   @param error
      An error describing what caused the file to stop recording, or nil if there was no error.
  
   @discussion
      This method is called when the file output has finished writing all data to a file whose recording was stopped,
      either because startRecordingToOutputFileURL:recordingDelegate: or stopRecording were called, or because an error,
      described by the error parameter, occurred (if no error occurred, the error parameter will be nil).  This method will
      always be called for each recording request, even if no data is successfully written to the file.
  
      Clients should not assume that this method will be called on a specific thread.
  
      Delegates are required to implement this method.
  */
  @available(iOS 4.0, *)
  func capture(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [AnyObject]!, error: Error!)
}

/*!
 @class AVCaptureMovieFileOutput
 @abstract
    AVCaptureMovieFileOutput is a concrete subclass of AVCaptureFileOutput that writes captured media to QuickTime movie
    files.

 @discussion
    AVCaptureMovieFileOutput implements the complete file recording interface declared by AVCaptureFileOutput for writing
    media data to QuickTime movie files. In addition, instances of AVCaptureMovieFileOutput allow clients to configure
    options specific to the QuickTime file format, including allowing them to write metadata collections to each file,
    specify media encoding options for each track (Mac OS X), and specify an interval at which movie fragments should be written.
*/
@available(iOS 4.0, *)
class AVCaptureMovieFileOutput : AVCaptureFileOutput {

  /*!
   @property movieFragmentInterval
   @abstract
      Specifies the frequency with which movie fragments should be written.
  
   @discussion
      When movie fragments are used, a partially written QuickTime movie file whose writing is unexpectedly interrupted can
      be successfully opened and played up to multiples of the specified time interval. A value of kCMTimeInvalid indicates
      that movie fragments should not be used, but that only a movie atom describing all of the media in the file should be
      written. The default value of this property is ten seconds.
  
      Changing the value of this property will not affect the movie fragment interval of the file currently being written,
      if there is one.
  */
  var movieFragmentInterval: CMTime

  /*!
   @property metadata
   @abstract
      A collection of metadata to be written to the receiver's output files.
  
   @discussion
      The value of this property is an array of AVMetadataItem objects representing the collection of top-level metadata to
      be written in each output file.
  */
  var metadata: [AnyObject]!

  /*!
   @method recordsVideoOrientationAndMirroringChangesAsMetadataTrackForConnection:
   @abstract
      Returns YES if the movie file output will create a timed metadata track that records samples which
  	reflect changes made to the given connection's videoOrientation and videoMirrored properties
  	during recording.
  
   @param connection
      A connection delivering video media to the movie file output. This method throws an NSInvalidArgumentException
  	if the connection does not have a mediaType of AVMediaTypeVideo or if the connection does not terminate at
  	the movie file output.
  
   @discussion
  	See setRecordsVideoOrientationAndMirroringChanges:asMetadataTrackForConnection: for details on the behavior
  	controlled by this value.
  	
  	The default value returned is NO.
  */
  @available(iOS 9.0, *)
  func recordsVideoOrientationAndMirroringChangesAsMetadataTrackFor(connection: AVCaptureConnection!) -> Bool

  /*!
   @method setRecordsVideoOrientationAndMirroringChanges:asMetadataTrackForConnection:
   @abstract
      Controls whether or not the movie file output will create a timed metadata track that records samples which
  	reflect changes made to the given connection's videoOrientation and videoMirrored properties during
  	recording.
   
   @param doRecordChanges
      If YES, the movie file output will create a timed metadata track that records samples which reflect changes
  	made to the given connection's videoOrientation and videoMirrored properties during recording.
  
   @param connection
      A connection delivering video media to the movie file output. This method throws an NSInvalidArgumentException
  	if the connection does not have a mediaType of AVMediaTypeVideo or if the connection does not terminate at
  	the movie file output.
  
   @discussion
      When a recording is started the current state of a video capture connection's videoOrientation and videoMirrored
  	properties are used to build the display matrix for the created video track. The movie file format allows only
  	one display matrix per track, which means that any changes made during a recording to the videoOrientation and
  	videoMirrored properties are not captured.  For example, a user starts a recording with their device in the portrait
  	orientation, and then partway through the recording changes the device to a landscape orientation. The landscape
  	orientation requires a different display matrix, but only the initial display matrix (the portrait display
  	matrix) is recorded for the video track.
  	
  	By invoking this method the client application directs the movie file output to create an additional track in the
  	captured movie. This track is a timed metadata track that is associated with the video track, and contains one or
  	more samples that contain a Video Orientation value (as defined by EXIF and TIFF specifications, which is enumerated
  	by CGImagePropertyOrientation in <ImageIO/CGImageProperties.h>).  The value represents the display matrix corresponding
  	to the AVCaptureConnection's videoOrientation and videoMirrored properties when applied to the input source.  The
  	initial sample written to the timed metadata track represents video track's display matrix. During recording additional
  	samples will be written to the timed metadata track whenever the client application changes the video connection's
  	videoOrienation or videoMirrored properties. Using the above example, when the client application detects the user
  	changing the device from portrait to landscape orientation, it updates the video connection's videoOrientation property,
  	thus causing the movie file output to add a new sample to the timed metadata track.
  	
  	After capture, playback and editing applications can use the timed metadata track to enhance their user's experience.
  	For example, when playing back the captured movie, a playback engine can use the samples to adjust the display of the
  	video samples to keep the video properly oriented.  Another example is an editing application that uses the sample
  	the sample times to suggest cut points for breaking the captured movie into separate clips, where each clip is properly
  	oriented.
  	
  	The default behavior is to not create the timed metadata track.
  	
  	The doRecordChanges value is only observed at the start of recording.  Changes to the value will not have any
  	effect until the next recording is started.
  */
  @available(iOS 9.0, *)
  func setRecordsVideoOrientationAndMirroringChanges(doRecordChanges: Bool, asMetadataTrackFor connection: AVCaptureConnection!)
  init()
}

/*!
 @class AVCaptureStillImageOutput
 @abstract
    AVCaptureStillImageOutput is a concrete subclass of AVCaptureOutput that can be used to capture high-quality still
    images with accompanying metadata.

 @discussion
    Instances of AVCaptureStillImageOutput can be used to capture, on demand, high quality snapshots from a realtime
    capture source. Clients can request a still image for the current time using the
    captureStillImageAsynchronouslyFromConnection:completionHandler: method. Clients can also configure still image
    outputs to produce still images in specific image formats.
*/
@available(iOS 4.0, *)
class AVCaptureStillImageOutput : AVCaptureOutput {

  /*!
   @property outputSettings
   @abstract
      Specifies the options the receiver uses to encode still images before they are delivered.
  
   @discussion
      See AVVideoSettings.h for more information on how to construct an output settings dictionary.
  
      On iOS, the only currently supported keys are AVVideoCodecKey and kCVPixelBufferPixelFormatTypeKey. 
      Use -availableImageDataCVPixelFormatTypes and -availableImageDataCodecTypes to determine what 
      codec keys and pixel formats are supported. AVVideoQualityKey is supported on iOS 6.0 and later
      and may only be used when AVVideoCodecKey is set to AVVideoCodecJPEG.
  */
  var outputSettings: [Object : AnyObject]!

  /*!
   @property availableImageDataCVPixelFormatTypes
   @abstract
      Indicates the supported image pixel formats that can be specified in outputSettings.
  
   @discussion
      The value of this property is an NSArray of NSNumbers that can be used as values for the 
      kCVPixelBufferPixelFormatTypeKey in the receiver's outputSettings property.  The first
      format in the returned list is the most efficient output format.
  */
  var availableImageDataCVPixelFormatTypes: [AnyObject]! { get }

  /*!
   @property availableImageDataCodecTypes
   @abstract
      Indicates the supported image codec formats that can be specified in outputSettings.
  
   @discussion
      The value of this property is an NSArray of NSStrings that can be used as values for the 
      AVVideoCodecKey in the receiver's outputSettings property.
  */
  var availableImageDataCodecTypes: [AnyObject]! { get }

  /*!
   @property stillImageStabilizationSupported
   @abstract
      Indicates whether the receiver supports still image stabilization.
   
   @discussion
      The receiver's automaticallyEnablesStillImageStabilizationWhenAvailable property can only be set 
      if this property returns YES.  Its value may change as the session's -sessionPreset or input device's
      -activeFormat changes.
  */
  @available(iOS 7.0, *)
  var isStillImageStabilizationSupported: Bool { get }

  /*!
   @property automaticallyEnablesStillImageStabilizationWhenAvailable
   @abstract
      Indicates whether the receiver should automatically use still image stabilization when necessary.
   
   @discussion
      On a receiver where -isStillImageStabilizationSupported returns YES, image stabilization
      may be applied to reduce blur commonly found in low light photos. When stabilization is enabled, still 
      image captures incur additional latency. The default value is YES when supported, NO otherwise. Setting 
      this property throws an NSInvalidArgumentException if -isStillImageStabilizationSupported returns NO.
  */
  @available(iOS 7.0, *)
  var automaticallyEnablesStillImageStabilizationWhenAvailable: Bool

  /*!
   @property stillImageStabilizationActive
   @abstract
      Indicates whether still image stabilization is in use for the current capture.
   
   @discussion
      On a receiver where -isStillImageStabilizationSupported returns YES, and
      automaticallyEnablesStillImageStabilizationWhenAvailable is set to YES, this property may be key-value
      observed, or queried from inside your key-value observation callback for the @"capturingStillImage"
  	property, to find out if still image stabilization is being applied to the current capture.
  */
  @available(iOS 7.0, *)
  var isStillImageStabilizationActive: Bool { get }

  /*!
   @property highResolutionStillImageOutputEnabled
   @abstract
      Indicates whether the receiver should emit still images at the highest resolution supported
      by its source AVCaptureDevice's activeFormat.
   
   @discussion
      By default, AVCaptureStillImageOutput emits images with the same dimensions as its source AVCaptureDevice's
      activeFormat.formatDescription.  However, if you set this property to YES, the receiver emits still images at its source
      AVCaptureDevice's activeFormat.highResolutionStillImageDimensions.  Note that if you enable video stabilization
      (see AVCaptureConnection's preferredVideoStabilizationMode) for any output, the high resolution still images 
      emitted by AVCaptureStillImageOutput may be smaller by 10 or more percent.
  */
  @available(iOS 8.0, *)
  var isHighResolutionStillImageOutputEnabled: Bool

  /*!
   @property capturingStillImage
   @abstract
      A boolean value that becomes true when a still image is being captured.
  
   @discussion
      The value of this property is a BOOL that becomes true when a still image is being
      captured, and false when no still image capture is underway.  This property is
      key-value observable.
  */
  @available(iOS 5.0, *)
  var isCapturingStillImage: Bool { get }

  /*!
   @method captureStillImageAsynchronouslyFromConnection:completionHandler:
   @abstract
      Initiates an asynchronous still image capture, returning the result to a completion handler.
  
   @param connection
      The AVCaptureConnection object from which to capture the still image.
   @param handler
      A block that will be called when the still image capture is complete. The block will be passed a CMSampleBuffer
      object containing the image data or an NSError object if an image could not be captured.
  
   @discussion
      This method will return immediately after it is invoked, later calling the provided completion handler block when
      image data is ready. If the request could not be completed, the error parameter will contain an NSError object
      describing the failure.
  
      Attachments to the image data sample buffer may contain metadata appropriate to the image data format. For instance,
      a sample buffer containing JPEG data may carry a kCGImagePropertyExifDictionary as an attachment. See
      <ImageIO/CGImageProperties.h> for a list of keys and value types.
  
      Clients should not assume that the completion handler will be called on a specific thread.
   
      Calls to captureStillImageAsynchronouslyFromConnection:completionHandler: are not synchronized with AVCaptureDevice
      manual control completion handlers. Setting a device manual control, waiting for its completion, then calling
      captureStillImageAsynchronouslyFromConnection:completionHandler: DOES NOT ensure that the still image returned reflects
      your manual control change. It may be from an earlier time. You can compare your manual control completion handler sync time
      to the returned still image's presentation time. You can retrieve the sample buffer's pts using 
      CMSampleBufferGetPresentationTimestamp(). If the still image has an earlier timestamp, your manual control command 
      does not apply to it.
  */
  func captureStillImageAsynchronouslyFrom(connection: AVCaptureConnection!, completionHandler handler: ((CMSampleBuffer!, Error!) -> Void)!)

  /*!
   @method jpegStillImageNSDataRepresentation:
   @abstract
      Converts the still image data and metadata attachments in a JPEG sample buffer to an NSData representation.
  
   @param jpegSampleBuffer
      The sample buffer carrying JPEG image data, optionally with Exif metadata sample buffer attachments.
      This method throws an NSInvalidArgumentException if jpegSampleBuffer is NULL or not in the JPEG format.
  
   @discussion
      This method returns an NSData representation of a JPEG still image sample buffer, merging the image data and
      Exif metadata sample buffer attachments without recompressing the image.
      The returned NSData is suitable for writing to disk.
  */
  class func jpegStillImageNSDataRepresentation(jpegSampleBuffer: CMSampleBuffer!) -> Data!
  init()
}

/*!
 @class AVCaptureBracketedStillImageSettings
 @abstract
    AVCaptureBracketedStillImageSettings is an abstract base class that defines an interface for settings
	pertaining to a bracketed capture.
 
 @discussion
    AVCaptureBracketedStillImageSettings may not be instantiated directly.
*/
@available(iOS 8.0, *)
class AVCaptureBracketedStillImageSettings : Object {
  init()
}

/*!
 @class AVCaptureManualExposureBracketedStillImageSettings
 @abstract
    AVCaptureManualExposureBracketedStillImageSettings is a concrete subclass of AVCaptureBracketedStillImageSettings
    to be used when bracketing exposure duration and ISO.
 
 @discussion
    An AVCaptureManualExposureBracketedStillImageSettings instance defines the exposure duration and ISO
    settings that should be applied to one image in a bracket. An array of settings objects is passed to
    -[AVCaptureStillImageOutput captureStillImageBracketAsynchronouslyFromConnection:withSettingsArray:completionHandler:].
    Min and max duration and ISO values are queryable properties of the AVCaptureDevice supplying data to
    an AVCaptureStillImageOutput instance. If you wish to leave exposureDuration unchanged for this bracketed
    still image, you may pass the special value AVCaptureExposureDurationCurrent. To keep ISO unchanged, you may
    pass AVCaptureISOCurrent (see AVCaptureDevice.h).
*/
@available(iOS 8.0, *)
class AVCaptureManualExposureBracketedStillImageSettings : AVCaptureBracketedStillImageSettings {
  class func manualExposureSettingsWithExposureDuration(duration: CMTime, iso ISO: Float) -> Self!
  var exposureDuration: CMTime { get }
  var iso: Float { get }
  init()
}

/*!
 @class AVCaptureAutoExposureBracketedStillImageSettings
 @abstract
    AVCaptureAutoExposureBracketedStillImageSettings is a concrete subclass of AVCaptureBracketedStillImageSettings
    to be used when bracketing exposure target bias.
 
 @discussion
    An AVCaptureAutoExposureBracketedStillImageSettings instance defines the exposure target bias
    setting that should be applied to one image in a bracket. An array of settings objects is passed to
    -[AVCaptureStillImageOutput captureStillImageBracketAsynchronouslyFromConnection:withSettingsArray:completionHandler:].
    Min and max exposure target bias are queryable properties of the AVCaptureDevice supplying data to
    an AVCaptureStillImageOutput instance. If you wish to leave exposureTargetBias unchanged for this bracketed
    still image, you may pass the special value AVCaptureExposureTargetBiasCurrent (see AVCaptureDevice.h).
*/
@available(iOS 8.0, *)
class AVCaptureAutoExposureBracketedStillImageSettings : AVCaptureBracketedStillImageSettings {
  class func autoExposureSettingsWithExposureTargetBias(exposureTargetBias: Float) -> Self!
  var exposureTargetBias: Float { get }
  init()
}

/*!
 @category AVCaptureStillImageOutput (BracketedCaptureMethods)
 @abstract
    A category of methods for bracketed still image capture.
 
 @discussion
    A "still image bracket" is a batch of images taken as quickly as possible in succession,
    optionally with different settings from picture to picture.
 
    In a bracketed capture, AVCaptureDevice flashMode property is ignored (flash is forced off), as is AVCaptureStillImageOutput's
    automaticallyEnablesStillImageStabilizationWhenAvailable property (stabilization is forced off).
*/
extension AVCaptureStillImageOutput {

  /*!
   @property maxBracketedCaptureStillImageCount
   @abstract
      Specifies the maximum number of still images that may be taken in a single bracket.
  
   @discussion
      AVCaptureStillImageOutput can only satisfy a limited number of image requests in a single bracket without exhausting system
      resources. The maximum number of still images that may be taken in a single bracket depends on the size of the images being captured,
      and consequently may vary with AVCaptureSession -sessionPreset and AVCaptureDevice -activeFormat.  Some formats do not support
      bracketed capture and return a maxBracketedCaptureStillImageCount of 0.  This read-only property is key-value observable.
      If you exceed -maxBracketedCaptureStillImageCount, then -captureStillImageBracketAsynchronouslyFromConnection:withSettingsArray:completionHandler:
      fails and the completionHandler is called [settings count] times with a NULL sample buffer and AVErrorMaximumStillImageCaptureRequestsExceeded.
  */
  @available(iOS 8.0, *)
  var maxBracketedCaptureStillImageCount: Int { get }

  /*!
   @property lensStabilizationDuringBracketedCaptureSupported
   @abstract
      Indicates whether the receiver supports lens stabilization during bracketed captures.
   
   @discussion
      The receiver's lensStabilizationDuringBracketedCaptureEnabled property can only be set 
      if this property returns YES.  Its value may change as the session's -sessionPreset or input device's
      -activeFormat changes.  This read-only property is key-value observable.
  */
  @available(iOS 9.0, *)
  var isLensStabilizationDuringBracketedCaptureSupported: Bool { get }

  /*!
   @property lensStabilizationDuringBracketedCaptureEnabled
   @abstract
      Indicates whether the receiver should use lens stabilization during bracketed captures.
   
   @discussion
      On a receiver where -isLensStabilizationDuringBracketedCaptureSupported returns YES, lens stabilization
      may be applied to the bracket to reduce blur commonly found in low light photos.  When lens stabilization is 
      enabled, bracketed still image captures incur additional latency.  Lens stabilization is more effective with longer-exposure
      captures, and offers limited or no benefit for exposure durations shorter than 1/30 of a second.  It is possible 
      that during the bracket, the lens stabilization module may run out of correction range and therefore will not be active for 
      every frame in the bracket.  Each emitted CMSampleBuffer from the bracket will have an attachment of kCMSampleBufferAttachmentKey_StillImageLensStabilizationInfo
      indicating additional information about stabilization was applied to the buffer, if any.  The default value of 
      -isLensStabilizationDuringBracketedCaptureEnabled is NO.  This value will be set to NO when -isLensStabilizationDuringBracketedCaptureSupported
      changes to NO.  Setting this property throws an NSInvalidArgumentException if -isLensStabilizationDuringBracketedCaptureSupported returns NO.
      This property is key-value observable.
  */
  @available(iOS 9.0, *)
  var isLensStabilizationDuringBracketedCaptureEnabled: Bool

  /*!
   @method prepareToCaptureStillImageBracketFromConnection:withSettingsArray:completionHandler:
   @abstract
      Allows the receiver to prepare resources in advance of capturing a still image bracket.
   
   @param connection
      The connection through which the still image bracket should be captured.
   
   @param settings
      An array of AVCaptureBracketedStillImageSettings objects. All must be of the same kind of AVCaptureBracketedStillImageSettings
      subclass, or an NSInvalidArgumentException is thrown.
   
   @param completionHandler
      A user provided block that will be called asynchronously once resources have successfully been allocated
      for the specified bracketed capture operation. If sufficient resources could not be allocated, the
      "prepared" parameter contains NO, and "error" parameter contains a non-nil error value. If [settings count]
      exceeds -maxBracketedCaptureStillImageCount, then AVErrorMaximumStillImageCaptureRequestsExceeded is returned.
      You should not assume that the completion handler will be called on a specific thread.
   
   @discussion
      -maxBracketedCaptureStillImageCount tells you the maximum number of images that may be taken in a single
      bracket given the current AVCaptureDevice/AVCaptureSession/AVCaptureStillImageOutput configuration. But before
      taking a still image bracket, additional resources may need to be allocated. By calling
      -prepareToCaptureStillImageBracketFromConnection:withSettingsArray:completionHandler: first, you are able to 
      deterministically know when the receiver is ready to capture the bracket with the specified settings array.
  
  */
  @available(iOS 8.0, *)
  func prepareToCaptureStillImageBracketFrom(connection: AVCaptureConnection!, withSettingsArray settings: [AnyObject]!, completionHandler handler: ((Bool, Error!) -> Void)!)

  /*!
   @method captureStillImageBracketAsynchronouslyFromConnection:withSettingsArray:completionHandler:
   @abstract
      Captures a still image bracket.
   
   @param connection
      The connection through which the still image bracket should be captured.
   
   @param settings
      An array of AVCaptureBracketedStillImageSettings objects. All must be of the same kind of AVCaptureBracketedStillImageSettings
      subclass, or an NSInvalidArgumentException is thrown.
   
   @param completionHandler
      A user provided block that will be called asynchronously as each still image in the bracket is captured.
      If the capture request is successful, the "sampleBuffer" parameter contains a valid CMSampleBuffer, the
      "stillImageSettings" parameter contains the settings object corresponding to this still image, and a nil
      "error" parameter. If the bracketed capture fails, sample buffer is NULL and error is non-nil.
      If [settings count] exceeds -maxBracketedCaptureStillImageCount, then AVErrorMaximumStillImageCaptureRequestsExceeded 
      is returned. You should not assume that the completion handler will be called on a specific thread.
   
   @discussion
      If you have not called -prepareToCaptureStillImageBracketFromConnection:withSettingsArray:completionHandler: for this 
      still image bracket request, the bracket may not be taken immediately, as the receiver may internally need to 
      prepare resources.
  */
  @available(iOS 8.0, *)
  func captureStillImageBracketAsynchronouslyFrom(connection: AVCaptureConnection!, withSettingsArray settings: [AnyObject]!, completionHandler handler: ((CMSampleBuffer!, AVCaptureBracketedStillImageSettings!, Error!) -> Void)!)
}

/*!
 @class AVCaptureMetadataOutput
 @abstract
    AVCaptureMetadataOutput is a concrete subclass of AVCaptureOutput that can be used to process metadata objects
    from an attached connection.

 @discussion
    Instances of AVCaptureMetadataOutput emit arrays of AVMetadataObject instances (see AVMetadataObject.h), such 
    as detected faces. Applications can access the metadata objects with the captureOutput:didOutputMetadataObjects:fromConnection: 
    delegate method.
*/
@available(iOS 6.0, *)
class AVCaptureMetadataOutput : AVCaptureOutput {

  /*!
   @method setMetadataObjectsDelegate:queue:
   @abstract
      Sets the receiver's delegate that will accept metadata objects and dispatch queue on which the delegate will be
      called.
  
   @param objectsDelegate
      An object conforming to the AVCaptureMetadataOutputObjectsDelegate protocol that will receive metadata objects
      after they are captured.
   @param objectsCallbackQueue
      A dispatch queue on which all delegate methods will be called.
  
   @discussion
      When new metadata objects are captured in the receiver's connection, they will be vended to the delegate using the
      captureOutput:didOutputMetadataObjects:fromConnection: delegate method. All delegate methods will be called on the
      specified dispatch queue.
  
      Clients that need to minimize the chances of metadata being dropped should specify a queue on which a sufficiently
      small amount of processing is performed along with receiving metadata objects.
  
      A serial dispatch queue must be used to guarantee that metadata objects will be delivered in order.
      The objectsCallbackQueue parameter may not be NULL, except when setting the objectsDelegate
      to nil.
  */
  func setMetadataObjectsDelegate(objectsDelegate: AVCaptureMetadataOutputObjectsDelegate!, queue objectsCallbackQueue: dispatch_queue_t!)

  /*!
   @property metadataObjectsDelegate
   @abstract
      The receiver's delegate.
   
   @discussion
      The value of this property is an object conforming to the AVCaptureMetadataOutputObjectsDelegate protocol that
      will receive metadata objects after they are captured. The delegate is set using the setMetadataObjectsDelegate:queue:
      method.
  */
  var metadataObjectsDelegate: AVCaptureMetadataOutputObjectsDelegate! { get }

  /*!
   @property metadataObjectsCallbackQueue
   @abstract
      The dispatch queue on which all metadata object delegate methods will be called.
  
   @discussion
      The value of this property is a dispatch_queue_t. The queue is set using the setMetadataObjectsDelegate:queue: method.
  */
  var metadataObjectsCallbackQueue: dispatch_queue_t! { get }

  /*!
   @property availableMetadataObjectTypes
   @abstract
      Indicates the receiver's supported metadata object types.
   
   @discussion
      The value of this property is an NSArray of NSStrings corresponding to AVMetadataObjectType strings defined
      in AVMetadataObject.h -- one for each metadata object type supported by the receiver.  Available 
      metadata object types are dependent on the capabilities of the AVCaptureInputPort to which this receiver's 
      AVCaptureConnection is connected.  Clients may specify the types of objects they would like to process
      by calling setMetadataObjectTypes:.  This property is key-value observable.
  */
  var availableMetadataObjectTypes: [AnyObject]! { get }

  /*!
   @property metadataObjectTypes
   @abstract
      Specifies the types of metadata objects that the receiver should present to the client.
  
   @discussion
  	AVCaptureMetadataOutput may detect and emit multiple metadata object types.  For apps linked before iOS 7.0, the 
  	receiver defaults to capturing face metadata objects if supported (see -availableMetadataObjectTypes).  For apps 
  	linked on or after iOS 7.0, the receiver captures no metadata objects by default.  -setMetadataObjectTypes: throws 
  	an NSInvalidArgumentException if any elements in the array are not present in the -availableMetadataObjectTypes array.
  */
  var metadataObjectTypes: [AnyObject]!

  /*!
   @property rectOfInterest
   @abstract
  	Specifies a rectangle of interest for limiting the search area for visual metadata.
   
   @discussion
  	The value of this property is a CGRect that determines the receiver's rectangle of interest for each frame of video.  
  	The rectangle's origin is top left and is relative to the coordinate space of the device providing the metadata.  Specifying 
  	a rectOfInterest may improve detection performance for certain types of metadata. The default value of this property is the 
  	value CGRectMake(0, 0, 1, 1).  Metadata objects whose bounds do not intersect with the rectOfInterest will not be returned.
   */
  @available(iOS 7.0, *)
  var rectOfInterest: CGRect
  init()
}

/*!
 @protocol AVCaptureMetadataOutputObjectsDelegate
 @abstract
    Defines an interface for delegates of AVCaptureMetadataOutput to receive emitted objects.
*/
protocol AVCaptureMetadataOutputObjectsDelegate : ObjectProtocol {

  /*!
   @method captureOutput:didOutputMetadataObjects:fromConnection:
   @abstract
      Called whenever an AVCaptureMetadataOutput instance emits new objects through a connection.
  
   @param captureOutput
      The AVCaptureMetadataOutput instance that emitted the objects.
   @param metadataObjects
      An array of AVMetadataObject subclasses (see AVMetadataObject.h).
   @param connection
      The AVCaptureConnection through which the objects were emitted.
  
   @discussion
      Delegates receive this message whenever the output captures and emits new objects, as specified by
      its metadataObjectTypes property. Delegates can use the provided objects in conjunction with other APIs
      for further processing. This method will be called on the dispatch queue specified by the output's
      metadataObjectsCallbackQueue property. This method may be called frequently, so it must be efficient to 
      prevent capture performance problems, including dropped metadata objects.
  
      Clients that need to reference metadata objects outside of the scope of this method must retain them and
      then release them when they are finished with them.
  */
  @available(iOS 4.0, *)
  optional func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, from connection: AVCaptureConnection!)
}

/*!
 @constant AVCaptureSessionRuntimeErrorNotification
 @abstract
    Posted when an unexpected error occurs while an AVCaptureSession instance is running.
 
 @discussion
    The notification object is the AVCaptureSession instance that encountered a runtime error.
    The userInfo dictionary contains an NSError for the key AVCaptureSessionErrorKey.
*/
@available(iOS 4.0, *)
let AVCaptureSessionRuntimeErrorNotification: String

/*!
 @constant AVCaptureSessionErrorKey
 @abstract
    The key used to provide an NSError describing the failure condition in an
    AVCaptureSessionRuntimeErrorNotification.
 
 @discussion
    AVCaptureSessionErrorKey may be found in the userInfo dictionary provided with
    an AVCaptureSessionRuntimeErrorNotification.  The NSError associated with the
    notification gives greater detail on the nature of the error, and in some cases
    recovery suggestions. 
*/
@available(iOS 4.0, *)
let AVCaptureSessionErrorKey: String

/*!
 @constant AVCaptureSessionDidStartRunningNotification
 @abstract
    Posted when an instance of AVCaptureSession successfully starts running.
 
 @discussion
    Clients may observe the AVCaptureSessionDidStartRunningNotification to know
    when an instance of AVCaptureSession starts running.
*/
@available(iOS 4.0, *)
let AVCaptureSessionDidStartRunningNotification: String

/*!
 @constant AVCaptureSessionDidStopRunningNotification
 @abstract
    Posted when an instance of AVCaptureSession stops running.
 
 @discussion
    Clients may observe the AVCaptureSessionDidStopRunningNotification to know
    when an instance of AVCaptureSession stops running.  An AVCaptureSession instance
    may stop running automatically due to external system conditions, such as the
    device going to sleep, or being locked by a user.
*/
@available(iOS 4.0, *)
let AVCaptureSessionDidStopRunningNotification: String

/*!
 @constant AVCaptureSessionWasInterruptedNotification
 @abstract
    Posted when an instance of AVCaptureSession becomes interrupted.
 
 @discussion
    Clients may observe the AVCaptureSessionWasInterruptedNotification to know
    when an instance of AVCaptureSession has been interrupted, for example, by
    an incoming phone call, or alarm, or another application taking control of 
    needed hardware resources.  When appropriate, the AVCaptureSession instance
    will stop running automatically in response to an interruption.
 
    Beginning in iOS 9.0, the AVCaptureSessionWasInterruptedNotification userInfo dictionary
    contains an AVCaptureSessionInterruptionReasonKey indicating the reason for the interruption.
*/
@available(iOS 4.0, *)
let AVCaptureSessionWasInterruptedNotification: String

/*!
 @enum AVCaptureSessionInterruptionReason
 @abstract
    Constants indicating interruption reason.  One of these is returned with the
    AVCaptureSessionWasInterruptedNotification (see AVCaptureSessionInterruptionReasonKey).
 
 @constant AVCaptureSessionInterruptionReasonVideoDeviceNotAvailableInBackground
    An interruption caused by the app being sent to the background while using a camera. Camera usage 
    is prohibited while in the background. Beginning in iOS 9.0, AVCaptureSession no longer produces an
    AVCaptureSessionRuntimeErrorNotification if you attempt to start running a camera while in the background.
    Instead, it sends an AVCaptureSessionWasInterruptedNotification with
    AVCaptureSessionInterruptionReasonVideoDeviceNotAvailableInBackground. Provided you don't explicitly call 
    [session stopRunning], your -startRunning request is preserved, and when your app comes back to foreground,
    you receive AVCaptureSessionInterruptionEndedNotification and your session starts running.
 @constant AVCaptureSessionInterruptionReasonAudioDeviceInUseByAnotherClient
    An interruption caused by the audio hardware temporarily being made unavailable, for instance,
    for a phone call, or alarm.
 @constant AVCaptureSessionInterruptionReasonVideoDeviceInUseByAnotherClient
    An interruption caused by the video device temporarily being made unavailable, for instance,
    when stolen away by another AVCaptureSession.
 @constant AVCaptureSessionInterruptionReasonVideoDeviceNotAvailableWithMultipleForegroundApps
    An interruption caused when the app is running in a multi-app layout, causing resource contention
    and degraded recording quality of service. Given your present AVCaptureSession configuration, the 
    session may only be run if your app occupies the full screen.
*/
@available(iOS 9.0, *)
enum AVCaptureSessionInterruptionReason : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case VideoDeviceNotAvailableInBackground
  case AudioDeviceInUseByAnotherClient
  case VideoDeviceInUseByAnotherClient
  case VideoDeviceNotAvailableWithMultipleForegroundApps
}

/*!
 @constant AVCaptureSessionInterruptionReasonKey
 @abstract
    The key used to provide an NSNumber describing the interruption reason in an
    AVCaptureSessionWasInterruptedNotification.
 
 @discussion
    AVCaptureSessionInterruptionReasonKey may be found in the userInfo dictionary provided with
    an AVCaptureSessionWasInterruptedNotification.  The NSNumber associated with the
    notification tells you why the interruption occurred.
*/
@available(iOS 9.0, *)
let AVCaptureSessionInterruptionReasonKey: String

/*!
 @constant AVCaptureSessionInterruptionEndedNotification
 @abstract
    Posted when an instance of AVCaptureSession ceases to be interrupted.
 
 @discussion
    Clients may observe the AVCaptureSessionInterruptionEndedNotification to know
    when an instance of AVCaptureSession ceases to be interrupted, for example, when
    a  phone call ends, and hardware resources needed to run the session are again
    available.  When appropriate, the AVCaptureSession instance that was previously
    stopped in response to an interruption will automatically restart once the
    interruption ends.
*/
@available(iOS 4.0, *)
let AVCaptureSessionInterruptionEndedNotification: String

/*!
 @enum AVCaptureVideoOrientation
 @abstract
    Constants indicating video orientation, for use with AVCaptureVideoPreviewLayer 
    (see AVCaptureVideoPreviewLayer.h) and AVCaptureConnection (see below).
 
 @constant AVCaptureVideoOrientationPortrait
    Indicates that video should be oriented vertically, home button on the bottom.
 @constant AVCaptureVideoOrientationPortraitUpsideDown
    Indicates that video should be oriented vertically, home button on the top.
 @constant AVCaptureVideoOrientationLandscapeRight
    Indicates that video should be oriented horizontally, home button on the right.
 @constant AVCaptureVideoOrientationLandscapeLeft
    Indicates that video should be oriented horizontally, home button on the left.
*/
@available(iOS 4.0, *)
enum AVCaptureVideoOrientation : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Portrait
  case PortraitUpsideDown
  case LandscapeRight
  case LandscapeLeft
}

/*!
 @constant AVCaptureSessionPresetPhoto
 @abstract
    An AVCaptureSession preset suitable for high resolution photo quality output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetPhoto
    for full resolution photo quality output.
*/
@available(iOS 4.0, *)
let AVCaptureSessionPresetPhoto: String

/*!
 @constant AVCaptureSessionPresetHigh
 @abstract
    An AVCaptureSession preset suitable for high quality video and audio output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetHigh
    to achieve high quality video and audio output.  AVCaptureSessionPresetHigh is the
    default sessionPreset value.
*/
@available(iOS 4.0, *)
let AVCaptureSessionPresetHigh: String

/*!
 @constant AVCaptureSessionPresetMedium
 @abstract
    An AVCaptureSession preset suitable for medium quality output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetMedium
    to achieve output video and audio bitrates suitable for sharing over WiFi.
*/
@available(iOS 4.0, *)
let AVCaptureSessionPresetMedium: String

/*!
 @constant AVCaptureSessionPresetLow
 @abstract
    An AVCaptureSession preset suitable for low quality output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetLow
    to achieve output video and audio bitrates suitable for sharing over 3G.
*/
@available(iOS 4.0, *)
let AVCaptureSessionPresetLow: String

/*!
 @constant AVCaptureSessionPreset352x288
 @abstract
    An AVCaptureSession preset suitable for 352x288 video output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPreset352x288
    to achieve CIF quality (352x288) output.
*/
@available(iOS 5.0, *)
let AVCaptureSessionPreset352x288: String

/*!
 @constant AVCaptureSessionPreset640x480
 @abstract
    An AVCaptureSession preset suitable for 640x480 video output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPreset640x480
    to achieve VGA quality (640x480) output.
*/
@available(iOS 4.0, *)
let AVCaptureSessionPreset640x480: String

/*!
 @constant AVCaptureSessionPreset1280x720
 @abstract
    An AVCaptureSession preset suitable for 1280x720 video output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPreset1280x720
    to achieve 1280x720 output.
*/
@available(iOS 4.0, *)
let AVCaptureSessionPreset1280x720: String

/*!
 @constant AVCaptureSessionPreset1920x1080
 @abstract
    An AVCaptureSession preset suitable for 1920x1080 video output.
 
 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPreset1920x1080
    to achieve 1920x1080 output.
*/
@available(iOS 5.0, *)
let AVCaptureSessionPreset1920x1080: String

/*!
 @constant AVCaptureSessionPreset3840x2160
 @abstract
    An AVCaptureSession preset suitable for 3840x2160 (UHD 4K) video output.

 @discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPreset3840x2160
    to achieve 3840x2160 output.
*/
@available(iOS 9.0, *)
let AVCaptureSessionPreset3840x2160: String

/*!
@constant AVCaptureSessionPresetiFrame960x540
@abstract
    An AVCaptureSession preset producing 960x540 Apple iFrame video and audio content.

@discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetiFrame960x540
    to achieve 960x540 quality iFrame H.264 video at ~30 Mbits/sec with AAC audio.  QuickTime
    movies captured in iFrame format are optimal for editing applications.
*/
@available(iOS 5.0, *)
let AVCaptureSessionPresetiFrame960x540: String

/*!
@constant AVCaptureSessionPresetiFrame1280x720
@abstract
    An AVCaptureSession preset producing 1280x720 Apple iFrame video and audio content.

@discussion
    Clients may set an AVCaptureSession instance's sessionPreset to AVCaptureSessionPresetiFrame1280x720
    to achieve 1280x720 quality iFrame H.264 video at ~40 Mbits/sec with AAC audio.  QuickTime
    movies captured in iFrame format are optimal for editing applications.
*/
@available(iOS 5.0, *)
let AVCaptureSessionPresetiFrame1280x720: String

/*!
@constant AVCaptureSessionPresetInputPriority
@abstract
    An AVCaptureSession preset indicating that the formats of the session's inputs are being given priority.

@discussion
    By calling -setSessionPreset:, clients can easily configure an AVCaptureSession to produce a desired 
    quality of service level.  The session configures its inputs and outputs optimally to produce the
    QoS level indicated.  Clients who need to ensure a particular input format is chosen can use
    AVCaptureDevice's -setActiveFormat: method.  When a client sets the active format on a device, the
    associated session's -sessionPreset property automatically changes to AVCaptureSessionPresetInputPriority.
    This change indicates that the input format selected by the client now dictates the quality of service 
    level provided at the outputs.  When a client sets the session preset to anything other than 
    AVCaptureSessionPresetInputPriority, the session resumes responsibility for configuring inputs and outputs,
    and is free to change its inputs' activeFormat as needed.
*/
@available(iOS 7.0, *)
let AVCaptureSessionPresetInputPriority: String

/*!
 @class AVCaptureSession
 @abstract
    AVCaptureSession is the central hub of the AVFoundation capture classes.
 
 @discussion
    To perform a real-time capture, a client may instantiate AVCaptureSession and add appropriate
    AVCaptureInputs, such as AVCaptureDeviceInput, and outputs, such as AVCaptureMovieFileOutput.
    [AVCaptureSession startRunning] starts the flow of data from the inputs to the outputs, and 
    [AVCaptureSession stopRunning] stops the flow.  A client may set the sessionPreset property to 
    customize the quality level or bitrate of the output.
*/
@available(iOS 4.0, *)
class AVCaptureSession : Object {

  /*!
   @method canSetSessionPreset:
   @abstract
      Returns whether the receiver can be configured with the given preset.
   
   @param preset
      An AVCaptureSession preset.
   @result
      YES if the receiver can be set to the given preset, NO otherwise.
   
   @discussion
      An AVCaptureSession instance can be associated with a preset that configures its inputs and outputs to fulfill common
      use cases. This method can be used to determine if the receiver supports the desired preset given its
      current input and output configuration.  The receiver's sessionPreset property may only be 
      set to a certain preset if this method returns YES for that preset.
  */
  func canSetSessionPreset(preset: String!) -> Bool

  /*!
   @property sessionPreset
   @abstract
      Indicates the session preset currently in use by the receiver.
   
   @discussion
      The value of this property is an NSString (one of AVCaptureSessionPreset*) indicating 
      the current session preset in use by the receiver.  The sessionPreset property may be set 
      while the receiver is running.
  */
  var sessionPreset: String!

  /*!
   @property inputs
   @abstract
      An NSArray of AVCaptureInputs currently added to the receiver.
  
   @discussion
      The value of this property is an NSArray of AVCaptureInputs currently added to
      the receiver.  Clients can add AVCaptureInputs to a session by calling -addInput:.
  */
  var inputs: [AnyObject]! { get }

  /*!
   @method canAddInput:
   @abstract
      Returns whether the proposed input can be added to the receiver.
   
   @param input
      An AVCaptureInput instance.
   @result
      YES if the proposed input can be added to the receiver, NO otherwise.
   
   @discussion
      An AVCaptureInput instance can only be added to a session using -addInput: if
      canAddInput: returns YES.
  */
  func canAddInput(input: AVCaptureInput!) -> Bool

  /*!
   @method addInput:
   @abstract
      Adds an AVCaptureInput to the session.
   
   @param input
      An AVCaptureInput instance.
   
   @discussion
      An AVCaptureInput instance can only be added to a session using -addInput: if
      canAddInput: returns YES.  -addInput: may be called while the session is running.
  */
  func addInput(input: AVCaptureInput!)

  /*!
   @method removeInput:
   @abstract
      Removes an AVCaptureInput from the session.
   
   @param input
      An AVCaptureInput instance.
   
   @discussion
      -removeInput: may be called while the session is running.
  */
  func removeInput(input: AVCaptureInput!)

  /*!
   @property outputs
   @abstract
      An NSArray of AVCaptureOutputs currently added to the receiver.
  
   @discussion
      The value of this property is an NSArray of AVCaptureOutputs currently added to
      the receiver.  Clients can add AVCaptureOutputs to a session by calling -addOutput:.
  */
  var outputs: [AnyObject]! { get }

  /*!
   @method canAddOutput:
   @abstract
      Returns whether the proposed output can be added to the receiver.
   
   @param output
      An AVCaptureOutput instance.
   @result
      YES if the proposed output can be added to the receiver, NO otherwise.
   
   @discussion
      An AVCaptureOutput instance can only be added to a session using -addOutput: if
      canAddOutput: returns YES.
  */
  func canAddOutput(output: AVCaptureOutput!) -> Bool

  /*!
   @method addOutput:
   @abstract
      Adds an AVCaptureOutput to the session.
   
   @param output
      An AVCaptureOutput instance.
   
   @discussion
      An AVCaptureOutput instance can only be added to a session using -addOutput: if
      canAddOutput: returns YES.  -addOutput: may be called while the session is running.
  */
  func addOutput(output: AVCaptureOutput!)

  /*!
   @method removeOutput:
   @abstract
      Removes an AVCaptureOutput from the session.
   
   @param output
      An AVCaptureOutput instance.
   
   @discussion
      -removeOutput: may be called while the session is running.
  */
  func removeOutput(output: AVCaptureOutput!)

  /*!
   @method addInputWithNoConnections:
   @abstract
      Adds an AVCaptureInput to the session without forming any connections.
   
   @param input
      An AVCaptureInput instance.
   
   @discussion
      -addInputWithNoConnections: may be called while the session is running.
      The -addInput: method is the preferred method for adding an input to an
      AVCaptureSession.  -addInputWithNoConnections: may be called if you need 
      fine-grained control over which inputs are connected to which outputs.
  */
  @available(iOS 8.0, *)
  func addInputWithNoConnections(input: AVCaptureInput!)

  /*!
   @method addOutputWithNoConnections:
   @abstract
      Adds an AVCaptureOutput to the session without forming any connections.
   
   @param output
      An AVCaptureOutput instance.
   
   @discussion
      -addOutputWithNoConnections: may be called while the session is running.
      The -addOutput: method is the preferred method for adding an output to an
      AVCaptureSession.  -addOutputWithNoConnections: may be called if you need 
      fine-grained control over which inputs are connected to which outputs.
  */
  @available(iOS 8.0, *)
  func addOutputWithNoConnections(output: AVCaptureOutput!)

  /*!
   @method canAddConnection:
   @abstract
      Returns whether the proposed connection can be added to the receiver.
   
   @param connection
      An AVCaptureConnection instance.
   
   @discussion
      An AVCaptureConnection instance can only be added to a session using -addConnection:
      if canAddConnection: returns YES.  When using -addInput: or -addOutput:, connections
      are formed automatically between all compatible inputs and outputs.  Manually
      adding connections is only necessary when adding an input or output with
      no connections.
  */
  @available(iOS 8.0, *)
  func canAdd(connection: AVCaptureConnection!) -> Bool

  /*!
   @method addConnection:
   @abstract
      Adds an AVCaptureConnection to the session.
   
   @param connection
      An AVCaptureConnection instance.
   
   @discussion
      An AVCaptureConnection instance can only be added to a session using -addConnection:
      if canAddConnection: returns YES.  When using -addInput: or -addOutput:, connections
      are formed automatically between all compatible inputs and outputs.  Manually
      adding connections is only necessary when adding an input or output with
      no connections.  -addConnection: may be called while the session is running.
  */
  @available(iOS 8.0, *)
  func add(connection: AVCaptureConnection!)

  /*!
   @method removeConnection:
   @abstract
      Removes an AVCaptureConnection from the session.
   
   @param connection
      An AVCaptureConnection instance.
   
   @discussion
      -removeConnection: may be called while the session is running.
  */
  @available(iOS 8.0, *)
  func remove(connection: AVCaptureConnection!)

  /*!
   @method beginConfiguration
   @abstract
      When paired with commitConfiguration, allows a client to batch multiple configuration
      operations on a running session into atomic updates.
  
   @discussion
      -beginConfiguration / -commitConfiguration are AVCaptureSession's mechanism
      for batching multiple configuration operations on a running session into atomic
      updates.  After calling [session beginConfiguration], clients may add or remove
      outputs, alter the sessionPreset, or configure individual AVCaptureInput or Output
      properties.  All changes will be pended until the client calls [session commitConfiguration],
      at which time they will be applied together.  -beginConfiguration / -commitConfiguration
      pairs may be nested, and will only be applied when the outermost commit is invoked.
  */
  func beginConfiguration()

  /*!
   @method commitConfiguration
   @abstract
      When preceded by beginConfiguration, allows a client to batch multiple configuration
      operations on a running session into atomic updates.
  
   @discussion
      -beginConfiguration / -commitConfiguration are AVCaptureSession's mechanism
      for batching multiple configuration operations on a running session into atomic
      updates.  After calling [session beginConfiguration], clients may add or remove
      outputs, alter the sessionPreset, or configure individual AVCaptureInput or Output
      properties.  All changes will be pended until the client calls [session commitConfiguration],
      at which time they will be applied together.  -beginConfiguration / -commitConfiguration
      pairs may be nested, and will only be applied when the outermost commit is invoked.
  */
  func commitConfiguration()

  /*!
   @property running
   @abstract
      Indicates whether the session is currently running.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver is running.
      Clients can key value observe the value of this property to be notified when
      the session automatically starts or stops running.
  */
  var isRunning: Bool { get }

  /*!
   @property interrupted
   @abstract
      Indicates whether the session is being interrupted.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver is currently
      being interrupted, such as by a phone call or alarm. Clients can key value observe 
      the value of this property to be notified when the session ceases to be interrupted
      and again has access to needed hardware resources.
  */
  @available(iOS 4.0, *)
  var isInterrupted: Bool { get }

  /*!
   @property usesApplicationAudioSession
   @abstract
      Indicates whether the receiver will use the application's AVAudioSession for recording.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver is currently
      using the application's AVAudioSession (see AVAudioSession.h).  Prior to iOS 7, AVCaptureSession
      uses its own audio session, which can lead to unwanted interruptions when interacting with
      the application's audio session. In applications linked on or after iOS 7, AVCaptureSession
      shares the application's audio session, allowing for simultaneous play back and recording
      without unwanted interruptions.  Clients desiring the pre-iOS 7 behavior may opt out
      by setting usesApplicationAudioSession to NO.  The default value is YES.
  */
  @available(iOS 7.0, *)
  var usesApplicationAudioSession: Bool

  /*!
   @property automaticallyConfiguresApplicationAudioSession
   @abstract
      Indicates whether the receiver should configure the application's audio session for recording.
   
   @discussion
      The value of this property is a BOOL indicating whether the receiver should configure the
      application's audio session when needed for optimal recording.  When set to YES, the receiver
      ensures the application's audio session is set to the PlayAndRecord category, and picks an appropriate
      microphone and polar pattern to match the video camera being used. When set to NO, and -usesApplicationAudioSession
      is set to YES, the receiver will use the application's audio session, but will not change any of its properties.  If
      the session is not set up correctly for input, audio recording may fail. The default value is YES.
  */
  @available(iOS 7.0, *)
  var automaticallyConfiguresApplicationAudioSession: Bool

  /*!
   @method startRunning
   @abstract
      Starts an AVCaptureSession instance running.
  
   @discussion
      Clients invoke -startRunning to start the flow of data from inputs to outputs connected to 
      the AVCaptureSession instance.  This call blocks until the session object has completely
      started up or failed.  A failure to start running is reported through the AVCaptureSessionRuntimeErrorNotification
      mechanism.
  */
  func startRunning()

  /*!
   @method stopRunning
   @abstract
      Stops an AVCaptureSession instance that is currently running.
  
   @discussion
      Clients invoke -stopRunning to stop the flow of data from inputs to outputs connected to 
      the AVCaptureSession instance.  This call blocks until the session object has completely
      stopped.
  */
  func stopRunning()

  /*!
   @property masterClock
   @abstract
  	Provides the master clock being used for output synchronization.
   @discussion
  	The masterClock is readonly. Use masterClock to synchronize AVCaptureOutput data with external data sources (e.g motion samples). 
  	All capture output sample buffer timestamps are on the masterClock timebase.
  	
  	For example, if you want to reverse synchronize the output timestamps to the original timestamps, you can do the following:
  	In captureOutput:didOutputSampleBuffer:fromConnection:
   
  	AVCaptureInputPort *port = [[connection inputPorts] objectAtIndex:0];
  	CMClockRef originalClock = [port clock];
   
  	CMTime syncedPTS = CMSampleBufferGetPresentationTime( sampleBuffer );
  	CMTime originalPTS = CMSyncConvertTime( syncedPTS, [session masterClock], originalClock );
   
  	This property is key-value observable.
   */
  @available(iOS 7.0, *)
  var masterClock: CMClock! { get }
  init()
}

/*!
 @class AVCaptureConnection
 @abstract
    AVCaptureConnection represents a connection between an AVCaptureInputPort or ports, and an AVCaptureOutput or 
    AVCaptureVideoPreviewLayer present in an AVCaptureSession.
 
 @discussion
    AVCaptureInputs have one or more AVCaptureInputPorts.  AVCaptureOutputs can accept
    data from one or more sources (example - an AVCaptureMovieFileOutput accepts both video and audio data).
    AVCaptureVideoPreviewLayers can accept data from one AVCaptureInputPort whose mediaType is
    AVMediaTypeVideo. When an input or output is added to a session, or a video preview layer is
    associated with a session, the session greedily forms connections between all the compatible AVCaptureInputs' 
    ports and AVCaptureOutputs or AVCaptureVideoPreviewLayers.  Iterating through an output's connections or a
    video preview layer's sole connection, a client may enable or disable the flow of data from a given input 
    to a given output or preview layer.
     
    Connections involving audio expose an array of AVCaptureAudioChannel objects, which can be used for
    monitoring levels.

    Connections involving video expose video specific properties, such as videoMirrored and videoOrientation.
*/
@available(iOS 4.0, *)
class AVCaptureConnection : Object {

  /*!
   @method initWithInputPorts:output:
   @abstract
      Returns an AVCaptureConnection instance describing a connection between the specified inputPorts 
      and the specified output.
   
   @param ports
      An array of AVCaptureInputPort objects associated with AVCaptureInput objects.
   @param output
      An AVCaptureOutput object.
   @result
      An AVCaptureConnection instance joining the specified inputPorts to the specified
      output port.
   
   @discussion
      This method returns an instance of AVCaptureConnection that may be subsequently added to an
      AVCaptureSession instance using AVCaptureSession's -addConnection: method.  When using 
      -addInput: or -addOutput:, connections are formed between all compatible inputs and outputs
      automatically.  You do not need to manually create and add connections to the session unless
      you use the primitive -addInputWithNoConnections: or -addOutputWithNoConnections: methods.
  */
  @available(iOS 8.0, *)
  init!(inputPorts ports: [AnyObject]!, output: AVCaptureOutput!)

  /*!
   @method initWithInputPort:videoPreviewLayer:
   @abstract
      Returns an AVCaptureConnection instance describing a connection between the specified inputPort 
      and the specified AVCaptureVideoPreviewLayer instance.
   
   @param port
      An AVCaptureInputPort object associated with an AVCaptureInput object.
   @param layer
      An AVCaptureVideoPreviewLayer object.
   @result
      An AVCaptureConnection instance joining the specified inputPort to the specified
      video preview layer.
   
   @discussion
      This method returns an instance of AVCaptureConnection that may be subsequently added to an
      AVCaptureSession instance using AVCaptureSession's -addConnection: method.  When using 
      AVCaptureVideoPreviewLayer's -initWithSession: or -setSession:, a connection is formed between 
      the first compatible input port and the video preview layer automatically.  You do not need to 
      manually create and add connections to the session unless you use AVCaptureVideoPreviewLayer's 
      primitive -initWithSessionWithNoConnection: or -setSessionWithNoConnection: methods.
  */
  @available(iOS 8.0, *)
  init!(inputPort port: AVCaptureInputPort!, videoPreviewLayer layer: AVCaptureVideoPreviewLayer!)

  /*!
   @property inputPorts
   @abstract
      An array of AVCaptureInputPort instances providing data through this connection.
  
   @discussion
      An AVCaptureConnection may involve one or more AVCaptureInputPorts producing data
      to the connection's AVCaptureOutput.  This property is read-only.  An AVCaptureConnection's
      inputPorts remain static for the life of the object.  
  */
  var inputPorts: [AnyObject]! { get }

  /*!
   @property output
   @abstract
      The AVCaptureOutput instance consuming data from this connection's inputPorts.
  
   @discussion
      An AVCaptureConnection may involve one or more AVCaptureInputPorts producing data
      to the connection's AVCaptureOutput.  This property is read-only.  An AVCaptureConnection's
      output remains static for the life of the object.  Note that a connection can either
      be to an output or a video preview layer, but never to both.
  */
  var output: AVCaptureOutput! { get }

  /*!
   @property videoPreviewLayer
   @abstract
      The AVCaptureVideoPreviewLayer instance consuming data from this connection's inputPort.
   
   @discussion
      An AVCaptureConnection may involve one AVCaptureInputPort producing data
      to an AVCaptureVideoPreviewLayer object.  This property is read-only.  An AVCaptureConnection's
      videoPreviewLayer remains static for the life of the object. Note that a connection can either
      be to an output or a video preview layer, but never to both.
  */
  @available(iOS 6.0, *)
  var videoPreviewLayer: AVCaptureVideoPreviewLayer! { get }

  /*!
   @property enabled
   @abstract
      Indicates whether the connection's output should consume data.
  
   @discussion
      The value of this property is a BOOL that determines whether the receiver's output should consume data 
      from its connected inputPorts when a session is running. Clients can set this property to stop the 
      flow of data to a given output during capture.  The default value is YES.  
  */
  var isEnabled: Bool

  /*!
   @property active
   @abstract
      Indicates whether the receiver's output is currently capable of consuming
      data through this connection.
  
   @discussion
      The value of this property is a BOOL that determines whether the receiver's output
      can consume data provided through this connection.  This property is read-only.  Clients
      may key-value observe this property to know when a session's configuration forces a
      connection to become inactive.  The default value is YES.  
  */
  var isActive: Bool { get }

  /*!
   @property audioChannels
   @abstract
      An array of AVCaptureAudioChannel objects representing individual channels of
      audio data flowing through the connection.
  
   @discussion
      This property is only applicable to AVCaptureConnection instances involving
      audio.  In such connections, the audioChannels array contains one AVCaptureAudioChannel
      object for each channel of audio data flowing through this connection.
  */
  var audioChannels: [AnyObject]! { get }

  /*!
   @property supportsVideoMirroring
   @abstract
      Indicates whether the connection supports setting the videoMirrored property.
  
   @discussion
      This property is only applicable to AVCaptureConnection instances involving
      video.  In such connections, the videoMirrored property may only be set if
      -isVideoMirroringSupported returns YES.
  */
  var isVideoMirroringSupported: Bool { get }

  /*!
   @property videoMirrored
   @abstract
      Indicates whether the video flowing through the connection should be mirrored
      about its vertical axis.
  
   @discussion
      This property is only applicable to AVCaptureConnection instances involving
      video.  if -isVideoMirroringSupported returns YES, videoMirrored may be set
      to flip the video about its vertical axis and produce a mirror-image effect.
  */
  var isVideoMirrored: Bool

  /*!
   @property automaticallyAdjustsVideoMirroring
   @abstract
      Specifies whether or not the value of @"videoMirrored" can change based on configuration
      of the session.
  	
   @discussion		
      For some session configurations, video data flowing through the connection will be mirrored 
      by default.  When the value of this property is YES, the value of @"videoMirrored" may change 
      depending on the configuration of the session, for example after switching to a different AVCaptureDeviceInput.
      The default value is YES.
  */
  @available(iOS 6.0, *)
  var automaticallyAdjustsVideoMirroring: Bool

  /*!
   @property supportsVideoOrientation
   @abstract
      Indicates whether the connection supports setting the videoOrientation property.
  
   @discussion
      This property is only applicable to AVCaptureConnection instances involving
      video.  In such connections, the videoOrientation property may only be set if
      -isVideoOrientationSupported returns YES.
  */
  var isVideoOrientationSupported: Bool { get }

  /*!
   @property videoOrientation
   @abstract
      Indicates whether the video flowing through the connection should be rotated
      to a given orientation.
  
   @discussion
      This property is only applicable to AVCaptureConnection instances involving
      video.  If -isVideoOrientationSupported returns YES, videoOrientation may be set
      to rotate the video buffers being consumed by the connection's output.  Note that
      setting videoOrientation does not necessarily result in a physical rotation of
      video buffers.  For instance, a video connection to an AVCaptureMovieFileOutput
      handles orientation using a Quicktime track matrix.  In the AVCaptureStillImageOutput,
      orientation is handled using Exif tags.
  */
  var videoOrientation: AVCaptureVideoOrientation

  /*!
   @property videoMaxScaleAndCropFactor
   @abstract
      Indicates the maximum video scale and crop factor supported by the receiver.
   
   @discussion
      This property is only applicable to AVCaptureConnection instances involving
      video.  In such connections, the videoMaxScaleAndCropFactor property specifies
      the maximum CGFloat value that may be used when setting the videoScaleAndCropFactor
      property.
  */
  @available(iOS 5.0, *)
  var videoMaxScaleAndCropFactor: CGFloat { get }

  /*!
   @property videoScaleAndCropFactor
   @abstract
      Indicates the current video scale and crop factor in use by the receiver.
   
   @discussion
      This property only applies to AVCaptureStillImageOutput connections.
      In such connections, the videoScaleAndCropFactor property may be set
      to a value in the range of 1.0 to videoMaxScaleAndCropFactor.  At a factor of
      1.0, the image is its original size.  At a factor greater than 1.0, the image
      is scaled by the factor and center-cropped to its original dimensions.
      This factor is applied in addition to any magnification from AVCaptureDevice's
      videoZoomFactor property.
   
   @see -[AVCaptureDevice videoZoomFactor]
  */
  @available(iOS 5.0, *)
  var videoScaleAndCropFactor: CGFloat

  /*!
   @property preferredVideoStabilizationMode
   @abstract
      Indicates the stabilization mode to apply to video flowing through the receiver when it is supported.
   
   @discussion
      This property is only applicable to AVCaptureConnection instances involving video.
      On devices where the video stabilization feature is supported, only a subset of available source
      formats may be available for stabilization.  By setting the preferredVideoStabilizationMode
      property to a value other than AVCaptureVideoStabilizationModeOff, video flowing through the receiver is stabilized
      when the mode is available.  Enabling video stabilization introduces additional latency into the video capture pipeline and
      may consume more system memory depending on the stabilization mode and format.  If the preferred stabilization mode isn't available,
      the activeVideoStabilizationMode will be set to AVCaptureVideoStabilizationModeOff.  Clients may key-value observe the
      activeVideoStabilizationMode property to know which stabilization mode is in use or when it is off.  The default value
      is AVCaptureVideoStabilizationModeOff.  When setting this property to AVCaptureVideoStabilizationModeAuto, an appropriate
      stabilization mode will be chosen based on the format and frame rate.  For apps linked before iOS 6.0, the default value
      is AVCaptureVideoStabilizationModeStandard for a video connection attached to an AVCaptureMovieFileOutput instance.
      For apps linked on or after iOS 6.0, the default value is always AVCaptureVideoStabilizationModeOff.  Setting a video stabilization
      mode using this property may change the value of enablesVideoStabilizationWhenAvailable.
  */
  @available(iOS 8.0, *)
  var preferredVideoStabilizationMode: AVCaptureVideoStabilizationMode

  /*!
   @property activeVideoStabilizationMode
   @abstract
      Indicates the stabilization mode currently being applied to video flowing through the receiver.
   
   @discussion
      This property is only applicable to AVCaptureConnection instances involving video.
      On devices where the video stabilization feature is supported, only a subset of available source formats may be stabilized.
      The activeVideoStabilizationMode property returns a value other than AVCaptureVideoStabilizationModeOff
      if video stabilization is currently in use.  This property never returns AVCaptureVideoStabilizationModeAuto.
      This property is key-value observable.
  */
  @available(iOS 8.0, *)
  var activeVideoStabilizationMode: AVCaptureVideoStabilizationMode { get }

  /*!
   @property supportsVideoStabilization
   @abstract
      Indicates whether the connection supports video stabilization.
   
   @discussion
      This property is only applicable to AVCaptureConnection instances involving video.
      In such connections, the -enablesVideoStabilizationWhenAvailable property may only be set if
      -supportsVideoStabilization returns YES.
      This property returns YES if the connection's input device has one or more formats that support
      video stabilization and the connection's output supports video stabilization.
      See [AVCaptureDeviceFormat isVideoStabilizationModeSupported:] to check which video stabilization
      modes are supported by the active device format.
  */
  @available(iOS 6.0, *)
  var isVideoStabilizationSupported: Bool { get }

  /*!
   @property videoStabilizationEnabled
   @abstract
      Indicates whether stabilization is currently being applied to video flowing through the receiver.
   
   @discussion
      This property is only applicable to AVCaptureConnection instances involving video.
      On devices where the video stabilization feature is supported, only a subset of available source 
      formats and resolutions may be available for stabilization.  The videoStabilizationEnabled 
      property returns YES if video stabilization is currently in use.  This property is key-value
      observable.  This property is deprecated.  Use activeVideoStabilizationMode instead.
  */
  @available(iOS, introduced=6.0, deprecated=8.0, message="Use activeVideoStabilizationMode instead.")
  var isVideoStabilizationEnabled: Bool { get }

  /*!
   @property enablesVideoStabilizationWhenAvailable;
   @abstract
      Indicates whether stabilization should be applied to video flowing through the receiver
      when the feature is available.
   
   @discussion
      This property is only applicable to AVCaptureConnection instances involving video.
      On devices where the video stabilization feature is supported, only a subset of available source 
      formats and resolutions may be available for stabilization.  By setting the
      enablesVideoStabilizationWhenAvailable property to YES, video flowing through the receiver
      is stabilized when available.  Enabling video stabilization may introduce additional latency 
      into the video capture pipeline.  Clients may key-value observe the videoStabilizationEnabled
      property to know when stabilization is in use or not.  The default value is NO.
      For apps linked before iOS 6.0, the default value is YES for a video connection attached to an 
      AVCaptureMovieFileOutput instance.  For apps linked on or after iOS 6.0, the default value is
      always NO.  This property is deprecated.  Use preferredVideoStabilizationMode instead.
  */
  @available(iOS, introduced=6.0, deprecated=8.0, message="Use preferredVideoStabilizationMode instead.")
  var enablesVideoStabilizationWhenAvailable: Bool
  init()
}

/*!
 @class AVCaptureAudioChannel
 @abstract
    AVCaptureAudioChannel represents a single channel of audio flowing through 
    an AVCaptureSession.
 
 @discussion
    An AVCaptureConnection from an input producing audio to an output receiving audio
    exposes an array of AVCaptureAudioChannel objects, one for each channel of audio
    available.  Iterating through these audio channel objects, a client may poll
    for audio levels. Instances of AVCaptureAudioChannel cannot be created directly.
*/
@available(iOS 4.0, *)
class AVCaptureAudioChannel : Object {

  /*!
   @property averagePowerLevel
   @abstract
      A measurement of the instantaneous average power level of the audio
      flowing through the receiver.
  
   @discussion
      A client may poll an AVCaptureAudioChannel object for its current
      averagePowerLevel to get its instantaneous average power level in decibels.
      This property is not key-value observable.
  */
  var averagePowerLevel: Float { get }

  /*!
   @property peakHoldLevel
   @abstract
      A measurement of the peak/hold level of the audio flowing through the receiver.
  
   @discussion
      A client may poll an AVCaptureAudioChannel object for its current
      peakHoldLevel to get its most recent peak hold level in decibels.
      This property is not key-value observable.
  */
  var peakHoldLevel: Float { get }
  init()
}

/*!
 @class AVCaptureVideoPreviewLayer
 @abstract
    A CoreAnimation layer subclass for previewing the visual output of an AVCaptureSession.

 @discussion		
    An AVCaptureVideoPreviewLayer instance is a subclass of CALayer and is therefore
    suitable for insertion in a layer hierarchy as part of a graphical interface.
    One creates an AVCaptureVideoPreviewLayer instance with the capture session to be
    previewed, using +layerWithSession: or -initWithSession:.  Using the @"videoGravity"
    property, one can influence how content is viewed relative to the layer bounds.  On
    some hardware configurations, the orientation of the layer can be manipulated using
    @"orientation" and @"mirrored".
*/
@available(iOS 4.0, *)
class AVCaptureVideoPreviewLayer : CALayer {

  /*!
   @method initWithSession:
   @abstract
      Creates an AVCaptureVideoPreviewLayer for previewing the visual output of the
      specified AVCaptureSession.
  
   @param session
      The AVCaptureSession instance to be previewed.
   @result
      A newly initialized AVCaptureVideoPreviewLayer instance.
  */
  init!(session: AVCaptureSession!)

  /*!
   @method initWithSessionWithNoConnection:
   @abstract
      Creates an AVCaptureVideoPreviewLayer for previewing the visual output of the
      specified AVCaptureSession, but creates no connections to any of the session's
      eligible video inputs.  Only use this initializer if you intend to manually 
      form a connection between a desired AVCaptureInputPort and the receiver using 
      AVCaptureSession's -addConnection: method.
   
   @param session
      The AVCaptureSession instance to be previewed.
   @result
      A newly initialized AVCaptureVideoPreviewLayer instance.
  */
  @available(iOS 8.0, *)
  init!(sessionWithNoConnection session: AVCaptureSession!)

  /*!
   @property session
   @abstract
      The AVCaptureSession instance being previewed by the receiver.
  
   @discussion
      The session is retained by the preview layer.
  */
  var session: AVCaptureSession!

  /*!
   method setSessionWithNoConnection:
   @abstract
      Attaches the receiver to a given session without implicitly forming a
      connection to the first eligible video AVCaptureInputPort.  Only use this 
      setter if you intend to manually form a connection between a desired 
      AVCaptureInputPort and the receiver using AVCaptureSession's -addConnection:
      method.
   
   @discussion
      The session is retained by the preview layer.
  */
  @available(iOS 8.0, *)
  func setSessionWithNoConnection(session: AVCaptureSession!)

  /*!
   @property connection
   @abstract
      The AVCaptureConnection instance describing the AVCaptureInputPort to which
      the receiver is connected.
   
   @discussion
      When calling initWithSession: or setSession: with a valid AVCaptureSession instance, 
      a connection is formed to the first eligible video AVCaptureInput.  If the receiver 
      is detached from a session, the connection property becomes nil.
  */
  @available(iOS 6.0, *)
  var connection: AVCaptureConnection! { get }

  /*!
   @property videoGravity
   @abstract
      A string defining how the video is displayed within an AVCaptureVideoPreviewLayer bounds rect.
  
   @discussion
      Options are AVLayerVideoGravityResize, AVLayerVideoGravityResizeAspect 
      and AVLayerVideoGravityResizeAspectFill. AVLayerVideoGravityResizeAspect is default.
      See <AVFoundation/AVAnimation.h> for a description of these options.
  */
  var videoGravity: String!

  /*!
   @method captureDevicePointOfInterestForPoint:
   @abstract
      Converts a point in layer coordinates to a point of interest in the coordinate space of the capture device providing
      input to the layer.
  
   @param pointInLayer
      A CGPoint in layer coordinates.
  
   @result
      A CGPoint in the coordinate space of the capture device providing input to the layer.
  
   @discussion
      AVCaptureDevice pointOfInterest is expressed as a CGPoint where {0,0} represents the top left of the picture area,
      and {1,1} represents the bottom right on an unrotated picture.  This convenience method converts a point in 
      the coordinate space of the receiver to a point of interest in the coordinate space of the AVCaptureDevice providing
      input to the receiver.  The conversion takes frameSize and videoGravity into consideration.
  */
  @available(iOS 6.0, *)
  func captureDevicePointOfInterestFor(pointInLayer: CGPoint) -> CGPoint

  /*!
   @method pointForCaptureDevicePointOfInterest:
   @abstract
      Converts a point of interest in the coordinate space of the capture device providing
      input to the layer to a point in layer coordinates.
  
   @param captureDevicePointOfInterest
      A CGPoint in the coordinate space of the capture device providing input to the layer.
  
   @result
      A CGPoint in layer coordinates.
  
   @discussion
      AVCaptureDevice pointOfInterest is expressed as a CGPoint where {0,0} represents the top left of the picture area,
      and {1,1} represents the bottom right on an unrotated picture.  This convenience method converts a point in 
      the coordinate space of the AVCaptureDevice providing input to the coordinate space of the receiver.  The conversion 
      takes frame size and videoGravity into consideration.
  */
  @available(iOS 6.0, *)
  func pointForCaptureDevicePointOfInterest(captureDevicePointOfInterest: CGPoint) -> CGPoint

  /*!
   @method metadataOutputRectOfInterestForRect:
   @abstract
  	Converts a rectangle in layer coordinates to a rectangle of interest in the coordinate space of an AVCaptureMetadataOutput
  	whose capture device is providing input to the layer.
   
   @param rectInLayerCoordinates
  	A CGRect in layer coordinates.
   
   @result
  	A CGRect in the coordinate space of the metadata output whose capture device is providing input to the layer.
   
   @discussion
  	AVCaptureMetadataOutput rectOfInterest is expressed as a CGRect where {0,0} represents the top left of the picture area,
  	and {1,1} represents the bottom right on an unrotated picture.  This convenience method converts a rectangle in
  	the coordinate space of the receiver to a rectangle of interest in the coordinate space of an AVCaptureMetadataOutput 
  	whose AVCaptureDevice is providing input to the receiver.  The conversion takes frame size and videoGravity into consideration.
   */
  @available(iOS 7.0, *)
  func metadataOutputRectOfInterestFor(rectInLayerCoordinates: CGRect) -> CGRect

  /*!
   @method rectForMetadataOutputRectOfInterest:
   @abstract
  	Converts a rectangle of interest in the coordinate space of an AVCaptureMetadataOutput whose capture device is 
  	providing input to the layer to a rectangle in layer coordinates.
   
   @param rectInMetadataOutputCoordinates
  	A CGRect in the coordinate space of the metadata output whose capture device is providing input to the layer.
   
   @result
  	A CGRect in layer coordinates.
   
   @discussion
  	AVCaptureMetadataOutput rectOfInterest is expressed as a CGRect where {0,0} represents the top left of the picture area,
  	and {1,1} represents the bottom right on an unrotated picture.  This convenience method converts a rectangle in
  	the coordinate space of an AVCaptureMetadataOutput whose AVCaptureDevice is providing input to the coordinate space of the 
  	receiver.  The conversion takes frame size and videoGravity into consideration.
   */
  @available(iOS 7.0, *)
  func rectForMetadataOutputRectOfInterest(rectInMetadataOutputCoordinates: CGRect) -> CGRect

  /*!
   @method transformedMetadataObjectForMetadataObject:
   @abstract
      Converts an AVMetadataObject's visual properties to layer coordinates.
  
   @param metadataObject
      An AVMetadataObject originating from the same AVCaptureInput as the preview layer.
  
   @result
      An AVMetadataObject whose properties are in layer coordinates.
  
   @discussion
      AVMetadataObject bounds may be expressed as a rect where {0,0} represents the top left of the picture area,
      and {1,1} represents the bottom right on an unrotated picture.  Face metadata objects likewise express
      yaw and roll angles with respect to an unrotated picture.  -transformedMetadataObjectForMetadataObject: 
  	converts the visual properties in the coordinate space of the supplied AVMetadataObject to the coordinate space of 
      the receiver.  The conversion takes orientation, mirroring, layer bounds and videoGravity into consideration.
      If the provided metadata object originates from an input source other than the preview layer's, nil will be returned.
  */
  @available(iOS 6.0, *)
  func transformedMetadataObjectFor(metadataObject: AVMetadataObject!) -> AVMetadataObject!
  init()
  init(layer: AnyObject)
  init?(coder aDecoder: Coder)
}
@available(iOS 4.0, *)
class AVComposition : AVAsset, MutableCopying {
  var tracks: [AVCompositionTrack] { get }
  var naturalSize: CGSize { get }

  /*!
  	@property		URLAssetInitializationOptions
  	@abstract		Specifies the initialization options for the creation of AVURLAssets by the receiver, e.g. AVURLAssetPreferPreciseDurationAndTimingKey. The default behavior for creation of AVURLAssets by an AVComposition is equivalent to the behavior of +[AVURLAsset URLAssetWithURL:options:] when specifying no initialization options.
  	@discussion
  		AVCompositions create AVURLAssets internally for URLs specified by AVCompositionTrackSegments of AVCompositionTracks, as needed, whenever AVCompositionTrackSegments were originally added to a track via -[AVMutableCompositionTrack setSegments:] rather than by inserting timeranges of already existing AVAssets or AVAssetTracks.
  		The value of URLAssetInitializationOptions can be specified at the time an AVMutableComposition is created via +compositionWithURLAssetInitializationOptions:.
   */
  @available(iOS 9.0, *)
  var urlAssetInitializationOptions: [String : AnyObject] { get }

  /*!
    @method		assetWithURL:
    @abstract		Returns an instance of AVAsset for inspection of a media resource.
    @param		URL
  				An instance of NSURL that references a media resource.
    @result		An instance of AVAsset.
    @discussion	Returns a newly allocated instance of a subclass of AVAsset initialized with the specified URL.
  */
  convenience init(url URL: URL)
  init()
  @available(iOS 4.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
extension AVComposition {

  /*!
    @method		trackWithTrackID:
    @abstract		Provides an instance of AVCompositionTrack that represents the track of the specified trackID.
    @param		trackID
  				The trackID of the requested AVCompositionTrack.
    @result		An instance of AVCompositionTrack; may be nil if no track of the specified trackID is available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func trackWithTrackID(trackID: CMPersistentTrackID) -> AVCompositionTrack?

  /*!
    @method		tracksWithMediaType:
    @abstract		Provides an array of AVCompositionTracks of the asset that present media of the specified media type.
    @param		mediaType
  				The media type according to which the receiver filters its AVCompositionTracks. (Media types are defined in AVMediaFormat.h)
    @result		An NSArray of AVCompositionTracks; may be empty if no tracks of the specified media type are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaType(mediaType: String) -> [AVCompositionTrack]

  /*!
    @method		tracksWithMediaCharacteristic:
    @abstract		Provides an array of AVCompositionTracks of the asset that present media with the specified characteristic.
    @param		mediaCharacteristic
  				The media characteristic according to which the receiver filters its AVCompositionTracks. (Media characteristics are defined in AVMediaFormat.h)
    @result		An NSArray of AVCompositionTracks; may be empty if no tracks with the specified characteristic are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaCharacteristic(mediaCharacteristic: String) -> [AVCompositionTrack]
}
@available(iOS 4.0, *)
class AVMutableComposition : AVComposition {
  var tracks: [AVMutableCompositionTrack] { get }
  var naturalSize: CGSize

  /*!
  	@method			compositionWithURLAssetInitializationOptions:
  	@abstract		Returns an empty AVMutableComposition.
  	@param			URLAssetInitializationOptions
  					Specifies the initialization options that the receiver should use when creating AVURLAssets internally, e.g. AVURLAssetPreferPreciseDurationAndTimingKey. The default behavior for creation of AVURLAssets by an AVMutableComposition is equivalent to the behavior of +[AVURLAsset URLAssetWithURL:options:] when specifying no initialization options.
  	@discussion		AVMutableCompositions create AVURLAssets internally for URLs specified by AVCompositionTrackSegments of AVMutableCompositionTracks, as needed, whenever AVCompositionTrackSegments are added to tracks via -[AVMutableCompositionTrack setSegments:] rather than by inserting timeranges of already existing AVAssets or AVAssetTracks.
   */
  @available(iOS 9.0, *)
  convenience init(urlAssetInitializationOptions URLAssetInitializationOptions: [String : AnyObject]? = [:])

  /*!
    @method		assetWithURL:
    @abstract		Returns an instance of AVAsset for inspection of a media resource.
    @param		URL
  				An instance of NSURL that references a media resource.
    @result		An instance of AVAsset.
    @discussion	Returns a newly allocated instance of a subclass of AVAsset initialized with the specified URL.
  */
  convenience init(url URL: URL)
  init()
}
extension AVMutableComposition {

  /*!
  	@method			insertTimeRange:ofAsset:atTime:error:
  	@abstract		Inserts all the tracks of a timeRange of an asset into a composition.
  	@param			timeRange
  					Specifies the timeRange of the asset to be inserted.
  	@param			asset
  					Specifies the asset that contains the tracks that are to be inserted. Only instances of AVURLAsset and AVComposition are supported (AVComposition starting in MacOS X 10.10 and iOS 8.0).
  	@param			startTime
  					Specifies the time at which the inserted tracks are to be presented by the composition.
  	@param			outError
  					Describes failures that may be reported to the user, e.g. the asset that was selected for insertion in the composition is restricted by copy-protection.
  	@result			A BOOL value indicating the success of the insertion.
  	@discussion	
  		You provide a reference to an AVAsset and the timeRange within it that you want to insert. You specify the start time in the destination composition at which the timeRange should be inserted.
  		
  		This method may add new tracks to ensure that all tracks of the asset are represented in the inserted timeRange.
  		
  		Note that the media data for the inserted timeRange will be presented at its natural duration and rate. It can be scaled to a different duration and presented at a different rate via -scaleTimeRange:toDuration:.
  		
  		Existing content at the specified startTime will be pushed out by the duration of timeRange. 
  */
  func insert(timeRange: CMTimeRange, of asset: AVAsset, at startTime: CMTime) throws

  /*!
  	@method			insertEmptyTimeRange:
  	@abstract		Adds or extends an empty timeRange within all tracks of the composition.
  	@param			timeRange
  					Specifies the empty timeRange to be inserted.
  	@discussion	
  		If you insert an empty timeRange into the composition, any media that was presented
  		during that interval prior to the insertion will be presented instead immediately
  		afterward. You can use this method to reserve an interval in which you want a subsequently
  		created track to present its media.
  */
  func insertEmpty(timeRange: CMTimeRange)

  /*!
  	@method			removeTimeRange:
  	@abstract		Removes a specified timeRange from all tracks of the composition.
  	@param			timeRange
  					Specifies the timeRange to be removed.
  	@discussion
  		Removal of a time range does not cause any existing tracks to be removed from the composition, 
  		even if removing timeRange results in an empty track.
  		Instead, it removes or truncates track segments that intersect with the timeRange.
  
  		After removing, existing content after timeRange will be pulled in.
  */
  func remove(timeRange: CMTimeRange)

  /*!
  	@method			scaleTimeRange:toDuration:
  	@abstract		Changes the duration of a timeRange of all tracks.
  	@param			timeRange
  					Specifies the timeRange of the composition to be scaled.
  	@param			duration
  					Specifies the new duration of the timeRange.
  	@discussion
  		Each trackSegment affected by the scaling operation will be presented at a rate equal to
  		source.duration / target.duration of its resulting timeMapping.
  */
  func scaleTimeRange(timeRange: CMTimeRange, toDuration duration: CMTime)
}
extension AVMutableComposition {

  /*!
  	@method			addMutableTrackWithMediaType:preferredTrackID:
  	@abstract		Adds an empty track to a mutable composition.
  	@param			mediaType
  					The media type of the new track.
  	@param			preferredTrackID
  					Specifies the preferred track ID for the new track.
  					The preferred track ID will be used for the new track provided that it is not currently in use and 
  					has not previously been used.
  					If you do not need to specify a preferred track ID, pass kCMPersistentTrackID_Invalid.
  					If the specified preferred track ID is not available, or kCMPersistentTrackID_Invalid was passed in,
  					a unique track ID will be generated.
  	@result			An instance of AVMutableCompositionTrack representing the new track.
      				Its actual trackID is available via its @"trackID" key.
  */
  func addMutableTrackWithMediaType(mediaType: String, preferredTrackID: CMPersistentTrackID) -> AVMutableCompositionTrack

  /*!
  	@method			removeTrack:
  	@abstract		Removes a track of a mutable composition.
  	@param			track
  					A reference to the AVCompositionTrack to be removed.
  	@discussion
  		If you retain a reference to the removed track, note that its @"composition" key will have the value nil, and
  		the values of its other properties are undefined.
  */
  func removeTrack(track: AVCompositionTrack)

  /*!
  	@method			mutableTrackCompatibleWithTrack:
  	@abstract		Provides a reference to a track of a mutable composition into which any timeRange of an AVAssetTrack
  					can be inserted (via -[AVMutableCompositionTrack insertTimeRange:ofTrack:atTime:error:]).
  	@param			track
  					A reference to the AVAssetTrack from which a timeRange may be inserted.
  	@result			An AVMutableCompositionTrack that can accommodate the insertion.
  					If no such track is available, the result is nil. A new track of the same mediaType
  					as the AVAssetTrack can be created via -addMutableTrackWithMediaType:preferredTrackID:,
  					and this new track will be compatible.
  	@discussion		Similar to -[AVAsset compatibleTrackForCompositionTrack:].
  		For best performance, the number of tracks of a composition should be kept to a minimum, corresponding to the
  		number for which media data must be presented in parallel. If media data of the same type is to be presented
  		serially, even from multiple assets, a single track of that media type should be used. This method,
  		-mutableTrackCompatibleWithTrack:, can help the client to identify an existing target track for an insertion.
  */
  func mutableTrackCompatibleWith(track: AVAssetTrack) -> AVMutableCompositionTrack?
}
extension AVMutableComposition {

  /*!
    @method		trackWithTrackID:
    @abstract		Provides an instance of AVMutableCompositionTrack that represents the track of the specified trackID.
    @param		trackID
  				The trackID of the requested AVMutableCompositionTrack.
    @result		An instance of AVMutableCompositionTrack; may be nil if no track of the specified trackID is available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func trackWithTrackID(trackID: CMPersistentTrackID) -> AVMutableCompositionTrack?

  /*!
    @method		tracksWithMediaType:
    @abstract		Provides an array of AVMutableCompositionTracks of the asset that present media of the specified media type.
    @param		mediaType
  				The media type according to which the receiver filters its AVMutableCompositionTracks. (Media types are defined in AVMediaFormat.h)
    @result		An NSArray of AVMutableCompositionTracks; may be empty if no tracks of the specified media type are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaType(mediaType: String) -> [AVMutableCompositionTrack]

  /*!
    @method		tracksWithMediaCharacteristic:
    @abstract		Provides an array of AVMutableCompositionTracks of the asset that present media with the specified characteristic.
    @param		mediaCharacteristic
  				The media characteristic according to which the receiver filters its AVMutableCompositionTracks. (Media characteristics are defined in AVMediaFormat.h)
    @result		An NSArray of AVMutableCompositionTracks; may be empty if no tracks with the specified characteristic are available.
    @discussion	Becomes callable without blocking when the key @"tracks" has been loaded
  */
  func tracksWithMediaCharacteristic(mediaCharacteristic: String) -> [AVMutableCompositionTrack]
}
@available(iOS 4.0, *)
class AVCompositionTrack : AVAssetTrack {
  var segments: [AVCompositionTrackSegment] { get }
}
@available(iOS 4.0, *)
class AVMutableCompositionTrack : AVCompositionTrack {
  var naturalTimeScale: CMTimeScale
  var languageCode: String?
  var extendedLanguageTag: String?
  var preferredTransform: CGAffineTransform
  var preferredVolume: Float
  var segments: [AVCompositionTrackSegment]!

  /*!
  	@method			insertTimeRange:ofTrack:atTime:error:
  	@abstract		Inserts a timeRange of a source track into a track of a composition.
  	@param			timeRange
  					Specifies the timeRange of the track to be inserted.
  	@param			track
  					Specifies the source track to be inserted. Only AVAssetTracks of AVURLAssets and AVCompositions are supported (AVCompositions starting in MacOS X 10.10 and iOS 8.0).
  	@param			startTime
  					Specifies the time at which the inserted track is to be presented by the composition track. You may pass kCMTimeInvalid for startTime to indicate that the timeRange should be appended to the end of the track.
  	@param			error
  					Describes failures that may be reported to the user, e.g. the asset that was selected for insertion in the composition is restricted by copy-protection.
  	@result			A BOOL value indicating the success of the insertion.
  	@discussion	
  		You provide a reference to an AVAssetTrack and the timeRange within it that you want to insert. You specify the start time in the target composition track at which the timeRange should be inserted.
  		
  		Note that the inserted track timeRange will be presented at its natural duration and rate. It can be scaled to a different duration (and presented at a different rate) via -scaleTimeRange:toDuration:.
  */
  func insertTimeRange(timeRange: CMTimeRange, of track: AVAssetTrack, at startTime: CMTime) throws

  /*!
  	@method			insertTimeRanges:ofTracks:atTime:error:
  	@abstract		Inserts the timeRanges of multiple source tracks into a track of a composition.
  	@param			timeRanges
  					Specifies the timeRanges to be inserted.  An NSArray of NSValues containing CMTimeRange. 
  					See +[NSValue valueWithCMTimeRange:] in AVTime.h.
  	@param			tracks
  					Specifies the source tracks to be inserted. Only AVAssetTracks of AVURLAssets and AVCompositions are supported (AVCompositions starting in MacOS X 10.10 and iOS 8.0).
  	@param			startTime
  					Specifies the time at which the inserted tracks are to be presented by the composition track. You may pass kCMTimeInvalid for startTime to indicate that the timeRanges should be appended to the end of the track.
  	@param			error
  					Describes failures that may be reported to the user, e.g. the asset that was selected for insertion in the composition is restricted by copy-protection.
  	@result			A BOOL value indicating the success of the insertion.
  	@discussion	
  		This method is equivalent to (but more efficient than) calling -insertTimeRange:ofTrack:atTime:error: for each timeRange/track pair. If this method returns an error, none of the time ranges will be inserted into the composition track. To specify an empty time range, pass NSNull for the track and a time range of starting at kCMTimeInvalid with a duration of the desired empty edit.
  */
  @available(iOS 5.0, *)
  func insertTimeRanges(timeRanges: [Value], of tracks: [AVAssetTrack], at startTime: CMTime) throws

  /*!
  	@method			insertEmptyTimeRange:
  	@abstract		Adds or extends an empty timeRange within the composition track.
  	@param			timeRange
  					Specifies the empty timeRange to be inserted.
  	@discussion	
  		If you insert an empty timeRange into the track, any media that was presented
  		during that interval prior to the insertion will be presented instead immediately
  		afterward.
  		The exact meaning of the term "empty timeRange" depends upon the mediaType of the track.  
  		For example, an empty timeRange in a sound track presents silence.
  */
  func insertEmptyTimeRange(timeRange: CMTimeRange)

  /*!
  	@method			removeTimeRange:
  	@abstract		Removes a specified timeRange from the track.
  	@param			timeRange
  					Specifies the timeRange to be removed.
  	@discussion
  		Removal of a timeRange does not cause the track to be removed from the composition.
  		Instead it removes or truncates track segments that intersect with the timeRange.
  */
  func removeTimeRange(timeRange: CMTimeRange)

  /*!
  	@method			scaleTimeRange:toDuration:
  	@abstract		Changes the duration of a timeRange of the track.
  	@param			timeRange
  					Specifies the timeRange of the track to be scaled.
  	@param			duration
  					Specifies the new duration of the timeRange.
  	@discussion
  		Each trackSegment affected by the scaling operation will be presented at a rate equal to
  		source.duration / target.duration of its resulting timeMapping.
  */
  func scaleTimeRange(timeRange: CMTimeRange, toDuration duration: CMTime)

  /*!
  	@method			validateTrackSegments:error:
  	@abstract		Tests an array of AVCompositionTrackSegments to determine whether they conform
  					to the timing rules noted above (see the property key @"trackSegments").
  	@param			trackSegments
  					The array of AVCompositionTrackSegments to be validated.
  	@param			error
  					If validation fais, returns information about the failure.
  	@discussion
  		The array is tested for suitability for setting as the value of the trackSegments property.
  		If a portion of an existing trackSegments array is to be modified, the modification can
  		be made via an instance of NSMutableArray, and the resulting array can be tested via
  		-validateTrackSegments:error:.
  */
  func validateSegments(trackSegments: [AVCompositionTrackSegment]) throws
}
@available(iOS 4.0, *)
class AVCompositionTrackSegment : AVAssetTrackSegment {

  /*!
  	@method			initWithURL:trackID:sourceTimeRange:targetTimeRange:
  	@abstract		Initializes an instance of AVCompositionTrackSegment that presents a portion of a file referenced by URL.
  	@param			URL
  					An instance of NSURL that references the container file to be presented by the AVCompositionTrackSegment.
  	@param			trackID
  					The track identifier that specifies the track of the container file to be presented by the AVCompositionTrackSegment.
  	@param			sourceTimeRange
  					The timeRange of the track of the container file to be presented by the AVCompositionTrackSegment.
  	@param			targetTimeRange
  					The timeRange of the composition track during which the AVCompositionTrackSegment is to be presented.
  	@result			An instance of AVCompositionTrackSegment.
  	@discussion		To specify that the segment be played at the asset's normal rate, set source.duration == target.duration in the timeMapping.
  					Otherwise, the segment will be played at a rate equal to the ratio source.duration / target.duration.
  */
  init(url URL: URL, trackID: CMPersistentTrackID, sourceTimeRange: CMTimeRange, targetTimeRange: CMTimeRange)

  /*!
  	@method			initWithTimeRange:
  	@abstract		Initializes an instance of AVCompositionTrackSegment that presents an empty track segment.
  	@param			timeRange
  					The timeRange of the empty AVCompositionTrackSegment.
  	@result			An instance of AVCompositionTrackSegment.
  */
  init(timeRange: CMTimeRange)
  var isEmpty: Bool { get }
  var sourceURL: URL? { get }
  var sourceTrackID: CMPersistentTrackID { get }
}
@available(iOS 4.0, *)
let AVFoundationErrorDomain: String
@available(iOS 4.0, *)
let AVErrorDeviceKey: String
@available(iOS 4.0, *)
let AVErrorTimeKey: String
@available(iOS 4.0, *)
let AVErrorFileSizeKey: String
@available(iOS 4.0, *)
let AVErrorPIDKey: String
@available(iOS 4.0, *)
let AVErrorRecordingSuccessfullyFinishedKey: String
@available(iOS 4.3, *)
let AVErrorMediaTypeKey: String
@available(iOS 4.3, *)
let AVErrorMediaSubTypeKey: String
@available(iOS 8.0, *)
let AVErrorPresentationTimeStampKey: String
@available(iOS 8.0, *)
let AVErrorPersistentTrackIDKey: String
@available(iOS 8.0, *)
let AVErrorFileTypeKey: String
enum AVError : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case OutOfMemory
  case SessionNotRunning
  case DeviceAlreadyUsedByAnotherSession
  case NoDataCaptured
  case SessionConfigurationChanged
  case DiskFull
  case DeviceWasDisconnected
  case MediaChanged
  case MaximumDurationReached
  case MaximumFileSizeReached
  case MediaDiscontinuity
  case MaximumNumberOfSamplesForFileFormatReached
  case DeviceNotConnected
  case DeviceInUseByAnotherApplication
  case DeviceLockedForConfigurationByAnotherProcess
  case SessionWasInterrupted
  case MediaServicesWereReset
  case ExportFailed
  case DecodeFailed
  case InvalidSourceMedia
  case FileAlreadyExists
  case CompositionTrackSegmentsNotContiguous
  case InvalidCompositionTrackSegmentDuration
  case InvalidCompositionTrackSegmentSourceStartTime
  case InvalidCompositionTrackSegmentSourceDuration
  case FileFormatNotRecognized
  case FileFailedToParse
  case MaximumStillImageCaptureRequestsExceeded
  case ContentIsProtected
  case NoImageAtTime
  case DecoderNotFound
  case EncoderNotFound
  case ContentIsNotAuthorized
  case ApplicationIsNotAuthorized
  @available(iOS, introduced=4.3, deprecated=9.0, message="AVCaptureSession no longer produces an AVCaptureSessionRuntimeErrorNotification with this error. See AVCaptureSessionInterruptionReasonVideoDeviceNotAvailableInBackground.")
  case DeviceIsNotAvailableInBackground
  case OperationNotSupportedForAsset
  case DecoderTemporarilyUnavailable
  case EncoderTemporarilyUnavailable
  case InvalidVideoComposition
  case ReferenceForbiddenByReferencePolicy
  case InvalidOutputURLPathExtension
  case ScreenCaptureFailed
  case DisplayWasDisabled
  case TorchLevelUnavailable
  case OperationInterrupted
  case IncompatibleAsset
  case FailedToLoadMediaData
  case ServerIncorrectlyConfigured
  case ApplicationIsNotAuthorizedToUseDevice
  @available(iOS 8.0, *)
  case FailedToParse
  @available(iOS 8.0, *)
  case FileTypeDoesNotSupportSampleReferences
  @available(iOS 8.0, *)
  case UndecodableMediaData
  @available(iOS 8.3, *)
  case AirPlayControllerRequiresInternet
  @available(iOS 8.3, *)
  case AirPlayReceiverRequiresInternet
  @available(iOS 9.0, *)
  case VideoCompositorFailed
  @available(iOS 9.0, *)
  case RecordingAlreadyInProgress
}

extension AVError : _BridgedNSError {
  static var _NSErrorDomain: String { get }
  typealias RawValue = Int
}

/*! @typedef AVMIDIPlayerCompletionHandler
	@abstract Generic callback block.
 */
typealias AVMIDIPlayerCompletionHandler = () -> Void

/*! @class AVMIDIPlayer
	@abstract A player for music file formats (MIDI, iMelody).
 */
@available(iOS 8.0, *)
class AVMIDIPlayer : Object {

  /*!	@method initWithContentsOfURL:soundBankURL:error:
   	@abstract Create a player with the contents of the file specified by the URL.
  	@discussion
   		'bankURL' should contain the path to a SoundFont2 or DLS bank to be used
   		by the MIDI synthesizer.  For OSX it can be set to nil for the default,
   		but for iOS it must always refer to a valid bank file.
  */
  init(contentsOf inURL: URL, soundBankURL bankURL: URL?) throws

  /*!	@method initWithData:soundBankURL:error:
  	@abstract Create a player with the contents of the data object
  	@discussion
  		'bankURL' should contain the path to a SoundFont2 or DLS bank to be used
  		by the MIDI synthesizer.  For OSX it can be set to nil for the default,
  		but for iOS it must always refer to a valid bank file.
   */
  init(data: Data, soundBankURL bankURL: URL?) throws

  /*! @method prepareToPlay
  	@abstract Get ready to play the sequence by prerolling all events
  	@discussion
  		Happens automatically on play if it has not already been called, but may produce a delay in startup.
   */
  func prepareToPlay()

  /*! @method play:
  	@abstract Play the sequence.
   */
  func play(completionHandler: AVMIDIPlayerCompletionHandler? = nil)

  /*! @method stop
  	@abstract Stop playing the sequence.
   */
  func stop()

  /*! @property duration
  	@abstract The length of the currently loaded file in seconds.
   */
  var duration: TimeInterval { get }

  /*! @property playing
  	@abstract Indicates whether or not the player is playing
   */
  var isPlaying: Bool { get }

  /*! @property rate
  	@abstract The playback rate of the player
  	@discussion
  		1.0 is normal playback rate.  Rate must be > 0.0.
   */
  var rate: Float

  /*! @property currentPosition
  	@abstract The current playback position in seconds
  	@discussion
  		Setting this positions the player to the specified time.  No range checking on the time value is done.
   		This can be set while the player is playing, in which case playback will resume at the new time.
   */
  var currentPosition: TimeInterval
  init()
}
@available(iOS 4.0, *)
let AVMediaTypeVideo: String
@available(iOS 4.0, *)
let AVMediaTypeAudio: String
@available(iOS 4.0, *)
let AVMediaTypeText: String
@available(iOS 4.0, *)
let AVMediaTypeClosedCaption: String
@available(iOS 4.0, *)
let AVMediaTypeSubtitle: String
@available(iOS 4.0, *)
let AVMediaTypeTimecode: String
@available(iOS 6.0, *)
let AVMediaTypeMetadata: String
@available(iOS 4.0, *)
let AVMediaTypeMuxed: String

/*!
 @constant AVMediaTypeMetadataObject
 @abstract mediaType of AVCaptureInputPorts that provide AVMetadataObjects.
 @discussion
 Prior to iOS 9.0, camera AVCaptureDeviceInputs provide metadata (detected faces and barcodes) to an
 AVCaptureMetadataOutput through an AVCaptureInputPort whose mediaType is AVMediaTypeMetadata.  The
 AVCaptureMetadataOutput presents metadata to the client as an array of AVMetadataObjects, which are
 defined by Apple and not externally subclassable.  Starting in iOS 9.0, clients may record arbitrary
 metadata to a movie file using the AVCaptureMovieFileOutput.  The movie file output consumes metadata
 in a different format than the AVCaptureMetadataOutput, namely it accepts CMSampleBuffers of type
 'meta'.  Starting in iOS 9.0, two types of AVCaptureInput can produce suitable metadata for the
 movie file output.
 
 <ul>
 <li>The camera AVCaptureDeviceInput now presents an additional AVCaptureInputPort for recording detected
 faces to a movie file. When linked on or after iOS 9, ports that deliver AVCaptureMetadataObjects have a
 mediaType of AVMediaTypeMetadataObject rather than AVMediaTypeMetadata.  Input ports that deliver CMSampleBuffer
 metadata have a mediaType of AVMediaTypeMetadata.</li>
 
 <li>New to iOS 9 is the AVCaptureMetadataInput, which allows clients to record arbitrary metadata to a movie
 file.  Clients package metadata as an AVTimedMetadataGroup, the AVCaptureMetadataInput presents a port of mediaType
 AVMediaTypeMetadata, and when connected to a movie file output, transforms the timed metadata group's AVMetadataItems
 into CMSampleBuffers which can be written to the movie file.</li>
 </ul>
 
 When linked on or after iOS 9, AVCaptureInputPorts with a mediaType of AVMediaTypeMetadata are handled
 specially by the AVCaptureSession. When inputs and outputs are added to the session, the session does
 not form connections implicitly between eligible AVCaptureOutputs and input ports of type AVMediaTypeMetadata.
 If clients want to record a particular kind of metadata to a movie, they must manually form connections
 between a AVMediaTypeMetadata port and the movie file output using AVCaptureSession's -addConnection API.
*/
@available(iOS 9.0, *)
let AVMediaTypeMetadataObject: String

/*!
 @constant AVMediaCharacteristicVisual
 @abstract A media characteristic that indicates that a track or media selection option includes visual content.
 @discussion
 AVMediaTypeVideo, AVMediaTypeSubtitle, AVMediaTypeClosedCaption are examples of media types with the characteristic AVMediaCharacteristicVisual.
 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 4.0, *)
let AVMediaCharacteristicVisual: String

/*!
 @constant AVMediaCharacteristicAudible
 @abstract A media characteristic that indicates that a track or media selection option includes audible content.
 @discussion
 AVMediaTypeAudio is a media type with the characteristic AVMediaCharacteristicAudible.
 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 4.0, *)
let AVMediaCharacteristicAudible: String

/*!
 @constant AVMediaCharacteristicLegible
 @abstract A media characteristic that indicates that a track or media selection option includes legible content.
 @discussion
 AVMediaTypeSubtitle and AVMediaTypeClosedCaption are examples of media types with the characteristic AVMediaCharacteristicLegible.
 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 4.0, *)
let AVMediaCharacteristicLegible: String

/*!
 @constant AVMediaCharacteristicFrameBased
 @abstract A media characteristic that indicates that a track or media selection option includes content that's frame-based.
 @discussion
 Frame-based content typically comprises discrete media samples that, once rendered, can remain current for indefinite periods of time without additional processing in support of "time-stretching". Further, any dependencies between samples are always explicitly signalled, so that the operations required to render any single sample can readily be performed on demand. AVMediaTypeVideo is the most common type of frame-based media. AVMediaTypeAudio is the most common counterexample. 
 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 4.0, *)
let AVMediaCharacteristicFrameBased: String

/*!
 @constant AVMediaCharacteristicIsMainProgramContent
 @abstract A media characteristic that indicates that a track or media selection option includes content that's marked by the content author as intrinsic to the presentation of the asset.
 @discussion
 Example: an option that presents the main program audio for the presentation, regardless of locale, would typically have this characteristic.
 The value of this characteristic is @"public.main-program-content".
 Note for content authors: the presence of this characteristic for a media option is inferred; any option that does not have the characteristic AVMediaCharacteristicIsAuxiliaryContent is considered to have the characteristic AVMediaCharacteristicIsMainProgramContent.

 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 5.0, *)
let AVMediaCharacteristicIsMainProgramContent: String

/*!
 @constant AVMediaCharacteristicIsAuxiliaryContent
 @abstract A media characteristic that indicates that a track or media selection option includes content that's marked by the content author as auxiliary to the presentation of the asset.
 @discussion
 The value of this characteristic is @"public.auxiliary-content".
 Example: an option that presents audio media containing commentary on the presentation would typically have this characteristic.
 Note for content authors: for QuickTime movie and .m4v files a media option is considered to have the characteristic AVMediaCharacteristicIsAuxiliaryContent if it's explicitly tagged with that characteristic or if, as a member of an alternate track group, its associated track is excluded from autoselection.
 See the discussion of the tagging of tracks with media characteristics below.

 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 5.0, *)
let AVMediaCharacteristicIsAuxiliaryContent: String

/*!
 @constant AVMediaCharacteristicContainsOnlyForcedSubtitles
 @abstract A media characteristic that indicates that a track or media selection option presents only forced subtitles.
 @discussion
 Media options with forced-only subtitles are typically selected when 1) the user has not selected a legible option with an accessibility characteristic or an auxiliary purpose and 2) its locale matches the locale of the selected audible media selection option.
 The value of this characteristic is @"public.subtitles.forced-only".
 Note for content authors: the presence of this characteristic for a legible media option may be inferred from the format description of the associated track that presents the subtitle media, if the format description carries sufficient information to indicate the presence or absence of forced and non-forced subtitles. If the format description does not carry this information, the legible media option can be explicitly tagged with the characteristic.

 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 5.0, *)
let AVMediaCharacteristicContainsOnlyForcedSubtitles: String

/*!
 @constant AVMediaCharacteristicTranscribesSpokenDialogForAccessibility
 @abstract A media characteristic that indicates that a track or media selection option includes legible content in the language of its specified locale that:
 	- transcribes spoken dialog and
 	- identifies speakers whenever other visual cues are insufficient for a viewer to determine who is speaking.
 @discussion
 Legible tracks provided for accessibility purposes are typically tagged both with this characteristic as well as with AVMediaCharacteristicDescribesMusicAndSoundForAccessibility.

 A legible track provided for accessibility purposes that's associated with an audio track that has no spoken dialog can be tagged with this characteristic, because it trivially meets these requirements.

 The value of this characteristic is @"public.accessibility.transcribes-spoken-dialog".

 Note for content authors: for QuickTime movie and .m4v files a media option is considered to have the characteristic AVMediaCharacteristicTranscribesSpokenDialogForAccessibility only if it's explicitly tagged with that characteristic.
 See the discussion of the tagging of tracks with media characteristics below.

 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 5.0, *)
let AVMediaCharacteristicTranscribesSpokenDialogForAccessibility: String

/*!
 @constant AVMediaCharacteristicDescribesMusicAndSoundForAccessibility
 @abstract A media characteristic that indicates that a track or media selection option includes legible content in the language of its specified locale that:
 	- describes music and
 	- describes sound other than spoken dialog, such as sound effects and significant silences, occurring in program audio.
 @discussion
 Legible tracks provided for accessibility purposes are typically tagged both with this characteristic as well as with AVMediaCharacteristicTranscribesSpokenDialogForAccessibility.

 A legible track provided for accessibility purposes that's associated with an audio track without music and without sound other than spoken dialog -- lacking even significant silences -- can be tagged with this characteristic, because it trivially meets these requirements.

 The value of this characteristic is @"public.accessibility.describes-music-and-sound".

 Note for content authors: for QuickTime movie and .m4v files a media option is considered to have the characteristic AVMediaCharacteristicDescribesMusicAndSoundForAccessibility only if it's explicitly tagged with that characteristic.
 See the discussion of the tagging of tracks with media characteristics below.

 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 5.0, *)
let AVMediaCharacteristicDescribesMusicAndSoundForAccessibility: String

/*!
 @constant AVMediaCharacteristicEasyToRead
 @abstract A media characteristic that indicates that a track or media selection option provides legible content in the language of its specified locale that has been edited for ease of reading.
 @discussion
 The value of this characteristic is @"public.easy-to-read".
 
 Closed caption tracks that carry "easy reader" captions (per the CEA-608 specification) should be tagged with this characteristic. Subtitle tracks can also be tagged with this characteristic, where appropriate.

 Note for content authors: for QuickTime movie and .m4v files a track is considered to have the characteristic AVMediaCharacteristicEasyToRead only if it's explicitly tagged with that characteristic.
 See the discussion of the tagging of tracks with media characteristics below.

 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 6.0, *)
let AVMediaCharacteristicEasyToRead: String

/*!
 @constant AVMediaCharacteristicDescribesVideoForAccessibility
 @abstract A media characteristic that indicates that a track or media selection option includes audible descriptions of the visual portion of the presentation that are sufficient for listeners without access to the visual content to comprehend the essential information, such as action and setting, that it depicts.
 @discussion
 See -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
 The value of this characteristic is @"public.accessibility.describes-video".
 Note for content authors: for QuickTime movie and .m4v files a media option is considered to have the characteristic AVMediaCharacteristicDescribesVideoForAccessibility only if it's explicitly tagged with that characteristic.
 See the discussion of the tagging of tracks with media characteristics below.

 Also see -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
*/
@available(iOS 5.0, *)
let AVMediaCharacteristicDescribesVideoForAccessibility: String

/*!
 @constant AVMediaCharacteristicLanguageTranslation
 @abstract A media characteristic that indicates that a track or media selection option contains a language or dialect translation of originally or previously produced content, intended to be used as a substitute for that content by users who prefer its designated language.
 @discussion
 See -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
 The value of this characteristic is @"public.translation".
 Note for content authors: for QuickTime movie and .m4v files a media option is considered to have the characteristic AVMediaCharacteristicLanguageTranslation only if it's explicitly tagged with that characteristic.
 See the discussion of the tagging of tracks with media characteristics below.
*/
@available(iOS 9.0, *)
let AVMediaCharacteristicLanguageTranslation: String

/*!
 @constant AVMediaCharacteristicDubbedTranslation
 @abstract A media characteristic that indicates that a track or media selection option contains a language or dialect translation of originally or previously produced content, created by substituting most or all of the dialog in a previous mix of audio content with dialog spoken in its designated language.
 @discussion
 Tracks to which this characteristic is assigned should typically also be assigned the characteristic AVMediaCharacteristicLanguageTranslation.
 See -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
 The value of this characteristic is @"public.translation.dubbed".
 Note for content authors: for QuickTime movie and .m4v files a media option is considered to have the characteristic AVMediaCharacteristicDubbedTranslation only if it's explicitly tagged with that characteristic.
 See the discussion of the tagging of tracks with media characteristics below.
*/
@available(iOS 9.0, *)
let AVMediaCharacteristicDubbedTranslation: String

/*!
 @constant AVMediaCharacteristicVoiceOverTranslation NS_AVAILABLE(10_11, 9_0);
 @abstract A media characteristic that indicates that a track or media selection option contains a language translation of originally or previously produced content, created by adding, in its designated language, a verbal interpretation of dialog and translations of other important information to a new mix of the audio content.
 @discussion
 Tracks to which this characteristic is assigned should typically also be assigned the characteristic AVMediaCharacteristicLanguageTranslation.
 See -[AVAssetTrack hasMediaCharacteristic:] and -[AVMediaSelectionOption hasMediaCharacteristic:].
 The value of this characteristic is @"public.translation.voice-over".
 Note for content authors: for QuickTime movie and .m4v files a media option is considered to have the characteristic AVMediaCharacteristicVoiceOverTranslation only if it's explicitly tagged with that characteristic.
 See the discussion of the tagging of tracks with media characteristics below.
*/
@available(iOS 9.0, *)
let AVMediaCharacteristicVoiceOverTranslation: String

/*!
 @constant AVFileTypeQuickTimeMovie
 @abstract A UTI for the QuickTime movie file format.
 @discussion
 The value of this UTI is @"com.apple.quicktime-movie".
 Files are identified with the .mov and .qt extensions.
 */
@available(iOS 4.0, *)
let AVFileTypeQuickTimeMovie: String

/*!
 @constant AVFileTypeMPEG4
 @abstract A UTI for the MPEG-4 file format.
 @discussion
 The value of this UTI is @"public.mpeg-4".
 Files are identified with the .mp4 extension.
 */
@available(iOS 4.0, *)
let AVFileTypeMPEG4: String

/*!
 @constant AVFileTypeAppleM4V
 @discussion
 The value of this UTI is @"com.apple.m4v-video".
 Files are identified with the .m4v extension.
 */
@available(iOS 4.0, *)
let AVFileTypeAppleM4V: String

/*!
 @constant AVFileTypeAppleM4A
 @discussion
 The value of this UTI is @"com.apple.m4a-audio".
 Files are identified with the .m4a extension.
 */
@available(iOS 4.0, *)
let AVFileTypeAppleM4A: String

/*!
 @constant AVFileType3GPP
 @abstract A UTI for the 3GPP file format.
 @discussion
 The value of this UTI is @"public.3gpp".
 Files are identified with the .3gp, .3gpp, and .sdv extensions.
 */
@available(iOS 4.0, *)
let AVFileType3GPP: String

/*!
 @constant AVFileType3GPP2
 @abstract A UTI for the 3GPP file format.
 @discussion
 The value of this UTI is @"public.3gpp2".
 Files are identified with the .3g2, .3gp2 extensions.
 */
@available(iOS 4.0, *)
let AVFileType3GPP2: String

/*!
 @constant AVFileTypeCoreAudioFormat
 @abstract A UTI for the CoreAudio file format.
 @discussion
 The value of this UTI is @"com.apple.coreaudio-format".
 Files are identified with the .caf extension.
 */
@available(iOS 4.0, *)
let AVFileTypeCoreAudioFormat: String

/*!
 @constant AVFileTypeWAVE
 @abstract A UTI for the WAVE audio file format.
 @discussion
 The value of this UTI is @"com.microsoft.waveform-audio".
 Files are identified with the .wav, .wave, and .bwf extensions.
 */
@available(iOS 4.0, *)
let AVFileTypeWAVE: String

/*!
 @constant AVFileTypeAIFF
 @abstract A UTI for the AIFF audio file format.
 @discussion
 The value of this UTI is @"public.aiff-audio".
 Files are identified with the .aif and .aiff extensions.
 */
@available(iOS 4.0, *)
let AVFileTypeAIFF: String

/*!
 @constant AVFileTypeAIFC
 @abstract A UTI for the AIFC audio file format.
 @discussion
 The value of this UTI is @"public.aifc-audio".
 Files are identified with the .aifc and .cdda extensions.
 */
@available(iOS 4.0, *)
let AVFileTypeAIFC: String

/*!
 @constant AVFileTypeAMR
 @abstract A UTI for the adaptive multi-rate audio file format.
 @discussion
 The value of this UTI is @"org.3gpp.adaptive-multi-rate-audio".
 Files are identified with the .amr extension.
 */
@available(iOS 4.0, *)
let AVFileTypeAMR: String

/*!
 @constant AVFileTypeMPEGLayer3
 @abstract A UTI for the MPEG layer 3 audio file format.
 @discussion
 The value of this UTI is @"public.mp3".
 Files are identified with the .mp3 extension.
 */
@available(iOS 7.0, *)
let AVFileTypeMPEGLayer3: String

/*!
 @constant AVFileTypeSunAU
 @abstract A UTI for the Sun/NeXT audio file format.
 @discussion
 The value of this UTI is @"public.au-audio".
 Files are identified with the .au and .snd extensions.
 */
@available(iOS 7.0, *)
let AVFileTypeSunAU: String

/*!
 @constant AVFileTypeAC3
 @abstract A UTI for the AC-3 audio file format.
 @discussion
 The value of this UTI is @"public.ac3-audio".
 Files are identified with the .ac3 extension.
 */
@available(iOS 7.0, *)
let AVFileTypeAC3: String

/*!
 @constant AVFileTypeEnhancedAC3
 @abstract A UTI for the enhanced AC-3 audio file format.
 @discussion
 The value of this UTI is @"public.enhanced-ac3-audio".
 Files are identified with the .eac3 extension.
 */
@available(iOS 9.0, *)
let AVFileTypeEnhancedAC3: String

/*!
 @constant AVStreamingKeyDeliveryContentKeyType
 @abstract A UTI for streaming key delivery content keys
 @discussion
 The value of this UTI is @"com.apple.streamingkeydelivery.contentkey".
 */
@available(iOS 9.0, *)
let AVStreamingKeyDeliveryContentKeyType: String

/*!
 @constant AVStreamingKeyDeliveryPersistentContentKeyType
 @abstract A UTI for persistent streaming key delivery content keys
 @discussion
 The value of this UTI is @"com.apple.streamingkeydelivery.persistentcontentkey".
 */
@available(iOS 9.0, *)
let AVStreamingKeyDeliveryPersistentContentKeyType: String
@available(iOS 9.0, *)
class AVMediaSelection : Object, Copying, MutableCopying {
  weak var asset: @sil_weak AVAsset? { get }

  /*!
   @method		selectedMediaOptionInMediaSelectionGroup:
   @abstract		Indicates the media selection option that's currently selected from the specified group. May be nil.
   @param 		mediaSelectionGroup
  				A media selection group obtained from the receiver's asset.
   @result		An instance of AVMediaSelectionOption that describes the currently selection option in the group.
   @discussion
  				If the value of the property allowsEmptySelection of the AVMediaSelectionGroup is YES, the currently selected option in the group may be nil.
  */
  func selectedMediaOptionIn(mediaSelectionGroup: AVMediaSelectionGroup) -> AVMediaSelectionOption?

  /*!
   @method		mediaSelectionCriteriaCanBeAppliedAutomaticallyToMediaSelectionGroup:
   @abstract		Indicates that specified media selection group is subject to automatic media selection.
   @param 		mediaSelectionGroup
  				A media selection group obtained from the receiver's asset.
   @result		YES if the group is subject to automatic media selection.
   @discussion	Automatic application of media selection criteria is suspended in any group in which a specific selection has been made via an invocation of -selectMediaOption:inMediaSelectionGroup:.
  */
  func mediaSelectionCriteriaCanBeAppliedAutomaticallyTo(mediaSelectionGroup: AVMediaSelectionGroup) -> Bool
  init()
  @available(iOS 9.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 9.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 9.0, *)
class AVMutableMediaSelection : AVMediaSelection {

  /*!
   @method		selectMediaOption:inMediaSelectionGroup:
   @abstract		Selects the media option described by the specified instance of AVMediaSelectionOption in the specified AVMediaSelectionGroup and deselects all other options in that group.
   @param			mediaSelectionOption
  				The option to select.
   @param			mediaSelectionGroup
  				The media selection group, obtained from the receiver's asset, that contains the specified option.
   @discussion
  				If the specified media selection option isn't a member of the specified media selection group, no change in presentation state will result.
  				If the value of the property allowsEmptySelection of the AVMediaSelectionGroup is YES, you can pass nil for mediaSelectionOption to deselect all media selection options in the group.
  */
  func selectMediaOption(mediaSelectionOption: AVMediaSelectionOption?, in mediaSelectionGroup: AVMediaSelectionGroup)
  init()
}
@available(iOS 5.0, *)
class AVMediaSelectionGroup : Object, Copying {

  /*!
   @property		options
   @abstract		A collection of mutually exclusive media selection options.
   @discussion	An NSArray of AVMediaSelectionOption*.
  */
  var options: [AVMediaSelectionOption] { get }

  /*!
   @property		defaultOption
   @abstract		Indicates the default option in the group, i.e. the option that's intended for use in the absence of a specific end-user selection or preference.
   @discussion
  	Can be nil, indicating that without a specific end-user selection or preference, no option in the group is intended to be selected.
  */
  @available(iOS 8.0, *)
  var defaultOption: AVMediaSelectionOption? { get }

  /*!
   @property		allowsEmptySelection
   @abstract		Indicates whether it's possible to present none of the options in the group when an associated AVPlayerItem is played.
   @discussion
  	If allowsEmptySelection is YES, all of the available media options in the group can be deselected by passing nil
  	as the specified AVMediaSelectionOption to -[AVPlayerItem selectMediaOption:inMediaSelectionGroup:].
  */
  var allowsEmptySelection: Bool { get }

  /*!
    @method		mediaSelectionOptionWithPropertyList:
    @abstract		Returns the instance of AVMediaSelectionOption with properties that match the specified property list.
    @param		plist
    				A property list previously obtained from an option in the group via -[AVMediaSelectionOption propertyList].
    @result		If the specified properties match those of an option in the group, an instance of AVMediaSelectionOption. Otherwise nil.
  */
  func mediaSelectionOptionWithPropertyList(plist: AnyObject) -> AVMediaSelectionOption?
  init()
  @available(iOS 5.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
  @category		AVMediaSelectionOptionFiltering
  @abstract		Filtering of media selection options.
  @discussion
	The AVMediaSelectionOptionFiltering category is provided for convenience in filtering the media selection options in a group
	according to playability, locale, and media characteristics.
	Note that it's possible to implement additional filtering behaviors by using -[NSArray indexesOfObjectsPassingTest:].
*/
extension AVMediaSelectionGroup {

  /*!
    @method		playableMediaSelectionOptionsFromArray:
    @abstract		Filters an array of AVMediaSelectionOptions according to whether they are playable.
    @param		mediaSelectionOptions
    				An array of AVMediaSelectionOption to be filtered according to whether they are playable.
    @result		An instance of NSArray containing the media selection options of the specified NSArray that are playable.
  */
  class func playableMediaSelectionOptionsFrom(mediaSelectionOptions: [AVMediaSelectionOption]) -> [AVMediaSelectionOption]

  /*!
   @method		mediaSelectionOptionsFromArray:filteredAndSortedAccordingToPreferredLanguages:
   @abstract		Filters an array of AVMediaSelectionOptions according to whether their locales match any language identifier in the specified array of preferred languages. The returned array is sorted according to the order of preference of the language each matches.
   @param			mediaSelectionOptions
  				An array of AVMediaSelectionOptions to be filtered and sorted.
   @param			preferredLanguages
  				An array of language identifiers in order of preference, each of which is an IETF BCP 47 (RFC 4646) language identifier. Use +[NSLocale preferredLanguages] to obtain the user's list of preferred languages.
   @result		An instance of NSArray containing media selection options of the specified NSArray that match a preferred language, sorted according to the order of preference of the language each matches.
  */
  @available(iOS 6.0, *)
  class func mediaSelectionOptionsFrom(mediaSelectionOptions: [AVMediaSelectionOption], filteredAndSortedAccordingToPreferredLanguages preferredLanguages: [String]) -> [AVMediaSelectionOption]

  /*!
    @method		mediaSelectionOptionsFromArray:withLocale:
    @abstract		Filters an array of AVMediaSelectionOptions according to locale.
    @param		mediaSelectionOptions
  				An array of AVMediaSelectionOption to be filtered by locale.
    @param		locale
    				The NSLocale that must be matched for a media selection option to be copied to the output array.
    @result		An instance of NSArray containing the media selection options of the specified NSArray that match the specified locale.
  */
  class func mediaSelectionOptionsFrom(mediaSelectionOptions: [AVMediaSelectionOption], withLocale locale: Locale) -> [AVMediaSelectionOption]

  /*!
    @method		mediaSelectionOptionsFromArray:withMediaCharacteristics:
    @abstract		Filters an array of AVMediaSelectionOptions according to one or more media characteristics.
    @param		mediaSelectionOptions
    				An array of AVMediaSelectionOptions to be filtered by media characteristic.
    @param		mediaCharacteristics
    				The media characteristics that must be matched for a media selection option to be copied to the output array.
    @result		An instance of NSArray containing the media selection options of the specified NSArray that match the specified
  				media characteristics.
  */
  class func mediaSelectionOptionsFrom(mediaSelectionOptions: [AVMediaSelectionOption], withMediaCharacteristics mediaCharacteristics: [String]) -> [AVMediaSelectionOption]

  /*!
    @method		mediaSelectionOptionsFromArray:withoutMediaCharacteristics:
    @abstract		Filters an array of AVMediaSelectionOptions according to whether they lack one or more media characteristics.
    @param		mediaSelectionOptions
    				An array of AVMediaSelectionOptions to be filtered by media characteristic.
    @param		mediaCharacteristics
    				The media characteristics that must not be present for a media selection option to be copied to the output array.
    @result		An instance of NSArray containing the media selection options of the specified NSArray that lack the specified
  				media characteristics.
  */
  class func mediaSelectionOptionsFrom(mediaSelectionOptions: [AVMediaSelectionOption], withoutMediaCharacteristics mediaCharacteristics: [String]) -> [AVMediaSelectionOption]
}
@available(iOS 5.0, *)
class AVMediaSelectionOption : Object, Copying {

  /*!
   @property		mediaType
   @abstract		The media type of the media data, e.g. AVMediaTypeAudio, AVMediaTypeSubtitle, etc.
  */
  var mediaType: String { get }

  /*!
   @property		mediaSubTypes
   @abstract		The mediaSubTypes of the media data associated with the option. 
   @discussion
  	An NSArray of NSNumbers carrying four character codes (of type FourCharCode) as defined in CoreAudioTypes.h for audio media and in CMFormatDescription.h for video media.
  	Also see CMFormatDescriptionGetMediaSubType in CMFormatDescription.h for more information about media subtypes.
  	
  	Note that if no information is available about the encoding of the media presented when a media option is selected, the value of mediaSubTypes will be an empty array. This can occur, for example, with streaming media. In these cases the value of mediaSubTypes should simply not be used as a criteria for selection.
  */
  var mediaSubTypes: [Number] { get }

  /*!
    @method		hasMediaCharacteristic:
    @abstract		Reports whether the media selection option includes media with the specified media characteristic.
    @param		mediaCharacteristic
    				The media characteristic of interest, e.g. AVMediaCharacteristicVisual, AVMediaCharacteristicAudible, AVMediaCharacteristicLegible, etc.
    @result		YES if the media selection option includes media with the specified characteristic, otherwise NO.
  */
  func hasMediaCharacteristic(mediaCharacteristic: String) -> Bool

  /*!
   @property		playable
   @abstract		Indicates whether a media selection option is playable.
   @discussion	If the media data associated with the option cannot be decoded or otherwise rendered, playable is NO.
  */
  var isPlayable: Bool { get }

  /*!
   @property		extendedLanguageTag
   @abstract		Indicates the RFC 4646 language tag associated with the option. May be nil.
   */
  @available(iOS 7.0, *)
  var extendedLanguageTag: String? { get }

  /*!
   @property		locale
   @abstract		Indicates the locale for which the media option was authored.
   @discussion
   	Use -[NSLocale objectForKey:NSLocaleLanguageCode] to obtain the language code of the locale. See NSLocale.h for additional information.
  */
  var locale: Locale? { get }

  /*!
   @property		commonMetadata
   @abstract		Provides an array of AVMetadataItems for each common metadata key for which a value is available.
   @discussion
     The array of AVMetadataItems can be filtered according to language via +[AVMetadataItem metadataItemsFromArray:filteredAndSortedAccordingToPreferredLanguages:], according to locale via +[AVMetadataItem metadataItemsFromArray:withLocale:],
     or according to key via +[AVMetadataItem metadataItemsFromArray:withKey:keySpace:].
     Example: to obtain the name (or title) of a media selection option in any of the user's preferred languages.
  
  	NSString *title = nil;
  	NSArray *titles = [AVMetadataItem metadataItemsFromArray:[mediaSelectionOption commonMetadata] withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
  	if ([titles count] > 0)
  	{
  		// Try to get a title that matches one of the user's preferred languages.
  		NSArray *titlesForPreferredLanguages = [AVMetadataItem metadataItemsFromArray:titles filteredAndSortedAccordingToPreferredLanguages:[NSLocale preferredLanguages]];
  		if ([titlesForPreferredLanguages count] > 0)
  		{
  			title = [[titlesForPreferredLanguages objectAtIndex:0] stringValue];
  		}
  		
  		// No matches in any of the preferred languages. Just use the primary title metadata we find.
  		if (title == nil)
  		{
  			title = [[titles objectAtIndex:0] stringValue];
  		}
  	}
  
  */
  var commonMetadata: [AVMetadataItem] { get }

  /*!
   @property		availableMetadataFormats
   @abstract		Provides an NSArray of NSStrings, each representing a metadata format that contains metadata associated with the option (e.g. ID3, iTunes metadata, etc.).
   @discussion
     Metadata formats are defined in AVMetadataFormat.h.
  */
  var availableMetadataFormats: [String] { get }

  /*!
    @method		metadataForFormat:
    @abstract		Provides an NSArray of AVMetadataItems, one for each metadata item in the container of the specified format.
    @param		format
    				The metadata format for which items are requested.
    @result		An NSArray containing AVMetadataItems.
  */
  func metadataForFormat(format: String) -> [AVMetadataItem]

  /*!
    @method		associatedMediaSelectionOptionInMediaSelectionGroup
    @abstract		If a media selection option in another group is associated with the specified option, returns a reference to the associated option.
    @param		mediaSelectionGroup
    				A media selection group in which an associated option is to be sought.
    @result		An instance of AVMediaSelectionOption.
   @discussion
     Audible media selection options often have associated legible media selection options; in particular, audible options are typically associated with forced-only subtitle options with the same locale. See AVMediaCharacteristicContainsOnlyForcedSubtitles in AVMediaFormat.h for a discussion of forced-only subtitles.
  */
  func associatedMediaSelectionOptionIn(mediaSelectionGroup: AVMediaSelectionGroup) -> AVMediaSelectionOption?

  /*!
    @method		propertyList
    @abstract		Returns a serializable property list that can be used to obtain an instance of AVMediaSelectionOption representing the same option as the receiver via -[AVMediaSelectionGroup mediaSelectionOptionWithPropertyList:].
    @result		A serializable property list that's sufficient to identify the option within its group. For serialization utilities, see NSPropertyList.h.
  */
  func propertyList() -> AnyObject

  /*!
    @method		displayNameWithLocale
    @abstract		Provides an NSString suitable for display.
    @param		locale
    				Localize manufactured portions of the string using the specificed locale.
    @discussion
     May use this option's common metadata, media characteristics and locale properties in addition to the provided locale to formulate an NSString intended for display. Will only consider common metadata with the specified locale.
  */
  @available(iOS 7.0, *)
  func displayNameWith(locale: Locale) -> String

  /*!
    @property		displayName
    @abstract		Provides an NSString suitable for display using the current system locale.
    @discussion
     May use this option's common metadata, media characteristics and locale properties in addition to the current system locale to formulate an NSString intended for display.
     In the event that common metadata is not available in the specified locale, displayName will fall back to considering locales with the multilingual ("mul") then undetermined ("und") locale identifiers.
     For a display name strictly with the specified locale use displayNameWithLocale: instead.
  */
  @available(iOS 7.0, *)
  var displayName: String { get }
  init()
  @available(iOS 5.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 4.0, *)
let AVMetadataKeySpaceCommon: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyTitle: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyCreator: String
@available(iOS 4.0, *)
let AVMetadataCommonKeySubject: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyDescription: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyPublisher: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyContributor: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyCreationDate: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyLastModifiedDate: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyType: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyFormat: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyIdentifier: String
@available(iOS 4.0, *)
let AVMetadataCommonKeySource: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyLanguage: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyRelation: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyLocation: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyCopyrights: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyAlbumName: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyAuthor: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyArtist: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyArtwork: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyMake: String
@available(iOS 4.0, *)
let AVMetadataCommonKeyModel: String
@available(iOS 4.0, *)
let AVMetadataCommonKeySoftware: String
@available(iOS 4.0, *)
let AVMetadataFormatQuickTimeUserData: String
@available(iOS 4.0, *)
let AVMetadataKeySpaceQuickTimeUserData: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyAlbum: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyArranger: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyArtist: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyAuthor: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyChapter: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyComment: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyComposer: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyCopyright: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyCreationDate: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyDescription: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyDirector: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyDisclaimer: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyEncodedBy: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyFullName: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyGenre: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyHostComputer: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyInformation: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyKeywords: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyMake: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyModel: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyOriginalArtist: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyOriginalFormat: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyOriginalSource: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyPerformers: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyProducer: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyPublisher: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyProduct: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeySoftware: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeySpecialPlaybackRequirements: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyTrack: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyWarning: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyWriter: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyURLLink: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyLocationISO6709: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyTrackName: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyCredits: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeUserDataKeyPhonogramRights: String
@available(iOS 5.0, *)
let AVMetadataQuickTimeUserDataKeyTaggedCharacteristic: String
@available(iOS 7.0, *)
let AVMetadataFormatISOUserData: String
@available(iOS 7.0, *)
let AVMetadataKeySpaceISOUserData: String
@available(iOS 4.0, *)
let AVMetadataISOUserDataKeyCopyright: String
@available(iOS 8.0, *)
let AVMetadataISOUserDataKeyTaggedCharacteristic: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyCopyright: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyAuthor: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyPerformer: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyGenre: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyRecordingYear: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyLocation: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyTitle: String
@available(iOS 4.0, *)
let AVMetadata3GPUserDataKeyDescription: String
@available(iOS 7.0, *)
let AVMetadata3GPUserDataKeyCollection: String
@available(iOS 7.0, *)
let AVMetadata3GPUserDataKeyUserRating: String
@available(iOS 7.0, *)
let AVMetadata3GPUserDataKeyThumbnail: String
@available(iOS 7.0, *)
let AVMetadata3GPUserDataKeyAlbumAndTrack: String
@available(iOS 7.0, *)
let AVMetadata3GPUserDataKeyKeywordList: String
@available(iOS 7.0, *)
let AVMetadata3GPUserDataKeyMediaClassification: String
@available(iOS 7.0, *)
let AVMetadata3GPUserDataKeyMediaRating: String
@available(iOS 4.0, *)
let AVMetadataFormatQuickTimeMetadata: String
@available(iOS 4.0, *)
let AVMetadataKeySpaceQuickTimeMetadata: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyAuthor: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyComment: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyCopyright: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyCreationDate: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyDirector: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyDisplayName: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyInformation: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyKeywords: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyProducer: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyPublisher: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyAlbum: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyArtist: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyArtwork: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyDescription: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeySoftware: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyYear: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyGenre: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyiXML: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyLocationISO6709: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyMake: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyModel: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyArranger: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyEncodedBy: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyOriginalArtist: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyPerformer: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyComposer: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyCredits: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyPhonogramRights: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyCameraIdentifier: String
@available(iOS 4.0, *)
let AVMetadataQuickTimeMetadataKeyCameraFrameReadoutTime: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyTitle: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyCollectionUser: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyRatingUser: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyLocationName: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyLocationBody: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyLocationNote: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyLocationRole: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyLocationDate: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyDirectionFacing: String
@available(iOS 4.3, *)
let AVMetadataQuickTimeMetadataKeyDirectionMotion: String
@available(iOS 9.0, *)
let AVMetadataQuickTimeMetadataKeyContentIdentifier: String
@available(iOS 4.0, *)
let AVMetadataFormatiTunesMetadata: String
@available(iOS 4.0, *)
let AVMetadataKeySpaceiTunes: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyAlbum: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyArtist: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyUserComment: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyCoverArt: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyCopyright: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyReleaseDate: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyEncodedBy: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyPredefinedGenre: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyUserGenre: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeySongName: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyTrackSubTitle: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyEncodingTool: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyComposer: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyAlbumArtist: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyAccountKind: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyAppleID: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyArtistID: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeySongID: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyDiscCompilation: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyDiscNumber: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyGenreID: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyGrouping: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyPlaylistID: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyContentRating: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyBeatsPerMin: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyTrackNumber: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyArtDirector: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyArranger: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyAuthor: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyLyrics: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyAcknowledgement: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyConductor: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyDescription: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyDirector: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyEQ: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyLinerNotes: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyRecordCompany: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyOriginalArtist: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyPhonogramRights: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyProducer: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyPerformer: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyPublisher: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeySoundEngineer: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeySoloist: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyCredits: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyThanks: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyOnlineExtras: String
@available(iOS 4.0, *)
let AVMetadataiTunesMetadataKeyExecProducer: String
@available(iOS 4.0, *)
let AVMetadataFormatID3Metadata: String
@available(iOS 4.0, *)
let AVMetadataKeySpaceID3: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyAudioEncryption: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyAttachedPicture: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyAudioSeekPointIndex: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyComments: String
@available(iOS 9.0, *)
let AVMetadataID3MetadataKeyCommercial: String
@available(iOS, introduced=4.0, deprecated=9.0)
let AVMetadataID3MetadataKeyCommerical: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyEncryption: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyEqualization: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyEqualization2: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyEventTimingCodes: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyGeneralEncapsulatedObject: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyGroupIdentifier: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyInvolvedPeopleList_v23: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyLink: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyMusicCDIdentifier: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyMPEGLocationLookupTable: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOwnership: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPrivate: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPlayCounter: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPopularimeter: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPositionSynchronization: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyRecommendedBufferSize: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyRelativeVolumeAdjustment: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyRelativeVolumeAdjustment2: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyReverb: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeySeek: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeySignature: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeySynchronizedLyric: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeySynchronizedTempoCodes: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyAlbumTitle: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyBeatsPerMinute: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyComposer: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyContentType: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyCopyright: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyDate: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyEncodingTime: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPlaylistDelay: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOriginalReleaseTime: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyRecordingTime: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyReleaseTime: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyTaggingTime: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyEncodedBy: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyLyricist: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyFileType: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyTime: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyInvolvedPeopleList_v24: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyContentGroupDescription: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyTitleDescription: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeySubTitle: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyInitialKey: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyLanguage: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyLength: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyMusicianCreditsList: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyMediaType: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyMood: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOriginalAlbumTitle: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOriginalFilename: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOriginalLyricist: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOriginalArtist: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOriginalReleaseYear: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyFileOwner: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyLeadPerformer: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyBand: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyConductor: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyModifiedBy: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPartOfASet: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyProducedNotice: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPublisher: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyTrackNumber: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyRecordingDates: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyInternetRadioStationName: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyInternetRadioStationOwner: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeySize: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyAlbumSortOrder: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPerformerSortOrder: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyTitleSortOrder: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyInternationalStandardRecordingCode: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyEncodedWith: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeySetSubtitle: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyYear: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyUserText: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyUniqueFileIdentifier: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyTermsOfUse: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyUnsynchronizedLyric: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyCommercialInformation: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyCopyrightInformation: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOfficialAudioFileWebpage: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOfficialArtistWebpage: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOfficialAudioSourceWebpage: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOfficialInternetRadioStationHomepage: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyPayment: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyOfficialPublisherWebpage: String
@available(iOS 4.0, *)
let AVMetadataID3MetadataKeyUserURL: String
@available(iOS 8.0, *)
let AVMetadataKeySpaceIcy: String
@available(iOS 8.0, *)
let AVMetadataIcyMetadataKeyStreamTitle: String
@available(iOS 8.0, *)
let AVMetadataIcyMetadataKeyStreamURL: String
@available(iOS 8.0, *)
let AVMetadataFormatHLSMetadata: String

/*!
 @constant		AVMetadataExtraAttributeValueURIKey
 @abstract
	When present in an item's extraAttributes dictionary, identifies the resource to be used as the item's value. Values for this key are of type NSString.
*/
@available(iOS 8.0, *)
let AVMetadataExtraAttributeValueURIKey: String

/*!
 @constant		AVMetadataExtraAttributeBaseURIKey
 @abstract
	When present in an item's extraAttributes dictionary, identifies the base URI against which other URIs related to the item are to be resolved, e.g. AVMetadataExtraAttributeValueURIKey. Values for this key are of type NSString.
*/
@available(iOS 8.0, *)
let AVMetadataExtraAttributeBaseURIKey: String

/*!
	@constant		AVMetadataExtraAttributeInfoKey
	@abstract		More information about the item; specific to the 
					item keySpace & key.
	@discussion		For example, this key is used with the following ID3 tags:
					TXXX, WXXX, APIC, GEOB: carries the Description
					PRIV: carries the Owner Identifier
 */
@available(iOS 9.0, *)
let AVMetadataExtraAttributeInfoKey: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierTitle: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierCreator: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierSubject: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierDescription: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierPublisher: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierContributor: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierCreationDate: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierLastModifiedDate: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierType: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierFormat: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierAssetIdentifier: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierSource: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierLanguage: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierRelation: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierLocation: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierCopyrights: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierAlbumName: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierAuthor: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierArtist: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierArtwork: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierMake: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierModel: String
@available(iOS 8.0, *)
let AVMetadataCommonIdentifierSoftware: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataAlbum: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataArranger: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataAuthor: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataChapter: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataComment: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataComposer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataCopyright: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataCreationDate: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataDescription: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataDirector: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataDisclaimer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataEncodedBy: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataFullName: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataGenre: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataHostComputer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataInformation: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataKeywords: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataMake: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataModel: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataOriginalArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataOriginalFormat: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataOriginalSource: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataPerformers: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataProducer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataPublisher: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataProduct: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataSoftware: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataSpecialPlaybackRequirements: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataTrack: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataWarning: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataWriter: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataURLLink: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataLocationISO6709: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataTrackName: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataCredits: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataPhonogramRights: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeUserDataTaggedCharacteristic: String
@available(iOS 8.0, *)
let AVMetadataIdentifierISOUserDataCopyright: String
@available(iOS 8.0, *)
let AVMetadataIdentifierISOUserDataTaggedCharacteristic: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataCopyright: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataAuthor: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataPerformer: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataGenre: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataRecordingYear: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataLocation: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataTitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataDescription: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataCollection: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataUserRating: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataThumbnail: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataAlbumAndTrack: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataKeywordList: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataMediaClassification: String
@available(iOS 8.0, *)
let AVMetadataIdentifier3GPUserDataMediaRating: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataAuthor: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataComment: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataCopyright: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataCreationDate: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataDirector: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataDisplayName: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataInformation: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataKeywords: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataProducer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataPublisher: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataAlbum: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataArtwork: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataDescription: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataSoftware: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataYear: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataGenre: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataiXML: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataLocationISO6709: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataMake: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataModel: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataArranger: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataEncodedBy: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataOriginalArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataPerformer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataComposer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataCredits: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataPhonogramRights: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataCameraIdentifier: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataCameraFrameReadoutTime: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataTitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataCollectionUser: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataRatingUser: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataLocationName: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataLocationBody: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataLocationNote: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataLocationRole: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataLocationDate: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataDirectionFacing: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataDirectionMotion: String
@available(iOS 8.0, *)
let AVMetadataIdentifierQuickTimeMetadataPreferredAffineTransform: String
@available(iOS 9.0, *)
let AVMetadataIdentifierQuickTimeMetadataDetectedFace: String
@available(iOS 9.0, *)
let AVMetadataIdentifierQuickTimeMetadataVideoOrientation: String
@available(iOS 9.0, *)
let AVMetadataIdentifierQuickTimeMetadataContentIdentifier: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataAlbum: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataUserComment: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataCoverArt: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataCopyright: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataReleaseDate: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataEncodedBy: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataPredefinedGenre: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataUserGenre: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataSongName: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataTrackSubTitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataEncodingTool: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataComposer: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataAlbumArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataAccountKind: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataAppleID: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataArtistID: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataSongID: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataDiscCompilation: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataDiscNumber: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataGenreID: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataGrouping: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataPlaylistID: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataContentRating: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataBeatsPerMin: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataTrackNumber: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataArtDirector: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataArranger: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataAuthor: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataLyrics: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataAcknowledgement: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataConductor: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataDescription: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataDirector: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataEQ: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataLinerNotes: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataRecordCompany: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataOriginalArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataPhonogramRights: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataProducer: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataPerformer: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataPublisher: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataSoundEngineer: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataSoloist: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataCredits: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataThanks: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataOnlineExtras: String
@available(iOS 8.0, *)
let AVMetadataIdentifieriTunesMetadataExecProducer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataAudioEncryption: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataAttachedPicture: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataAudioSeekPointIndex: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataComments: String
@available(iOS 9.0, *)
let AVMetadataIdentifierID3MetadataCommercial: String
@available(iOS, introduced=8.0, deprecated=9.0)
let AVMetadataIdentifierID3MetadataCommerical: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataEncryption: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataEqualization: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataEqualization2: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataEventTimingCodes: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataGeneralEncapsulatedObject: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataGroupIdentifier: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataInvolvedPeopleList_v23: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataLink: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataMusicCDIdentifier: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataMPEGLocationLookupTable: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOwnership: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPrivate: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPlayCounter: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPopularimeter: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPositionSynchronization: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataRecommendedBufferSize: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataRelativeVolumeAdjustment: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataRelativeVolumeAdjustment2: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataReverb: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataSeek: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataSignature: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataSynchronizedLyric: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataSynchronizedTempoCodes: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataAlbumTitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataBeatsPerMinute: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataComposer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataContentType: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataCopyright: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataDate: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataEncodingTime: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPlaylistDelay: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOriginalReleaseTime: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataRecordingTime: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataReleaseTime: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataTaggingTime: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataEncodedBy: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataLyricist: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataFileType: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataTime: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataInvolvedPeopleList_v24: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataContentGroupDescription: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataTitleDescription: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataSubTitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataInitialKey: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataLanguage: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataLength: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataMusicianCreditsList: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataMediaType: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataMood: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOriginalAlbumTitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOriginalFilename: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOriginalLyricist: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOriginalArtist: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOriginalReleaseYear: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataFileOwner: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataLeadPerformer: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataBand: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataConductor: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataModifiedBy: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPartOfASet: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataProducedNotice: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPublisher: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataTrackNumber: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataRecordingDates: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataInternetRadioStationName: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataInternetRadioStationOwner: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataSize: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataAlbumSortOrder: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPerformerSortOrder: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataTitleSortOrder: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataInternationalStandardRecordingCode: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataEncodedWith: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataSetSubtitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataYear: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataUserText: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataUniqueFileIdentifier: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataTermsOfUse: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataUnsynchronizedLyric: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataCommercialInformation: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataCopyrightInformation: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOfficialAudioFileWebpage: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOfficialArtistWebpage: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOfficialAudioSourceWebpage: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOfficialInternetRadioStationHomepage: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataPayment: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataOfficialPublisherWebpage: String
@available(iOS 8.0, *)
let AVMetadataIdentifierID3MetadataUserURL: String
@available(iOS 8.0, *)
let AVMetadataIdentifierIcyMetadataStreamTitle: String
@available(iOS 8.0, *)
let AVMetadataIdentifierIcyMetadataStreamURL: String
@available(iOS 4.0, *)
class AVMetadataItem : Object, AVAsynchronousKeyValueLoading, Copying, MutableCopying {
  @available(iOS 8.0, *)
  var identifier: String? { get }
  @available(iOS 8.0, *)
  var extendedLanguageTag: String? { get }
  @NSCopying var locale: Locale? { get }
  var time: CMTime { get }
  @available(iOS 4.2, *)
  var duration: CMTime { get }
  @available(iOS 8.0, *)
  var dataType: String? { get }
  @NSCopying var value: protocol<Copying, ObjectProtocol>? { get }
  var extraAttributes: [String : AnyObject]? { get }
  init()
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 4.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
extension AVMetadataItem {
  @available(iOS 9.0, *)
  @NSCopying var startDate: Date? { get }
}
extension AVMetadataItem {
  var stringValue: String? { get }
  var numberValue: Number? { get }
  var dateValue: Date? { get }
  var dataValue: Data? { get }
}
extension AVMetadataItem {
  @available(iOS 4.2, *)
  func statusOfValueForKey(key: String, error outError: ErrorPointer) -> AVKeyValueStatus
  @available(iOS 4.2, *)
  func loadValuesAsynchronouslyForKeys(keys: [String], completionHandler handler: (() -> Void)? = nil)
}
extension AVMetadataItem {

  /*!
   @method		metadataItemsFromArray:filteredAndSortedAccordingToPreferredLanguages:
   @abstract		Filters an array of AVMetadataItems according to whether their locales match any language identifier in the specified array of preferred languages. The returned array is sorted according to the order of preference of the language each matches.
   @param			metadataItems
  				An array of AVMetadataItems to be filtered and sorted.
   @param			preferredLanguages
  				An array of language identifiers in order of preference, each of which is an IETF BCP 47 (RFC 4646) language identifier. Use +[NSLocale preferredLanguages] to obtain the user's list of preferred languages.
   @result		An instance of NSArray containing metadata items of the specified NSArray that match a preferred language, sorted according to the order of preference of the language each matches.
  */
  @available(iOS 6.0, *)
  class func metadataItemsFrom(metadataItems: [AVMetadataItem], filteredAndSortedAccordingToPreferredLanguages preferredLanguages: [String]) -> [AVMetadataItem]

  /*!
  	@method			metadataItemsFromArray:filteredByIdentifier:
  	@abstract			Filters an array of AVMetadataItems according to identifier.
  	@param			metadataItems
  	An array of AVMetadataItems to be filtered by identifier.
  	@param			identifier
  	The identifier that must be matched for a metadata item to be copied to the output array. Items are considered a match not only when their identifiers are equal to the specified identifier, and also when their identifiers conform to the specified identifier.
  	@result			An instance of NSArray containing the metadata items of the target NSArray that match the specified identifier.
  */
  @available(iOS 8.0, *)
  class func metadataItemsFrom(metadataItems: [AVMetadataItem], filteredByIdentifier identifier: String) -> [AVMetadataItem]

  /*!
  	@method			metadataItemsFromArray:filteredByMetadataItemFilter:
  	@abstract		Filters an array of AVMetadataItems using the supplied AVMetadataItemFilter.
  	@param			metadataItems
  					An array of AVMetadataItems to be filtered.
  	@param			metadataItemFilter
  					The AVMetadataItemFilter object for filtering the metadataItems.
  	@result			An instance of NSArray containing the metadata items of the target NSArray that have not been removed by metadataItemFilter.
  */
  @available(iOS 7.0, *)
  class func metadataItemsFrom(metadataItems: [AVMetadataItem], filteredBy metadataItemFilter: AVMetadataItemFilter) -> [AVMetadataItem]
}
extension AVMetadataItem {

  /*!
  	@method			identifierForKey:keySpace:
  	@abstract		Provides the metadata identifier that's equivalent to a key and keySpace.
  	@param			key
  					The metadata key.
  	@param			keySpace
  					The metadata keySpace.
  	@result			A metadata identifier equivalent to the given key and keySpace, or nil if no identifier can be constructed from the given key and keySpace.
  	@discussion
  		Metadata keys that are not instances of NSString, NSNumber, or NSData cannot be converted to metadata identifiers; they also cannot be written to media resources via AVAssetExportSession or AVAssetWriter.  Metadata item keySpaces must be a string of one to four printable ASCII characters.
   
  		For custom identifiers, the keySpace AVMetadataKeySpaceQuickTimeMetadata is recommended.  This keySpace defines its key values to be expressed as reverse-DNS strings, which allows third parties to define their own keys in a well established way that avoids collisions.
  */
  @available(iOS 8.0, *)
  class func identifierForKey(key: AnyObject, keySpace: String) -> String?
  @available(iOS 8.0, *)
  class func keySpaceForIdentifier(identifier: String) -> String?
  @available(iOS 8.0, *)
  class func keyForIdentifier(identifier: String) -> AnyObject?
  @NSCopying var key: protocol<Copying, ObjectProtocol>? { get }
  var commonKey: String? { get }
  var keySpace: String? { get }
}
@available(iOS 4.0, *)
class AVMutableMetadataItem : AVMetadataItem {
  @available(iOS 8.0, *)
  var identifier: String?
  @available(iOS 8.0, *)
  var extendedLanguageTag: String?
  @NSCopying var locale: Locale?
  var time: CMTime
  @available(iOS 4.2, *)
  var duration: CMTime
  @available(iOS 8.0, *)
  var dataType: String?
  @NSCopying var value: protocol<Copying, ObjectProtocol>?
  var extraAttributes: [String : AnyObject]?
  init()
}
extension AVMutableMetadataItem {
  @available(iOS 9.0, *)
  @NSCopying var startDate: Date?
}
extension AVMutableMetadataItem {
  var keySpace: String?
  @NSCopying var key: protocol<Copying, ObjectProtocol>?
}
extension AVMetadataItem {

  /*!
  	@method			metadataItemWithPropertiesOfMetadataItem:valueLoadingHandler:
  	@abstract		Creates an instance of AVMutableMetadataItem with a value that you do not wish to load unless required, e.g. a large image value that needn't be loaded into memory until another module wants to display it.
  	@param			metadataItem
  					An instance of AVMetadataItem with the identifier, extendedLanguageTag, and other property values that you want the newly created instance of AVMetadataItem to share. The value of metadataItem is ignored.
  	@param			handler
  					A block that loads the value of the metadata item.
  	@result			An instance of AVMetadataItem.
  	@discussion
   		This method is intended for the creation of metadata items for optional display purposes, when there is no immediate need to load specific metadata values. For example, see the interface for navigation markers as consumed by AVPlayerViewController. It's not intended for the creation of metadata items with values that are required immediately, such as metadata items that are provided for impending serialization operations (e.g. via -[AVAssetExportSession setMetadata:] and other similar methods defined on AVAssetWriter and AVAssetWriterInput). 
  		When -loadValuesAsynchronouslyForKeys:completionHandler: is invoked on an AVMetadataItem created via +metadataItemWithPropertiesOfMetadataItem:valueLoadingHandler: and @"value" is among the keys for which loading is requested, the block you provide as the value loading handler will be executed on an arbitrary dispatch queue, off the main thread. The handler can perform I/O and other necessary operations to obtain the value. If loading of the value succeeds, provide the value by invoking -[AVMetadataItemValueRequest respondWithValue:]. If loading of the value fails, provide an instance of NSError that describes the failure by invoking -[AVMetadataItemValueRequest respondWithError:].
  */
  @available(iOS 9.0, *)
  /*not inherited*/ init(propertiesOf metadataItem: AVMetadataItem, valueLoadingHandler handler: (AVMetadataItemValueRequest) -> Void)
}
@available(iOS 9.0, *)
class AVMetadataItemValueRequest : Object {
  weak var metadataItem: @sil_weak AVMetadataItem? { get }

  /*!
  	@method			respondWithValue:
  	@abstract		Allows you to respond to an AVMetadataItemValueRequest by providing a value.
  	@param			value
  					The value of the AVMetadataItem.
  */
  func respondWithValue(value: protocol<Copying, ObjectProtocol>)

  /*!
  	@method			respondWithError:
  	@abstract		Allows you to respond to an AVMetadataItemValueRequest in the case of failure.
  	@param			error
  					An instance of NSError that describes a failure encountered while loading the value of an AVMetadataItem.
  */
  func respondWithError(error: Error)
  init()
}
@available(iOS 7.0, *)
class AVMetadataItemFilter : Object {
  class func forSharing() -> AVMetadataItemFilter
  init()
}
extension AVMetadataItem {

  /*!
   @method			metadataItemsFromArray:withLocale:
   @discussion		Instead, use metadataItemsFromArray:filteredAndSortedAccordingToPreferredLanguages:.
   */
  class func metadataItemsFrom(metadataItems: [AVMetadataItem], withLocale locale: Locale) -> [AVMetadataItem]

  /*!
   @method			metadataItemsFromArray:withKey:keySpace:
   @discussion		Instead, use metadataItemsFromArray:filteredByIdentifier:.
   */
  class func metadataItemsFrom(metadataItems: [AVMetadataItem], withKey key: AnyObject?, keySpace: String?) -> [AVMetadataItem]
}

/*!
 @class AVMetadataObject
 @abstract
    AVMetadataObject is an abstract class that defines an interface for a metadata object used by AVFoundation.
 
 @discussion
    AVMetadataObject provides an abstract interface for metadata associated with a piece of media.  One example 
    is face metadata that might be detected in a picture. All metadata objects have a time, duration, bounds, and type.
 
    The concrete AVMetadataFaceObject is used by AVCaptureMetadataOutput for face detection.
*/
@available(iOS 6.0, *)
class AVMetadataObject : Object {

  /*!
   @property time
   @abstract
      The media time associated with this metadata object.
   
   @discussion
      The value of this property is a CMTime associated with the metadata object. For capture, it is the time at 
  	which this object was captured. If this metadata object originates from a CMSampleBuffer, its time matches
      the sample buffer's presentation time. This property may return kCMTimeInvalid.
  */
  var time: CMTime { get }

  /*!
   @property duration
   @abstract
      The media duration associated with this metadata object.
   
   @discussion
      The value of this property is a CMTime representing the duration of the metadata object. If this metadata 
      object originates from a CMSampleBuffer, its duration matches the sample buffer's duration. This property 
      may return kCMTimeInvalid.
  */
  var duration: CMTime { get }

  /*!
   @property bounds
   @abstract
      The bounding rectangle of the receiver.
   
   @discussion
      The value of this property is a CGRect representing the bounding rectangle of the object with respect to the 
      picture in which it resides.  The rectangle's origin is top left.  If the metadata originates from video, bounds 
      may be expressed as scalar values from 0. - 1.  If the original video has been scaled down, the bounds of the 
      metadata object still are meaningful.  This property may return CGRectZero if the metadata has no bounds.
  */
  var bounds: CGRect { get }

  /*!
   @property type
   @abstract
      An identifier for the metadata object.
   
   @discussion
      The value of this property is an NSString representing the type of the metadata object.  Clients inspecting
      a collection of metadata objects can use this property to filter objects with a matching type.
  */
  var type: String! { get }
  init()
}

/*!
 @constant AVMetadataObjectTypeFace
 @abstract An identifier for an instance of AVMetadataFaceObject.
 @discussion
    AVMetadataFaceObject objects return this constant as their type.
*/
@available(iOS 6.0, *)
let AVMetadataObjectTypeFace: String

/*!
 @class AVMetadataFaceObject
 @abstract
    AVMetadataFaceObject is a concrete subclass of AVMetadataObject defining the features of a detected face.
 
 @discussion
    AVMetadataFaceObject represents a single detected face in a picture.  It is an immutable object
    describing the various features found in the face.

    On supported platforms, AVCaptureMetadataOutput outputs arrays of detected face objects.  See AVCaptureOutput.h.
*/
@available(iOS 6.0, *)
class AVMetadataFaceObject : AVMetadataObject, Copying {

  /*!
   @property faceID
   @abstract
      A unique number associated with the receiver.
   
   @discussion
      The value of this property is an NSInteger indicating the unique identifier of this face in the picture.
      When a new face enters the picture, it is assigned a new unique identifier.  faceIDs are not re-used as
      faces leave the picture and new ones enter.  Faces that leave the picture then re-enter are assigned
      a new faceID.
  */
  var faceID: Int { get }

  /*!
   @property hasRollAngle
   @abstract
      A BOOL indicating whether the rollAngle property is valid for this receiver.
   
   @discussion
  */
  var hasRollAngle: Bool { get }

  /*!
   @property rollAngle
   @abstract
      The roll angle of the face in degrees.
   
   @discussion
      The value of this property is a CGFloat indicating the face's angle of roll (or tilt) in degrees.
      A value of 0.0 indicates that the face is level in the picture.  If -hasRollAngle returns NO,
      then reading this property throws an NSGenericException.
  */
  var rollAngle: CGFloat { get }

  /*!
   @property hasYawAngle
   @abstract
      A BOOL indicating whether the yawAngle property is valid for this receiver.
   
   @discussion
  */
  var hasYawAngle: Bool { get }

  /*!
   @property yawAngle
   @abstract
      The yaw angle of the face in degrees.
   
   @discussion
      The value of this property is a CGFloat indicating the face's angle of yaw (or turn) in degrees.
      A value of 0.0 indicates that the face is straight on in the picture.  If -hasYawAngle returns NO,
      then reading this property throws an NSGenericException.
  */
  var yawAngle: CGFloat { get }
  init()
  @available(iOS 6.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @constant AVMetadataObjectTypeUPCECode
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeUPCECode.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from UPC-E codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeUPCECode: String

/*!
 @constant AVMetadataObjectTypeCode39Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeCode39Code.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from Code 39 codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeCode39Code: String

/*!
 @constant AVMetadataObjectTypeCode39Mod43Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeCode39Mod43Code.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from Code 39 mod 43 codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeCode39Mod43Code: String

/*!
 @constant AVMetadataObjectTypeEAN13Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeEAN13Code.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from EAN-13 (including UPC-A) codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeEAN13Code: String

/*!
 @constant AVMetadataObjectTypeEAN8Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeEAN8Code.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from EAN-8 codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeEAN8Code: String

/*!
 @constant AVMetadataObjectTypeCode93Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeCode93Code.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from Code 93 codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeCode93Code: String

/*!
 @constant AVMetadataObjectTypeCode128Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeCode128Code.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from Code 128 codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeCode128Code: String

/*!
 @constant AVMetadataObjectTypePDF417Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypePDF417Code.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from PDF417 codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypePDF417Code: String

/*!
 @constant AVMetadataObjectTypeQRCode
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeQRCode.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from QR codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeQRCode: String

/*!
 @constant AVMetadataObjectTypeAztecCode
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeAztecCode.
 @discussion
    AVMetadataMachineReadableCodeObject objects generated from Aztec codes return this constant as their type.
 */
@available(iOS 7.0, *)
let AVMetadataObjectTypeAztecCode: String

/*!
 @constant AVMetadataObjectTypeInterleaved2of5Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeInterleaved2of5Code.
 @discussion
	AVMetadataMachineReadableCodeObject objects generated from Interleaved 2 of 5 codes return this constant as their type.
*/
@available(iOS 8.0, *)
let AVMetadataObjectTypeInterleaved2of5Code: String

/*!
 @constant AVMetadataObjectTypeITF14Code
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeITF14Code.
 @discussion
	AVMetadataMachineReadableCodeObject objects generated from ITF14 codes return this constant as their type.
*/
@available(iOS 8.0, *)
let AVMetadataObjectTypeITF14Code: String

/*!
 @constant AVMetadataObjectTypeDataMatrixCode
 @abstract An identifier for an instance of AVMetadataMachineReadableCodeObject having a type AVMetadataObjectTypeDataMatrixCode.
 @discussion
	AVMetadataMachineReadableCodeObject objects generated from DataMatrix codes return this constant as their type.
*/
@available(iOS 8.0, *)
let AVMetadataObjectTypeDataMatrixCode: String

/*!
 @class AVMetadataMachineReadableCodeObject
 @abstract
    AVMetadataMachineReadableCodeObject is a concrete subclass of AVMetadataObject defining the features of a detected one-dimensional
    or two-dimensional barcode.
 
 @discussion
    AVMetadataMachineReadableCodeObject represents a single detected machine readable code in a picture.  It is an immutable object
    describing the features and payload of a barcode.
 
    On supported platforms, AVCaptureMetadataOutput outputs arrays of detected machine readable code objects.  See AVCaptureMetadataOutput.h.
 */
@available(iOS 7.0, *)
class AVMetadataMachineReadableCodeObject : AVMetadataObject {

  /*!
   @property corners
   @abstract
      The points defining the (X,Y) locations of the corners of the machine-readable code.
   
   @discussion
      The value of this property is an NSArray of CFDictionaries, each of which has been created from a CGPoint using 
      CGPointCreateDictionaryRepresentation(), representing the coordinates of the corners of the object with respect to the image 
      in which it resides.  If the metadata originates from video, the points may be expressed as scalar values from 0. - 1. The 
      points in the corners differ from the bounds rectangle in that bounds is axis-aligned to orientation of the captured image, 
      and the values of the corners reside within the bounds rectangle. The points are arranged in counter-clockwise order 
      (clockwise if the code or image is mirrored), starting with the top-left of the code in its canonical orientation.
   */
  var corners: [AnyObject]! { get }

  /*!
   @property stringValue
   @abstract Returns the receiver's errorCorrectedData decoded into a human-readable string.
   @discussion
      The value of this property is an NSString created by decoding the binary payload according to the format of the machine
      readable code.  Returns nil if a string representation cannot be created from the payload.
   */
  var stringValue: String! { get }
  init()
}
@available(iOS 7.0, *)
let AVOutputSettingsPreset640x480: String
@available(iOS 7.0, *)
let AVOutputSettingsPreset960x540: String
@available(iOS 7.0, *)
let AVOutputSettingsPreset1280x720: String
@available(iOS 7.0, *)
let AVOutputSettingsPreset1920x1080: String
@available(iOS 9.0, *)
let AVOutputSettingsPreset3840x2160: String

/*!
	@class AVOutputSettingsAssistant
	@abstract
		A class, each instance of which specifies a set of parameters for configuring objects that use output settings dictionaries, for example AVAssetWriter & AVAssetWriterInput, so that the resulting media file conforms to some specific criteria
	@discussion
		Instances of AVOutputSettingsAssistant are typically created using a string constant representing a specific preset configuration, such as AVOutputSettingsPreset1280x720.  Once you have an instance, its properties can be used as a guide for creating and configuring an AVAssetWriter object and one or more AVAssetWriterInput objects.  If all the suggested properties are respected, the resulting media file will conform to the criteria implied by the preset.  Alternatively, the properties of an instance can be used as a "base" configuration which can be customized to suit your individual needs.
 
		The recommendations made by an instance get better as you tell it more about the format of your source data.  For example, if you set the sourceVideoFormat property, the recommendation made by the videoSettings property will ensure that your video frames are not scaled up from a smaller size.
 */
@available(iOS 7.0, *)
class AVOutputSettingsAssistant : Object {

  /*!
  	@method availableOutputSettingsPresets
  	@abstract
  		Returns the list of presets that can be used to create an instance of AVOutputSettingsAssistant
  	@result
  		An NSArray of NSString objects, each of which is a preset identifier
  	@discussion
  		Each preset in the returned list can be passed in to +outputSettingsAssistantWithPreset: to create a new instance of AVOutputSettingsAssistant.
   
  		On iOS, the returned array may be different between different device models.
   */
  @available(iOS 7.0, *)
  class func availableOutputSettingsPresets() -> [String]

  /*!
  	@method outputSettingsAssistantWithPreset:
  	@abstract
  		Returns an instance of AVOutputSettingsAssistant corresponding to the given preset
  	@param presetIdentifier
  		The string identifier, for example AVOutputSettingsPreset1280x720, for the desired preset
  	@result
  		An instance of AVOutputSettingsAssistant with properties corresponding to the given preset, or nil if there is no such available preset.
  	@discussion
  		The properties of the returned object can be used as a guide for creating and configuring an AVAssetWriter object and one or more AVAssetWriterInput objects.  If all the suggested properties are respected in creating the AVAssetWriter, the resulting media file will conform to the criteria implied by the preset.
   
  		Use +availableOutputSettingsPresets to get a list of presets identifiers that can be used with this method.
   */
  convenience init?(preset presetIdentifier: String)

  /*!
  	@property audioSettings
  	@abstract
  		A dictionary of key/value pairs, as specified in AVAudioSettings.h, to be used when e.g. creating an instance of AVAssetWriterInput
  	@discussion
  		The value of this property may change as a result of setting a new value for the sourceAudioFormat property.
   */
  var audioSettings: [String : AnyObject]? { get }

  /*!
  	@property videoSettings
  	@abstract
  		A dictionary of key/value pairs, as specified in AVVideoSettings.h, to be used when e.g. creating an instance of AVAssetWriterInput
  	@discussion
  		The value of this property may change as a result of setting a new value for the sourceVideoFormat property.
   */
  var videoSettings: [String : AnyObject]? { get }

  /*!
  	@property outputFileType
  	@abstract
  		A UTI indicating the type of file to be written, to be used when e.g. creating an instance of AVAssetWriter
  	@discussion
  		Use UTTypeCopyPreferredTagWithClass / kUTTagClassFilenameExtension to get a suitable file extension for a given file type.
   */
  var outputFileType: String { get }
}
extension AVOutputSettingsAssistant {

  /*!
  	@property sourceAudioFormat
  	@abstract
  		A CMAudioFormatDescription object describing the format of you audio data
  	@discussion
  		Setting this property will allow the receiver to make a more informed recommendation for the audio settings that should be used.  After setting this property, you should re-query the audioSettings property to get the new recommendation.  The default value is NULL, which means that the receiver does not know anything about the format of your audio data.
  
  		If you set a non-NULL value for this property, and are using the receiver to initialize an AVAssetWriterInput, the same format description should be used to initialize the AVAssetWriterInput, along with the dictionary from the audioSettings property.
   */
  var sourceAudioFormat: CMAudioFormatDescription?

  /*!
  	@property sourceVideoFormat
  	@abstract
  		A CMVideoFormatDescription object describing the format of your video data
  	@discussion
  		Setting this property will allow the receiver to make a more informed recommendation for the video settings that should be used.  After setting this property, you should re-query the videoSettings property to get the new recommendation.  The default value is NULL, which means that the receiver does not know anything about the format of your video data.
  
  		If you set a non-NULL value for this property, and are using the receiver to initialize an AVAssetWriterInput, the same format description should be used to initialize the AVAssetWriterInput, along with the dictionary from the videoSettings property.
   */
  var sourceVideoFormat: CMVideoFormatDescription?

  /*!
  	@property sourceVideoAverageFrameDuration
  	@abstract
  		A CMTime describing the average frame duration (reciprocal of average frame rate) of your video data
  	@discussion
  		Setting this property will allow the receiver to make a more informed recommendation for the video settings that should be used.  After setting this property, you should re-query the videoSettings property to get the new recommendation.
   
  		The default value is 1/30, which means that the receiver is assuming that your source video has an average frame rate of 30fps.
   
  		It is an error to set this property to a value that is not positive or not numeric.  See CMTIME_IS_NUMERIC.
   */
  var sourceVideoAverageFrameDuration: CMTime

  /*!
  	@property sourceVideoMinFrameDuration
  	@abstract
  		A CMTime describing the minimum frame duration (reciprocal of the maximum frame rate) of your video data
  	@discussion
  		Setting this property will allow the receiver to make a more informed recommendation for the video settings that should be used.  After setting this property, you should re-query the videoSettings property to get the new recommendation.
   
  		If your source of video data is an instance of AVAssetReaderOutput, you can discover the minimum frame duration of your source asset using the AVAssetTrack.minFrameDuration property.
   
  		The default value is 1/30, which means that the receiver is assuming that your source video has a maximum frame rate of 30fps.
   
  		It is an error to set this property to a value that is not positive or not numeric.  See CMTIME_IS_NUMERIC.
   */
  @available(iOS 7.0, *)
  var sourceVideoMinFrameDuration: CMTime
}

/*!
 @enum AVPlayerStatus
 @abstract
	These constants are returned by the AVPlayer status property to indicate whether it can successfully play items.
 
 @constant	 AVPlayerStatusUnknown
	Indicates that the status of the player is not yet known because it has not tried to load new media resources for
	playback.
 @constant	 AVPlayerStatusReadyToPlay
	Indicates that the player is ready to play AVPlayerItem instances.
 @constant	 AVPlayerStatusFailed
	Indicates that the player can no longer play AVPlayerItem instances because of an error. The error is described by
	the value of the player's error property.
 */
enum AVPlayerStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case ReadyToPlay
  case Failed
}
@available(iOS 4.0, *)
class AVPlayer : Object {

  /*!
  	@method			initWithURL:
  	@abstract		Initializes an AVPlayer that plays a single audiovisual resource referenced by URL.
  	@param			URL
  	@result			An instance of AVPlayer
  	@discussion		Implicitly creates an AVPlayerItem. Clients can obtain the AVPlayerItem as it becomes the player's currentItem.
  */
  init(url URL: URL)

  /*!
  	@method			initWithPlayerItem:
  	@abstract		Create an AVPlayer that plays a single audiovisual item.
  	@param			item
  	@result			An instance of AVPlayer
  	@discussion		Useful in order to play items for which an AVAsset has previously been created. See -[AVPlayerItem initWithAsset:].
  */
  init(playerItem item: AVPlayerItem)

  /*!
   @property status
   @abstract
  	The ability of the receiver to be used for playback.
   
   @discussion
  	The value of this property is an AVPlayerStatus that indicates whether the receiver can be used for playback. When
  	the value of this property is AVPlayerStatusFailed, the receiver can no longer be used for playback and a new
  	instance needs to be created in its place. When this happens, clients can check the value of the error property to
  	determine the nature of the failure. This property is key value observable.
   */
  var status: AVPlayerStatus { get }

  /*!
   @property error
   @abstract
  	If the receiver's status is AVPlayerStatusFailed, this describes the error that caused the failure.
   
   @discussion
  	The value of this property is an NSError that describes what caused the receiver to no longer be able to play items.
  	If the receiver's status is not AVPlayerStatusFailed, the value of this property is nil.
   */
  var error: Error? { get }
  init()
}
extension AVPlayer {
  var rate: Float

  /*!
  	@method			play
  	@abstract		Begins playback of the current item.
  	@discussion		Same as setting rate to 1.0.
  */
  func play()

  /*!
  	@method			pause
  	@abstract		Pauses playback.
  	@discussion		Same as setting rate to 0.0.
  */
  func pause()
}
extension AVPlayer {
  var currentItem: AVPlayerItem? { get }

  /*!
  	@method			replaceCurrentItemWithPlayerItem:
  	@abstract		Replaces the player's current item with the specified player item.
  	@param			item
  	  The AVPlayerItem that will become the player's current item.
  	@discussion
  	  In all releases of iOS 4, invoking replaceCurrentItemWithPlayerItem: with an AVPlayerItem that's already the receiver's currentItem results in an exception being raised. Starting with iOS 5, it's a no-op.
  */
  func replaceCurrentItemWith(item: AVPlayerItem?)
  var actionAtItemEnd: AVPlayerActionAtItemEnd
}

/*!
 @enum AVPlayerActionAtItemEnd
 @abstract
	These constants are the allowable values of AVPlayer's actionAtItemEnd property.
 
 @constant	 AVPlayerActionAtItemEndAdvance
	Indicates that when an AVPlayerItem reaches its end time the player will automatically advance to the next item in its queue.
	This value is supported only for players of class AVQueuePlayer. An AVPlayer that's not an AVQueuePlayer will raise an NSInvalidArgumentException if an attempt is made to set its actionAtItemEnd to AVPlayerActionAtItemEndAdvance.
 @constant	 AVPlayerActionAtItemEndPause
	Indicates that when an AVPlayerItem reaches its end time the player will automatically pause (which is to say, the player's
	rate will automatically be set to 0).
 @constant	 AVPlayerActionAtItemEndNone
	Indicates that when an AVPlayerItem reaches its end time the player will take no action (which is to say, the player's rate
	will not change, its currentItem will not change, and its currentTime will continue to be incremented or decremented as time
	elapses, according to its rate). After this, if the player's actionAtItemEnd is set to a value other than AVPlayerActionAtItemEndNone,
	the player will immediately take the action appropriate to that value.
*/
enum AVPlayerActionAtItemEnd : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Advance
  case Pause
  case None
}
extension AVPlayer {

  /*!
   @method			currentTime
   @abstract			Returns the current time of the current item.
   @result			A CMTime
   @discussion		Returns the current time of the current item. Not key-value observable; use -addPeriodicTimeObserverForInterval:queue:usingBlock: instead.
   */
  func currentTime() -> CMTime

  /*!
   @method			seekToDate:
   @abstract			Moves the playback cursor.
   @param				date
   @discussion		Use this method to seek to a specified time for the current player item.
  					The time seeked to may differ from the specified time for efficiency. For sample accurate seeking see seekToTime:toleranceBefore:toleranceAfter:.
   */
  func seekTo(date: Date)

  /*!
   @method			seekToDate:completionHandler:
   @abstract			Moves the playback cursor and invokes the specified block when the seek operation has either been completed or been interrupted.
   @param				date
   @param				completionHandler
   @discussion		Use this method to seek to a specified time for the current player item and to be notified when the seek operation is complete.
  					The completion handler for any prior seek request that is still in process will be invoked immediately with the finished parameter 
  					set to NO. If the new request completes without being interrupted by another seek request or by any other operation the specified 
  					completion handler will be invoked with the finished parameter set to YES. 
   */
  @available(iOS 5.0, *)
  func seekTo(date: Date, completionHandler: (Bool) -> Void)

  /*!
   @method			seekToTime:
   @abstract			Moves the playback cursor.
   @param				time
   @discussion		Use this method to seek to a specified time for the current player item.
  					The time seeked to may differ from the specified time for efficiency. For sample accurate seeking see seekToTime:toleranceBefore:toleranceAfter:.
   */
  func seekTo(time: CMTime)

  /*!
   @method			seekToTime:toleranceBefore:toleranceAfter:
   @abstract			Moves the playback cursor within a specified time bound.
   @param				time
   @param				toleranceBefore
   @param				toleranceAfter
   @discussion		Use this method to seek to a specified time for the current player item.
  					The time seeked to will be within the range [time-toleranceBefore, time+toleranceAfter] and may differ from the specified time for efficiency.
  					Pass kCMTimeZero for both toleranceBefore and toleranceAfter to request sample accurate seeking which may incur additional decoding delay. 
  					Messaging this method with beforeTolerance:kCMTimePositiveInfinity and afterTolerance:kCMTimePositiveInfinity is the same as messaging seekToTime: directly.
   */
  func seekTo(time: CMTime, toleranceBefore: CMTime, toleranceAfter: CMTime)

  /*!
   @method			seekToTime:completionHandler:
   @abstract			Moves the playback cursor and invokes the specified block when the seek operation has either been completed or been interrupted.
   @param				time
   @param				completionHandler
   @discussion		Use this method to seek to a specified time for the current player item and to be notified when the seek operation is complete.
  					The completion handler for any prior seek request that is still in process will be invoked immediately with the finished parameter 
  					set to NO. If the new request completes without being interrupted by another seek request or by any other operation the specified 
  					completion handler will be invoked with the finished parameter set to YES. 
   */
  @available(iOS 5.0, *)
  func seekTo(time: CMTime, completionHandler: (Bool) -> Void)

  /*!
   @method			seekToTime:toleranceBefore:toleranceAfter:completionHandler:
   @abstract			Moves the playback cursor within a specified time bound and invokes the specified block when the seek operation has either been completed or been interrupted.
   @param				time
   @param				toleranceBefore
   @param				toleranceAfter
   @discussion		Use this method to seek to a specified time for the current player item and to be notified when the seek operation is complete.
  					The time seeked to will be within the range [time-toleranceBefore, time+toleranceAfter] and may differ from the specified time for efficiency.
  					Pass kCMTimeZero for both toleranceBefore and toleranceAfter to request sample accurate seeking which may incur additional decoding delay. 
  					Messaging this method with beforeTolerance:kCMTimePositiveInfinity and afterTolerance:kCMTimePositiveInfinity is the same as messaging seekToTime: directly.
  					The completion handler for any prior seek request that is still in process will be invoked immediately with the finished parameter set to NO. If the new 
  					request completes without being interrupted by another seek request or by any other operation the specified completion handler will be invoked with the 
  					finished parameter set to YES.
   */
  @available(iOS 5.0, *)
  func seekTo(time: CMTime, toleranceBefore: CMTime, toleranceAfter: CMTime, completionHandler: (Bool) -> Void)
}
extension AVPlayer {

  /*!
  	@method			setRate:time:atHostTime:
  	@abstract		Simultaneously sets the playback rate and the relationship between the current item's current time and host time.
  	@discussion		You can use this function to synchronize playback with an external activity.
  	
  					The current item's timebase is adjusted so that its time will be (or was) itemTime when host time is (or was) hostClockTime.
  					In other words: if hostClockTime is in the past, the timebase's time will be interpolated as though the timebase has been running at the requested rate since that time.  If hostClockTime is in the future, the timebase will immediately start running at the requested rate from an earlier time so that it will reach the requested itemTime at the requested hostClockTime.  (Note that the item's time will not jump backwards, but instead will sit at itemTime until the timebase reaches that time.)
  
  					Note that advanced rate control is not currently supported for HTTP Live Streaming.
  	@param itemTime	The time to start playback from, specified precisely (i.e., with zero tolerance).
  					Pass kCMTimeInvalid to use the current item's current time.
  	@param hostClockTime
  					The host time at which to start playback.
  					If hostClockTime is specified, the player will not ensure that media data is loaded before the timebase starts moving.
  					If hostClockTime is kCMTimeInvalid, the rate and time will be set together, but without external synchronization;
  					a host time in the near future will be used, allowing some time for data media loading.
  */
  @available(iOS 6.0, *)
  func setRate(rate: Float, time itemTime: CMTime, atHostTime hostClockTime: CMTime)

  /*!
  	@method			prerollAtRate:completionHandler:
  	@abstract		Begins loading media data to prime the render pipelines for playback from the current time with the given rate.
  	@discussion		Once the completion handler is called with YES, the player's rate can be set with minimal latency.
  					The completion handler will be called with NO if the preroll is interrupted by a time change or incompatible rate change, or if preroll is not possible for some other reason.
  					Call this method only when the rate is currently zero and only after the AVPlayer's status has become AVPlayerStatusReadyToPlay.
  
  					Note that advanced rate control is not currently supported for HTTP Live Streaming.
  	@param rate		The intended rate for subsequent playback.
  	@param completionHandler
  					The block that will be called when the preroll is either completed or is interrupted.
  */
  @available(iOS 6.0, *)
  func prerollAtRate(rate: Float, completionHandler: ((Bool) -> Void)? = nil)

  /*!
  	@method			cancelPendingPrerolls
  	@abstract		Cancel any pending preroll requests and invoke the corresponding completion handlers if present.
  	@discussion		Use this method to cancel and release the completion handlers for pending prerolls. The finished parameter of the completion handlers will be set to NO.
  */
  @available(iOS 6.0, *)
  func cancelPendingPrerolls()
  @available(iOS 6.0, *)
  var masterClock: CMClock?
}
extension AVPlayer {

  /*!
  	@method			addPeriodicTimeObserverForInterval:queue:usingBlock:
  	@abstract		Requests invocation of a block during playback to report changing time.
  	@param			interval
  	  The interval of invocation of the block during normal playback, according to progress of the current time of the player.
  	@param			queue
  	  The serial queue onto which block should be enqueued.  If you pass NULL, the main queue (obtained using dispatch_get_main_queue()) will be used.  Passing a
  	  concurrent queue to this method will result in undefined behavior.
  	@param			block
  	  The block to be invoked periodically.
  	@result
  	  An object conforming to the NSObject protocol.  You must retain this returned value as long as you want the time observer to be invoked by the player.
  	  Pass this object to -removeTimeObserver: to cancel time observation.
  	@discussion		The block is invoked periodically at the interval specified, interpreted according to the timeline of the current item.
  					The block is also invoked whenever time jumps and whenever playback starts or stops.
  					If the interval corresponds to a very short interval in real time, the player may invoke the block less frequently
  					than requested. Even so, the player will invoke the block sufficiently often for the client to update indications
  					of the current time appropriately in its end-user interface.
  					Each call to -addPeriodicTimeObserverForInterval:queue:usingBlock: should be paired with a corresponding call to -removeTimeObserver:.
  					Releasing the observer object without a call to -removeTimeObserver: will result in undefined behavior.
  */
  func addPeriodicTimeObserverForInterval(interval: CMTime, queue: dispatch_queue_t?, usingBlock block: (CMTime) -> Void) -> AnyObject

  /*!
  	@method			addBoundaryTimeObserverForTimes:queue:usingBlock:
  	@abstract		Requests invocation of a block when specified times are traversed during normal playback.
  	@param			times
  	  The times for which the observer requests notification, supplied as an array of NSValues carrying CMTimes.
  	@param			queue
  	  The serial queue onto which block should be enqueued.  If you pass NULL, the main queue (obtained using dispatch_get_main_queue()) will be used.  Passing a
  	  concurrent queue to this method will result in undefined behavior.
  	@param			block
  	  The block to be invoked when any of the specified times is crossed during normal playback.
  	@result
  	  An object conforming to the NSObject protocol.  You must retain this returned value as long as you want the time observer to be invoked by the player.
  	  Pass this object to -removeTimeObserver: to cancel time observation.
  	@discussion		Each call to -addPeriodicTimeObserverForInterval:queue:usingBlock: should be paired with a corresponding call to -removeTimeObserver:.
  					Releasing the observer object without a call to -removeTimeObserver: will result in undefined behavior.
  */
  func addBoundaryTimeObserverForTimes(times: [Value], queue: dispatch_queue_t?, usingBlock block: () -> Void) -> AnyObject

  /*!
  	@method			removeTimeObserver:
  	@abstract		Cancels a previously registered time observer.
  	@param			observer
  	  An object returned by a previous call to -addPeriodicTimeObserverForInterval:queue:usingBlock: or -addBoundaryTimeObserverForTimes:queue:usingBlock:.
  	@discussion		Upon return, the caller is guaranteed that no new time observer blocks will begin executing.  Depending on the calling thread and the queue
  					used to add the time observer, an in-flight block may continue to execute after this method returns.  You can guarantee synchronous time 
  					observer removal by enqueuing the call to -removeTimeObserver: on that queue.  Alternatively, call dispatch_sync(queue, ^{}) after
  					-removeTimeObserver: to wait for any in-flight blocks to finish executing.
  					-removeTimeObserver: should be used to explicitly cancel each time observer added using -addPeriodicTimeObserverForInterval:queue:usingBlock:
  					and -addBoundaryTimeObserverForTimes:queue:usingBlock:.
  */
  func removeTimeObserver(observer: AnyObject)
}
extension AVPlayer {
  @available(iOS 7.0, *)
  var volume: Float
  @available(iOS 7.0, *)
  var isMuted: Bool
  var isClosedCaptionDisplayEnabled: Bool
}
extension AVPlayer {
  @available(iOS 7.0, *)
  var appliesMediaSelectionCriteriaAutomatically: Bool

  /*!
   @method     setMediaSelectionCriteria:forMediaCharacteristic:
   @abstract   Applies automatic selection criteria for media that has the specified media characteristic.
   @param      criteria
     An instance of AVPlayerMediaSelectionCriteria.
   @param      mediaCharacteristic
     The media characteristic for which the selection criteria are to be applied. Supported values include AVMediaCharacteristicAudible, AVMediaCharacteristicLegible, and AVMediaCharacteristicVisual.
   @discussion
  	Criteria will be applied to an AVPlayerItem when:
  		a) It is made ready to play
  		b) Specific media selections are made by -[AVPlayerItem selectMediaOption:inMediaSelectionGroup:] in a different group. The automatic choice in one group may be influenced by a specific selection in another group.
  		c) Underlying system preferences change, e.g. system language, accessibility captions.
  
     Specific selections made by -[AVPlayerItem selectMediaOption:inMediaSelectionGroup:] within any group will override automatic selection in that group until -[AVPlayerItem selectMediaOptionAutomaticallyInMediaSelectionGroup:] is received.
  */
  @available(iOS 7.0, *)
  func setMediaSelectionCriteria(criteria: AVPlayerMediaSelectionCriteria?, forMediaCharacteristic mediaCharacteristic: String)

  /*!
   @method     mediaSelectionCriteriaForMediaCharacteristic:
   @abstract   Returns the automatic selection criteria for media that has the specified media characteristic.
   @param      mediaCharacteristic
    The media characteristic for which the selection criteria is to be returned. Supported values include AVMediaCharacteristicAudible, AVMediaCharacteristicLegible, and AVMediaCharacteristicVisual.
  */
  @available(iOS 7.0, *)
  func mediaSelectionCriteriaForMediaCharacteristic(mediaCharacteristic: String) -> AVPlayerMediaSelectionCriteria?
}
extension AVPlayer {
}
extension AVPlayer {
  @available(iOS 6.0, *)
  var allowsExternalPlayback: Bool
  @available(iOS 6.0, *)
  var isExternalPlaybackActive: Bool { get }
  @available(iOS 6.0, *)
  var usesExternalPlaybackWhileExternalScreenIsActive: Bool
  @available(iOS 6.0, *)
  var externalPlaybackVideoGravity: String
}
extension AVPlayer {
}
extension AVPlayer {

  /*!
  	@property outputObscuredDueToInsufficientExternalProtection
  	@abstract
  		Whether or not decoded output is being obscured due to insufficient external protection.
   
  	@discussion
  		The value of this property indicates whether the player is purposefully obscuring the visual output
  		of the current item because the requirement for an external protection mechanism is not met by the
  		current device configuration. It is highly recommended that clients whose content requires external
  		protection observe this property and set the playback rate to zero and display an appropriate user
  		interface when the value changes to YES. This property is key value observable.
  
  		Note that the value of this property is dependent on the external protection requirements of the
  		current item. These requirements are inherent to the content itself and cannot be externally specified.
  		If the current item does not require external protection, the value of this property will be NO.
   */
  @available(iOS 6.0, *)
  var outputObscuredDueToInsufficientExternalProtection: Bool { get }
}
@available(iOS 4.1, *)
class AVQueuePlayer : AVPlayer {

  /*!
      @method     initWithItems:
      @abstract   Initializes an instance of AVQueuePlayer by enqueueing the AVPlayerItems from the specified array.
      @param      items
        An NSArray of AVPlayerItems with which to populate the player's queue initially.
      @result
        An instance of AVQueuePlayer.
  */
  init(items: [AVPlayerItem])

  /*!
      @method     items
      @abstract   Provides an array of the currently enqueued items.
      @result     An NSArray containing the enqueued AVPlayerItems.
  */
  func items() -> [AVPlayerItem]

  /*!
      @method     advanceToNextItem
      @abstract   Ends playback of the current item and initiates playback of the next item in the player's queue.
      @discussion Removes the current item from the play queue.
  */
  func advanceToNextItem()

  /*!
      @method     canInsertItem:afterItem:
      @abstract   Tests whether an AVPlayerItem can be inserted into the player's queue.
      @param      item
        The AVPlayerItem to be tested.
      @param      afterItem
        The item that the item to be tested is to follow in the queue. Pass nil to test whether the item can be appended to the queue.
      @result
        An indication of whether the item can be inserted into the queue after the specified item.
      @discussion
        Note that adding the same AVPlayerItem to an AVQueuePlayer at more than one position in the queue is not supported.
  */
  func canInsertItem(item: AVPlayerItem, after afterItem: AVPlayerItem?) -> Bool

  /*!
      @method     insertItem:afterItem:
      @abstract   Places an AVPlayerItem after the specified item in the queue.
      @param      item
        The item to be inserted.
      @param      afterItem
        The item that the newly inserted item should follow in the queue. Pass nil to append the item to the queue.
  */
  func insertItem(item: AVPlayerItem, after afterItem: AVPlayerItem?)

  /*!
      @method     removeItem:
      @abstract   Removes an AVPlayerItem from the queue.
      @param      item
        The item to be removed.
      @discussion
        If the item to be removed is currently playing, has the same effect as -advanceToNextItem.
  */
  func removeItem(item: AVPlayerItem)

  /*!
      @method     removeAllItems
      @abstract   Removes all items from the queue.
      @discussion Stops playback by the target.
  */
  func removeAllItems()

  /*!
  	@method			initWithURL:
  	@abstract		Initializes an AVPlayer that plays a single audiovisual resource referenced by URL.
  	@param			URL
  	@result			An instance of AVPlayer
  	@discussion		Implicitly creates an AVPlayerItem. Clients can obtain the AVPlayerItem as it becomes the player's currentItem.
  */
  init(url URL: URL)

  /*!
  	@method			initWithPlayerItem:
  	@abstract		Create an AVPlayer that plays a single audiovisual item.
  	@param			item
  	@result			An instance of AVPlayer
  	@discussion		Useful in order to play items for which an AVAsset has previously been created. See -[AVPlayerItem initWithAsset:].
  */
  init(playerItem item: AVPlayerItem)
  init()
}
@available(iOS 5.0, *)
let AVPlayerItemTimeJumpedNotification: String
@available(iOS 4.0, *)
let AVPlayerItemDidPlayToEndTimeNotification: String
@available(iOS 4.3, *)
let AVPlayerItemFailedToPlayToEndTimeNotification: String
@available(iOS 6.0, *)
let AVPlayerItemPlaybackStalledNotification: String
@available(iOS 6.0, *)
let AVPlayerItemNewAccessLogEntryNotification: String
@available(iOS 6.0, *)
let AVPlayerItemNewErrorLogEntryNotification: String
@available(iOS 4.3, *)
let AVPlayerItemFailedToPlayToEndTimeErrorKey: String

/*!
 @enum AVPlayerItemStatus
 @abstract
	These constants are returned by the AVPlayerItem status property to indicate whether it can successfully be played.
 
 @constant	 AVPlayerItemStatusUnknown
	Indicates that the status of the player item is not yet known because it has not tried to load new media resources
	for playback.
 @constant	 AVPlayerItemStatusReadyToPlay
	Indicates that the player item is ready to be played.
 @constant	 AVPlayerItemStatusFailed
	Indicates that the player item can no longer be played because of an error. The error is described by the value of
	the player item's error property.
 */
enum AVPlayerItemStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case ReadyToPlay
  case Failed
}
@available(iOS 4.0, *)
class AVPlayerItem : Object, Copying {

  /*!
   @method		initWithURL:
   @abstract		Initializes an AVPlayerItem with an NSURL.
   @param			URL
   @result		An instance of AVPlayerItem
   @discussion	Equivalent to -initWithAsset:, passing [AVAsset assetWithURL:URL] as the value of asset.
   */
  convenience init(url URL: URL)

  /*!
   @method		initWithAsset:
   @abstract		Initializes an AVPlayerItem with an AVAsset.
   @param			asset
   @result		An instance of AVPlayerItem
   @discussion	Equivalent to -initWithAsset:automaticallyLoadedAssetKeys:, passing @[ @"duration" ] as the value of automaticallyLoadedAssetKeys.
   */
  convenience init(asset: AVAsset)

  /*!
   @method		initWithAsset:automaticallyLoadedAssetKeys:
   @abstract		Initializes an AVPlayerItem with an AVAsset.
   @param			asset
   				An instance of AVAsset.
   @param			automaticallyLoadedAssetKeys
   				An NSArray of NSStrings, each representing a property key defined by AVAsset. See AVAsset.h for property keys, e.g. duration.
   @result		An instance of AVPlayerItem
   @discussion	The value of each key in automaticallyLoadedAssetKeys will be automatically be loaded by the underlying AVAsset before the receiver achieves the status AVPlayerItemStatusReadyToPlay; i.e. when the item is ready to play, the value of -[[AVPlayerItem asset] statusOfValueForKey:error:] will be one of the terminal status values greater than AVKeyValueStatusLoading.
   */
  @available(iOS 7.0, *)
  init(asset: AVAsset, automaticallyLoadedAssetKeys: [String]?)

  /*!
   @property status
   @abstract
  	The ability of the receiver to be used for playback.
   
   @discussion
  	The value of this property is an AVPlayerItemStatus that indicates whether the receiver can be used for playback.
  	When the value of this property is AVPlayerItemStatusFailed, the receiver can no longer be used for playback and
  	a new instance needs to be created in its place. When this happens, clients can check the value of the error
  	property to determine the nature of the failure. This property is key value observable.
   */
  var status: AVPlayerItemStatus { get }

  /*!
   @property error
   @abstract
  	If the receiver's status is AVPlayerItemStatusFailed, this describes the error that caused the failure.
   
   @discussion
  	The value of this property is an NSError that describes what caused the receiver to no longer be able to be played.
  	If the receiver's status is not AVPlayerItemStatusFailed, the value of this property is nil.
   */
  var error: Error? { get }
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
extension AVPlayerItem {

  /*!
   @property asset
   @abstract Accessor for underlying AVAsset.
   */
  var asset: AVAsset { get }

  /*!
   @property tracks
   @abstract Provides array of AVPlayerItem tracks. Observable (can change dynamically during playback).
  	
   @discussion
  	The value of this property will accord with the properties of the underlying media resource when the receiver becomes ready to play.
  	Before the underlying media resource has been sufficiently loaded, its value is an empty NSArray. Use key-value observation to obtain
  	a valid array of tracks as soon as it becomes available.
   */
  var tracks: [AVPlayerItemTrack] { get }

  /*!
   @property duration
   @abstract Indicates the duration of the item, not considering either its forwardPlaybackEndTime or reversePlaybackEndTime.
   
   @discussion
  	This property is observable. The duration of an item can change dynamically during playback.
  	
  	Unless you omit @"duration" from the array of asset keys you pass to +playerItemWithAsset:automaticallyLoadedAssetKeys: or
  	-initWithAsset:automaticallyLoadedAssetKeys:, the value of this property will accord with the properties of the underlying
  	AVAsset and the current state of playback once the receiver becomes ready to play.
  
  	Before the underlying duration has been loaded, the value of this property is kCMTimeIndefinite. Use key-value observation to
  	obtain a valid duration as soon as it becomes available. (Note that the value of duration may remain kCMTimeIndefinite,
  	e.g. for live streams.)
   */
  @available(iOS 4.3, *)
  var duration: CMTime { get }

  /*!
   @property presentationSize
   @abstract The size of the receiver as presented by the player.
   
   @discussion 
  	Indicates the size at which the visual portion of the item is presented by the player; can be scaled from this 
  	size to fit within the bounds of an AVPlayerLayer via its videoGravity property. Can be scaled arbitarily for presentation
  	via the frame property of an AVPlayerLayer.
  	
  	The value of this property will accord with the properties of the underlying media resource when the receiver becomes ready to play.
  	Before the underlying media resource is sufficiently loaded, its value is CGSizeZero. Use key-value observation to obtain a valid
  	presentationSize as soon as it becomes available. (Note that the value of presentationSize may remain CGSizeZero, e.g. for audio-only items.)
   */
  var presentationSize: CGSize { get }

  /*!
   @property timedMetadata
   @abstract Provides an NSArray of AVMetadataItems representing the timed metadata encountered most recently within the media as it plays. May be nil.
   @discussion
     Notifications of changes are available via key-value observation.
     As an optimization for playback, AVPlayerItem may omit the processing of timed metadata when no observer of this property is registered. Therefore, when no such observer is registered, the value of the timedMetadata property may remain nil regardless of the contents of the underlying media.
   */
  var timedMetadata: [AVMetadataItem]? { get }

  /*!
   @property automaticallyLoadedAssetKeys
   @abstract An array of property keys defined on AVAsset. The value of each key in the array is automatically loaded while the receiver is being made ready to play.
   @discussion
     The value of each key in automaticallyLoadedAssetKeys will be automatically be loaded by the underlying AVAsset before the receiver achieves the status AVPlayerItemStatusReadyToPlay; i.e. when the item is ready to play, the value of -[[AVPlayerItem asset] statusOfValueForKey:error:] will be AVKeyValueStatusLoaded. If loading of any of the values fails, the status of the AVPlayerItem will change instead to AVPlayerItemStatusFailed..
   */
  @available(iOS 7.0, *)
  var automaticallyLoadedAssetKeys: [String] { get }
}
extension AVPlayerItem {
  @available(iOS 5.0, *)
  var canPlayFastForward: Bool { get }
  @available(iOS 6.0, *)
  var canPlaySlowForward: Bool { get }
  @available(iOS 6.0, *)
  var canPlayReverse: Bool { get }
  @available(iOS 6.0, *)
  var canPlaySlowReverse: Bool { get }
  @available(iOS 5.0, *)
  var canPlayFastReverse: Bool { get }
  @available(iOS 6.0, *)
  var canStepForward: Bool { get }
  @available(iOS 6.0, *)
  var canStepBackward: Bool { get }
}
extension AVPlayerItem {

  /*!
   @method			currentTime
   @abstract			Returns the current time of the item.
   @result			A CMTime
   @discussion		Returns the current time of the item.
   */
  func currentTime() -> CMTime

  /*!
   @property forwardPlaybackEndTime
   @abstract
  	The end time for forward playback.
   
   @discussion
  	Specifies the time at which playback should end when the playback rate is positive (see AVPlayer's rate property).
  	The default value is kCMTimeInvalid, which indicates that no end time for forward playback is specified.
  	In this case, the effective end time for forward playback is the receiver's duration.
  	
  	When the end time is reached, the receiver will post AVPlayerItemDidPlayToEndTimeNotification and the AVPlayer will take
  	the action indicated by the value of its actionAtItemEnd property (see AVPlayerActionAtItemEnd in AVPlayer.h). 
  
  	The value of this property has no effect on playback when the rate is negative.
   */
  var forwardPlaybackEndTime: CMTime

  /*!
   @property reversePlaybackEndTime
   @abstract
  	The end time for reverse playback.
   
   @discussion
  	Specifies the time at which playback should end when the playback rate is negative (see AVPlayer's rate property).
  	The default value is kCMTimeInvalid, which indicates that no end time for reverse playback is specified.
  	In this case, the effective end time for reverse playback is kCMTimeZero.
  
  	When the end time is reached, the receiver will post AVPlayerItemDidPlayToEndTimeNotification and the AVPlayer will take
  	the action indicated by the value of its actionAtItemEnd property (see AVPlayerActionAtItemEnd in AVPlayer.h). 
  
  	The value of this property has no effect on playback when the rate is positive.
   */
  var reversePlaybackEndTime: CMTime

  /*!
   @property seekableTimeRanges
   @abstract This property provides a collection of time ranges that the player item can seek to. The ranges provided might be discontinous.
   @discussion Returns an NSArray of NSValues containing CMTimeRanges.
   */
  var seekableTimeRanges: [Value] { get }

  /*!
   @method			seekToTime:
   @abstract			Moves the playback cursor.
   @param				time
   @discussion		Use this method to seek to a specified time for the item.
  					The time seeked to may differ from the specified time for efficiency. For sample accurate seeking see seekToTime:toleranceBefore:toleranceAfter:.
   */
  func seekTo(time: CMTime)

  /*!
   @method			seekToTime:completionHandler:
   @abstract			Moves the playback cursor and invokes the specified block when the seek operation has either been completed or been interrupted.
   @param				time
   @param				completionHandler
   @discussion		Use this method to seek to a specified time for the item and to be notified when the seek operation is complete.
   					The completion handler for any prior seek request that is still in process will be invoked immediately with the finished parameter 
   					set to NO. If the new request completes without being interrupted by another seek request or by any other operation the specified 
   					completion handler will be invoked with the finished parameter set to YES. 
   */
  @available(iOS 5.0, *)
  func seekTo(time: CMTime, completionHandler: (Bool) -> Void)

  /*!
   @method			seekToTime:toleranceBefore:toleranceAfter:
   @abstract			Moves the playback cursor within a specified time bound.
   @param				time
   @param				toleranceBefore
   @param				toleranceAfter
   @discussion		Use this method to seek to a specified time for the item.
  					The time seeked to will be within the range [time-toleranceBefore, time+toleranceAfter] and may differ from the specified time for efficiency.
  					Pass kCMTimeZero for both toleranceBefore and toleranceAfter to request sample accurate seeking which may incur additional decoding delay. 
  					Messaging this method with beforeTolerance:kCMTimePositiveInfinity and afterTolerance:kCMTimePositiveInfinity is the same as messaging seekToTime: directly.
  					Seeking is constrained by the collection of seekable time ranges. If you seek to a time outside all of the seekable ranges the seek will result in a currentTime
  					within the seekable ranges.
   */
  func seekTo(time: CMTime, toleranceBefore: CMTime, toleranceAfter: CMTime)

  /*!
   @method			seekToTime:toleranceBefore:toleranceAfter:completionHandler:
   @abstract			Moves the playback cursor within a specified time bound and invokes the specified block when the seek operation has either been completed or been interrupted.
   @param				time
   @param				toleranceBefore
   @param				toleranceAfter
   @param				completionHandler
   @discussion		Use this method to seek to a specified time for the item and to be notified when the seek operation is complete.
  					The time seeked to will be within the range [time-toleranceBefore, time+toleranceAfter] and may differ from the specified time for efficiency.
  					Pass kCMTimeZero for both toleranceBefore and toleranceAfter to request sample accurate seeking which may incur additional decoding delay. 
  					Messaging this method with beforeTolerance:kCMTimePositiveInfinity and afterTolerance:kCMTimePositiveInfinity is the same as messaging seekToTime: directly.
  					The completion handler for any prior seek request that is still in process will be invoked immediately with the finished parameter set to NO. If the new 
  					request completes without being interrupted by another seek request or by any other operation the specified completion handler will be invoked with the 
  					finished parameter set to YES.
   */
  @available(iOS 5.0, *)
  func seekTo(time: CMTime, toleranceBefore: CMTime, toleranceAfter: CMTime, completionHandler: (Bool) -> Void)

  /*!
   @method			cancelPendingSeeks
   @abstract			Cancel any pending seek requests and invoke the corresponding completion handlers if present.
   @discussion		Use this method to cancel and release the completion handlers of pending seeks. The finished parameter of the completion handlers will
   					be set to NO.
   */
  @available(iOS 5.0, *)
  func cancelPendingSeeks()

  /*!
  	@method	currentDate
  	@abstract	If currentTime is mapped to a particular (real-time) date, return that date.
  	@result		Returns the date of current playback, or nil if playback is not mapped to any date.
  */
  func currentDate() -> Date?

  /*!
   @method		seekToDate
   @abstract		move playhead to a point corresponding to a particular date.
   @discussion
     For playback content that is associated with a range of dates, move the
     playhead to point within that range. Will fail if the supplied date is outside
     the range or if the content is not associated with a range of dates.
   @param			date	The new position for the playhead.
   @result		Returns true if the playhead was moved to the supplied date.
   */
  func seekTo(date: Date) -> Bool

  /*!
   @method		seekToDate:completionHandler:
   @abstract		move playhead to a point corresponding to a particular date, and invokes the specified block when the seek operation has either been completed or been interrupted.
   @discussion
     For playback content that is associated with a range of dates, move the
     playhead to point within that range and invokes the completion handler when the seek operation is complete. 
     Will fail if the supplied date is outside the range or if the content is not associated with a range of dates.  
     The completion handler for any prior seek request that is still in process will be invoked immediately with the finished parameter 
     set to NO. If the new request completes without being interrupted by another seek request or by any other operation, the specified 
     completion handler will be invoked with the finished parameter set to YES. 
   @param			date				The new position for the playhead.
   @param			completionHandler	The block to invoke when seek operation is complete
   @result		Returns true if the playhead was moved to the supplied date.
   */
  @available(iOS 6.0, *)
  func seekTo(date: Date, completionHandler: (Bool) -> Void) -> Bool

  /*!
   @method		stepByCount:
   @abstract		Moves player's current item's current time forward or backward by the specified number of steps.
   @param 		stepCount
     The number of steps by which to move. A positive number results in stepping forward, a negative number in stepping backward.
   @discussion
     The size of each step depends on the enabled AVPlayerItemTracks of the AVPlayerItem. 
   */
  func stepByCount(stepCount: Int)

  /*!
   @property		timebase
   @abstract		The item's timebase.
   @discussion 
     You can examine the timebase to discover the relationship between the item's time and the master clock used for drift synchronization.
     This timebase is read-only; you cannot set its time or rate to affect playback.  The value of this property may change during playback.
   */
  @available(iOS 6.0, *)
  var timebase: CMTimebase? { get }
}
extension AVPlayerItem {

  /*!
   @property videoComposition
   @abstract Indicates the video composition settings to be applied during playback.
   */
  @NSCopying var videoComposition: AVVideoComposition?

  /*!
   @property customVideoCompositor
   @abstract Indicates the custom video compositor instance.
   @discussion
   	This property is nil if there is no video compositor, or if the internal video compositor is in use. This reference can be used to provide
  	extra context to the custom video compositor instance if required.
   */
  @available(iOS 7.0, *)
  var customVideoCompositor: AVVideoCompositing? { get }

  /*!
   @property seekingWaitsForVideoCompositionRendering
   @abstract Indicates whether the item's timing follows the displayed video frame when seeking with a video composition
   @discussion
     By default, item timing is updated as quickly as possible, not waiting for media at new times to be rendered when seeking or 
     during normal playback. The latency that occurs, for example, between the completion of a seek operation and the display of a 
     video frame at a new time is negligible in most situations. However, when video compositions are in use, the processing of 
     video for any particular time may introduce noticeable latency. Therefore it may be desirable when a video composition is in 
     use for the item's timing be updated only after the video frame for a time has been displayed. This allows, for instance, an 
     AVSynchronizedLayer associated with an AVPlayerItem to remain in synchronization with the displayed video and for the 
     currentTime property to return the time of the displayed video.
  
     This property has no effect on items for which videoComposition is nil.
  
   */
  @available(iOS 6.0, *)
  var seekingWaitsForVideoCompositionRendering: Bool

  /*!
   @property textStyleRules
   @abstract An array of AVTextStyleRules representing text styling that can be applied to subtitles and other legible media.
   @discussion
  	The styling information contained in each AVTextStyleRule object in the array is used only when no equivalent styling information is provided by the media resource being played.  For example, if the text style rules specify Courier font but the media resource specifies Helvetica font, the text will be drawn using Helvetica font.
   
  	This property has an effect only for tracks with media subtype kCMSubtitleFormatType_WebVTT.
  */
  @available(iOS 6.0, *)
  var textStyleRules: [AVTextStyleRule]?
}
extension AVPlayerItem {

  /*!
   @property	audioTimePitchAlgorithm
   @abstract	Indicates the processing algorithm used to manage audio pitch at varying rates and for scaled audio edits.
   @discussion
     Constants for various time pitch algorithms, e.g. AVAudioTimePitchSpectral, are defined in AVAudioProcessingSettings.h.
     The default value on iOS is AVAudioTimePitchAlgorithmLowQualityZeroLatency and on OS X is AVAudioTimePitchAlgorithmSpectral.
  */
  @available(iOS 7.0, *)
  var audioTimePitchAlgorithm: String

  /*!
   @property audioMix
   @abstract Indicates the audio mix parameters to be applied during playback
   @discussion
     The inputParameters of the AVAudioMix must have trackIDs that correspond to a track of the receiver's asset. Otherwise they will be ignored. (See AVAudioMix.h for the declaration of AVAudioMixInputParameters and AVPlayerItem's asset property.)
   */
  @NSCopying var audioMix: AVAudioMix?
}
extension AVPlayerItem {

  /*!
   @property loadedTimeRanges
   @abstract This property provides a collection of time ranges for which the player has the media data readily available. The ranges provided might be discontinuous.
   @discussion Returns an NSArray of NSValues containing CMTimeRanges.
   */
  var loadedTimeRanges: [Value] { get }

  /*!
   @property playbackLikelyToKeepUp
   @abstract Indicates whether the item will likely play through without stalling.
   @discussion This property communicates a prediction of playability. Factors considered in this prediction
  	include I/O throughput and media decode performance. It is possible for playbackLikelyToKeepUp to
  	indicate NO while the property playbackBufferFull indicates YES. In this event the playback buffer has
  	reached capacity but there isn't the statistical data to support a prediction that playback is likely to 
  	keep up. It is left to the application programmer to decide to continue media playback or not. 
  	See playbackBufferFull below.
    */
  var isPlaybackLikelyToKeepUp: Bool { get }

  /*! 
   @property playbackBufferFull
   @abstract Indicates that the internal media buffer is full and that further I/O is suspended.
   @discussion This property reports that the data buffer used for playback has reach capacity.
  	Despite the playback buffer reaching capacity there might not exist sufficient statistical 
  	data to support a playbackLikelyToKeepUp prediction of YES. See playbackLikelyToKeepUp above.
   */
  var isPlaybackBufferFull: Bool { get }
  var isPlaybackBufferEmpty: Bool { get }

  /*!
   @property canUseNetworkResourcesForLiveStreamingWhilePaused
   @abstract Indicates whether the player item can use network resources to keep playback state up to date while paused
   @discussion
  	For live streaming content, the player item may need to use extra networking and power resources to keep playback state up to date when paused.  For example, when this property is set to YES, the seekableTimeRanges property will be periodically updated to reflect the current state of the live stream.
   
  	For clients linked on or after OS X 10.11 or iOS 9.0, the default value is NO.  To minimize power usage, avoid setting this property to YES when you do not need playback state to stay up to date while paused.
   */
  @available(iOS 9.0, *)
  var canUseNetworkResourcesForLiveStreamingWhilePaused: Bool
}
extension AVPlayerItem {

  /*!
   @property preferredPeakBitRate
   @abstract Indicates the desired limit of network bandwidth consumption for this item.
  
   @discussion
  	Set preferredPeakBitRate to non-zero to indicate that the player should attempt to limit item playback to that bit rate, expressed in bits per second.
  
  	If network bandwidth consumption cannot be lowered to meet the preferredPeakBitRate, it will be reduced as much as possible while continuing to play the item.
  */
  @available(iOS 8.0, *)
  var preferredPeakBitRate: Double
}
extension AVPlayerItem {

  /*!
   @method		selectMediaOption:inMediaSelectionGroup:
   @abstract
     Selects the media option described by the specified instance of AVMediaSelectionOption in the specified AVMediaSelectionGroup and deselects all other options in that group.
   @param 		mediaSelectionOption	The option to select.
   @param 		mediaSelectionGroup		The media selection group, obtained from the receiver's asset, that contains the specified option.
   @discussion
     If the specified media selection option isn't a member of the specified media selection group, no change in presentation state will result.
     If the value of the property allowsEmptySelection of the AVMediaSelectionGroup is YES, you can pass nil for mediaSelectionOption to deselect
     all media selection options in the group.
     Note that if multiple options within a group meet your criteria for selection according to locale or other considerations, and if these options are otherwise indistinguishable to you according to media characteristics that are meaningful for your application, content is typically authored so that the first available option that meets your criteria is appropriate for selection.
   */
  @available(iOS 5.0, *)
  func selectMediaOption(mediaSelectionOption: AVMediaSelectionOption?, in mediaSelectionGroup: AVMediaSelectionGroup)

  /*!
   @method		selectMediaOptionAutomaticallyInMediaSelectionGroup:
   @abstract
      Selects the media option in the specified media selection group that best matches the AVPlayer's current automatic selection criteria. Also allows automatic selection to be re-applied to the specified group subsequently if the relevant criteria are changed.
   @param 		mediaSelectionGroup		The media selection group, obtained from the receiver's asset, that contains the specified option.
   @discussion
     Has no effect unless the appliesMediaSelectionCriteriaAutomatically property of the associated AVPlayer is YES and unless automatic media selection has previously been overridden via -[AVPlayerItem selectMediaOption:inMediaSelectionGroup:].
   */
  @available(iOS 7.0, *)
  func selectMediaOptionAutomaticallyIn(mediaSelectionGroup: AVMediaSelectionGroup)

  /*!
   @method		selectedMediaOptionInMediaSelectionGroup:
   @abstract		Indicates the media selection option that's currently selected from the specified group. May be nil.
   @param 		mediaSelectionGroup		A media selection group obtained from the receiver's asset.
   @result		An instance of AVMediaSelectionOption that describes the currently selection option in the group.
   @discussion
     If the value of the property allowsEmptySelection of the AVMediaSelectionGroup is YES, the currently selected option in the group may be nil.
   */
  @available(iOS 5.0, *)
  func selectedMediaOptionIn(mediaSelectionGroup: AVMediaSelectionGroup) -> AVMediaSelectionOption?

  /*!
    @property		currentMediaSelection
    @abstract		Provides an instance of AVMediaSelection carrying current selections for each of the receiver's media selection groups.
  */
  @available(iOS 9.0, *)
  var currentMediaSelection: AVMediaSelection { get }
}
extension AVPlayerItem {

  /*!
   @method		accessLog
   @abstract		Returns an object that represents a snapshot of the network access log. Can be nil.
   @discussion	An AVPlayerItemAccessLog provides methods to retrieve the network access log in a format suitable for serialization.
   				If nil is returned then there is no logging information currently available for this AVPlayerItem.
  				An AVPlayerItemNewAccessLogEntryNotification will be posted when new logging information becomes available. However, accessLog might already return a non-nil value even before the first notification is posted.
   @result		An autoreleased AVPlayerItemAccessLog instance.
   */
  @available(iOS 4.3, *)
  func accessLog() -> AVPlayerItemAccessLog?

  /*!
   @method		errorLog
   @abstract		Returns an object that represents a snapshot of the error log. Can be nil.
   @discussion	An AVPlayerItemErrorLog provides methods to retrieve the error log in a format suitable for serialization.
   				If nil is returned then there is no logging information currently available for this AVPlayerItem.
   @result		An autoreleased AVPlayerItemErrorLog instance.
   */
  @available(iOS 4.3, *)
  func errorLog() -> AVPlayerItemErrorLog?
}
extension AVPlayerItem {

  /*!
   @method		addOutput:
   @abstract		Adds the specified instance of AVPlayerItemOutput to the receiver's collection of outputs.
   @discussion	
  	The class of AVPlayerItemOutput provided dictates the data structure that decoded samples are vended in. 
   
   	When an AVPlayerItemOutput is associated with an AVPlayerItem, samples are provided for a media type in accordance with the rules for mixing, composition, or exclusion that the AVPlayer honors among multiple enabled tracks of that media type for its own rendering purposes. For example, video media will be composed according to the instructions provided via AVPlayerItem.videoComposition, if present. Audio media will be mixed according to the parameters provided via AVPlayerItem.audioMix, if present.
   @param			output
  				An instance of AVPlayerItemOutput
   */
  @available(iOS 6.0, *)
  func addOutput(output: AVPlayerItemOutput)

  /*!
   @method		removeOutput:
   @abstract		Removes the specified instance of AVPlayerItemOutput from the receiver's collection of outputs.
   @param			output
  				An instance of AVPlayerItemOutput
   */
  @available(iOS 6.0, *)
  func removeOutput(output: AVPlayerItemOutput)

  /*!
   @property		outputs
   @abstract		The collection of associated outputs.
   */
  @available(iOS 6.0, *)
  var outputs: [AVPlayerItemOutput] { get }
}

/*!
 @class			AVPlayerItemAccessLog
 @abstract		An AVPlayerItemAccessLog provides methods to retrieve the access log in a format suitable for serialization.
 @discussion	An AVPlayerItemAccessLog acculumulates key metrics about network playback and presents them as a collection 
 				of AVPlayerItemAccessLogEvent instances. Each AVPlayerItemAccessLogEvent instance collates the data 
 				that relates to each uninterrupted period of playback.
*/
@available(iOS 4.3, *)
class AVPlayerItemAccessLog : Object, Copying {

  /*!
   @method		extendedLogData
   @abstract		Serializes an AVPlayerItemAccessLog in the Extended Log File Format.
   @discussion	This method converts the webserver access log into a textual format that conforms to the
  				W3C Extended Log File Format for web server log files.
  				For more information see: http://www.w3.org/pub/WWW/TR/WD-logfile.html
   @result		An autoreleased NSData instance.
   */
  func extendedLogData() -> Data?

  /*!
   @property		extendedLogDataStringEncoding
   @abstract		Returns the NSStringEncoding for extendedLogData, see above.
   @discussion	A string suitable for console output is obtainable by: 
   				[[NSString alloc] initWithData:[myLog extendedLogData] encoding:[myLog extendedLogDataStringEncoding]]
   */
  var extendedLogDataStringEncoding: UInt { get }

  /*!
   @property		events
   @abstract		An ordered collection of AVPlayerItemAccessLogEvent instances.
   @discussion	An ordered collection of AVPlayerItemAccessLogEvent instances that represent the chronological
   				sequence of events contained in the access log.
   				This property is not observable.
   */
  var events: [AVPlayerItemAccessLogEvent] { get }
  init()
  @available(iOS 4.3, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class			AVPlayerItemErrorLog
 @abstract		An AVPlayerItemErrorLog provides methods to retrieve the error log in a format suitable for serialization.
 @discussion	An AVPlayerItemErrorLog provides data to identify if, and when, network resource playback failures occured.
*/
@available(iOS 4.3, *)
class AVPlayerItemErrorLog : Object, Copying {

  /*!
   @method		extendedLogData
   @abstract		Serializes an AVPlayerItemErrorLog in the Extended Log File Format.
   @discussion	This method converts the webserver error log into a textual format that conforms to the
  				W3C Extended Log File Format for web server log files.
  				For more information see: http://www.w3.org/pub/WWW/TR/WD-logfile.html
   @result		An autoreleased NSData instance.
   */
  func extendedLogData() -> Data?

  /*!
   @property		extendedLogDataStringEncoding
   @abstract		Returns the NSStringEncoding for extendedLogData, see above.
   @discussion	A string suitable for console output is obtainable by: 
   				[[NSString alloc] initWithData:[myLog extendedLogData] encoding:[myLog extendedLogDataStringEncoding]]
   */
  var extendedLogDataStringEncoding: UInt { get }

  /*!
   @property		events
   @abstract		An ordered collection of AVPlayerItemErrorLogEvent instances.
   @discussion	An ordered collection of AVPlayerItemErrorLogEvent instances that represent the chronological
   				sequence of events contained in the error log.
   				This property is not observable.
   */
  var events: [AVPlayerItemErrorLogEvent] { get }
  init()
  @available(iOS 4.3, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class			AVPlayerItemAccessLogEvent
 @abstract		An AVPlayerItemAccessLogEvent represents a single log entry.
 @discussion	An AVPlayerItemAccessLogEvent provides named properties for accessing the data
				fields of each log event. None of the properties of this class are observable.
*/
@available(iOS 4.3, *)
class AVPlayerItemAccessLogEvent : Object, Copying {

  /*!
   @property		numberOfMediaRequests
   @abstract		A count of media read requests.
   @discussion	Value is negative if unknown. A count of media read requests from the server to this client. Corresponds to "sc-count".
  				For HTTP live Streaming, a count of media segments downloaded from the server to this client.
  				For progressive-style HTTP media downloads, a count of HTTP GET (byte-range) requests for the resource.
   				This property is not observable. 
   */
  @available(iOS 6.0, *)
  var numberOfMediaRequests: Int { get }

  /*!
   @property		playbackStartDate
   @abstract		The date/time at which playback began for this event. Can be nil.
   @discussion	If nil is returned the date is unknown. Corresponds to "date".
   				This property is not observable.
   */
  var playbackStartDate: Date? { get }

  /*!
   @property		URI
   @abstract		The URI of the playback item. Can be nil.
   @discussion	If nil is returned the URI is unknown. Corresponds to "uri".
   				This property is not observable.
   */
  var uri: String? { get }

  /*!
   @property		serverAddress
   @abstract		The IP address of the server that was the source of the last delivered media segment. Can be nil.
   @discussion	If nil is returned the address is unknown. Can be either an IPv4 or IPv6 address. Corresponds to "s-ip".
   				This property is not observable.
   */
  var serverAddress: String? { get }

  /*!
   @property		numberOfServerAddressChanges
   @abstract		A count of changes to the property serverAddress, see above, over the last uninterrupted period of playback.
   @discussion	Value is negative if unknown. Corresponds to "s-ip-changes".
   				This property is not observable.
   */
  var numberOfServerAddressChanges: Int { get }

  /*!
   @property		playbackSessionID
   @abstract		A GUID that identifies the playback session. This value is used in HTTP requests. Can be nil.
   @discussion	If nil is returned the GUID is unknown. Corresponds to "cs-guid".
   				This property is not observable.
   */
  var playbackSessionID: String? { get }

  /*!
   @property		playbackStartOffset
   @abstract		An offset into the playlist where the last uninterrupted period of playback began. Measured in seconds.
   @discussion	Value is negative if unknown. Corresponds to "c-start-time".
   				This property is not observable.
   */
  var playbackStartOffset: TimeInterval { get }

  /*!
   @property		segmentsDownloadedDuration
   @abstract		The accumulated duration of the media downloaded. Measured in seconds.
   @discussion	Value is negative if unknown. Corresponds to "c-duration-downloaded".
   				This property is not observable.
   */
  var segmentsDownloadedDuration: TimeInterval { get }

  /*!
   @property		durationWatched
   @abstract		The accumulated duration of the media played. Measured in seconds.
   @discussion	Value is negative if unknown. Corresponds to "c-duration-watched".
   				This property is not observable.
   */
  var durationWatched: TimeInterval { get }

  /*!
   @property		numberOfStalls
   @abstract		The total number of playback stalls encountered.
   @discussion	Value is negative if unknown. Corresponds to "c-stalls".
   				This property is not observable.
   */
  var numberOfStalls: Int { get }

  /*!
   @property		numberOfBytesTransferred
   @abstract		The accumulated number of bytes transferred.
   @discussion	Value is negative if unknown. Corresponds to "bytes".
   				This property is not observable.
   */
  var numberOfBytesTransferred: Int64 { get }

  /*!
   @property		transferDuration
   @abstract		The accumulated duration of active network transfer of bytes. Measured in seconds.
   @discussion	Value is negative if unknown. Corresponds to "c-transfer-duration".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var transferDuration: TimeInterval { get }

  /*!
   @property		observedBitrate
   @abstract		The empirical throughput across all media downloaded. Measured in bits per second.
   @discussion	Value is negative if unknown. Corresponds to "c-observed-bitrate".
   				This property is not observable.
   */
  var observedBitrate: Double { get }

  /*!
   @property		indicatedBitrate
   @abstract		The throughput required to play the stream, as advertised by the server. Measured in bits per second.
   @discussion	Value is negative if unknown. Corresponds to "sc-indicated-bitrate".
   				This property is not observable.
   */
  var indicatedBitrate: Double { get }

  /*!
   @property		numberOfDroppedVideoFrames
   @abstract		The total number of dropped video frames.
   @discussion	Value is negative if unknown. Corresponds to "c-frames-dropped".
   				This property is not observable.
   */
  var numberOfDroppedVideoFrames: Int { get }

  /*!
   @property		startupTime
   @abstract		The accumulated duration until player item is ready to play. Measured in seconds.
   @discussion	Value is negative if unknown. Corresponds to "c-startup-time".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var startupTime: TimeInterval { get }

  /*!
   @property		downloadOverdue
   @abstract		The total number of times the download of the segments took too long.
   @discussion	Value is negative if unknown. Corresponds to "c-overdue".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var downloadOverdue: Int { get }

  /*!
   @property		observedMaxBitrate
   @abstract		Maximum observed segment download bit rate.
   @discussion	Value is negative if unknown. Corresponds to "c-observed-max-bitrate".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var observedMaxBitrate: Double { get }

  /*!
   @property		observedMinBitrate
   @abstract		Minimum observed segment download bit rate.
   @discussion	Value is negative if unknown. Corresponds to "c-observed-min-bitrate".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var observedMinBitrate: Double { get }

  /*!
   @property		observedBitrateStandardDeviation
   @abstract		Standard deviation of observed segment download bit rates.
   @discussion	Value is negative if unknown. Corresponds to "c-observed-bitrate-sd".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var observedBitrateStandardDeviation: Double { get }

  /*!
   @property		playbackType
   @abstract		Playback type (LIVE, VOD, FILE).
   @discussion	If nil is returned the playback type is unknown. Corresponds to "s-playback-type".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var playbackType: String? { get }

  /*!
   @property		mediaRequestsWWAN
   @abstract		Number of network read requests over WWAN.
   @discussion	Value is negative if unknown. Corresponds to "sc-wwan-count".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var mediaRequestsWWAN: Int { get }

  /*!
   @property		switchBitrate
   @abstract		Bandwidth that caused us to switch (up or down).
   @discussion	Value is negative if unknown. Corresponds to "c-switch-bitrate".
  				This property is not observable.
   */
  @available(iOS 7.0, *)
  var switchBitrate: Double { get }
  init()
  @available(iOS 4.3, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
 @class			AVPlayerItemErrorLogEvent
 @abstract		An AVPlayerItemErrorLogEvent represents a single log entry.
 @discussion	An AVPlayerItemErrorLogEvent provides named properties for accessing the data
				fields of each log event. None of the properties of this class are observable.
*/
@available(iOS 4.3, *)
class AVPlayerItemErrorLogEvent : Object, Copying {

  /*!
   @property		date
   @abstract		The date and time when the error occured. Can be nil.
   @discussion	If nil is returned the date is unknown. Corresponds to "date".
   				This property is not observable.
   */
  var date: Date? { get }

  /*!
   @property		URI
   @abstract		The URI of the playback item. Can be nil.
   @discussion	If nil is returned the URI is unknown. Corresponds to "uri".
   				This property is not observable.
   */
  var uri: String? { get }

  /*!
   @property		serverAddress
   @abstract		The IP address of the server that was the source of the error. Can be nil.
   @discussion	If nil is returned the address is unknown. Can be either an IPv4 or IPv6 address. Corresponds to "s-ip".
   				This property is not observable.
   */
  var serverAddress: String? { get }

  /*!
   @property		playbackSessionID
   @abstract		A GUID that identifies the playback session. This value is used in HTTP requests. Can be nil.
   @discussion	If nil is returned the GUID is unknown. Corresponds to "cs-guid".
   				This property is not observable.
   */
  var playbackSessionID: String? { get }

  /*!
   @property		errorStatusCode
   @abstract		A unique error code identifier.
   @discussion	Corresponds to "status".
   				This property is not observable.
   */
  var errorStatusCode: Int { get }

  /*!
   @property		errorDomain
   @abstract		The domain of the error.
   @discussion	Corresponds to "domain".
   				This property is not observable.
   */
  var errorDomain: String { get }

  /*!
   @property		errorComment
   @abstract		A description of the error encountered. Can be nil.
   @discussion	If nil is returned further information is not available. Corresponds to "comment".
   				This property is not observable.
   */
  var errorComment: String? { get }
  init()
  @available(iOS 4.3, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 6.0, *)
class AVPlayerItemOutput : Object {

  /*!
  	@method			itemTimeForHostTime:
  	@abstract		Convert a host time, expressed in seconds, to item time.
  	@discussion
  		Converts a host time value (for example a CADisplayLink timestamp, or the value returned by CACurrentMediaTime()) to the equivalent time on the item's timebase.
  		
  		Note: The Core Animation CADisplayLink timestamp property expresses the most recent, or previous, screen refresh time. You need to increment this timestamp by the CADisplayLink's duration property to find the next appropriate item time.
  	@param			hostTimeInSeconds
  					The timestamp value to convert to item time.
  	@result			The equivalent item time.
   */
  func itemTimeForHostTime(hostTimeInSeconds: CFTimeInterval) -> CMTime

  /*!
  	@method			itemTimeForMachAbsoluteTime:
  	@abstract		Convenience method to convert a Mach host time to item time.
  	@discussion
  		Converts Mach host time to the equivalent time on the item's timebase.
  		mach_absolute_time() returns time awake since boot in system-specific rational units that can be queried by calling mach_timebase_info().
  	@param			machAbsoluteTime
  					The Mach host time to convert to item time.
  	@result			The equivalent item time.
   */
  func itemTimeForMachAbsoluteTime(machAbsoluteTime: Int64) -> CMTime

  /*!
  	@property		suppressesPlayerRendering
  	@abstract		Indicates whether the output, when added to an AVPlayerItem, will be used in addition to normal rendering of media data by the player or instead of normal rendering.
  	@discussion
  		The default value is NO, indicating that the output will be used in addition to normal rendering. If you want to render the media data provided by the output yourself instead of allowing it to be rendered as in normally would be by AVPlayer, set suppressesPlayerRendering to YES.
   
  		 Whenever any output is added to an AVPlayerItem that has suppressesPlayerRendering set to YES, the media data supplied to the output will not be rendered by AVPlayer. Other media data associated with the item but not provided to such an output is not affected. For example, if an output of class AVPlayerItemVideoOutput with a value of YES for suppressesPlayerRendering is added to an AVPlayerItem, video media for that item will not be rendered by the AVPlayer, while audio media, subtitle media, and other kinds of media, if present, will be rendered.
  */
  @available(iOS 6.0, *)
  var suppressesPlayerRendering: Bool
  init()
}
@available(iOS 6.0, *)
class AVPlayerItemVideoOutput : AVPlayerItemOutput {

  /*!
  	@method			initWithPixelBufferAttributes:
  	@abstract		Returns an instance of AVPlayerItemVideoOutput, initialized with the specified pixel buffer attributes, for video image output.
  	@param			pixelBufferAttributes
  					The client requirements for output CVPixelBuffers, expressed using the constants in <CoreVideo/CVPixelBuffer.h>.
  	@result			An instance of AVPlayerItemVideoOutput.
   */
  init(pixelBufferAttributes: [String : AnyObject]? = [:])

  /*!
  	@method			hasNewPixelBufferForItemTime:
  	@abstract		Query if any new video output is available for an item time.
  	@discussion
  		This method returns YES if there is available video output, appropriate for display, at the specified item time not marked as acquired. If you require multiple objects to acquire video output from the same AVPlayerItem, you should instantiate more than one AVPlayerItemVideoOutput and add each via addOutput:. Each AVPlayerItemVideoOutput maintains a separate record of client acquisition.
  	@param			itemTime
  					The item time to query.
  	@result			A BOOL indicating if there is newer output.
   */
  func hasNewPixelBufferForItemTime(itemTime: CMTime) -> Bool

  /*!
  	@method			copyPixelBufferForItemTime:itemTimeForDisplay:
  	@abstract		Retrieves an image that is appropriate for display at the specified item time, and marks the image as acquired.
  	@discussion
  		The client is responsible for calling CVBufferRelease on the returned CVPixelBuffer when finished with it. 
  		
  		Typically you would call this method in response to a CVDisplayLink callback or CADisplayLink delegate invocation and if hasNewPixelBufferForItemTime: also returns YES. 
  		
  		The buffer reference retrieved from copyPixelBufferForItemTime:itemTimeForDisplay: may itself be NULL. A reference to a NULL pixel buffer communicates that nothing should be displayed for the supplied item time.
  	@param			itemTime
  					A CMTime that expresses a desired item time.
  	@param			itemTimeForDisplay
  					A CMTime pointer whose value will contain the true display deadline for the copied pixel buffer. Can be NULL.
   */
  func copyPixelBufferForItemTime(itemTime: CMTime, itemTimeForDisplay outItemTimeForDisplay: UnsafeMutablePointer<CMTime>) -> CVPixelBuffer?

  /*!
  	@method			setDelegate:queue:
  	@abstract		Sets the receiver's delegate and a dispatch queue on which the delegate will be called.
  	@param			delegate
  					An object conforming to AVPlayerItemOutputPullDelegate protocol.
  	@param			delegateQueue
  					A dispatch queue on which all delegate methods will be called.
   */
  func setDelegate(delegate: AVPlayerItemOutputPullDelegate?, queue delegateQueue: dispatch_queue_t?)

  /*!
  	@method			requestNotificationOfMediaDataChangeWithAdvanceInterval:
  	@abstract		Informs the receiver that the AVPlayerItemVideoOutput client is entering a quiescent state.
  	@param			interval
  					A wall clock time interval.
  	@discussion
  		Message this method before you suspend your use of a CVDisplayLink or CADisplayLink. The interval you provide will be used to message your delegate, in advance, that it should resume the display link. If the interval you provide is large, effectively requesting wakeup earlier than the AVPlayerItemVideoOutput is prepared to act, the delegate will be invoked as soon as possible. Do not use this method to force a delegate invocation for each sample.
   */
  func requestNotificationOfMediaDataChangeWithAdvanceInterval(interval: TimeInterval)

  /*!
  	@property		delegate
  	@abstract		The receiver's delegate.
   */
  unowned(unsafe) var delegate: @sil_unmanaged AVPlayerItemOutputPullDelegate? { get }

  /*!
  	@property		delegateQueue
  	@abstract		The dispatch queue where the delegate is messaged.
   */
  var delegateQueue: dispatch_queue_t? { get }
  convenience init()
}

/*!
	@protocol		AVPlayerItemOutputPullDelegate
	@abstract		Defines common delegate methods for objects participating in AVPlayerItemOutput pull sample output acquisition.
 */
protocol AVPlayerItemOutputPullDelegate : ObjectProtocol {

  /*!
  	@method			outputMediaDataWillChange:
  	@abstract		A method invoked once, prior to a new sample, if the AVPlayerItemOutput sender was previously messaged requestNotificationOfMediaDataChangeWithAdvanceInterval:.
  	@discussion
  		This method is invoked once after the sender is messaged requestNotificationOfMediaDataChangeWithAdvanceInterval:.
    */
  @available(iOS 6.0, *)
  optional func outputMediaDataWillChange(sender: AVPlayerItemOutput)

  /*!
  	@method			outputSequenceWasFlushed:
  	@abstract		A method invoked when the output is commencing a new sequence.
  	@discussion
  		This method is invoked after any seeking and change in playback direction. If you are maintaining any queued future samples, copied previously, you may want to discard these after receiving this message.
    */
  @available(iOS 6.0, *)
  optional func outputSequenceWasFlushed(output: AVPlayerItemOutput)
}

/*!
	@class			AVPlayerItemLegibleOutput
	@abstract		A subclass of AVPlayerItemOutput that can vend media with a legible characteristic as NSAttributedStrings.
	@discussion
		An instance of AVPlayerItemLegibleOutput is typically initialized using the -init method.
 */
@available(iOS 7.0, *)
class AVPlayerItemLegibleOutput : AVPlayerItemOutput {

  /*!
  	@method			setDelegate:queue:
  	@abstract		Sets the receiver's delegate and a dispatch queue on which the delegate will be called.
  	@param			delegate
  					An object conforming to AVPlayerItemLegibleOutputPushDelegate protocol.
  	@param			delegateQueue
  					A dispatch queue on which all delegate methods will be called.
  	@discussion
  		The delegate is held using a zeroing-weak reference, so it is safe to deallocate the delegate while the receiver still has a reference to it.
   */
  func setDelegate(delegate: AVPlayerItemLegibleOutputPushDelegate?, queue delegateQueue: dispatch_queue_t?)

  /*!
  	@property		delegate
  	@abstract		The receiver's delegate.
  	@discussion
  		The delegate is held using a zeroing-weak reference, so this property will have a value of nil after a delegate that was previously set has been deallocated.  This property is not key-value observable.
   */
  weak var delegate: @sil_weak AVPlayerItemLegibleOutputPushDelegate? { get }

  /*!
  	@property		delegateQueue
  	@abstract		The dispatch queue where the delegate is messaged.
  	@discussion
  		This property is not key-value observable.
   */
  var delegateQueue: dispatch_queue_t? { get }

  /*!
  	@property		advanceIntervalForDelegateInvocation
  	@abstract		Permits advance invocation of the associated delegate, if any.
  	@discussion
  		If it is possible, an AVPlayerItemLegibleOutput will message its delegate advanceIntervalForDelegateInvocation seconds earlier than otherwise. If the value you provide is large, effectively requesting provision of samples earlier than the AVPlayerItemLegibleOutput is prepared to act on them, the delegate will be invoked as soon as possible.
   */
  var advanceIntervalForDelegateInvocation: TimeInterval
  init()
}
extension AVPlayerItemLegibleOutput {

  /*!
  	@method			initWithMediaSubtypesForNativeRepresentation:
  	@abstract		Returns an instance of AVPlayerItemLegibleOutput with filtering enabled for AVPlayerItemLegibleOutputPushDelegate's legibleOutput:didOutputAttributedStrings:nativeSampleBuffers:forItemTime:.
  	@param			subtypes
  					NSArray of NSNumber FourCC codes, e.g. @[ [NSNumber numberWithUnsignedInt:'tx3g'] ]
  	@result			An instance of AVPlayerItemLegibleOutput.
  	@discussion
  		Add media subtype FourCC number objects to the subtypes array to elect to receive that type as a CMSampleBuffer instead of an NSAttributedString.  Initializing an AVPlayerItemLegibleOutput using the -init method is equivalent to calling -initWithMediaSubtypesForNativeRepresentation: with an empty array, which means that all legible data, regardless of media subtype, will be delivered using NSAttributedString in a common format.
   
  		If a media subtype for which there is no legible data in the current player item is included in the media subtypes array, no error will occur.  AVPlayerItemLegibleOutput will not vend closed caption data as CMSampleBuffers, so it is an error to include 'c608' in the media subtypes array.
   */
  init(mediaSubtypesForNativeRepresentation subtypes: [Number])
}
extension AVPlayerItemLegibleOutput {

  /*!
   @property		textStylingResolution
   @abstract		A string identifier indicating the degree of text styling to be applied to attributed strings vended by the receiver
   @discussion
  	Valid values are AVPlayerItemLegibleOutputTextStylingResolutionDefault and AVPlayerItemLegibleOutputTextStylingResolutionSourceAndRulesOnly.  An NSInvalidArgumentException is raised if this property is set to any other value.  The default value is AVPlayerItemLegibleOutputTextStylingResolutionDefault, which indicates that attributed strings vended by the receiver will include the same level of styling information that would be used if AVFoundation were rendering the text via AVPlayerLayer.
   */
  var textStylingResolution: String
}

/*!
 @constant		AVPlayerItemLegibleOutputTextStylingResolutionDefault
 @abstract		Specify this level of text styling resolution to receive attributed strings from an AVPlayerItemLegibleOutput that include the same level of styling information that AVFoundation would use itself to render text within an AVPlayerLayer. The text styling will accommodate user-level Media Accessibility settings.
 */
@available(iOS 7.0, *)
let AVPlayerItemLegibleOutputTextStylingResolutionDefault: String

/*!
 @constant		AVPlayerItemLegibleOutputTextStylingResolutionSourceAndRulesOnly
 @abstract		Specify this level of text styling resolution to receive only the styling present in the source media and the styling provided via AVPlayerItem.textStyleRules.
 @discussion
	This level of resolution excludes styling provided by the user-level Media Accessibility settings. You would typically use it if you wish to override the styling specified in source media. If you do this, you are strongly encouraged to allow your custom styling in turn to be overriden by user preferences for text styling that are available as Media Accessibility settings.
 */
@available(iOS 7.0, *)
let AVPlayerItemLegibleOutputTextStylingResolutionSourceAndRulesOnly: String

/*!
	@protocol		AVPlayerItemLegibleOutputPushDelegate
	@abstract		Extends AVPlayerItemOutputPushDelegate to provide additional methods specific to attributed string output.
 */
protocol AVPlayerItemLegibleOutputPushDelegate : AVPlayerItemOutputPushDelegate {

  /*!
  	@method			legibleOutput:didOutputAttributedStrings:nativeSampleBuffers:forItemTime:
  	@abstract		A delegate callback that delivers new textual samples.
  	@param			output
  					The AVPlayerItemLegibleOutput source.
  	@param			strings
  					An NSArray of NSAttributedString, each containing both the run of text and descriptive markup.
  	@param			nativeSamples
  					An NSArray of CMSampleBuffer objects, for media subtypes included in the array passed in to -initWithMediaSubtypesForNativeRepresentation:
  	@param			itemTime
  					The item time at which the strings should be presented.
  	@discussion
  		For each media subtype in the array passed in to -initWithMediaSubtypesForNativeRepresentation:, the delegate will receive sample buffers carrying data in its native format via the nativeSamples parameter, if there is media data of that subtype in the media resource.  For all other media subtypes present in the media resource, the delegate will receive attributed strings in a common format via the strings parameter.  See <CoreMedia/CMTextMarkup.h> for the string attributes that are used in the attributed strings.
   */
  @available(iOS 7.0, *)
  optional func legibleOutput(output: AVPlayerItemLegibleOutput, didOutputAttributedStrings strings: [AttributedString], nativeSampleBuffers nativeSamples: [AnyObject], forItemTime itemTime: CMTime)
}

/*!
 @protocol		AVPlayerItemOutputPushDelegate
 @abstract		Defines common delegate methods for objects participating in AVPlayerItemOutput push sample output acquisition.
 */
protocol AVPlayerItemOutputPushDelegate : ObjectProtocol {

  /*!
  	@method			outputSequenceWasFlushed:
  	@abstract		A method invoked when the output is commencing a new sequence of media data.
  	@discussion
  		This method is invoked after any seeking and change in playback direction. If you are maintaining any queued future media data, received previously, you may want to discard these after receiving this message.
   */
  @available(iOS 6.0, *)
  optional func outputSequenceWasFlushed(output: AVPlayerItemOutput)
}

/*!
	@class			AVPlayerItemMetadataOutput
	@abstract		A subclass of AVPlayerItemOutput that vends collections of metadata items carried in metadata tracks.
 
	@discussion
		Setting the value of suppressesPlayerRendering on an instance of AVPlayerItemMetadataOutput has no effect.
 */
@available(iOS 8.0, *)
class AVPlayerItemMetadataOutput : AVPlayerItemOutput {

  /*!
  	@method			initWithIdentifiers:
  	@abstract		Creates an instance of AVPlayerItemMetadataOutput.
  	@param			identifiers
  					A array of metadata identifiers indicating the metadata items that the output should provide.
  	@discussion
  		See AVMetadataIdentifiers.h for publicly defined metadata identifiers. Pass nil to receive all of the timed metadata from all enabled AVPlayerItemTracks that carry timed metadata.
   */
  init(identifiers: [String]?)

  /*!
  	@method			setDelegate:queue:
  	@abstract		Sets the receiver's delegate and a dispatch queue on which the delegate will be called.
  	@param			delegate
  					An object conforming to AVPlayerItemMetadataOutputPushDelegate protocol.
  	@param			delegateQueue
  					A dispatch queue on which all delegate methods will be called.
   */
  func setDelegate(delegate: AVPlayerItemMetadataOutputPushDelegate?, queue delegateQueue: dispatch_queue_t?)

  /*!
  	@property		delegate
  	@abstract		The receiver's delegate.
  	@discussion
  		The delegate is held using a zeroing-weak reference, so this property will have a value of nil after a delegate that was previously set has been deallocated.  This property is not key-value observable.
   */
  weak var delegate: @sil_weak AVPlayerItemMetadataOutputPushDelegate? { get }

  /*!
  	@property		delegateQueue
  	@abstract		The dispatch queue on which messages are sent to the delegate.
  	@discussion
  		This property is not key-value observable.
   */
  var delegateQueue: dispatch_queue_t? { get }

  /*!
  	@property		advanceIntervalForDelegateInvocation
  	@abstract		Permits advance invocation of the associated delegate, if any.
  	@discussion
  		If it is possible, an AVPlayerItemMetadataOutput will message its delegate advanceIntervalForDelegateInvocation seconds earlier than otherwise. If the value you provide is large, effectively requesting provision of samples earlier than the AVPlayerItemMetadataOutput is prepared to act on them, the delegate will be invoked as soon as possible.
   */
  var advanceIntervalForDelegateInvocation: TimeInterval
  convenience init()
}

/*!
	@protocol		AVPlayerItemMetadataOutputPushDelegate
	@abstract		Extends AVPlayerItemOutputPushDelegate to provide additional methods specific to metadata output.
 */
protocol AVPlayerItemMetadataOutputPushDelegate : AVPlayerItemOutputPushDelegate {

  /*!
  	@method			metadataOutput:didOutputTimedMetadataGroup:fromPlayerItemTrack:
  	@abstract		A delegate callback that delivers a new collection of metadata items.
  	@param			output
  					The AVPlayerItemMetadataOutput source.
  	@param			groups
  					An NSArray of AVTimedMetadataGroups that may contain metadata items with requested identifiers, according to the format descriptions associated with the underlying tracks.
  	@param			track
  					An instance of AVPlayerItemTrack that indicates the source of the metadata items in the group.
  	@discussion
  		Each group provided in a single invocation of this method will have timing that does not overlap with any other group in the array.
  		Note that for some timed metadata formats carried by HTTP live streaming, the timeRange of each group must be reported as kCMTimeIndefinite, because its duration will be unknown until the next metadata group in the stream arrives. In these cases, the groups parameter will always contain a single group.
  		Groups are typically packaged into arrays for delivery to your delegate according to the chunking or interleaving of the underlying metadata data.
  		Note that if the item carries multiple metadata tracks containing metadata with the same metadata identifiers, this method can be invoked for each one separately, each with reference to the associated AVPlayerItemTrack.
  		Note that the associated AVPlayerItemTrack parameter can be nil which implies that the metadata describes the asset as a whole, not just a single track of the asset.
   */
  @available(iOS 8.0, *)
  optional func metadataOutput(output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack)
}

/*!
	@class			AVPlayerItemTrack

	@abstract
		An AVPlayerItemTrack carries a reference to an AVAssetTrack as well as presentation settings for that track.

	@discussion
		Note that inspection of assets tracks is provided by AVAssetTrack.
		This class is intended to represent presentation state for a track of an asset that's played by an AVPlayer and AVPlayerItem.

		To ensure safe access to AVPlayerItemTrack's nonatomic properties while dynamic changes in playback state may be reported,
		clients must serialize their access with the associated AVPlayer's notification queue. In the common case, such serialization
		is naturally achieved by invoking AVPlayerItemTrack's various methods on the main thread or queue.
*/
@available(iOS 4.0, *)
class AVPlayerItemTrack : Object {

  /*!
   @property		assetTrack
   @abstract		Indicates the AVAssetTrack for which the AVPlayerItemTrack represents presentation state.
   @discussion	This property is not observable.
  	Clients must serialize their access to the resulting AVAssetTrack and related objects on the associated AVPlayer's
  	notification queue.  By default, this queue is the main queue.
  */
  var assetTrack: AVAssetTrack { get }

  /*!
   @property		enabled
   @abstract		Indicates whether the track is enabled for presentation during playback.
  */
  var isEnabled: Bool

  /*!
   @property		currentVideoFrameRate
   @abstract		If the media type of the assetTrack is AVMediaTypeVideo, indicates the current frame rate of the track as it plays, in units of frames per second. If the item is not playing, or if the media type of the track is not video, the value of this property is 0.
   @discussion	This property is not observable.
  */
  @available(iOS 7.0, *)
  var currentVideoFrameRate: Float { get }
  init()
}
@available(iOS 4.0, *)
class AVPlayerLayer : CALayer {

  /*!
  	@method		layerWithPlayer:
  	@abstract		Returns an instance of AVPlayerLayer to display the visual output of the specified AVPlayer.
  	@result		An instance of AVPlayerLayer.
  */
  /*not inherited*/ init(player: AVPlayer?)

  /*! 
  	@property		player
  	@abstract		Indicates the instance of AVPlayer for which the AVPlayerLayer displays visual output
  */
  var player: AVPlayer?

  /*!
  	@property		videoGravity
  	@abstract		A string defining how the video is displayed within an AVPlayerLayer bounds rect.
  	@discusssion	Options are AVLayerVideoGravityResizeAspect, AVLayerVideoGravityResizeAspectFill 
   					and AVLayerVideoGravityResize. AVLayerVideoGravityResizeAspect is default. 
  					See <AVFoundation/AVAnimation.h> for a description of these options.
   */
  var videoGravity: String

  /*!
  	 @property		readyForDisplay
  	 @abstract		Boolean indicating that the first video frame has been made ready for display for the current item of the associated AVPlayer.
  	 @discusssion	Use this property as an indicator of when best to show or animate-in an AVPlayerLayer into view. 
  					An AVPlayerLayer may be displayed, or made visible, while this propoerty is NO, however the layer will not have any 
  					user-visible content until the value becomes YES. 
  					This property remains NO for an AVPlayer currentItem whose AVAsset contains no enabled video tracks.
   */
  var isReadyForDisplay: Bool { get }

  /*!
  	@property		videoRect
  	@abstract		The current size and position of the video image as displayed within the receiver's bounds.
   */
  @available(iOS 7.0, *)
  var videoRect: CGRect { get }

  /*!
  	@property		pixelBufferAttributes
  	@abstract		The client requirements for the visual output displayed in AVPlayerLayer during playback.  	
  	@discussion		Pixel buffer attribute keys are defined in <CoreVideo/CVPixelBuffer.h>
   */
  @available(iOS 9.0, *)
  var pixelBufferAttributes: [String : AnyObject]?
  init()
  init(layer: AnyObject)
  init?(coder aDecoder: Coder)
}
@available(iOS 7.0, *)
class AVPlayerMediaSelectionCriteria : Object {
  var preferredLanguages: [String]? { get }
  var preferredMediaCharacteristics: [String]? { get }

  /*!
    @method		initWithPreferredLanguages:preferredMediaCharacteristics:
    @abstract		Creates an instance of AVPlayerMediaSelectionCriteria.
    @param		preferredLanguages
  				An NSArray of NSStrings containing language identifiers, in order of desirability, that are preferred for selection. Can be nil.
    @param		preferredMediaCharacteristics
  				An NSArray of NSStrings indicating additional media characteristics, in order of desirability, that are preferred when selecting media with the characteristic for which the receiver is set on the AVPlayer as the selection criteria. Can be nil.
    @result		An instance of AVPlayerMediaSelectionCriteria.
  */
  init(preferredLanguages: [String]?, preferredMediaCharacteristics: [String]?)
  init()
}

/*!
	@enum		 AVQueuedSampleBufferRenderingStatus
	@abstract	 These constants are the possible values of the AVSampleBufferDisplayLayer status property.
	@constant	 AVQueuedSampleBufferRenderingStatusUnknown
	Indicates that the receiver is in a fresh state without any sample buffers enqueued on it.
	@constant	 AVQueuedSampleBufferRenderingStatusRendering
	Indicates at least one sample buffer has been enqueued on the receiver.
	@constant	 AVQueuedSampleBufferRenderingStatusFailed
	Terminal state indicating that the receiver can no longer render sample buffers because of an error. The error is described by
	the value of AVSampleBufferDisplayLayer's error property.
 */
@available(iOS 8.0, *)
enum AVQueuedSampleBufferRenderingStatus : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Unknown
  case Rendering
  case Failed
}
@available(iOS 8.0, *)
let AVSampleBufferDisplayLayerFailedToDecodeNotification: String
@available(iOS 8.0, *)
let AVSampleBufferDisplayLayerFailedToDecodeNotificationErrorKey: String
@available(iOS 8.0, *)
class AVSampleBufferDisplayLayer : CALayer {

  /*!
  	@property		controlTimebase
  	@abstract		The layer's control timebase, which governs how time stamps are interpreted.
  	@discussion		By default, this property is NULL, in which case time stamps will be interpreted
  					according to the host time clock (mach_absolute_time with the appropriate timescale
  					conversion; this is the same as Core Animation's CACurrentMediaTime).  With no 
  					control timebase, once frames are enqueued, it is not possible to adjust exactly 
  					when they are displayed.
  					
  					If a non-NULL control timebase is set, it will be used to interpret time stamps.
  					You can control the timing of frame display by setting the rate and time of the
  					control timebase.  
  					If you are synchronizing video to audio, you can use a timebase whose master clock
  					is a CMAudioDeviceClock for the appropriate audio device to prevent drift.
  					
  					Note that prior to OSX 10.10 and iOS 8.0, the control timebase could not be changed after enqueueSampleBuffer: was called.  As of OSX 10.10 and iOS 8.0, the control timebase may be changed at any time.
  */
  var controlTimebase: CMTimebase?

  /*!
  	@property		videoGravity
  	@abstract		A string defining how the video is displayed within an AVSampleBufferDisplayLayer bounds rect.
  	@discusssion	Options are AVLayerVideoGravityResizeAspect, AVLayerVideoGravityResizeAspectFill 
   					and AVLayerVideoGravityResize. AVLayerVideoGravityResizeAspect is default. 
  					See <AVFoundation/AVAnimation.h> for a description of these options.
   */
  var videoGravity: String

  /*!
  	@property		status
  	@abstract		The ability of the display layer to be used for enqueuing sample buffers.
  	@discussion		The value of this property is an AVQueuedSampleBufferRenderingStatus that indicates whether the receiver can be used for enqueuing sample buffers. When the value of this property is AVQueuedSampleBufferRenderingStatusFailed, the receiver can no longer be used and a new instance needs to be created in its place. When this happens, clients can check the value of the error property to determine the failure. This property is key value observable.
   */
  @available(iOS 8.0, *)
  var status: AVQueuedSampleBufferRenderingStatus { get }

  /*!
  	@property		error
  	@abstract		If the display layer's status is AVQueuedSampleBufferRenderingStatusFailed, this describes the error that caused the failure.
  	@discussion		The value of this property is an NSError that describes what caused the display layer to no longer be able to enqueue sample buffers. If the status is not AVQueuedSampleBufferRenderingStatusFailed, the value of this property is nil.
   */
  @available(iOS 8.0, *)
  var error: Error? { get }
  init()
  init(layer: AnyObject)
  init?(coder aDecoder: Coder)
}
extension AVSampleBufferDisplayLayer {

  /*!
  	@method			enqueueSampleBuffer:
  	@abstract		Sends a sample buffer for display.
  	@discussion		If sampleBuffer has the kCMSampleAttachmentKey_DoNotDisplay attachment set to
  					kCFBooleanTrue, the frame will be decoded but not displayed.
  					Otherwise, if sampleBuffer has the kCMSampleAttachmentKey_DisplayImmediately
  					attachment set to kCFBooleanTrue, the decoded image will be displayed as soon 
  					as possible, replacing all previously enqueued images regardless of their timestamps.
  					Otherwise, the decoded image will be displayed at sampleBuffer's output presentation
  					timestamp, as interpreted by the control timebase (or the mach_absolute_time timeline
  					if there is no control timebase).
  					
  					To schedule the removal of previous images at a specific timestamp, enqueue 
  					a marker sample buffer containing no samples, with the
  					kCMSampleBufferAttachmentKey_EmptyMedia attachment set to kCFBooleanTrue.
  					
  					IMPORTANT NOTE: attachments with the kCMSampleAttachmentKey_ prefix must be set via
  					CMSampleBufferGetSampleAttachmentsArray and CFDictionarySetValue. 
  					Attachments with the kCMSampleBufferAttachmentKey_ prefix must be set via
  					CMSetAttachment.
  */
  func enqueueSampleBuffer(sampleBuffer: CMSampleBuffer)

  /*!
  	@method			flush
  	@abstract		Instructs the layer to discard pending enqueued sample buffers.
  	@discussion		It is not possible to determine which sample buffers have been decoded, 
  					so the next frame passed to enqueueSampleBuffer: should be an IDR frame
  					(also known as a key frame or sync sample).
  */
  func flush()

  /*!
  	@method			flushAndRemoveImage
  	@abstract		Instructs the layer to discard pending enqueued sample buffers and remove any
  					currently displayed image.
  	@discussion		It is not possible to determine which sample buffers have been decoded, 
  					so the next frame passed to enqueueSampleBuffer: should be an IDR frame
  					(also known as a key frame or sync sample).
  */
  func flushAndRemoveImage()

  /*!
  	@property		readyForMoreMediaData
  	@abstract		Indicates the readiness of the layer to accept more sample buffers.
  	@discussion		AVSampleBufferDisplayLayer keeps track of the occupancy levels of its internal queues
  					for the benefit of clients that enqueue sample buffers from non-real-time sources --
  					i.e., clients that can supply sample buffers faster than they are consumed, and so
  					need to decide when to hold back.
  					
  					Clients enqueueing sample buffers from non-real-time sources may hold off from
  					generating or obtaining more sample buffers to enqueue when the value of
  					readyForMoreMediaData is NO.  
  					
  					It is safe to call enqueueSampleBuffer: when readyForMoreMediaData is NO, but 
  					it is a bad idea to enqueue sample buffers without bound.
  					
  					To help with control of the non-real-time supply of sample buffers, such clients can use
  					-requestMediaDataWhenReadyOnQueue:usingBlock
  					in order to specify a block that the layer should invoke whenever it's ready for 
  					sample buffers to be appended.
   
  					The value of readyForMoreMediaData will often change from NO to YES asynchronously, 
  					as previously supplied sample buffers are decoded and displayed.
  	
  					This property is not key value observable.
  */
  var isReadyForMoreMediaData: Bool { get }

  /*!
  	@method			requestMediaDataWhenReadyOnQueue:usingBlock:
  	@abstract		Instructs the target to invoke a client-supplied block repeatedly, 
  					at its convenience, in order to gather sample buffers for display.
  	@discussion		The block should enqueue sample buffers to the layer either until the layer's
  					readyForMoreMediaData property becomes NO or until there is no more data 
  					to supply. When the layer has decoded enough of the media data it has received 
  					that it becomes ready for more media data again, it will invoke the block again 
  					in order to obtain more.
  					If this function is called multiple times, only the last call is effective.
  					Call stopRequestingMediaData to cancel this request.
  					Each call to requestMediaDataWhenReadyOnQueue:usingBlock: should be paired
  					with a corresponding call to stopRequestingMediaData:. Releasing the
  					AVSampleBufferDisplayLayer without a call to stopRequestingMediaData will result
  					in undefined behavior.
  */
  func requestMediaDataWhenReadyOn(queue: dispatch_queue_t, usingBlock block: () -> Void)

  /*!
  	@method			stopRequestingMediaData
  	@abstract		Cancels any current requestMediaDataWhenReadyOnQueue:usingBlock: call.
  	@discussion		This method may be called from outside the block or from within the block.
  */
  func stopRequestingMediaData()
}
@available(iOS 7.0, *)
enum AVSpeechBoundary : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Immediate
  case Word
}
@available(iOS 9.0, *)
enum AVSpeechSynthesisVoiceQuality : Int {
  init?(rawValue: Int)
  var rawValue: Int { get }
  case Default
  case Enhanced
}
@available(iOS 7.0, *)
let AVSpeechUtteranceMinimumSpeechRate: Float
@available(iOS 7.0, *)
let AVSpeechUtteranceMaximumSpeechRate: Float
@available(iOS 7.0, *)
let AVSpeechUtteranceDefaultSpeechRate: Float
@available(iOS 9.0, *)
let AVSpeechSynthesisVoiceIdentifierAlex: String

/*!
 @class AVSpeechSynthesisVoice
 @abstract
 AVSpeechSynthesisVoice encapsulates the attributes of the voice used to synthesize speech on the system.
 
 @discussion
 Retrieve a voice by specifying the language code your text should be spoken in, or by using voiceWithIdentifier
 for a known voice identifier.
 */
@available(iOS 7.0, *)
class AVSpeechSynthesisVoice : Object, SecureCoding {
  class func speechVoices() -> [AVSpeechSynthesisVoice]
  class func currentLanguageCode() -> String

  /*!
   @method        voiceWithLanguage:
   @abstract      Use a BCP-47 language tag to specify the desired language and region.
   @param			language
   Specifies the BCP-47 language tag that represents the voice.
   @discussion
   The default is the system's region and language.
   Passing in nil will return the default voice.
   Passing in an invalid languageCode will return nil.
   Will return enhanced quality voice if available, default quality otherwise.
   Examples: en-US (U.S. English), fr-CA (French Canadian)
   */
  /*not inherited*/ init?(language languageCode: String?)

  /*!
   @method        voiceWithIdentifier:
   @abstract      Retrieve a voice by its identifier.
   @param			identifier
   A unique identifier for a voice.
   @discussion
   Passing in an invalid identifier will return nil.
   Returns nil if the identifier is valid, but the voice is not available on device (i.e. not yet downloaded by the user).
   */
  @available(iOS 9.0, *)
  /*not inherited*/ init?(identifier: String)
  var language: String { get }
  @available(iOS 9.0, *)
  var identifier: String { get }
  @available(iOS 9.0, *)
  var name: String { get }
  @available(iOS 9.0, *)
  var quality: AVSpeechSynthesisVoiceQuality { get }
  init()
  @available(iOS 7.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 7.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!
 @class AVSpeechUtterance
 @abstract
 AVSpeechUtterance is the atom of speaking a string or pausing the synthesizer.
 
 @discussion
 To start speaking, specify the AVSpeechSynthesisVoice and the string to be spoken, then optionally change the rate, pitch or volume if desired.
 */
@available(iOS 7.0, *)
class AVSpeechUtterance : Object, Copying, SecureCoding {
  init(string: String)
  var voice: AVSpeechSynthesisVoice?
  var speechString: String { get }
  var rate: Float
  var pitchMultiplier: Float
  var volume: Float
  var preUtteranceDelay: TimeInterval
  var postUtteranceDelay: TimeInterval
  init()
  @available(iOS 7.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 7.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 7.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
}

/*!
 @class AVSpeechSynthesizer
 @abstract
 AVSpeechSynthesizer allows speaking of speech utterances with a basic queuing mechanism.
 
 @discussion
 Create an instance of AVSpeechSynthesizer to start generating synthesized speech by using AVSpeechUtterance objects.
 */
@available(iOS 7.0, *)
class AVSpeechSynthesizer : Object {
  unowned(unsafe) var delegate: @sil_unmanaged AVSpeechSynthesizerDelegate?
  var isSpeaking: Bool { get }
  var isPaused: Bool { get }
  func speak(utterance: AVSpeechUtterance)
  func stopSpeakingAt(boundary: AVSpeechBoundary) -> Bool
  func pauseSpeakingAt(boundary: AVSpeechBoundary) -> Bool
  func continueSpeaking() -> Bool
  init()
}

/*!
 @protocol AVSpeechSynthesizerDelegate
 @abstract
 Defines an interface for delegates of AVSpeechSynthesizer to receive notifications of important speech utterance events.
 */
protocol AVSpeechSynthesizerDelegate : ObjectProtocol {
  @available(iOS 7.0, *)
  optional func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance)
  @available(iOS 7.0, *)
  optional func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance)
  @available(iOS 7.0, *)
  optional func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance)
  @available(iOS 7.0, *)
  optional func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance)
  @available(iOS 7.0, *)
  optional func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance)
  @available(iOS 7.0, *)
  optional func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance)
}
@available(iOS 4.0, *)
class AVSynchronizedLayer : CALayer {

  /*!
  	@method			synchronizedLayerWithPlayerItem:
  	@abstract		Returns an instance of AVSynchronizedLayer with timing synchronized with the specified AVPlayerItem.
  	@result			An instance of AVSynchronizedLayer.
  */
  /*not inherited*/ init(playerItem: AVPlayerItem)
  var playerItem: AVPlayerItem?
  init()
  init(layer: AnyObject)
  init?(coder aDecoder: Coder)
}
@available(iOS 6.0, *)
class AVTextStyleRule : Object, Copying {

  /*!
   @method		propertyListForTextStyleRules:
   @abstract		Converts an NSArray of AVTextStyleRules into a serializable property list that can be used for persistent storage.
   @param			textStyleRules
   				An array of AVTextStyleRules.
   @result		A serializable property list.
   @discussion	For serialization utilities, see NSPropertyList.h.
  */
  class func propertyListFor(textStyleRules: [AVTextStyleRule]) -> AnyObject

  /*!
   @method		textStyleRulesFromPropertyList:
   @abstract		Converts a property list into an NSArray of AVTextStyleRules.
   @param			plist
   				A property list, normally obtained previously via an invocation of +propertyListForTextStyleRules:.
   @result		An NSArray of AVTextStyleRules
  */
  class func textStyleRulesFromPropertyList(plist: AnyObject) -> [AVTextStyleRule]?

  /*!
   @method		initWithTextMarkupAttributes:
   @abstract		Creates an instance of AVTextStyleRule with the specified text markup attributes.
   @param			textMarkupAttributes
   				An NSDictionary with keys representing text style attributes that are specifiable in text markup. Eligible keys are defined in <CoreMedia/CMTextMarkup.h>.
   @result		An instance of AVTextStyleRule
   @discussion	Equivalent to invoking -initWithTextMarkupAttributes:textSelector: with a value of nil for textSelector.
  */
  convenience init?(textMarkupAttributes: [String : AnyObject] = [:])

  /*!
   @method		initWithTextMarkupAttributes:textSelector:
   @abstract		Creates an instance of AVTextStyleRule with the specified text markup attributes and an identifier for the range or ranges of text to which the attributes should be applied.
   @param			textMarkupAttributes
   				An NSDictionary with keys representing text style attributes that are specifiable in text markup. Eligible keys are defined in <CoreMedia/CMTextMarkup.h>.
   @param			textSelector
  				An identifier for the range or ranges of text to which the attributes should be applied. Eligible identifiers are determined by the format and content of the legible media. A value of nil indicates that the textMarkupAttributes should be applied as default styles for all text unless overridden by content markup or other applicable text selectors.
   @result		An instance of AVTextStyleRule
  */
  init?(textMarkupAttributes: [String : AnyObject] = [:], textSelector: String?)

  /*!
   @property		textMarkupAttributes
   @abstract		An NSDictionary with keys representing text style attributes that are specifiable in text markup. Eligible keys and the expected types of their corresponding values are defined in <CoreMedia/CMTextMarkup.h>.
  */
  var textMarkupAttributes: [String : AnyObject] { get }

  /*!
   @property		textSelector
   @abstract		A string that identifies the range or ranges of text to which the attributes should be applied. A value of nil indicates that the textMarkupAttributes should be applied as default styles for all text unless overridden by content markup or other applicable text selectors.
   @dicussion		The syntax of text selectors is determined by the format of the legible media. Eligible selectors may be determined by the content of the legible media (e.g. CSS selectors that are valid for a specific WebVTT document).
  */
  var textSelector: String? { get }
  @available(iOS 6.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
extension Value {
  @available(iOS 4.0, *)
  /*not inherited*/ init(cmTime time: CMTime)
  @available(iOS 4.0, *)
  var cmTimeValue: CMTime { get }
  @available(iOS 4.0, *)
  /*not inherited*/ init(cmTimeRange timeRange: CMTimeRange)
  @available(iOS 4.0, *)
  var cmTimeRangeValue: CMTimeRange { get }
  @available(iOS 4.0, *)
  /*not inherited*/ init(cmTimeMapping timeMapping: CMTimeMapping)
  @available(iOS 4.0, *)
  var cmTimeMappingValue: CMTimeMapping { get }
}
extension Coder {
  @available(iOS 4.0, *)
  func encode(time: CMTime, forKey key: String)
  @available(iOS 4.0, *)
  func decodeCMTimeForKey(key: String) -> CMTime
  @available(iOS 4.0, *)
  func encode(timeRange: CMTimeRange, forKey key: String)
  @available(iOS 4.0, *)
  func decodeCMTimeRangeForKey(key: String) -> CMTimeRange
  @available(iOS 4.0, *)
  func encode(timeMapping: CMTimeMapping, forKey key: String)
  @available(iOS 4.0, *)
  func decodeCMTimeMappingForKey(key: String) -> CMTimeMapping
}

/*!
	@class		AVMetadataGroup
 
	@abstract	AVMetadataGroup is the common superclass for AVTimedMetadataGroup and AVDateRangeMetadataGroup; each represents a collection of metadata items associated with a segment of a timeline. AVTimedMetadataGroup is typically used with content that defines an independent timeline, while AVDateRangeMetadataGroup is typically used with content that's associated with a specific range of dates.
*/
@available(iOS 9.0, *)
class AVMetadataGroup : Object {
  var items: [AVMetadataItem] { get }
  init()
}

/*!
	@class		AVTimedMetadataGroup
 
	@abstract	AVTimedMetadataGroup is used to represent a collection of metadata items that are valid for use during a specific range of time. For example, AVTimedMetadataGroups are used to represent chapters, optionally containing metadata items for chapter titles and chapter images.
*/
@available(iOS 4.3, *)
class AVTimedMetadataGroup : AVMetadataGroup, Copying, MutableCopying {

  /*!
  	@method		initWithItems:timeRange:
  	@abstract	Initializes an instance of AVTimedMetadataGroup with a collection of metadata items.
  	@param		items
  				An NSArray of AVMetadataItems.
  	@param		timeRange
  				The timeRange of the collection of AVMetadataItems.
  	@result		An instance of AVTimedMetadataGroup.
  */
  init(items: [AVMetadataItem], timeRange: CMTimeRange)

  /*!
  	@method		initWithSampleBuffer:
  	@abstract	Initializes an instance of AVTimedMetadataGroup with a sample buffer.
  	@param		sampleBuffer
  				A CMSampleBuffer with media type kCMMediaType_Metadata.
  	@result		An instance of AVTimedMetadataGroup.
  */
  @available(iOS 8.0, *)
  init?(sampleBuffer: CMSampleBuffer)
  var timeRange: CMTimeRange { get }
  var items: [AVMetadataItem] { get }
  init()
  @available(iOS 4.3, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 4.3, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
extension AVTimedMetadataGroup {

  /*!
  	@method		copyFormatDescription
  	@abstract	Creates a format description based on the receiver's items.
  	@result		An instance of CMMetadataFormatDescription sufficient to describe the contents of all the items referenced by the receiver.
  	@discussion
  		The returned format description is suitable for use as the format hint parameter when creating an instance of AVAssetWriterInput.
   
  		Each item referenced by the receiver must carry a non-nil value for its dataType property.  An exception will be thrown if any item does not have a data type.
  */
  @available(iOS 8.0, *)
  func copyFormatDescription() -> CMMetadataFormatDescription?
}

/*!
	@class		AVMutableTimedMetadataGroup
 
	@abstract	AVMutableTimedMetadataGroup is used to represent a mutable collection of metadata items that are valid for use during a specific range of time.
*/
@available(iOS 4.3, *)
class AVMutableTimedMetadataGroup : AVTimedMetadataGroup {
  var timeRange: CMTimeRange
  var items: [AVMetadataItem]

  /*!
  	@method		initWithItems:timeRange:
  	@abstract	Initializes an instance of AVTimedMetadataGroup with a collection of metadata items.
  	@param		items
  				An NSArray of AVMetadataItems.
  	@param		timeRange
  				The timeRange of the collection of AVMetadataItems.
  	@result		An instance of AVTimedMetadataGroup.
  */
  init(items: [AVMetadataItem], timeRange: CMTimeRange)

  /*!
  	@method		initWithSampleBuffer:
  	@abstract	Initializes an instance of AVTimedMetadataGroup with a sample buffer.
  	@param		sampleBuffer
  				A CMSampleBuffer with media type kCMMediaType_Metadata.
  	@result		An instance of AVTimedMetadataGroup.
  */
  @available(iOS 8.0, *)
  init?(sampleBuffer: CMSampleBuffer)
  init()
}

/*!
	@class		AVDateRangeMetadataGroup
 
	@abstract	AVDateRangeMetadataGroup is used to represent a collection of metadata items that are valid for use within a specific range of dates.
*/
@available(iOS 9.0, *)
class AVDateRangeMetadataGroup : AVMetadataGroup, Copying, MutableCopying {

  /*!
  	@method		initWithItems:startDate:endDate:
  	@abstract	Initializes an instance of AVDateRangeMetadataGroup with a collection of metadata items.
  	@param		items
  				An NSArray of AVMetadataItems.
  	@param		startDate
  				The start date of the collection of AVMetadataItems.
  	@param		endDate
  				The end date of the collection of AVMetadataItems. If the receiver is intended to represent information about an instantaneous event, the value of endDate should be equal to the value of startDate. A value of nil for endDate indicates that the endDate is indefinite.
  	@result		An instance of AVDateRangeMetadataGroup.
  */
  init(items: [AVMetadataItem], start startDate: Date, end endDate: Date?)
  @NSCopying var startDate: Date { get }
  @NSCopying var endDate: Date? { get }
  var items: [AVMetadataItem] { get }
  init()
  @available(iOS 9.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 9.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}

/*!
	@class		AVMutableDateRangeMetadataGroup
 
	@abstract	AVMutableDateRangeMetadataGroup is used to represent a mutable collection of metadata items that are valid for use within a specific range of dates.
*/
@available(iOS 9.0, *)
class AVMutableDateRangeMetadataGroup : AVDateRangeMetadataGroup {
  @NSCopying var startDate: Date
  @NSCopying var endDate: Date?
  var items: [AVMetadataItem]

  /*!
  	@method		initWithItems:startDate:endDate:
  	@abstract	Initializes an instance of AVDateRangeMetadataGroup with a collection of metadata items.
  	@param		items
  				An NSArray of AVMetadataItems.
  	@param		startDate
  				The start date of the collection of AVMetadataItems.
  	@param		endDate
  				The end date of the collection of AVMetadataItems. If the receiver is intended to represent information about an instantaneous event, the value of endDate should be equal to the value of startDate. A value of nil for endDate indicates that the endDate is indefinite.
  	@result		An instance of AVDateRangeMetadataGroup.
  */
  init(items: [AVMetadataItem], start startDate: Date, end endDate: Date?)
  init()
}

/*!
 @function					AVMakeRectWithAspectRatioInsideRect
 @abstract					Returns a scaled CGRect that maintains the aspect ratio specified by a CGSize within a bounding CGRect.
 @discussion				This is useful when attempting to fit the presentationSize property of an AVPlayerItem within the bounds of another CALayer. 
							You would typically use the return value of this function as an AVPlayerLayer frame property value. For example:
							myPlayerLayer.frame = AVMakeRectWithAspectRatioInsideRect(myPlayerItem.presentationSize, mySuperLayer.bounds);
 @param aspectRatio			The width & height ratio, or aspect, you wish to maintain.
 @param	boundingRect		The bounding CGRect you wish to fit into. 
 */
@available(iOS 4.0, *)
func AVMakeRectWithAspectRatioInsideRect(aspectRatio: CGSize, _ boundingRect: CGRect) -> CGRect
struct AVPixelAspectRatio {
  var horizontalSpacing: Int
  var verticalSpacing: Int
  init()
  init(horizontalSpacing: Int, verticalSpacing: Int)
}
struct AVEdgeWidths {
  var left: CGFloat
  var top: CGFloat
  var right: CGFloat
  var bottom: CGFloat
  init()
  init(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat)
}
@available(iOS 7.0, *)
class AVVideoCompositionRenderContext : Object {
  var size: CGSize { get }
  var renderTransform: CGAffineTransform { get }
  var renderScale: Float { get }
  var pixelAspectRatio: AVPixelAspectRatio { get }
  var edgeWidths: AVEdgeWidths { get }
  var highQualityRendering: Bool { get }
  var videoComposition: AVVideoComposition { get }

  /*!
  	@method			newPixelBuffer
  	@abstract		Vends a CVPixelBuffer to use for rendering
  	@discussion
  					The buffer will have its kCVImageBufferCleanApertureKey and kCVImageBufferPixelAspectRatioKey attachments set to match the current composition processor properties.
  					 
  */
  func newPixelBuffer() -> CVPixelBuffer?
  init()
}

/*!
	@protocol		AVVideoCompositing
	@abstract		Defines properties and methods for custom video compositors
	@discussion
		For each AVFoundation object of class AVPlayerItem, AVAssetExportSession, AVAssetImageGenerator, or AVAssetReaderVideoCompositionOutput that has a non-nil value for its videoComposition property, when the value of the customVideoCompositorClass property of the AVVideoComposition is not Nil, AVFoundation creates and uses an instance of that custom video compositor class to process the instructions contained in the AVVideoComposition. The custom video compositor instance will be created when you invoke -setVideoComposition: with an instance of AVVideoComposition that's associated with a different custom video compositor class than the object was previously using.

		When creating instances of custom video compositors, AVFoundation initializes them by calling -init and then makes them available to you for further set-up or communication, if any is needed, as the value of the customVideoCompositor property of the object on which -setVideoComposition: was invoked.

		Custom video compositor instances will then be retained by the AVFoundation object for as long as the value of its videoComposition property indicates that an instance of the same custom video compositor class should be used, even if the value is changed from one instance of AVVideoComposition to another instance that's associated with the same custom video compositor class.
*/
@available(iOS 7.0, *)
protocol AVVideoCompositing : ObjectProtocol {
  var sourcePixelBufferAttributes: [String : AnyObject]? { get }
  var requiredPixelBufferAttributesForRenderContext: [String : AnyObject] { get }

  /*!
      @method			renderContextChanged:
  	@abstract       Called to notify the custom compositor that a composition will switch to a different render context
  	@param			newRenderContext
  					The render context that will be handling the video composition from this point
      @discussion
  					Instances of classes implementing the AVVideoComposting protocol can implement this method to be notified when
  					the AVVideoCompositionRenderContext instance handing a video composition changes. AVVideoCompositionRenderContext instances
  					being immutable, such a change will occur every time there is a change in the video composition parameters.
  */
  func renderContextChanged(newRenderContext: AVVideoCompositionRenderContext)

  /*!
  	@method			startVideoCompositionRequest:
  	@abstract		Directs a custom video compositor object to create a new pixel buffer composed asynchronously from a collection of sources.
  	@param			asyncVideoCompositionRequest
      				An instance of AVAsynchronousVideoCompositionRequest that provides context for the requested composition.
  	@discussion
  		The custom compositor is expected to invoke, either subsequently or immediately, either:
  		-[AVAsynchronousVideoCompositionRequest finishWithComposedVideoFrame:] or
  		-[AVAsynchronousVideoCompositionRequest finishWithError:]. If you intend to finish rendering the frame after your
  		handling of this message returns, you must retain the instance of AVAsynchronousVideoCompositionRequest until after composition is finished.
  		Note that if the custom compositor's implementation of -startVideoCompositionRequest: returns without finishing the composition immediately,
  		it may be invoked again with another composition request before the prior request is finished; therefore in such cases the custom compositor should
  		be prepared to manage multiple composition requests.
  
  		If the rendered frame is exactly the same as one of the source frames, with no letterboxing, pillboxing or cropping needed,
  		then the appropriate source pixel buffer may be returned (after CFRetain has been called on it).
  */
  func start(asyncVideoCompositionRequest: AVAsynchronousVideoCompositionRequest)

  /*!
  	@method			cancelAllPendingVideoCompositionRequests	
  	@abstract		Directs a custom video compositor object to cancel or finish all pending video composition requests
  	@discussion
  		When receiving this message, a custom video compositor must block until it has either cancelled all pending frame requests,
  		and called the finishCancelledRequest callback for each of them, or, if cancellation is not possible, finished processing of all the frames
  		and called the finishWithComposedVideoFrame: callback for each of them.
  */
  optional func cancelAllPendingVideoCompositionRequests()
}
@available(iOS 7.0, *)
class AVAsynchronousVideoCompositionRequest : Object, Copying {
  var renderContext: AVVideoCompositionRenderContext { get }
  var compositionTime: CMTime { get }
  var sourceTrackIDs: [Number] { get }
  var videoCompositionInstruction: AVVideoCompositionInstructionProtocol { get }

  /*!
      @method			sourceFrameByTrackID:
  	@abstract       Returns the source CVPixelBufferRef for the given track ID
  	@param			trackID
  					The track ID for the requested source frame
  */
  func sourceFrameByTrackID(trackID: CMPersistentTrackID) -> CVPixelBuffer?
  func finishWithComposedVideoFrame(composedVideoFrame: CVPixelBuffer)
  func finishWithError(error: Error)
  func finishCancelledRequest()
  init()
  @available(iOS 7.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 9.0, *)
class AVAsynchronousCIImageFilteringRequest : Object, Copying {
  var renderSize: CGSize { get }
  var compositionTime: CMTime { get }
  func finishWithError(error: Error)
  init()
  @available(iOS 9.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
}

/*!
	@protocol	AVVideoCompositionInstruction
 
	@abstract	The AVVideoCompositionInstruction protocol is implemented by objects to represent operations to be performed by a compositor.
*/
@available(iOS 7.0, *)
protocol AVVideoCompositionInstructionProtocol : ObjectProtocol {
  var timeRange: CMTimeRange { get }
  var enablePostProcessing: Bool { get }
  var containsTweening: Bool { get }
  var requiredSourceTrackIDs: [Value]? { get }
  var passthroughTrackID: CMPersistentTrackID { get }
}

/*!
	@class		AVVideoCompositionRenderContext
 
	@abstract	The AVVideoCompositionRenderContext class defines the context within which custom compositors render new output pixels buffers.
 
	@discussion
		An instance of AVVideoCompositionRenderContext provides size and scaling information and offers a service for efficiently providing pixel buffers from a managed pool of buffers.
*/
@available(iOS 4.0, *)
class AVVideoComposition : Object, Copying, MutableCopying {
  @available(iOS 6.0, *)
  /*not inherited*/ init(propertiesOf asset: AVAsset)
  @available(iOS 7.0, *)
  var customVideoCompositorClass: AnyObject.Type? { get }
  var frameDuration: CMTime { get }
  var renderSize: CGSize { get }
  var renderScale: Float { get }
  var instructions: [AVVideoCompositionInstructionProtocol] { get }
  var animationTool: AVVideoCompositionCoreAnimationTool? { get }
  init()
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 4.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
extension AVVideoComposition {
  @available(iOS 9.0, *)
  /*not inherited*/ init(asset: AVAsset, applyingCIFiltersWithHandler applier: (AVAsynchronousCIImageFilteringRequest) -> Void)
}
@available(iOS 4.0, *)
class AVMutableVideoComposition : AVVideoComposition {
  @available(iOS 6.0, *)
  /*not inherited*/ init(propertiesOf asset: AVAsset)
  @available(iOS 7.0, *)
  var customVideoCompositorClass: AnyObject.Type?
  var frameDuration: CMTime
  var renderSize: CGSize
  var renderScale: Float
  var instructions: [AVVideoCompositionInstructionProtocol]
  var animationTool: AVVideoCompositionCoreAnimationTool?
  init()
}
extension AVMutableVideoComposition {
  @available(iOS 9.0, *)
  /*not inherited*/ init(asset: AVAsset, applyingCIFiltersWithHandler applier: (AVAsynchronousCIImageFilteringRequest) -> Void)
}
@available(iOS 4.0, *)
class AVVideoCompositionInstruction : Object, SecureCoding, Copying, MutableCopying, AVVideoCompositionInstructionProtocol {
  var timeRange: CMTimeRange { get }
  var backgroundColor: CGColor? { get }
  var layerInstructions: [AVVideoCompositionLayerInstruction] { get }
  var enablePostProcessing: Bool { get }
  @available(iOS 7.0, *)
  var requiredSourceTrackIDs: [Value] { get }
  @available(iOS 7.0, *)
  var passthroughTrackID: CMPersistentTrackID { get }
  init()
  @available(iOS 4.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 4.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 4.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 7.0, *)
  var containsTweening: Bool { get }
}
@available(iOS 4.0, *)
class AVMutableVideoCompositionInstruction : AVVideoCompositionInstruction {
  var timeRange: CMTimeRange
  var backgroundColor: CGColor?
  var layerInstructions: [AVVideoCompositionLayerInstruction]
  var enablePostProcessing: Bool
  init()
  init?(coder aDecoder: Coder)
}
@available(iOS 4.0, *)
class AVVideoCompositionLayerInstruction : Object, SecureCoding, Copying, MutableCopying {
  var trackID: CMPersistentTrackID { get }
  func getTransformRampFor(time: CMTime, start startTransform: UnsafeMutablePointer<CGAffineTransform>, end endTransform: UnsafeMutablePointer<CGAffineTransform>, timeRange: UnsafeMutablePointer<CMTimeRange>) -> Bool
  func getOpacityRampFor(time: CMTime, startOpacity: UnsafeMutablePointer<Float>, endOpacity: UnsafeMutablePointer<Float>, timeRange: UnsafeMutablePointer<CMTimeRange>) -> Bool
  @available(iOS 7.0, *)
  func getCropRectangleRampFor(time: CMTime, startCropRectangle: UnsafeMutablePointer<CGRect>, endCropRectangle: UnsafeMutablePointer<CGRect>, timeRange: UnsafeMutablePointer<CMTimeRange>) -> Bool
  init()
  @available(iOS 4.0, *)
  class func supportsSecureCoding() -> Bool
  @available(iOS 4.0, *)
  func encodeWith(aCoder: Coder)
  init?(coder aDecoder: Coder)
  @available(iOS 4.0, *)
  func copy(zone zone: Zone = nil) -> AnyObject
  @available(iOS 4.0, *)
  func mutableCopy(zone zone: Zone = nil) -> AnyObject
}
@available(iOS 4.0, *)
class AVMutableVideoCompositionLayerInstruction : AVVideoCompositionLayerInstruction {
  convenience init(assetTrack track: AVAssetTrack)
  var trackID: CMPersistentTrackID
  func setTransformRampFromStart(startTransform: CGAffineTransform, toEnd endTransform: CGAffineTransform, timeRange: CMTimeRange)
  func setTransform(transform: CGAffineTransform, at time: CMTime)
  func setOpacityRampFromStartOpacity(startOpacity: Float, toEndOpacity endOpacity: Float, timeRange: CMTimeRange)
  func setOpacity(opacity: Float, at time: CMTime)
  @available(iOS 7.0, *)
  func setCropRectangleRampFromStartCropRectangle(startCropRectangle: CGRect, toEndCropRectangle endCropRectangle: CGRect, timeRange: CMTimeRange)
  @available(iOS 7.0, *)
  func setCropRectangle(cropRectangle: CGRect, at time: CMTime)
  init()
  init?(coder aDecoder: Coder)
}

/*!
	@class		AVVideoComposition
 
	@abstract	An AVVideoComposition object represents an immutable video composition.
 
	@discussion	
		A video composition describes, for any time in the aggregate time range of its instructions, the number and IDs of video tracks that are to be used in order to produce a composed video frame corresponding to that time. When AVFoundation's built-in video compositor is used, the instructions an AVVideoComposition contain can specify a spatial transformation, an opacity value, and a cropping rectangle for each video source, and these can vary over time via simple linear ramping functions.
 
		A client can implement their own custom video compositor by implementing the AVVideoCompositing protocol; a custom video compositor is provided with pixel buffers for each of its video sources during playback and other operations and can perform arbitrary graphical operations on them in order to produce visual output.
*/
@available(iOS 4.0, *)
class AVVideoCompositionCoreAnimationTool : Object {

  /*!
   	@method						videoCompositionCoreAnimationToolWithAdditionalLayer:asTrackID:
  	@abstract					Add a Core Animation layer to the video composition
  	@discussion					Include a Core Animation layer as an individual track input in video composition.
  								This layer should not come from, or be added to, another layer tree.
  								trackID should not match any real trackID in the source. Use -[AVAsset unusedTrackID] 
  								to obtain a trackID that's guaranteed not to coincide with the trackID of any track of the asset.
  								AVVideoCompositionInstructions should reference trackID where the rendered animation should be included.
  								For best performance, no transform should be set in the AVVideoCompositionLayerInstruction for this trackID.
  								Be aware that on iOS, CALayers backing a UIView usually have their content flipped (as defined by the
  								-contentsAreFlipped method). It may be required to insert a CALayer with its geometryFlipped property set
  								to YES in the layer hierarchy to get the same result when attaching a CALayer to a AVVideoCompositionCoreAnimationTool
  								as when using it to back a UIView.
  */
  convenience init(additionalLayer layer: CALayer, asTrackID trackID: CMPersistentTrackID)

  /*!
  	@method						videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:inLayer:
  	@abstract					Compose the composited video frames with the Core Animation layer
  	@discussion					Place composited video frames in videoLayer and render animationLayer 
  								to produce the final frame. Normally videoLayer should be in animationLayer's sublayer tree.
  								The animationLayer should not come from, or be added to, another layer tree.
  								Be aware that on iOS, CALayers backing a UIView usually have their content flipped (as defined by the
  								-contentsAreFlipped method). It may be required to insert a CALayer with its geometryFlipped property set
  								to YES in the layer hierarchy to get the same result when attaching a CALayer to a AVVideoCompositionCoreAnimationTool
  								as when using it to back a UIView.
  */
  convenience init(postProcessingAsVideoLayer videoLayer: CALayer, in animationLayer: CALayer)

  /*!
  	@method						videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayers:inLayer:
  	@abstract					Compose the composited video frames with the Core Animation layer
  	@discussion					Duplicate the composited video frames in each videoLayer and render animationLayer 
  								to produce the final frame. Normally videoLayers should be in animationLayer's sublayer tree.
  								The animationLayer should not come from, or be added to, another layer tree.
  								Be aware that on iOS, CALayers backing a UIView usually have their content flipped (as defined by the
  								-contentsAreFlipped method). It may be required to insert a CALayer with its geometryFlipped property set
  								to YES in the layer hierarchy to get the same result when attaching a CALayer to a AVVideoCompositionCoreAnimationTool
  								as when using it to back a UIView.
  */
  @available(iOS 7.0, *)
  convenience init(postProcessingAsVideoLayers videoLayers: [CALayer], in animationLayer: CALayer)
  init()
}
extension AVAsset {
  func unusedTrackID() -> CMPersistentTrackID
}
extension AVVideoComposition {

  /*!
   @method		isValidForAsset:timeRange:validationDelegate:
   @abstract
     Indicates whether the timeRanges of the receiver's instructions conform to the requirements described for them immediately above (in connection with the instructions property) and also whether all of the layer instructions have a value for trackID that corresponds either to a track of the specified asset or to the receiver's animationTool. 
   @param			asset
      Pass a reference to an AVAsset if you wish to validate the timeRanges of the instructions against the duration of the asset and the trackIDs of the layer instructions against the asset's tracks. Pass nil to skip that validation. Clients should ensure that the keys @"tracks" and @"duration" are already loaded on the AVAsset before validation is attempted.
   @param			timeRange
     A CMTimeRange.  Only those instuctions with timeRanges that overlap with the specified timeRange will be validated. To validate all instructions that may be used for playback or other processing, regardless of timeRange, pass CMTimeRangeMake(kCMTimeZero, kCMTimePositiveInfinity).
   @param			validationDelegate
     Indicates an object implementing the AVVideoCompositionValidationHandling protocol to receive information about troublesome portions of a video composition during processing of -isValidForAsset:. May be nil.
  @discussion
     In the course of validation, the receiver will invoke its validationDelegate with reference to any trouble spots in the video composition.
     An exception will be raised if the delegate modifies the receiver's array of instructions or the array of layerInstructions of any AVVideoCompositionInstruction contained therein during validation.
  */
  @available(iOS 5.0, *)
  func isValidFor(asset: AVAsset?, timeRange: CMTimeRange, validationDelegate: AVVideoCompositionValidationHandling?) -> Bool
}
protocol AVVideoCompositionValidationHandling : ObjectProtocol {

  /*!
   @method		videoComposition:shouldContinueValidatingAfterFindingInvalidValueForKey:
   @abstract
     Invoked by an instance of AVVideoComposition when validating an instance of AVVideoComposition, to report a key that has an invalid value.
   @result
     An indication of whether the AVVideoComposition should continue validation in order to report additional problems that may exist.
  */
  @available(iOS 5.0, *)
  optional func videoComposition(videoComposition: AVVideoComposition, shouldContinueValidatingAfterFindingInvalidValueForKey key: String) -> Bool

  /*!
   @method		videoComposition:shouldContinueValidatingAfterFindingEmptyTimeRange:
   @abstract
     Invoked by an instance of AVVideoComposition when validating an instance of AVVideoComposition, to report a timeRange that has no corresponding video composition instruction.
   @result
     An indication of whether the AVVideoComposition should continue validation in order to report additional problems that may exist.
  */
  @available(iOS 5.0, *)
  optional func videoComposition(videoComposition: AVVideoComposition, shouldContinueValidatingAfterFindingEmpty timeRange: CMTimeRange) -> Bool

  /*!
   @method		videoComposition:shouldContinueValidatingAfterFindingInvalidTimeRangeInInstruction:
   @abstract
     Invoked by an instance of AVVideoComposition when validating an instance of AVVideoComposition, to report a video composition instruction with a timeRange that's invalid, that overlaps with the timeRange of a prior instruction, or that contains times earlier than the timeRange of a prior instruction.
   @discussion
     Use CMTIMERANGE_IS_INVALID, defined in CMTimeRange.h, to test whether the timeRange itself is invalid. Refer to headerdoc for AVVideoComposition.instructions for a discussion of how timeRanges for instructions must be formulated.
   @result
     An indication of whether the AVVideoComposition should continue validation in order to report additional problems that may exist.
  */
  @available(iOS 5.0, *)
  optional func videoComposition(videoComposition: AVVideoComposition, shouldContinueValidatingAfterFindingInvalidTimeRangeIn videoCompositionInstruction: AVVideoCompositionInstructionProtocol) -> Bool

  /*!
   @method		videoComposition:shouldContinueValidatingAfterFindingInvalidTrackIDInInstruction:layerInstruction:asset:
   @abstract
     Invoked by an instance of AVVideoComposition when validating an instance of AVVideoComposition, to report a video composition layer instruction with a trackID that does not correspond either to the trackID used for the composition's animationTool or to a track of the asset specified in -[AVVideoComposition isValidForAsset:timeRange:delegate:].
   @result
     An indication of whether the AVVideoComposition should continue validation in order to report additional problems that may exist.
  */
  @available(iOS 5.0, *)
  optional func videoComposition(videoComposition: AVVideoComposition, shouldContinueValidatingAfterFindingInvalidTrackIDIn videoCompositionInstruction: AVVideoCompositionInstructionProtocol, layerInstruction: AVVideoCompositionLayerInstruction, asset: AVAsset) -> Bool
}

/*!
 @header AVVideoSettings
 @abstract
	NSDictionary keys for configuring output video format
	
 @discussion
	A video settings dictionary may take one of two forms:
	
	1. For compressed video output, use only the keys in this header, AVVideoSettings.h.
	2. For uncompressed video output, start with kCVPixelBuffer* keys in <CoreVideo/CVPixelBuffer.h>.
	
	In addition to the keys in CVPixelBuffer.h, uncompressed video settings dictionaries may also contain the following keys:
 
		AVVideoPixelAspectRatioKey
		AVVideoCleanApertureKey
		AVVideoScalingModeKey
		AVVideoColorPropertiesKey
 
	It is an error to add any other AVVideoSettings.h keys to an uncompressed video settings dictionary.
*/
@available(iOS 4.0, *)
let AVVideoCodecKey: String
@available(iOS 4.0, *)
let AVVideoCodecH264: String
@available(iOS 4.0, *)
let AVVideoCodecJPEG: String
@available(iOS 4.0, *)
let AVVideoWidthKey: String
@available(iOS 4.0, *)
let AVVideoHeightKey: String

/*!
 @constant	AVVideoPixelAspectRatioKey
 @abstract	The aspect ratio of the pixels in the video frame
 @discussion
	The value for this key is an NSDictionary containing AVVideoPixelAspectRatio*Key keys.  If no value is specified for this key, the default value for the codec is used.  Usually this is 1:1, meaning square pixels.
 
	Note that prior to OS X 10.9 and iOS 7.0, this key could only be specified as part of the dictionary given for AVVideoCompressionPropertiesKey.  As of OS X 10.9 and iOS 7.0, the top level of an AVVideoSettings dictionary is the preferred place to specify this key.
*/
@available(iOS 4.0, *)
let AVVideoPixelAspectRatioKey: String
@available(iOS 4.0, *)
let AVVideoPixelAspectRatioHorizontalSpacingKey: String
@available(iOS 4.0, *)
let AVVideoPixelAspectRatioVerticalSpacingKey: String

/*!
 @constant	AVVideoCleanApertureKey
 @abstract	Defines the region within the video dimensions that will be displayed during playback
 @discussion
	The value for this key is an NSDictionary containing AVVideoCleanAperture*Key keys.  AVVideoCleanApertureWidthKey and AVVideoCleanApertureHeightKey define a clean rectangle which is centered on the video frame.  To offset this rectangle from center, use AVVideoCleanApertureHorizontalOffsetKey and AVVideoCleanApertureVerticalOffsetKey.  A positive value for AVVideoCleanApertureHorizontalOffsetKey moves the clean aperture region to the right, and a positive value for AVVideoCleanApertureVerticalOffsetKey moves the clean aperture region down.
 
	If no clean aperture region is specified, the entire frame will be displayed during playback.
 
	Note that prior to OS X 10.9 and iOS 7.0, this key could only be specified as part of the dictionary given for AVVideoCompressionPropertiesKey.  As of OS X 10.9 and iOS 7.0, the top level of an AVVideoSettings dictionary is the preferred place to specify this key.
*/
@available(iOS 4.0, *)
let AVVideoCleanApertureKey: String
@available(iOS 4.0, *)
let AVVideoCleanApertureWidthKey: String
@available(iOS 4.0, *)
let AVVideoCleanApertureHeightKey: String
@available(iOS 4.0, *)
let AVVideoCleanApertureHorizontalOffsetKey: String
@available(iOS 4.0, *)
let AVVideoCleanApertureVerticalOffsetKey: String
@available(iOS 5.0, *)
let AVVideoScalingModeKey: String
@available(iOS 5.0, *)
let AVVideoScalingModeFit: String
@available(iOS 5.0, *)
let AVVideoScalingModeResize: String
@available(iOS 5.0, *)
let AVVideoScalingModeResizeAspect: String
@available(iOS 5.0, *)
let AVVideoScalingModeResizeAspectFill: String

/*!
 @constant	AVVideoCompressionPropertiesKey
 @abstract
	The value for this key is an instance of NSDictionary, containing properties to be passed down to the video encoder.
 @discussion
	Package the below keys in an instance of NSDictionary and use it as the value for AVVideoCompressionPropertiesKey in the top-level AVVideoSettings dictionary.  In addition to the keys listed below, you can also include keys from VideoToolbox/VTCompressionProperties.h.
 
	Most keys can only be used for certain encoders.  Look at individual keys for details.
 */
@available(iOS 4.0, *)
let AVVideoCompressionPropertiesKey: String
@available(iOS 4.0, *)
let AVVideoAverageBitRateKey: String
@available(iOS 5.0, *)
let AVVideoQualityKey: String
@available(iOS 4.0, *)
let AVVideoMaxKeyFrameIntervalKey: String
@available(iOS 7.0, *)
let AVVideoMaxKeyFrameIntervalDurationKey: String

/*!
	 @constant	AVVideoAllowFrameReorderingKey
	 @abstract
		 Enables or disables frame reordering.
	 @discussion
		 In order to achieve the best compression while maintaining image quality, some video encoders can reorder frames.  This means that the order in which the frames will be emitted and stored (the decode order) will be different from the order in which they are presented to the video encoder (the display order).
		
		Encoding using frame reordering requires more system resources than encoding without frame reordering, so encoding performance should be taken into account when deciding whether to enable frame reordering.  This is especially important when encoding video data from a real-time source, such as AVCaptureVideoDataOutput.  In this situation, using a value of @NO for AVVideoAllowFrameReorderingKey may yield the best results.
	 
		The default is @YES, which means that the encoder decides whether to enable frame reordering.
	 */
@available(iOS 7.0, *)
let AVVideoAllowFrameReorderingKey: String
@available(iOS 4.0, *)
let AVVideoProfileLevelKey: String
@available(iOS 4.0, *)
let AVVideoProfileLevelH264Baseline30: String
@available(iOS 4.0, *)
let AVVideoProfileLevelH264Baseline31: String
@available(iOS 5.0, *)
let AVVideoProfileLevelH264Baseline41: String
@available(iOS 7.0, *)
let AVVideoProfileLevelH264BaselineAutoLevel: String
@available(iOS 4.0, *)
let AVVideoProfileLevelH264Main30: String
@available(iOS 4.0, *)
let AVVideoProfileLevelH264Main31: String
@available(iOS 5.0, *)
let AVVideoProfileLevelH264Main32: String
@available(iOS 5.0, *)
let AVVideoProfileLevelH264Main41: String
@available(iOS 7.0, *)
let AVVideoProfileLevelH264MainAutoLevel: String
@available(iOS 6.0, *)
let AVVideoProfileLevelH264High40: String
@available(iOS 6.0, *)
let AVVideoProfileLevelH264High41: String
@available(iOS 7.0, *)
let AVVideoProfileLevelH264HighAutoLevel: String

/*!
	 @constant	AVVideoH264EntropyModeKey
	 @abstract
		The entropy encoding mode for H.264 compression.
	 @discussion
		If supported by an H.264 encoder, this property controls whether the encoder should use Context-based Adaptive Variable Length Coding (CAVLC) or Context-based Adaptive Binary Arithmetic Coding (CABAC).  CABAC generally gives better compression at the expense of higher computational overhead.  The default value is encoder-specific and may change depending on other encoder settings.  Care should be taken when using this property -- changes may result in a configuration which is not compatible with a requested Profile and Level.  Results in this case are undefined, and could include encode errors or a non-compliant output stream.
	*/
@available(iOS 7.0, *)
let AVVideoH264EntropyModeKey: String
@available(iOS 7.0, *)
let AVVideoH264EntropyModeCAVLC: String
@available(iOS 7.0, *)
let AVVideoH264EntropyModeCABAC: String

/*!
	 @constant	AVVideoExpectedSourceFrameRateKey
	 @abstract
		Indicates the expected source frame rate, if known.
	 @discussion
		The frame rate is measured in frames per second. This is not used to control the frame rate; it is provided as a hint to the video encoder so that it can set up internal configuration before compression begins. The actual frame rate will depend on frame durations and may vary. This should be set if an AutoLevel AVVideoProfileLevelKey is used, or if the source content has a high frame rate (higher than 30 fps). The encoder might have to drop frames to satisfy bit stream requirements if this key is not specified.
	 */
@available(iOS 7.0, *)
let AVVideoExpectedSourceFrameRateKey: String

/*!
	 @constant	AVVideoAverageNonDroppableFrameRateKey
	 @abstract
		The desired average number of non-droppable frames to be encoded for each second of video.
	 @discussion
		Some video encoders can produce a flexible mixture of non-droppable frames and droppable frames.  The difference between these types is that it is necessary for a video decoder to decode a non-droppable frame in order to successfully decode subsequent frames, whereas droppable frames are optional and can be skipped without impact on decode of subsequent frames.  Having a proportion of droppable frames in a sequence has advantages for temporal scalability: at playback time more or fewer frames may be decoded depending on the play rate.  This property requests that the encoder emit an overall proportion of non-droppable and droppable frames so that there are the specified number of non-droppable frames per second.
 
		For example, to specify that the encoder should include an average of 30 non-droppable frames for each second of video:
 
		[myVideoSettings setObject:@30 forKey:AVVideoAverageNonDroppableFrameRateKey];
	 */
@available(iOS 7.0, *)
let AVVideoAverageNonDroppableFrameRateKey: String
