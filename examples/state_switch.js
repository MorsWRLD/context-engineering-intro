class ModeSwitch {
  constructor() {
    this.mode = "chill"; // default
  }

  toggle() {
    this.mode = this.mode === "chill" ? "grind" : "chill";
    return this.mode;
  }

  getGlowColor() {
    return this.mode === "chill" ? "#ff00ff" : "#00ffff"; // neon pink/blue
  }
}

// Example usage
const ms = new ModeSwitch();
console.log(ms.toggle()); // grind
console.log(ms.getGlowColor()); // cyan
