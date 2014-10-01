Address Detection Widget v.0.0.2
===================

Retrieves user localization and tries to find his current address using google maps api. Widget is using browser geolocalization functionality. The list of supported browsers are [here.](http://caniuse.com/#feat=geolocation) 

----------

Requirements
-------------

Address detection widget requires [jquery](http://jquery.com/) library to work. Also its styling is based on [Bootstrap](http://getbootstrap.com/) so it requires bootstrap styles included into document. There is no need to include bootstraps scripts whatsoever. 


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

Also there is need to include css styles sheet:
```html
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" >
<link rel="stylesheet" href="styles/addressDetectionWidget.css">
```

All above files you can find in **/dist** folder.

-----------------

Initialization
-----------

First and formost you have to create widget placeholder
```html
...
<div id="yourWidgetID" class="adw"></div>
...
```

The width of the widget is 100% so it allways fill its container. Height is fixed.
