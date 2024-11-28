{{foreach pizzas}}
<div class="card" style="
    background-color: #f8f8f8;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    max-width: 350px;
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
    ">
      {{description}}
    </div>

    <!-- Add to Order Button -->
    <div class="card__footer" style="
      padding: 16px;
    ">
      <button class="card__button" style="
        background-color: #e74c3c;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      " 
      onmouseover="this.style.backgroundColor='#c0392b'"
      onmouseout="this.style.backgroundColor='#e74c3c'">
        Add to Order
      </button>
    </div>
  </div>
  {{endfor pizzas}}