<h1>{{mode_dsc}}</h1>
{{with pizza}}
<h1>{{pizza_name}}</h1>
<div class="pizza-details-container pizza-details">
  <!-- Pizza Image -->
  <div class="pizza-image-container">
    <img class="Img-Size" src="{{image_url}}" alt="{{pizza_name}}" />
  </div>

  <!-- Pizza Name -->
  <h1 class="pizza-name">{{pizza_name}}</h1>

  <!-- Pizza Ingredients -->
  <p class="pizza-ingredients"><strong>Ingredients:</strong> {{ingredients}}</p>

  <!-- Pizza Description -->
  <p class="pizza-description">{{description}}</p>

  <!-- Pizza Sizes -->
  <form method="POST" action="/order">
    <h3>Select Size</h3>
    <div class="pizza-sizes" style="margin-bottom: 20px;">
      {{with ~pizzaSizes}}
        {{foreach ~pizzaSizes}}
          <div class="size-option" style="margin-bottom: 10px; text-align: left;">
            <input type="radio" id="size_{{size_id}}" name="pizza_size" value="{{size_id}}" required
              style="margin-right: 10px;" />
            <label for="size_{{size_id}}" style="font-size: 18px; color: #555;">
              {{sizeName}} - ${{price}}
            </label>
          </div>
        {{endfor ~pizzaSizes}}
      {{endwith ~pizzaSizes}}
    </div>

    <!-- Quantity Control -->
    <div class="cantidad-controles">
      <span class="cantidad-label">Cantidad:</span>
      <button type="button" class="btn-restar" id="btn-restar">-</button>
      <span class="pizza-cantidad" id="cantidad">1</span>
      <button type="button" class="btn-sumar" id="btn-sumar">+</button>
    </div>

    <!-- Submit Button -->
    <button type="submit" class="order-button">Order Now</button>
  </form>
</div>

{{endwith pizza}}

<style>
/* Global Styles */
:root {
  --primary: #007bff;
  --secondary: #6c757d;
  --success: #28a745;
  --font-sans: 'Font-PH-2', sans-serif;
}

body {
  margin: 0;
  font-family: var(--font-sans), -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  font-size: 1rem;
  line-height: 1.5;
  background-image: url('public/imgs/hero/Marmol.png');
  background-size: 120%; /* Aumenta el tamaño del fondo */
  background-repeat: no-repeat;
  background-position: center center; /* Centra la imagen */
  text-align: center;
  color: #212529;
  cursor: url('/Stylesheets/Pizza Normal Select.cur'), pointer;
}

*,
::after,
::before {
  box-sizing: border-box;
}

h2, h3 {
  margin-bottom: 15px;
  color: var(--secondary);
}

/* Pizza Details */
.pizza-details {
  margin: 20px auto;
  max-width: 600px;
  background-color: #fff;
  border: 1px solid rgba(0, 0, 0, 0.125);
  border-radius: 0.25rem;
  padding: 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.pizza-image-container {
  margin-bottom: 20px;
}

.Img-Size {
  border: 0;
  background-color: transparent;
  width: 100%;
  max-width: 400px;
  height: auto;
}

.pizza-name {
  font-size: 1.8rem;
  font-weight: bold;
  margin: 15px 0;
}

.pizza-ingredients,
.pizza-description {
  font-size: 1rem;
  margin-bottom: 15px;
}

/* Pizza Sizes */
.pizza-sizes {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 10px;
}

.size-option {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 1rem;
  color: var(--secondary);
}

input[type='radio'] {
  cursor: pointer;
}

/* Quantity Controls */
.cantidad-controles {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 20px;
}

.cantidad-label {
  font-size: 1rem;
  font-weight: bold;
  color: var(--secondary);
}

.cantidad-controles button {
  background-color: #f82a2a;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
}

.pizza-cantidad {
  font-size: 1.2rem;
  font-weight: bold;
  margin: 0 10px;
}

/* Button */
.order-button {
  margin-top: 20px;
  padding: 10px 20px;
  font-size: 1rem;
  color: #fff;
  background-color: var(--success);
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.order-button:hover {
  background-color: #218838;
}
</style>
