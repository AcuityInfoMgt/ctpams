# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'page:load ready', ->
  $('input.datepicker').datepicker dateFormat: 'yy-mm-dd'
  $('#filteredreport').DataTable
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
  $('#fiscal_year').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Fiscal Year <b class="caret"></b>'
      else if options.length > 3
        'Fiscal Year: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#program_id').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Program <b class="caret"></b>'
      else if options.length > 3
        'Program: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#funding_mechanism_id').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Funding Type <b class="caret"></b>'
      else if options.length > 3
        'Funding Type: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#sub_account_id').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Sub Account <b class="caret"></b>'
      else if options.length > 3
        'Sub Account: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#country_id').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Country <b class="caret"></b>'
      else if options.length > 3
        'Country: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#workflow_state').multiselect
    buttonWidth: '180px'
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
  $('#implementation_status').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Status <b class="caret"></b>'
      else if options.length > 3
        'Status: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#implementer_id').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Implementer <b class="caret"></b>'
      else if options.length > 3
        'Implementer: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  $('#region_id').multiselect
    buttonWidth: '180px'
    maxHeight: 340
    buttonText: (options) ->
      selected = undefined
      if options.length == 0
        'Region <b class="caret"></b>'
      else if options.length > 3
        'Region: ' + options.length + ' selected  <b class="caret"></b>'
      else
        selected = ''
        options.each ->
          selected += $(this).text() + ', '
          return
        selected.substr(0, selected.length - 2) + ' <b class="caret"></b>'
  return