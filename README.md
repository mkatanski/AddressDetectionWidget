Address Detection Widget v.0.0.2
===================

Retrieves user localization and tries to find his current address using google maps api. Widget is using browser geolocalization functionality. The list of supported browsers are [here.](http://caniuse.com/#feat=geolocation) 

----------

Installation
-------------

To enable this widget on your website you have to include javascript documents in your document head section:
 ``` <!-- jQuery  -->
 <script src="jquery/jquery.min.js"></script>
 ...
 <!--  Google maps API -->
   <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
   <!-- Widget core scripts  -->
    <script src="scripts/jq.addressDetectionWidget.min.js"></script>
 ```

Also there is need to include css style sheet:
```<link rel="stylesheet" href="styles/addressDetectionWidget.css">```

All above files you can find in **/dist** folder.

-----------------

Initialization
-----------
