@EveningRow = React.createClass
  getInitialState: ->
    db: ''    

  particular: ->
    if @props.order.particular
      order =JSON.parse @props.order.particular
      [JSON.stringify(order)]

  deleteIt: ->
    if confirm('Press a button!') == true
      $.ajax
        url: "/histories/#{@props.order.id}"
        data: {id: @props.order.id}
        type: 'DELETE'
        cache: false
        success: ((result) ->
          if result.status
            @props.showReport
          else
            alert "error"
          return
        ).bind(this)    
    
    

  render: ->    
    <tr>
    	<td>{moment(@props.order.created_at).format('YYYY-MM-DD')}</td>
    	<td></td>
      <td>{@props.order.slot}</td>
      <td>{@particular()}</td>
      <td className="red">{@props.order.debit}</td>
      <td className="green">{@props.order.credit}</td>
      <td className="purple">{@props.order.balance}</td>
      <td><input type="button" className="btn btn-danger" value="Delete" onClick={@deleteIt.bind(this)} /></td>
    </tr>