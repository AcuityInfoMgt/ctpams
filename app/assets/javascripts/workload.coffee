# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'page:load ready', ->
  $('#cn_workflow_state').multiselect
    buttonWidth: '260px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Approval <b class="caret"></b>'
      else if options.length > 3
        'Approval: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#filteredcnreport').DataTable
    'aLengthMenu': [
      [
        10
        25
        50
        100
        200
        -1
      ]
      [
        10
        25
        50
        100
        200
        'All'
      ]
    ]
    'iDisplayLength': -1
  return