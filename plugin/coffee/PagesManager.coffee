# PagesManager class
#
# Manage widget pages.
#
# @author   Michal Katanski (mkatanski@nexway.com)
# @version 0.0.3
class PagesManager

  # Construct PagesManager class.
  #
  # @param [class] AddressDetectionWidget class
  #
  constructor: (@base) ->
    return

  # Remove current page content from wrapper
  #
  # @private
  _closeCurrentPage: ->
    # Remove existing page if exists
    @base._currentElement.children().remove()
    return

  # Show start page
  #
  start: ->
    step_start_html = """
    <div class="step-start alert alert-info" >
      <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4>#{@base.options.texts.start.title}</h4>
      <p>#{@base.options.texts.start.content}</p>
      <button type="button" class="detectBtn btn btn-primary btn-xs">#{@base.options.texts.start.detectBtn}</button>
      <button type="button" class="cancelBtn btn btn-link">#{@base.options.texts.cancelBtn}</button>
    </div>
    """
    @_closeCurrentPage()
    # render new page
    @base._currentElement.html(step_start_html)

    # DetectBtn onClick event
    @base._currentElement.find('.detectBtn').on 'click', (e) =>
      @base.detect()
      return
    # CancelBtn onClick event
    @base._currentElement.find('.cancelBtn').on 'click', (e) =>
      @_closeCurrentPage()
      return

    @base._currentElement.find('.close').on 'click', (e) =>
      @_closeCurrentPage()
      return

    @base.log 'Render start page'
    return

  # Show success page
  #
  success: ->
    step_success_html = """
    <div class="step-success alert alert-info">
      <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4>#{@base.options.texts.success.title}</h4>
      <p>#{@base.options.texts.success.content}</p>
        <address>
          #{@base.addressData.streetName} #{@base.addressData.streetNumber}, #{@base.addressData.postalCode} #{@base.addressData.city}, #{@base.addressData.country}
        </address>
      <button type="button" class="fillBtn btn btn-primary btn-xs">#{@base.options.texts.success.fillBtn}</button>
    </div>
    """
    @_closeCurrentPage()

    # render new page
    @base._currentElement.html(step_success_html)

    @base._currentElement.find('.fillBtn').on 'click', (e) =>
      @base.fillForm()
      return

    @base._currentElement.find('.close').on 'click', (e) =>
      @_closeCurrentPage()
      return

    @base.log 'Render success page'
    return

  # Show error page
  #
  # @param [String] Error title
  # @param [String] Error message
  # @param [Bool] Show/Hide 'Try Again' button
  #
  error: (title, content, showTryBtn = true) ->
    step_error_html = """
    <div class="step-error alert alert-danger">
      <button type="button" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
      <h4>#{title}</h4>
      <p>#{content}</p>
      <button type="button" class="tryBtn btn btn-primary btn-xs">#{@base.options.texts.tryAgainBtn}</button>
    </div>
    """
    @_closeCurrentPage()

    # render new page
    @base._currentElement.html(step_error_html)

    if showTryBtn is false
      # Remove try btn
      @base._currentElement.find('.tryBtn').remove()

    @base._currentElement.find('.tryBtn').on 'click', (e) =>
      @base.detect()
      return

    @base._currentElement.find('.close').on 'click', (e) =>
      @_closeCurrentPage()
      return

    @base.log 'Render error page'
    return

  # Show loading page
  #
  loading: ->
    step_loading_html = """
    <div class="step-loading alert alert-info">
      <h4>#{@base.options.texts.loading.title}</h4>
      <p>#{@base.options.texts.loading.content}</p>
    </div>
    """
    @_closeCurrentPage()

    # render new page
    @base._currentElement.html(step_loading_html)
    @base.log 'Render loading page'
    return



