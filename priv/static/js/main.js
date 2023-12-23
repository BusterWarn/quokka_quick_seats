document.getElementById('getAllSeats').addEventListener('click', loadSeats);

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
        if(response.ok) {
            loadSeats(); // Reload all seats after booking
        }
    })
    .catch(error => console.error('Error booking seat:', error));
}

// Initial load of seats
loadSeats();

