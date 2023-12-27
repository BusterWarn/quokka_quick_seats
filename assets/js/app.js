import { connect_to_socket } from "./booking_socket.js";
import {
  display_danger,
  display_info,
  display_success,
  display_warning,
} from "./alerts.js";

const URL = "http://localhost:4004/";

let channel = null;

function load_all_seats() {
  fetch(URL + "api/seats")
    .then((response) => response.json())
    .then((seat_data) => {
      const seat_container = document.getElementById("seat_container");
      seat_container.innerHTML = "";

      seat_data.forEach((seat) => {
        const btn = document.createElement("button");
        btn.className = "btn seat-button button-63 " +
          (seat.is_booked ? "booked" : "btn-primary");
        btn.textContent = seat.seat_id;

        // Add title attribute for booked seats
        if (seat.is_booked) {
          if (seat.full_name === get_name()) {
            btn.className += " color_blue";
          } else {
            btn.className += " color_booked_seat";
          }
          // btn.title = `Name: ${seat.full_name}\nPhone: ${seat.phone_number}`;
          btn.onmouseenter = function (event) {
            show_tooltip(
              event,
              `Name: ${seat.full_name}\nPhone: ${seat.phone_number}`,
            );
          };
          btn.onmouseleave = function () {
            hide_tooltip();
          };
        } else {
          btn.className += " color_available_seat";
        }
        btn.addEventListener("click", () => book_seat(seat.seat_id));
        seat_container.appendChild(btn);
      });
    })
    .catch((error) => console.error("Error:", error));
}

function show_tooltip(event, text) {
  const tooltip = document.getElementById("seat_tooltip");
  tooltip.textContent = text;
  tooltip.style.display = "block";
  tooltip.style.left = event.clientX + "px";
  tooltip.style.top = event.clientY + "px";
}

function hide_tooltip() {
  document.getElementById("seat_tooltip").style.display = "none";
}

function get_name() {
  return document.getElementById("full_name").value || "";
}

function get_phone_number() {
  return document.getElementById("phone_number").value || "";
}

function book_seat(seat_id) {
  const full_name = get_name();
  const phone_number = get_phone_number();

  if (full_name == "") {
    display_warning("Please input full name");
    return;
  }

  if (!is_valid_swedish_phone_number(phone_number)) {
    display_warning("Not a valid phone number: '" + phone_number + "''");
    return;
  }

  const requestBody = {
    seat_id: seat_id,
    full_name: full_name,
    phone_number: phone_number,
  };

  fetch(URL + "api/book_seat", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(requestBody),
  })
    .then((response) => {
      if (response.ok) {
        console.log("Succesfully booked seat '" + seat_id + "'!");
        display_success("Succesfully booked seat '" + seat_id + "'!");
        channel.push("book_seat", { "seat_id": seat_id })
          .receive("ok", (resp) => {
            console.log("Booked successfully", resp);
          })
          .receive("error", (resp) => {
            console.log("Unable to book", resp);
          });
      } else {
        console.log(response);
        display_warning(
          response.status + ": Could not book seat '" + seat_id + "'",
        );
      }
    })
    .catch((error) => {
      console.log("Big error");
      display_danger("Error: " + error);
    });
}

function is_valid_swedish_phone_number(phoneNumber) {
  const regex = /^(?:\+46|0046|0)\d{6,10}$/;
  return regex.test(phoneNumber);
}

// Event Listeners
document.addEventListener("DOMContentLoaded", function () {
  document.getElementById("get_all_seats").addEventListener(
    "click",
    load_all_seats,
  );
  load_all_seats();

  channel = connect_to_socket();
  channel.on("seat_booked", () => {
    console.log("Reload all seats broadcasted from server");
    load_all_seats();
  });
});

document.getElementById("phone_number").addEventListener("input", function () {
  const phoneNumber = this.value;
  if (is_valid_swedish_phone_number(phoneNumber)) {
    this.style.borderColor = "green";
  } else {
    this.style.borderColor = "red";
  }
});

document.getElementById("full_name").addEventListener("input", function () {
  const full_name = this.value;
  if (full_name != "") {
    this.style.borderColor = "green";
  } else {
    this.style.borderColor = "red";
  }
});
