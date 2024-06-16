<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Background Color</title>
</head>
<body>
    <label for="colorSelect">Choose a color:</label>
    <select id="colorSelect">
        <option value="">Select a color</option>
        <option value="red" style="background-color: red;">Red</option>
        <option value="green" style="background-color: green;">Green</option>
        <option value="blue" style="background-color: blue;">Blue</option>
    </select>

    <script>
        document.getElementById('colorSelect').addEventListener('change', function() {
            var selectedColor = this.options[this.selectedIndex].value;
            this.style.backgroundColor = selectedColor;
        });
    </script>
</body>
</html>
