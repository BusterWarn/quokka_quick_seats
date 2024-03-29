const CLASS_ALERT_INFO = "alert_info";
const CLASS_ALERT_SUCCESS = "alert_success";
const CLASS_ALERT_WARNING = "alert_warning";
const CLASS_ALERT_DANGER = "alert_danger";

function alert_show(alert_style = CLASS_ALERT_INFO, message = "") {
  const alert_el = document.getElementById("qqs_alert");
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

  setTimeout(function () {
    alert_close();
  }, 5000);
}

function alert_close() {
  const alert_el = document.getElementById("qqs_alert");
  alert_el.classList.remove("show");
  alert_el.classList.add("hide");
}

export function display_info(message) {
  console.log("Info message: " + message);
  alert_show(CLASS_ALERT_INFO, message);
}

export function display_success(message) {
  console.log("Success message: " + message);
  alert_show(CLASS_ALERT_SUCCESS, message);
}

export function display_warning(message) {
  console.warn("Warning message: " + message);
  alert_show(CLASS_ALERT_WARNING, message);
}

export function display_danger(message) {
  console.error("Danger message: " + message);
  alert_show(CLASS_ALERT_DANGER, message);
}
