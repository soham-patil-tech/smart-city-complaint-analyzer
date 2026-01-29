function login() {
  fetch("../backend/login.php", {
    method: "POST",
    headers: {"Content-Type":"application/x-www-form-urlencoded"},
    body: `email=${email.value}&password=${password.value}`
  })
  .then(res => res.text())
  .then(data => alert(data));
}

function submitComplaint() {
  const title = document.getElementById("title").value;
  const description = document.getElementById("description").value;
  const urgency = document.getElementById("urgency").value;

  fetch("../backend/submit_complaint.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body:
      "user_id=1" +
      "&department=1" +
      "&area=1" +
      "&title=" + encodeURIComponent(title) +
      "&description=" + encodeURIComponent(description) +
      "&urgency=" + encodeURIComponent(urgency)
  })
  .then(res => res.text())
  .then(data => alert(data));
}


fetch("../backend/get_complaints.php")
.then(res => res.json())
.then(data => {
  if (!document.getElementById("table")) return;
  table.innerHTML = "<tr><th>ID</th><th>Title</th><th>Status</th></tr>";
  data.forEach(c => {
    table.innerHTML += `<tr>
      <td>${c.id}</td>
      <td>${c.title}</td>
      <td>${c.status}</td>
    </tr>`;
  });
});
