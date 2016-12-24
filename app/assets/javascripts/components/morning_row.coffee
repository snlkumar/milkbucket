@MorningRow = React.createClass
  getInitialState: ->
    f: ''
  render: ->
    <tr>
      <td>
        <label className="pull-right inline">
	        <input type="text" className="credited-amount" placeholder= "Deposited Amount" onChange={@creditAmount}/>
	      </label>
      </td>
    </tr>