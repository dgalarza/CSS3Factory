ColorPicker = React.createClass({
  componentDidMount: function() {
    const container = ReactDOM.findDOMNode(this);
    $(container).ColorPicker({
      flat: true,
      onChange: this.props.updateColor
    });
  },

  setColor: function(hex) {
    const container = ReactDOM.findDOMNode(this);
    $(container).ColorPickerSetColor(hex);
  },

  render: function() {
    return (
      <div ref="colorPickerContainer"></div>
    )
  }
});
