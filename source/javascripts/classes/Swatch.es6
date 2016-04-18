class Swatch {
  constructor(options) {
    if (options.hex) {
      this.hex = options.hex.toUpperCase();
    }

    this.rgb = options.rgb;
    this.id = options.id;
    this.position = options.position;
  }

  get hexColor() {
    return `#${this.hex}`;
  }

  hexColorStop() {
    return `${this.hexColor} ${this.position}%`;
  }

  legacyHexColorStop() {
    const position = this.position / 100;
    return `color-stop(${position}, #${this.hex.toUpperCase()})`;
  }

  rgbColorStop() {
    return `rgb(${this.rgb.r}, ${this.rgb.g}, ${this.rgb.b}) ${this.position}%`;
  }

  legacyRGBColorStop() {
    const position = this.position / 100;
    return `color-stop(${position}, rgb(${this.rgb.r}, ${this.rgb.g}, ${this.rgb.b}))`;
  }
}
