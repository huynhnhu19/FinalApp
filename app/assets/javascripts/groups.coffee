window.GroupTools =
  run: ->
    $(document).ready ->
      allCheckBoxTools()
      checkboxTool()

allCheckBoxTools = ->
  $("#all_").on "click", ->
    if $("#all_").is(":checked")
      list_checkbox = $(".tool-checkbox")
      $("#tool-option").removeClass("display-none")
      _.map(list_checkbox, (i) ->
        $(i).prop('checked', true))
    else
      list_checkbox = $(".tool-checkbox")
      $("#tool-option").addClass("display-none")
      _.map(list_checkbox, (i) ->
        $(i).prop('checked', false))

checkboxTool = ->
  $(".tool-checkbox").on "click", ->
    if $(this).is(":checked")
      $("#all_").prop('checked', true)
      $("#tool-option").removeClass("display-none")
    else
      list_checkbox = $(".tool-checkbox")
      allChecked = false
      _.map(list_checkbox, (i) ->
        if $(i).is(":checked")
          allChecked = true
        )
      if allChecked == true
        $("#tool-option").removeClass("display-none")
        $("#all_").prop('checked', true)
      else
        $("#tool-option").addClass("display-none")
        $("#all_").prop('checked', false)


