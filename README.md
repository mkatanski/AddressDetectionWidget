Address Detection Widget v.0.1.0
===================

Retrieves user localization and tries to find his current address using google maps api. After that it automatically fill HTML form with collected values. Widget is using browser geolocalization functionality. The list of supported browsers are [here.](http://caniuse.com/#feat=geolocation) 

----------

Requirements
-------------

Address detection widget requires [jquery](http://jquery.com/) library to work. Also its styling is based on [Bootstrap](http://getbootstrap.com/) so it requires the bootstrap styles included into document. There is no need to include bootstrap scripts whatsoever. 


Installation
-------------

To enable this widget on your website you have to include javascript documents in your document head section:
 ```html
 <!-- jQuery  -->
 <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
 <!--  Google maps API -->
 <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
 <!-- Widget core scripts  -->
 <script src="scripts/jq.addressDetectionWidget.min.js"></script>
 ```

Also there is need to include css styles sheets:
```html
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" >
<link rel="stylesheet" href="styles/addressDetectionWidget.css">
```

*jq.addressDetectionWidget.min.js* and *addressDetectionWidget.css* files you can find in **/dist/scripts** and **/dist/styles** folders.

-----------------

Initialization
-----------

First and foremost you have to create widget placeholder
```html
<div id="yourWidgetID" class="adw"></div>
```

The width of the widget is always 100% so it fills its container. Height is fixed.

After that initialize plugin using code below. place it somewhere in your document (for example at the bottom, just before ```</body>``` tag).
```html

<script>

// WIDGET INITIALIZATION
$('#yourWidgetID').AddressDetectionWidget({
    formId: '#testForm' // id of form you want to fill with collected values
});

</script>

```

Notice that as an option you have to pass ```formId``` with the ID of form which plugin is going to manage. This is mandatory.

Options
------------

You can change widget settings by passing them as a JavaScript Object during initialization. Below is the list of options with their default values.

```JS
defaultOptions = {
  formId: '',
  addressId: '#street',
  cityId: '#city',
  postalID: '#zip',
  postalFirstID: '#zip-first',
  postalSecondID: '#zip-second',
  countryID: '#country',
  texts: {
    cancelBtn: 'cancel',
    tryAgainBtn: 'Try again',
    start: {
      title: 'Location Detection',
      content: 'We can detect your address to simplify form filling. Just press the button below.',
      detectBtn: 'Detect location'
    },
    success: {
      title: 'Is this your address?',
      content: 'We think that this is your adress. If it is correct click "Fill form" button below.',
      fillBtn: 'Fill form'
    },
    error: {
      title: 'Ups...',
      geocoder_failed: 'We cannot retrieve your location information right now :(',
      unsupported_browser: 'Geolocation is not supported by this browser. Please try to use latest IE, Chrome, Firefox, Opera or Safari browser.'
    },
    loading: {
      title: 'Please wait...',
      content: 'We are detecting your current location'
    }
  }
};
```

And here is example how to change default ID of post-code input and success message title diuring plugin initialization. Remember to add **#** sign before input ID.

```html
<script>

// WIDGET INITIALIZATION
$('#yourWidgetID').AddressDetectionWidget({
    formId: '#testForm',
    postalID: '#post_code',
    texts: {
      success: {
        title: 'Success!'
      }
    }
});

</script>

```

License
--------------

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Address Detection Widget</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a> and also available under [the MIT License](LICENSE.txt).

Contact/Help
-------------

<mkatanski@nexway.com>

