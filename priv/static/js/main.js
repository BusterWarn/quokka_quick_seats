
const CLASS_ALERT_INFO = "alert_info";
const CLASS_ALERT_SUCCESS = "alert_success";
const CLASS_ALERT_WARNING = "alert_warning";
const CLASS_ALERT_DANGER = "alert_danger";

function loadSeats() {
    fetch('http://localhost:4004/api/seats')
        .then(response => response.json())
        .then(seatData => {
            const seatContainer = document.getElementById('seatContainer');
            seatContainer.innerHTML = '';

            seatData.forEach(seat => {
                const btn = document.createElement('button');
                btn.className = 'btn seat-button ' + (seat.is_booked ? 'booked' : 'btn-primary');
                btn.textContent = seat.seat_id;

                // Add title attribute for booked seats
                if (seat.is_booked) {
                    // btn.title = `Name: ${seat.full_name}\nPhone: ${seat.phone_number}`;
                    btn.onmouseenter = function(event) {
                        showTooltip(event, `Name: ${seat.full_name}\nPhone: ${seat.phone_number}`);
                    };
                    btn.onmouseleave = function() {
                        hideTooltip();
                    };
                }

                btn.addEventListener('click', () => bookSeat(seat.seat_id));
                seatContainer.appendChild(btn);
            });
        })
        .catch(error => console.error('Error:', error));
}

function showTooltip(event, text) {
    const tooltip = document.getElementById('seatTooltip');
    tooltip.textContent = text;
    tooltip.style.display = 'block';
    tooltip.style.left = event.clientX + 'px';
    tooltip.style.top = event.clientY + 'px';
}

function hideTooltip() {
    document.getElementById('seatTooltip').style.display = 'none';
}

function bookSeat(seatId) {
    const fullName = document.getElementById('fullName').value || "Mr Quokk";
    const phoneNumber = document.getElementById('phoneNumber').value || "070";

    const requestBody = {
        seat_id: seatId,
        full_name: fullName,
        phone_number: phoneNumber
    };

    fetch('http://localhost:4004/api/book_seat', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestBody)
    })
    .then(response => {
        console.log("then");
        if (response.ok) {
            display_success("Succesfully booked seat '" + seatId + "'!");
            loadSeats(); // Reload all seats after booking
        }
        else
        {
          display_warning("Could not book seat '" + seatId + "'")
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
    document.getElementById('getAllSeats').addEventListener('click', loadSeats);
    loadSeats();
});
