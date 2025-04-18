import consumer from "channels/consumer";

consumer.subscriptions.create("LogsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("received data" + data);
    const logOutput = document.getElementById("logOutput");
    var p = document.createElement("p");
    p.innerHTML = data;
    logOutput.append(p);
  },
});
