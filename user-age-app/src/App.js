import React, { useState } from "react";
import "./App.css";

function App() {
  const [name, setName] = useState("");
  const [dob, setDob] = useState("");
  const [ageResponse, setAgeResponse] = useState("");
  const [users, setUsers] = useState([]);

  const API_BASE = process.env.REACT_APP_API_BASE_URL;

const handleSubmit = async () => {
  const response = await fetch(`${API_BASE}/api/users`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name, dateOfBirth: dob }),
  });

  const data = await response.json();
  setAgeResponse(data.age);
};

const fetchUsers = async () => {
  const response = await fetch(`${API_BASE}/api/users`);
  const data = await response.json();
  setUsers(data);
};


  return (
    <div className="App">
      <h2>User Age Calculator</h2>

      <div>
        <input
          type="text"
          placeholder="Enter name"
          value={name}
          onChange={(e) => setName(e.target.value)}
        />
        <input
          type="date"
          placeholder="Enter Date of Birth"
          value={dob}
          onChange={(e) => setDob(e.target.value)}
        />
        <button onClick={handleSubmit}>Submit</button>
      </div>

      {ageResponse && (
        <div>
          <h3>Calculated Age</h3>
          <p>{ageResponse}</p>
        </div>
      )}

      <hr />

      <div>
        <button onClick={fetchUsers}>Fetch All Users</button>
        {users.length > 0 && (
          <table border="1" cellPadding="5">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Date of Birth</th>
                <th>Age</th>
              </tr>
            </thead>
            <tbody>
              {users.map((u) => (
                <tr key={u.id}>
                  <td>{u.id}</td>
                  <td>{u.name}</td>
                  <td>{u.dateOfBirth}</td>
                  <td>{u.age}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
}

export default App;
