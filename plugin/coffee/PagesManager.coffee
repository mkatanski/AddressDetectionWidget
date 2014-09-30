# PagesManager class
#
# @author   Michal Katanski (mkatanski@nexway.com)
# @version 0.0.3
class PagesManager

  # Construct PagesManager class.
  #
  # @param [class] Base class
  #
  constructor: (@base) ->
    return

  _closeCurrentPage: ->
    # Remove existing page if exists
    @base._currentElement.children().remove()
    return

  start: ->
    step_start_html = """
    <div class="step-start alert alert-info" >
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

    @base.log 'Render start page'
    return

  success: ->

    step_success_html = """
    <div class="step-success alert alert-info">
      <h4>#{@base.options.texts.success.title}</h4>
      <p>#{@base.options.texts.success.content}</p>
        <address>
          #{@base.addresData.street_name} #{@base.addresData.street_number}<br>
          #{@base.addresData.city}, #{@base.addresData.postal_code}<br>
          #{@base.addresData.country}<br>
        </address>
      <button type="button" class="fillBtn btn btn-primary btn-xs">#{@base.options.texts.success.fillBtn}</button>
      <button type="button" class="cancelBtn btn btn-link">#{@base.options.texts.cancelBtn}</button>
    </div>
    """

    @_closeCurrentPage()
    # render new page
    @base._currentElement.html(step_success_html)

    @base._currentElement.find('.fillBtn').on 'click', (e) =>
      @base.fillForm()
      #@_closeCurrentPage()
      return

    @base.log 'Render success page'
    return

  error: ->
    step_error_html = """
    <div class="step-error alert alert-danger">
      <h4>#{@base.options.texts.error.title}</h4>
      <p>#{@base.options.texts.error.content}</p>
      <button type="button" class="tryBtn btn btn-primary btn-xs">#{@base.options.texts.error.tryAgainBtn}</button>
    </div>
    """
    @_closeCurrentPage()
    # render new page
    @base._currentElement.html(step_error_html)
    @base.log 'Render error page'
    return

  loading: ->
    step_loading_html = """
    <div class="step-loading alert alert-info">
      <h4>#{@base.options.texts.loading.title}</h4>
      <p>#{@base.options.texts.loading.content}</p>
    </div>
    """
    @_closeCurrentPage()
    # render new page
    # $(@pagesHtml.start).appendTo @base._currentElement.html()
    @base._currentElement.html(step_loading_html)
    @base.log 'Render loading page'
    return



