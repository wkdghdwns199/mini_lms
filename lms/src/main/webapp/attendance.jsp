<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Location Page</title>
    <script>
        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            } else {
                alert("Geolocation is not supported by this browser.");
            }
        }

        function showPosition(position) {
            const lat = position.coords.latitude;
            const lon = position.coords.longitude;
			console.log(lat,lon)
            // 서버에 위치 정보 전송
            fetch('saveLocation', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    'latitude': lat,
                    'longitude': lon
                })
            })
            .then(response => response.text())
            .then(data => {
                document.getElementById("result").innerText = data;
            })
            .catch(error => {
                console.error('Error:', error);
                alert("An error occurred while sending location data.");
            });
        }

        function showError(error) {
            switch(error.code) {
                case error.PERMISSION_DENIED:
                    alert("User denied the request for Geolocation. Please allow location access to proceed.");
                    document.getElementById("result").innerText = "Location access denied. Please enable location services and try again.";
                    break;
                case error.POSITION_UNAVAILABLE:
                    alert("Location information is unavailable.");
                    document.getElementById("result").innerText = "Location information is unavailable.";
                    break;
                case error.TIMEOUT:
                    alert("The request to get user location timed out.");
                    document.getElementById("result").innerText = "The request to get user location timed out.";
                    break;
                case error.UNKNOWN_ERROR:
                    alert("An unknown error occurred.");
                    document.getElementById("result").innerText = "An unknown error occurred.";
                    break;
            }
        }
    </script>
</head>
<body>
    <h2>Location Page</h2>
    <p id="result">Fetching your location...</p>
    <button onclick="getLocation()">Try Again</button>
</body>
</html>