import {connect_to_socket} from "./booking_socket.js"

const URL = "http://localhost:4004/"
const CLASS_ALERT_INFO = "alert_info";
const CLASS_ALERT_SUCCESS = "alert_success";
const CLASS_ALERT_WARNING = "alert_warning";
const CLASS_ALERT_DANGER = "alert_danger";

let channel = null;

function load_all_seats() {
    fetch(URL + "api/seats")
        .then(response => response.json())
        .then(seat_data => {
            const seat_container = document.getElementById("seat_container");
            seat_container.innerHTML = '';

            seat_data.forEach(seat => {
                const btn = document.createElement('button');
                btn.className = 'btn seat-button button-63 ' + (seat.is_booked ? 'booked' : 'btn-primary');
                btn.textContent = seat.seat_id;

                // Add title attribute for booked seats
                if (seat.is_booked) {
                    if (seat.full_name === get_name())
                    {
                        btn.className += ' color_blue'
                    }
                    else
                    {
                        btn.className += ' color_booked_seat'
                    }
                    // btn.title = `Name: ${seat.full_name}\nPhone: ${seat.phone_number}`;
                    btn.onmouseenter = function(event) {
                        show_tooltip(event, `Name: ${seat.full_name}\nPhone: ${seat.phone_number}`);
                    };
                    btn.onmouseleave = function() {
                        hide_tooltip();
                    };
                }
                else
                {
                    btn.className += ' color_available_seat'
                }
                btn.addEventListener('click', () => book_seat(seat.seat_id));
                seat_container.appendChild(btn);
            });
        })
        .catch(error => console.error('Error:', error));
}

function show_tooltip(event, text) {
    const tooltip = document.getElementById('seat_tooltip');
    tooltip.textContent = text;
    tooltip.style.display = 'block';
    tooltip.style.left = event.clientX + 'px';
    tooltip.style.top = event.clientY + 'px';
}

function hide_tooltip() {
    document.getElementById('seat_tooltip').style.display = 'none';
}

function get_name()
{
    return document.getElementById('full_name').value || "Mr Quokk";
}

function book_seat(seat_id) {
    const full_name = get_name();
    const phone_number = document.getElementById('phone_number').value || "070";

    const requestBody = {
        seat_id: seat_id,
        full_name: full_name,
        phone_number: phone_number
    };
    
    channel.push("book_seat", {"seat_id" : seat_id})
        .receive("ok", resp => { console.log("Booked successfully", resp) })
        .receive("error", resp => { console.log("Unable to book", resp) })

    fetch(URL + "api/book_seat", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestBody)
    })
    .then(response => {
        if (response.ok) {
            display_success("Succesfully booked seat '" + seat_id + "'!");
            load_all_seats(); // Reload all seats after booking
        }
        else
        {
          display_warning("Could not book seat '" + seat_id + "'")
          console.log(response);
        }
    })
    .catch(error => {
        display_danger("Error: " + error);
    });
}

// Alerts

function alert_show(alert_style = CLASS_ALERT_INFO, message = "") {

  alert_el = document.getElementById("qqs_alert");
  if (!alert_el) {
    console.error("Could not get alert element!");
    return;
  }

  if (!alert_el.childNodes[9]) {
    console.error("Could not get alert inner message element!");
    return;
  }
  alert_el.childNodes[9].innerHTML = message;

  alert_el.classList.remove("alert_info");
  alert_el.classList.remove("alert_success");
  alert_el.classList.remove("alert_warning");
  alert_el.classList.remove("alert_danger");
  alert_el.classList.add(alert_style);

  alert_el.classList.add("show");
  alert_el.classList.remove("hide");
  alert_el.classList.add("showAlert");
  
  setTimeout(function(){ alert_close() }, 5000);
}

function alert_close() {
  alert_el = document.getElementById("qqs_alert");
  alert_el.classList.remove("show");
  alert_el.classList.add("hide");
}

function display_info(message) {

  console.log("Info message: " + message);
  alert_show(CLASS_ALERT_INFO, message);
}

function display_success(message) {
  
  console.log("Success message: " + message);
  alert_show(CLASS_ALERT_SUCCESS, message);
}

function display_warning(message) {
  
  console.warn("Warning message: " + message);
  alert_show(CLASS_ALERT_WARNING, message);
}

function display_danger(message) {

  console.error("Danger message: " + message);
  alert_show(CLASS_ALERT_DANGER, message);
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('get_all_seats').addEventListener('click', load_all_seats);
    load_all_seats();

    channel = connect_to_socket();
    channel.on("seat_booked", () => {
        load_all_seats();});
});
