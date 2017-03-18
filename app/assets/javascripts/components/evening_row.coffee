@EveningRow = React.createClass
  getInitialState: ->
    db: ''    

  particular: ->
    if @props.order.particular
      order =JSON.parse @props.order.particular
      [JSON.stringify(order)]

  render: ->    
    <tr>
    	<td>{moment(@props.order.created_at).format('YYYY-MM-DD')}</td>
    	<td></td>
      <td>{@props.order.slot}</td>
      <td>{@particular()}</td>
      <td className="red">{@props.order.debit}</td>
      <td className="green">{@props.order.credit}</td>
      <td className="purple">{@props.order.balance}</td>
    </tr>