// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"

// And connect to the path in "lib/quokka_quick_seats_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.

export function connect_to_socket() {
    console.log("Connection to socket")
    let socket = new Socket("/socket", {})

    socket.connect()

    let channel = socket.channel("booking:0", {})
    channel.join()
      .receive("ok", resp => { alert("Joined successfully", resp) })
      .receive("error", resp => { alert("Unable to join", resp) })

    return channel
}
