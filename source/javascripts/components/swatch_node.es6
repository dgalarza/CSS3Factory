const SwatchNode = React.createClass({
  onClick: function() {
    this.props.swatchClick(this.props.swatch);
  },

  render: function() {
    const style = {
      backgroundColor: this.props.swatch.hexColor
    };

    return (
      <li onClick={this.onClick} className="color-swatch" style={style}>
        <a className="swatch" href="#swatch"></a>
        <a className="remove-swatch" href="#remove"></a>
      </li>
    );
  }
});
