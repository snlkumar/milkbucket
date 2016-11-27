@MakeHistory = React.createClass
  arrComponents: []
  getInitialState: ->
    milkKrate: 0
    milkAmount: 0    
    dahiKrate: 0
    dahiAmount: 0
    display: "none"
    

  registerComponent : (component) ->
    @arrComponents.push(component)

  

  calculateAmount: ->
    mkrt = 0
    milk = 0
    dahi = 0
    dkrt = 0
    for component in @arrComponents
      if component.state.amount
        if component.props.product.category_id == 1        
          milk = milk + component.state.amount
          mkrt = mkrt + component.totalKrt()
        else
          dahi = dahi + component.state.amount
          dkrt = dkrt + parseInt(component.state.krt)    
    @setState
      milkAmount: milk
      milkKrate: mkrt
      dahiAmount: dahi
      dahiKrate: dkrt
      display: "inline"
    

  saveData: ->
    data = {'totoal Amount': @state.dahiAmount + @state.milkAmount }
    milkData = {'totoal Amount': @state.milkAmount, 'total Krate': @state.milkKrate}
    dahiData = {'totoal Amount': @state.dahiAmount, 'total Krate': @state.dahiKrate}    
    for component in @arrComponents
      if component.props.product.category_id == 1
        milkData[component.props.product.name] = component.componentValue()
      else
        dahiData[component.props.product.name] = component.componentValue()
    data['milk'] = milkData
    data['dahi'] = dahiData
    $.post "/histories", {'data': data}
    
    debugger
    

  render: ->
    <div>    
      <span>Total Amount: {@state.dahiAmount + @state.milkAmount}</span>
      <h3>Milk</h3>
      <table className="table" >
        <thead>
          <tr>
            <th>Product</th>
            <th>1/2kg box</th>
            <th>1kg box</th>
            <th>6kg box</th>
            <th>Total karet</th>
            <th>Total in ltr</th>
            <th>Amount</th>
          </tr>
        </thead>
        <tbody> 
          {
            for p in @props.milk
              <MilkRow key= {p.id} product={p} setMilkAmount={@setMilkAmount} owner={this}  />            
          }
        </tbody>
        <span>
          <label>Total Amount: { @state.milkAmount} </label>
          <label>Total Karet: {@state.milkKrate}</label>
        </span>        
      </table>
      <hr/>
      <h3>Dahi</h3>
      <form action="" >
        <table className="table" id="dahiTable" >
          <thead>
            <tr>
              <th>Product</th>
              <th>karet</th>
              <th>Amount</th>
            </tr>
          </thead>
          <tbody>
            {
              for p in @props.dahi
                <DahiRow key={p.id} product={p} setDahiAmount={@setDahiAmount} owner={this}/>
            }
          </tbody>
          <span>
            <label>Total Amount: { @state.dahiAmount} </label>
            <label>Total Karet: {@state.dahiKrate}</label>
          </span>
        </table>
        <input type="button" className="save" style={'display': @state.display} value="Save " onClick={@saveData} /> <input type="button" className="calculate" value="Calculate" onClick={@calculateAmount} />
      </form>
    </div>
