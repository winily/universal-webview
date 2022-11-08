class EventBus {
  constructor() {
    this.events = new Map();
  }

  on (key, callback) {
    console.assert(key, "key cannot be null!")
    console.assert(callback, "callback cannot be null!")
    if (key && callback) {
      if (!this.events.has(key)) this.events.set(key, [])
      this.events.get(key).push(callback)
    }
  }

  emit (key, ...values) {
    if (!this.events.has(key)) return
    this.events.get(key).forEach(callback => callback(...values))
  }
}

export default (() => {
  if (!window._uwEventBus) {
    window._uwEventBus = new EventBus();
  }
  return window._uwEventBus
})()