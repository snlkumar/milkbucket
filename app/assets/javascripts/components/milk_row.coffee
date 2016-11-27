@MilkRow = React.createClass
  getInitialState: ->
    halfLtrKrt: 0
    fullLtrKrt: 0
    sixLtrKrt: 0
    totalrLtr: 0
    krtCount: 0
    ltrCount: 0
    rate: @props.product.price

  componentValue: ->
    {'halfkrt': @state.halfLtrKrt, 'fkrt': @state.fullLtrKrt, 'amount': @state.amount}

  componentWillMount: ->
    @props.owner.registerComponent(this) if @props.owner.registerComponent

  calulateHalfLeter: (e) ->
    if e.target.value.length > 0
      ltr=e.target.value*12 + @state.fullLtrKrt*12
    else
      ltr = @state.fullLtrKrt*12    
    @setState
      halfLtrKrt: e.target.value
      amount: ltr*@state.rate
    @props.owner.setState({display: 'none'})
   
  calulateFullLeter: (e)->     
    if e.target.value.length > 0
      ltr=e.target.value*12 + @state.halfLtrKrt*12
    else
      ltr = @state.halfLtrKrt*12   
    @setState
      fullLtrKrt: e.target.value
      amount: ltr*@state.rate
    @props.owner.setState({display: 'none'})

  calulateSixLeter: (e) ->
    if e.target.value.length > 0
      ltr= e.target.value*12 + @state.halfLtrKrt*12 + @state.fullLtrKrt*12
    else
      ltr = @state.halfLtrKrt*12 + @state.fullLtrKrt*12
    @setState
      sixLtrKrt: e.target.value
      amount: ltr*@state.rate
    @props.owner.setState({display: 'none'})

  calculateLtr: ->
    ltr = if @state.fullLtrKrt then parseInt(@state.fullLtrKrt) else 0
    halfltr = if @state.halfLtrKrt then parseInt(@state.halfLtrKrt) else 0
    sixltr = if @state.sixLtrKrt then parseInt(@state.sixLtrKrt) else 0
    ltr*12 + halfltr*12 + sixltr*12

  totalKrt: ->
    ltr = if @state.fullLtrKrt then parseInt(@state.fullLtrKrt) else 0
    halfltr = if @state.halfLtrKrt then parseInt(@state.halfLtrKrt) else 0
    sixltr = if @state.sixLtrKrt then parseInt(@state.sixLtrKrt) else 0
    halfltr + ltr + sixltr

  render: ->
    <tr>
      <td><input type='text' name='product' value={@props.product.name} /></td>
      <td><input type='text' name='1/2ltr' onChange={@calulateHalfLeter}  /> </td>
      <td><input type='text' name='1ltr' onChange={@calulateFullLeter} /> </td>
      <td><input type='text' name='6ltr' onChange={@calulateSixLeter} /> </td>
      <td><input type='text' name='totalkrt' value={@totalKrt()} /></td>
      <td><input type='text' name='total in ltr' value={@calculateLtr()} /></td>
      <td><input type='text' name='total amount' value={@state.amount} /></td>
    </tr>
