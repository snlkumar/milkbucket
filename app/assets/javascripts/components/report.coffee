@ReportDashboard = React.createClass
  getInitialState: ->
    startDate: moment(new Date()).format('YYYY-MM-DD')
    endDate: moment(new Date()).format('YYYY-MM-DD')
    download: "hide"
    data: []
    
  showReport: ->
    $.ajax
      url: '/reports/show_report'
      data: {'from': @state.startDate, 'to': @state.endDate}
      type: 'GET'
      cache: false
      success: ((result) ->
        @setState
          data: result.data
          download: "show"
        return
      ).bind(this)

  downloadReport: ->


    

  setStartDate: (selected) ->    
    @setState
      startDate: moment(selected).format('YYYY-MM-DD')

  setEndDate: (selected) ->
    @setState
      endDate: moment(selected).format('YYYY-MM-DD')


  render: ->
    <div className="main-content-inner">
      <div id="breadcrumbs" className="breadcrumbs ace-save-state">
        <ul className="breadcrumb">
          <li><i className="ace-icon fa fa-home home-icon"></i><a href="#">Home</a></li>
          <li className="active">Report</li>
        </ul>
      </div>
      <div className="page-content">
        <div className="row">
          <div className="col-xs-12">
            <div className="row">
              <div className="col-sm-6">
                <div className="row">
                  <div className="col-sm-6">
                    <span>From</span>
                    <div className="input-group input-group-sm">
                      <DatePicker addClass="input-field align-center" showSelected={@state.endDate} onSelect={@setStartDate} calendar='false'/>
                      <span className="input-group-addon">
                        <i className="ace-icon fa fa-calendar"></i>
                      </span>
                    </div>
                  </div>
                  <div className="col-xs-6">
                    <span>To</span>
                    <div className="input-group input-group-sm">
                      <DatePicker addClass="input-field align-center form-cont" showSelected={@state.endDate} onSelect={@setEndDate} calendar='false'/>
                      <span className="input-group-addon">
                        <i className="ace-icon fa fa-calendar"></i>
                      </span>
                    </div>
                  </div>                  
                </div>
              </div>
              <div className="col-sm-6">
                <p className="report-button">
                  <button className="btn btn-white btn-success" onClick={@showReport} type="button">Show</button>                  
                </p>
              </div>
              <div className="col-xs-12">
                <button className="btn btn-white btn-warning #{@state.download}" onClick={@downloadReport} type="button">Download</button>
                {
                  if @state.data.length > 0
                    <table className="table table-bordered table-hover" >
                      <thead>
                        <tr>
                          <th>Date</th>
                          <th>V.No.</th>
                          <th>Slot</th>
                          <th>Particulars</th>
                          <th>Debit</th>
                          <th>Credit</th>
                          <th>Balance</th>
                          <th>Action</th>
                        </tr>
                      </thead>
                      <tbody>
                        {@state.data.map(((x, i)->                          
                          <EveningRow order={x} key={i} showReport={@showReport}/>
                        ).bind(this))
                        }
                        
                      </tbody>
                    </table>
                }
              </div>          
            </div>
          </div> 
        </div>
      </div>
    </div>