@MakeHistory = React.createClass
  arrComponents: []
  getInitialState: ->
    milkKrate: 0
    milkAmount: 0    
    dahiKrate: 0
    dahiAmount: 0
    sloat: 'M'
    creditedAmount: 0
    checked: true
    display: "none"
    showAlert: "hide"
    message: ''
    

  registerComponent : (component) ->
    @arrComponents.push(component)

  handleSloat: (e) ->
    checked = ""
    sloat = "E"
    if e.target.checked == true
      checked = true 
      sloat = "E"   
    @setState
      checked: checked
      sloat: sloat 

  creditAmount: (e) ->
    @setState
      creditedAmount: e.target.value


  calculateAmount: ->    
    mkrt = 0
    milk = 0
    dahi = 0
    dkrt = 0
    for component in @arrComponents
      if component.state.amount        
        if component.props.product.category == 'Milk' 
          milk = milk + component.state.amount
          mkrt = mkrt + component.totalKrt()
        else if component.props.product.category == 'Dahi' 
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
      if component.props.product.category == 'Milk'
        milkData[component.props.product.name] = component.componentValue()
      else if component.props.product.category == 'Dahi' 
        dahiData[component.props.product.name] = component.componentValue()
    data['milk'] = milkData
    data['dahi'] = dahiData
    inputData = {'particular': data, 'slot': @state.sloat, debit: @state.milkAmount }

    $.ajax
      url: '/histories'
      data: {order: inputData}
      type: 'POST'
      cache: false
      success: ((result) ->
        if result.status
          @setState
            showAlert: "alert-success show"
            message: result.message
        else
          @setState
            showAlert: "alert-danger show"
            message: result.errors
        return
      ).bind(this)
      
    #$.post "/histories", {'data': data, 'sloat': @state.sloat, 'credited': @state.creditedAmount}, (result) ->
    #  if result.status
    #    debugger
    #    alert result.message
    
    
    

  render: ->
    <div className="main-content-inner">
      <div id="breadcrumbs" className="breadcrumbs ace-save-state">
        <ul className="breadcrumb">
          <li><i className="ace-icon fa fa-home home-icon"></i><a href="#">Home</a></li>
          <li className="active">Dashboard</li>
        </ul>
      </div>
      <div className="page-content">
        <div className="row">
          <div className="col-xs-12">
            <div className="row">
              <div className="col-xs-12">
                <div className="alert #{@state.showAlert}">
                  <button className="close" data-dismiss="alert" type="button">
                    <i className="ace-icon fa fa-times"></i>
                  </button>
                  <p>
                    {@state.message}
                  </p>
                </div>
                <div className="col-sm-6">
                  <h3 className="row header smaller lighter orange">
                    <span>
                      <label className="pull-left inline">
                        Total Amount: {@state.dahiAmount + @state.milkAmount}
                      </label>                      
                    </span>
                  </h3> 
                </div>
                <div className="col-sm-6">
                  <h3 className="row header smaller lighter orange">                  
                    <label className="pull-right inline">
                      Morning Sloat?:
                      <input id="gritter-light" checked={@state.checked} type="checkbox" className="ace ace-switch ace-switch-5" onChange={@handleSloat} />
                      <span className="lbl middle"></span>
                    </label>
                    
                  </h3>                  
                </div>                
                <h3>Milk</h3>
                <table className="table table-bordered table-hover" >
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
                  <table className="table table-bordered table-hover" id="dahiTable" >
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
                  <input type="button" className="btn btn-success" style={'display': @state.display} value="Save " onClick={@saveData} /> <input type="button" className="btn btn-danger" value="Calculate" onClick={@calculateAmount} />
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
