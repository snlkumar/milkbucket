@Field = React.createClass
	getInitialState: ->
    owner: @props.owner
    fieldValue: @props.value

  handleChange: (e) ->    
    @setState({fieldValue: e.target.value })
    @props.setKrt(e)

  componentValue: ->
    @state.fieldValue

  #componentWillMount: ->
  # @props.owner.registerComponent(this) if @props.owner.registerComponent

  render: ->
  	<input type="text" value={@state.fieldValue} onChange={@handleChange} />  