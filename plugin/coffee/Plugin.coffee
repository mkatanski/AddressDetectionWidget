#______________________________________________________________
#                                                        Plugin
# Generic class for plugins. Extend this class to
# create own functionality
#
# @author Michal Katanski (mkatanski@nexway.com)
# @version 0.0.1
class Plugin
    #default settings
    defaultOptions =
      debug:    false
      messageScope: 'warning'

    constructor: (element, options, instanceName) ->
      # initial plugin element
      @element = element
      @options = $.extend({}, defaultOptions, options)
      @instanceName = instanceName
      @defaults = defaultOptions

    # simple logger
    log: (msg, type='info') ->
      if @options.debug is on
        prefix = ''
        show = true

        if @options.messageScope is 'error' and type is 'info'
          show = false
        if @options.messageScope is 'error' and type is 'warning'
          show = false
        if @options.messageScope is 'warning' and type is 'info'
          show = false

        if type is 'info'
          titleColor = 'background: white; color: grey'
          msgColor = 'background: white; color: green'
        if type is 'error'
          titleColor = 'background: red; color: white'
          msgColor = 'background: white; color: red'
          prefix = '(Error!)'
        if type is 'warning'
          titleColor = 'background: white; color: orange'
          msgColor = 'background: white; color: orange'
          prefix = '(Warning)'

        if show
          console.log "%c #{@instanceName}: #{prefix} %c #{msg}", titleColor, msgColor
      return

    getPluginByInstanceName: (domElement, instName, numeric=-1, callback) ->
      return $.data(domElement, instName)

    runForEachInstance: (selector, callback) ->
      i = 0
      iName = @pluginName
      $(selector).each ->
        i = i + 1
        # get plugin instance and
        # close editor window if is open
        if $.data(@, iName + '_' + i)?
          callback $.data(@, iName + '_' + i)
        else if $.data(@, iName + '_#' + $(@).attr('id'))?
          callback $.data(@, iName + '_#' + $(@).attr('id'))
      return


