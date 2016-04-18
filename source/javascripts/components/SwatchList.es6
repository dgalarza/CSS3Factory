const SwatchList = React.createClass({
  render: function() {
    const swatchClick = this.props.swatchClick;
    const swatchNodes = this.props.swatches.map(function(swatch, index) {
      return (
        <SwatchNode swatchClick={swatchClick} swatch={swatch} key={index}>
        </SwatchNode>
      )
    });

    return (
      <ul className="swatch-list clearfix">
        {swatchNodes}
      </ul>
    )
  }
});
