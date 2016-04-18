const SwatchNode = React.createClass({
  cssClass: function() {
    let className = "color-swatch";

    if (this.props.activeSwatch == this.props.swatch) {
      className += " active";
    }

    return className;
  },

  onClick: function() {
    this.props.swatchClick(this.props.swatch);
  },

  render: function() {
    const style = {
      backgroundColor: this.props.swatch.hexColor
    };

    return (
      <li onClick={this.onClick} className={this.cssClass()} style={style}>
        <a className="swatch" href="#swatch"></a>
        <a className="remove-swatch" href="#remove"></a>
      </li>
    );
  }
});
