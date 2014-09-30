## Import required classes in correct order
#import Plugin
#import PagesManager

#______________________________________________________________
#                                        AddressDetectionWidget
#
# Main AddressDetectionWidget class
#
# @author   Michal Katanski (mkatanski@nexway.com)
# @version 0.0.2
class AddressDetectionWidget extends Plugin

  #default options
  defaultOptions =
    formId: ''
    addressId: '#street'
    cityId: '#city'
    postalID: '#zip'
    postalFirstID: '#zip-first'
    postalSecondID: '#zip-second'
    countryID: '#country'
    texts:
      cancelBtn: 'cancel'
      tryAgainBtn: 'Try again'
      start:
        title: 'Location Detection'
        content: 'We can detect your address to simplify form filling. Just press the button below.'
        detectBtn: 'Detect location'
      success:
        title: 'Is this your address?'
        content: 'We think that this is your adress. If it is correct click "Fill form" button below.'
        fillBtn: 'Fill form'
      error:
        title: 'Ups...'
        geocoder_failed: 'We cannot retrieve your location information right now :('
        unsupported_browser: 'Geolocation is not supported by this browser. Please try to use latest IE, Chrome, Firefox, Opera or Safari browser.'
      loading:
        title: 'Please wait...'
        content: 'We are detecting your current location'


  # Construct base class.
  #
  # @param [Object] jQuery plugin object
  #
  constructor: (element, options, instanceName, @pluginName) ->
    options = $.extend({}, defaultOptions, options)
    super(element, options, instanceName)

    if options.formId is ''
      @log 'There is no formId value', 'error'
      return

    if $(@options.formId).length is 0
      @log 'Can\'t find form with id: ' + options.formId, 'error'
      return

    # set initial input element as @_currentElement
    # <input class="m-wrap lang-translation large"/>
    @_currentElement = $(element)
    @pages = new PagesManager(@)

    return

  init: ->
    @addresData =
      street_number: ''
      street_name: ''
      city: ''
      country: ''
      postal_code: ''

    @pages.start()
    return

  detect: ->
    if navigator.geolocation
      # get current coordinates and pass to getAdress method
      # to retrieve adress
      navigator.geolocation.getCurrentPosition @_getAddress
    else
      @pages.error(@options.texts.error.title, @options.texts.error.unsupported_browser, false)
      @log "Geolocation is not supported by this browser.", 'error'
    return

  fillForm: ->
    $(@options.formId).find(@options.addressId).val @addresData.street_name + ' ' + @addresData.street_number
    $(@options.formId).find(@options.cityId).val @addresData.city
    $(@options.formId).find(@options.postalID).val @addresData.postal_code
    $(@options.formId).find(@options.postalFirstID).val @addresData.postal_code.split('-')[0]
    $(@options.formId).find(@options.postalSecondID).val @addresData.postal_code.split('-')[1]
    $(@options.formId).find(@options.countryID).val @addresData.country
    return


  _getAddress: (position) =>
    lat = position.coords.latitude
    lng = position.coords.longitude

    @pages.loading()

    geocoder = new google.maps.Geocoder();
    latlng = new google.maps.LatLng(lat, lng);

    geocoder.geocode {'latLng': latlng}, (results, status) =>
      if status == google.maps.GeocoderStatus.OK
        if results[0] && results[1]
          @log results[0].formatted_address
          @_parseResult results[0];
          @_parseResult results[1];
          @pages.success()
        else
          @pages.error(@options.texts.error.title, @options.texts.error.geocoder_failed)
          @log "Geocoder failed due to: #{status}", 'error'
      return

    return

  _parseResult: (addressObject) ->
    for addrComp in addressObject.address_components
      type = addrComp.types[0]
      name = addrComp.long_name
      if type is 'street_number'
        @addresData.street_number = name
      if type is 'route'
        @addresData.street_name = name
      if type is 'locality'
        @addresData.city = name
      if type is 'country'
        @addresData.country = name
      if type is 'postal_code'
        @addresData.postal_code = name
    return


#______________________________________________________________
#                                         JQuery Initialisation

(($, window, document, undefined_) ->

  pluginName = "AddressDetectionWidget"
  $.fn[pluginName] = (options, languages) ->
    count = 0
    instanceCount = @.length
    @each ->
      count = count + 1
      if instanceCount is 1
        # if its only one instance do not generate
        # index number. Try to use elements id instead.
        # This will enable possibility to instantiate
        # plugin by id.
        count = '#' + $(this).attr('id')

      instanceName = pluginName + '_' + count
      newInstance = new AddressDetectionWidget(this, options, instanceName, pluginName, languages)
      unless $.data(this, instanceName)
        $.data this, instanceName, newInstance
        newInstance.init()
    return

  return
) jQuery, window, document
