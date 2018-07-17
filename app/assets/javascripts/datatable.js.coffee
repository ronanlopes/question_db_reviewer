@custom_datatable = (dom_id, columns, row_callback) ->
  console.log("custom data table")
  $("#" + dom_id).dataTable
    columns: columns
    bLengthChange: false
    bInfo: true
    paginate: true,
    serverSide: true,
    iDisplayLength: 25,
    ajax: $("#" + dom_id).data('source')
    fnRowCallback: row_callback
    drawCallback: datatable_draw_callback

