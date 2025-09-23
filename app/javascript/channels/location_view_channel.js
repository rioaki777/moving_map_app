import consumer from "channels/consumer"

const locationViewChannel = consumer.subscriptions.create("LocationViewChannel", {
  connected() {
    console.log("✅ LocationViewChannel connected");
    this.startPinging();
  },

  disconnected() {
    console.log("❌ LocationViewChannel disconnected");
    clearInterval(this.pingTimer);
  },

  received(data) {
    console.log("📡 Received:", data);
    if (data.seconds_viewed !== undefined) {
      const counter = document.getElementById("seconds-viewed");
      if (counter) {
        counter.textContent = `${data.seconds_viewed} 秒`;
      }
    }
  },

  startPinging() {
    this.pingTimer = setInterval(() => {
      this.perform("ping", {});
    }, 5000)
  }
});

export default locationViewChannel;