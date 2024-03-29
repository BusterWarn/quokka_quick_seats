// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import { Socket } from "phoenix";
import { display_danger, display_info } from "./alerts.js";

// And connect to the path in "lib/quokka_quick_seats_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.

export function connect_to_socket() {
  console.log("Connection to socket");
  const socket = new Socket("/socket", {});

  socket.connect();

  const channel = socket.channel("booking:0", {});
  channel.join()
    .receive("ok", (resp) => {
      console.log(
        "Successfully joined live session. Seats reservations will be updated automatically.",
      );
      console.log(resp);
    })
    .receive("error", (resp) => {
      display_danger(
        "Unable to join live session. Seat data will not be update in real time.",
      );
      console.log(resp);
    });

  return channel;
}
