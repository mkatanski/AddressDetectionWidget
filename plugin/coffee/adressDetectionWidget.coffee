## Import required classes in correct order
#import Plugin

#______________________________________________________________
#                                        AddressDetectionWidget
#
# Main AddressDetectionWidget class
#
# @author   Michal Katanski (mkatanski@nexway.com)
# @version 0.0.1
class AdressDetectionWidget extends Plugin

  #default options
  defaultOptions =
    dataSource: 'json'


  # Construct base class.
  #
  # @param [Object] jQuery plugin object
  #
  constructor: (element, options, instanceName, @pluginName, languages) ->
    options = $.extend({}, defaultOptions, options)
    super(element, options, instanceName, languages)

    # set initial input element as @_currentElement
    # <input class="m-wrap lang-translation large"/>
    @_currentElement = $(element)

    return

  init: ->

    return




#______________________________________________________________
#                                         JQuery Initialisation

(($, window, document, undefined_) ->

  pluginName = "AdressDetectionWidget"
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
      newInstance = new AdressDetectionWidget(this, options, instanceName, pluginName, languages)
      unless $.data(this, instanceName)
        $.data this, instanceName, newInstance
        newInstance.init()
    return

  return
) jQuery, window, document
