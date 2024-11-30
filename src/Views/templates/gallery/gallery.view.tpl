<section class="hero" style="
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  height: 100vh;
  background: url('public/imgs/hero/pizzeriahero2.PNG') no-repeat center center/cover;
  color: #ffffff;
  font-family: Arial, sans-serif;
  padding: 0 20px;
">
  <!-- Overlay for better text visibility -->
  <div style="
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5); /* Dark overlay */
    z-index: 1;
  "></div>

  <div style="position: relative; z-index: 2; max-width: 800px;">
    <!-- Hero Headline -->
    <h1 style="
      font-size: 48px;
      font-weight: bold;
      margin-bottom: 20px;
    ">
      Welcome to Our Pizzeria!
    </h1>

    <!-- Hero Description -->
    <p style="
      font-size: 20px;
      margin-bottom: 30px;
      line-height: 1.6;
    ">
      Enjoy the finest handcrafted pizzas with fresh ingredients and bold flavors. Your perfect meal is just a click away!
    </p>

    <!-- Call to Action Button -->
    <a href="#order" style="
      display: inline-block;
      background-color: #e74c3c;
      color: #ffffff;
      text-decoration: none;
      padding: 15px 30px;
      font-size: 18px;
      border-radius: 8px;
      transition: background-color 0.3s ease;
    " 
    onmouseover="this.style.backgroundColor='#c0392b'"
    onmouseout="this.style.backgroundColor='#e74c3c'">
      Order Now
    </a>
  </div>
</section>



<section style="
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 20px;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
">
<p style="
  font-size: 18px;
  font-weight: 500;
  color: #333333;
  text-align: center;
  margin-bottom: 20px;
  font-family: Arial, sans-serif;
">
  Our customers can't get enough of these favorites! Add them to your cart and taste the love in every bite.
</p>


  {{foreach pizzas}}
<div class="card" style="
    display: flex;
    flex-direction: column; /* Ensure children stack vertically */
    justify-content: space-between; /* Distribute space */
    background-color: #f8f8f8;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    max-width: 350px;
    flex: 1 1 calc(50% - 40px); /* Two cards per row */
    margin: 20px auto;
    font-family: Arial, sans-serif;
    text-align: center;
    transition: all 0.3s ease;
  "
  onmouseover="this.style.transform='translateY(-10px)'; this.style.boxShadow='0 8px 16px rgba(0, 0, 0, 0.2)'"
  onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 8px rgba(0, 0, 0, 0.1)'">

    <!-- Pizza Image -->
    <img src="{{image_url}}" alt="Pizza" style="
      width: 100%;
      height: auto;
    ">

    <!-- Card Header (Pizza Name) -->
    <div class="card__header" style="
      padding: 16px;
      font-size: 22px;
      font-weight: bold;
      color: #333333;
    ">
      {{name}}
    </div>

    <!-- Card Description -->
    <div class="card__body" style="
      padding: 16px;
      font-size: 16px;
      color: #555555;
      line-height: 1.5;
      flex-grow: 1; /* Take up remaining space */
    ">
      {{description}}
    </div>

    <!-- Add to Order Button -->
    <div class="card__footer" style="padding: 16px; margin-top: auto;">
      <a href="index.php?page=Gallery-PizzaDetails&mode=DSP&id={{id}}" style="
        display: block;
        background-color: #e74c3c;
        color: #ffffff;
        text-align: center;
        text-decoration: none;
        border: none;
        border-radius: 4px;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;"
        onmouseover="this.style.backgroundColor='#c0392b'"
        onmouseout="this.style.backgroundColor='#e74c3c'">
        View Details
      </a>
    </div>
    </div>
  </div>

  {{endfor pizzas}}
</section>
