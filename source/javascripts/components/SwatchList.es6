const SwatchList = React.createClass({
  render: function() {
    const swatchNodes = this.props.swatches.map((swatch, index) => {
      return (
        <SwatchNode
          swatchClick={this.props.swatchClick}
          activeSwatch={this.props.activeSwatch}
          swatch={swatch}
          key={index}
        >
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
