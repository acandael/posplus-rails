jQuery ->
  $(document).on "ajax:error", (xhr, status, error) ->
    console.log status.responseText
    console.log error
