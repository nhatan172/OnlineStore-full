# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#province').change ->
    val = $(this).val()
    $('#test').html 'binh thuong'
    $.ajax
      url: '/filter_districts_by_province'
      type: 'GET'
      data: selected_province: val
      success: (data) ->
        $('#test').html 'linh'
        return
      error: (data) ->
        $('#test').html 'loi'
        return
    return

  $('#district').change ->
    vall = $(this).val()
    $('#test1').html 'binh thuong'
    $.ajax
      url: '/filter_wards_by_district'
      type: 'GET'
      data: selected_district: vall
      success: (data) ->
        $('#test1').html vall
        return
      error: (data) ->
        $('#test1').html 'loi'
        return
    return


  