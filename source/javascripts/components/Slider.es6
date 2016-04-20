Slider = React.createClass({
  getInitialState: function() {
    return {
      currentPosition: this.props.currentPosition
    };
  },

  getSliderElement: function() {
    const container = ReactDOM.findDOMNode(this);
    return $(container).find(".swatch-slider");
  },

  componentDidMount: function() {
    this.getSliderElement().slider({
      max: 100,
      range: "min",
      change: this.positionUpdate,
      slide: this.positionUpdate,
    });
  },

  className: function() {
    let className = "position-input";
    if (this.focused) {
      className += " transition";
    }

    return className;
  },

  positionUpdate: function(e, ui) {
    if (ui.value != Number(this.state.currentPosition)) {
      this.props.currentPosition = ui.value;
      this.props.positionUpdated(ui.value);
    }
  },

  textFieldUpdate: function(event) {
    const value = event.target.value;

    if (value != Number(this.state.currentPosition)) {
      this.props.currentPosition = value;
      this.props.positionUpdated(value);
    }
  },

  setPosition: function(value) {
    this.setState({"currentPosition": value});
    this.getSliderElement().slider("option", "value", value);
  },

  onFocus: function() {
    //this.setState("focused", true);
    //this.getSliderInput().addClass("transition");
  },

  onBlur: function() {
    //this.setState("focused", false);
    //this.getSliderInput().removeClass("transition");
  },

  render: function() {
    return (
      <div>
        <div className="swatch-slider"></div>
        <input 
          type="text"
          onChange={this.textFieldUpdate}
          onFocus={this.onFocus}
          onBlur={this.onBlur}
          className={this.className()}
          value={this.state.currentPosition}
          //className="position-input"
          maxLength="3"
        />
      </div>
    )
  }
});
