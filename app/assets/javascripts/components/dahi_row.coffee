@DahiRow = React.createClass
  getInitialState: ->   
    krt: 0
    rate: @props.product.price
    amount: 0
    name: @props.product.name

  componentValue: ->
    {'krt': @state.krt, 'amount': @state.amount}

  componentWillMount: ->
    @props.owner.registerComponent(this) if @props.owner.registerComponent

  setKrt: (e) ->    
    amount = @state.rate * e.target.value
    @setState
      krt: e.target.value
      amount: amount
    @props.owner.setState({display: 'none'})
    

  render: ->
    <tr>
      <td><input type="text" name="product" value={@props.product.name} /></td>      
      <td><Field name="totalkrt" setKrt={@setKrt} owner={this} /></td>
      <td><input type='text' name='total amount' value={@state.amount} /></td>
    </tr>