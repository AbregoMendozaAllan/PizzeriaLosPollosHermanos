<h1>{{mode_dsc}}</h1>
{{with pizza}}
<h1>{{pizza_name}}</h1>
<div class="pizza-details-container">
  <!-- Pizza Image -->
  <div class="pizza-image">
    <img src="{{image_url}}" alt="{{pizza_name}}" />
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
    <!-- Submit Button -->
    <button type="submit">Order Now</button>
  </form>
</div>

{{endwith pizza}}