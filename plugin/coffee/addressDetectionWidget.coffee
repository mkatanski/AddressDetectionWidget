## Import required classes in correct order
#import Plugin
#import PagesManager

#______________________________________________________________
#                                        AddressDetectionWidget
#
# Main AddressDetectionWidget class
#
# @author   Michal Katanski (mkatanski@nexway.com)
# @version 0.0.3
class AddressDetectionWidget extends Plugin

  #default options
  defaultOptions =
    formId: ''
    addressId: '#street'
    cityId: '#city'
    postalId: '#zip'
    postalFirstId: '#zip-first'
    postalSecondId: '#zip-second'
    countryId: '#country'
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
        geocoderFailed: 'We cannot retrieve your location information right now :('
        unsupportedBrowser: 'Geolocation is not supported by this browser. Please try to use latest IE, Chrome, Firefox, Opera or Safari browser.'
      loading:
        title: 'Please wait...'
        content: 'We are detecting your current location'


  # Construct base class.
  #
  # @param [Object] jQuery plugin object
  # @param [Objects] User options
  # @param [String] Instance name
  # @param [String] Plugin name
  #
  constructor: (element, options, instanceName, @pluginName) ->
    options = $.extend({}, defaultOptions, options)
    super(element, options, instanceName)

    # formId is required parameter
    if options.formId is ''
      @log 'There is no formId value', 'error'
      return

    # form has to be existing form in current document
    if $(@options.formId).length is 0
      @log 'Can\'t find form with id: ' + options.formId, 'error'
      return

    # set initial input element as @_currentElement
    # <div class="addressDetectionWidget"/>
    @_currentElement = $(element)
    # Initialize PagesManager class which will create widget pages
    # and switch between them
    @pages = new PagesManager(@)

    return

  # Initialize plugin
  #
  init: ->
    @addressData =
      streetNumber: ''
      streetName: ''
      city: ''
      country: ''
      postalCode: ''

    @pages.start()
    return

  # Detects current location using browsers geolocation engine
  #
  # If browser is supporting geolocation it is invoking @_getAdress method
  # asynchronously. Otherwise displays error page.
  #
  detect: ->
    if navigator.geolocation
      # get current coordinates and pass to getAdress method
      # to retrieve adress
      navigator.geolocation.getCurrentPosition @_getAddress
    else
      # go to error page
      @pages.error(@options.texts.error.title, @options.texts.error.unsupportedBrowser, false)
      @log "Geolocation is not supported by this browser.", 'error'
    return

  # Fill form with collected address data
  #
  fillForm: ->
    form = $(@options.formId);
    form.find(@options.addressId).val @addressData.streetName + ' ' + @addressData.streetNumber
    form.find(@options.cityId).val @addressData.city
    form.find(@options.postalId).val @addressData.postalCode
    form.find(@options.postalFirstId).val @addressData.postalCode.split('-')[0]
    form.find(@options.postalSecondId).val @addressData.postalCode.split('-')[1]
    form.find(@options.countryId).val @addressData.country
    return

  # Asynchronously get current address using google maps API
  #
  # If address is found @_parseResult will be invoked and
  # success page will be shown. Otherwise go to error page.
  #
  # @private
  # @param [Object] Geolocation result object
  #
  _getAddress: (position) =>
    lat = position.coords.latitude
    lng = position.coords.longitude

    @pages.loading()
    # instatiate Google Maps classes required to
    # retrieve address data
    geocoder = new google.maps.Geocoder();
    latlng = new google.maps.LatLng(lat, lng);

    geocoder.geocode {'latLng': latlng}, (results, status) =>
      if status == google.maps.GeocoderStatus.OK
        if results[0] && results[1]
          @log results[0].formatted_address
          # Parse result twice to get first and
          # second location level
          @_parseResult results[0];
          @_parseResult results[1];
          # go to success page
          @pages.success()
        else
          # go to error page
          @pages.error(@options.texts.error.title, @options.texts.error.geocoderFailed)
          @log "Geocoder failed due to: #{status}", 'error'
      return

    return

  # Parse address data from google maps API and store it
  # in @addressData public object
  #
  # @private
  # @param [Object] Google Maps API resuklt object
  #
  _parseResult: (addressObject) ->
    for addrComp in addressObject.address_components
      # always use first type name as it is most reliable
      type = addrComp.types[0]
      name = addrComp.long_name

      switch type
        when "street_number" then @addressData.streetNumber = name
        when "route" then @addressData.streetName = name
        when "locality" then @addressData.city = name
        when "country" then @addressData.country = name
        when "postal_code" then @addressData.postalCode = name

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
