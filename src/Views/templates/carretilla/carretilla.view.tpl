<form method="POST" action="index.php?page=Carretilla_Carretilla">
  <ul class="carrito-detalles">
    <li class="carrito-item encabezado">
      <span class="pizza-nombre">Pizza</span>
      <span class="pizza-tamano">Tamaño</span>
      <span class="pizza-cantidad">Cantidad</span>
      <span class="pizza-precio">Precio</span>
    </li>
    <!-- Aquí se llenará dinámicamente la lista de items -->
    {{foreach cartItems}}
      <li class="carrito-item" data-item-id="{{item_id}}">
        <div class="item-info">
          <span class="pizza-nombre">{{pizza_name}}</span>
          <span class="pizza-tamano">{{size}}</span>
          <div class="cantidad-controles">
            <button class="btn-restar" type="button" data-item="{{item_id}}" data-precio="{{price}}">-</button>
            <span class="pizza-cantidad" id="cantidad-{{item_id}}">{{quantity}}</span>
            <button class="btn-sumar" type="button" data-item="{{item_id}}" data-precio="{{price}}">+</button>
          </div>
          <span class="pizza-precio">L. <span class="precio-unitario" data-precio="{{price}}">{{price}}</span></span>
        </div>
        <input type="hidden" name="cart_items[{{item_id}}][item_id]" value="{{item_id}}">
        <input type="hidden" name="cart_items[{{item_id}}][quantity]" id="hidden-quantity-{{item_id}}" value="{{quantity}}">
        <input type="hidden" name="cart_items[{{item_id}}][price]" value="{{price}}">
      </li>
    {{endfor cartItems}}
  </ul>

  <div class="carrito-resumen">
    <div class="subtotal">
      <strong>Subtotal:</strong> L. <span id="subtotal">0.00</span>
    </div>
    <div class="impuesto">
      <strong>Impuesto:</strong> L. <span id="impuesto">0.00</span>
    </div>
    <div class="flete">
      <strong>Flete:</strong> L. <span id="flete">0.00</span>
    </div>
    <div class="descuento">
      <strong>Descuento:</strong> L. <span id="descuento">0.00</span>
    </div>
    <div class="cupon">
      <strong>Cupón:</strong> L. <span id="cupon">0.00</span>
    </div>
    <div class="total-precio">
      <strong>TOTAL:</strong> L. <span id="precio-total">0.00</span>
    </div>
  </div>

  <button type="submit" class="Btn">
    Pagar
    <svg class="svgIcon" viewBox="0 0 576 512"><path d="M512 80c8.8 0 16 7.2 16 16v32H48V96c0-8.8 7.2-16 16-16H512zm16 144V416c0 8.8-7.2 16-16 16H64c-8.8 0-16-7.2-16-16V224H528zM64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm56 304c-13.3 0-24 10.7-24 24s10.7 24 24 24h48c13.3 0 24-10.7 24-24s-10.7-24-24-24H120zm128 0c-13.3 0-24 10.7-24 24s10.7 24 24 24H360c13.3 0 24-10.7 24-24s-10.7-24-24-24H248z"></path></svg>
  </button>
</form>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const actualizarTotal = () => {
      const carritoItems = document.querySelectorAll('.carrito-item');
      let subtotal = 0;
      let impuesto = 0;
      let flete = 0;
      let descuento = 0;
      let cupon = 0;

      carritoItems.forEach(item => {
        const cantidadElement = item.querySelector('.pizza-cantidad');
        const precioElement = item.querySelector('.precio-unitario');

        if (cantidadElement && precioElement) {
          const cantidad = parseInt(cantidadElement.textContent);
          const precio = parseFloat(precioElement.getAttribute('data-precio'));

          if (!isNaN(cantidad) && !isNaN(precio)) {
            const itemTotal = cantidad * precio;
            subtotal += itemTotal;

            precioElement.textContent = itemTotal.toFixed(2);
          }
        }
      });

      impuesto = subtotal * 0.15;
      const total = subtotal + impuesto + flete - descuento - cupon;

      document.getElementById('subtotal').textContent = subtotal.toFixed(2);
      document.getElementById('impuesto').textContent = impuesto.toFixed(2);
      document.getElementById('flete').textContent = flete.toFixed(2);
      document.getElementById('descuento').textContent = descuento.toFixed(2);
      document.getElementById('cupon').textContent = cupon.toFixed(2);
      document.getElementById('precio-total').textContent = total.toFixed(2);
    };

    document.querySelectorAll('.carrito-item').forEach(item => {
      const itemId = item.getAttribute('data-item-id');
      const btnSumar = item.querySelector(`.btn-sumar[data-item="${itemId}"]`);
      const btnRestar = item.querySelector(`.btn-restar[data-item="${itemId}"]`);
      const cantidadElement = item.querySelector(`#cantidad-${itemId}`);
      const hiddenQuantityElement = document.getElementById(`hidden-quantity-${itemId}`);

      if (btnSumar && btnRestar && cantidadElement) {
        btnSumar.addEventListener('click', () => {
          let cantidad = parseInt(cantidadElement.textContent);
          cantidad++;
          cantidadElement.textContent = cantidad;
          hiddenQuantityElement.value = cantidad;
          actualizarTotal();
        });

        btnRestar.addEventListener('click', () => {
          let cantidad = parseInt(cantidadElement.textContent);
          if (cantidad > 0) {
            cantidad--;
            cantidadElement.textContent = cantidad;
            hiddenQuantityElement.value = cantidad;
            if (cantidad === 0) {
              eliminarItem(itemId, item);
            }
            actualizarTotal();
          }
        });
      }
    });

    const eliminarItem = (itemId, itemElement) => {
      fetch(window.location.href, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
          'action': 'delete',
          'item_id': itemId
        })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        if (data.success) {
          itemElement.remove();
          actualizarTotal();
        } else {
          alert('Error al eliminar el item: ' + data.message);
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('Ocurrió un error al procesar la solicitud: ' + error.message);
      });
    };

    actualizarTotal();
  });
</script>


<style>
  body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f3f4f6;
    color: #333;
  }

  .carrito-container {
    position: relative;
  }

  .carrito-detalles {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .carrito-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 8px 0;
    font-size: 14px;
    color: #555;
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
  }

  .carrito-item.encabezado {
    font-weight: bold;
    background-color: #f1f1f1;
    padding: 12px 0;
    text-align: center;
  }

  .item-info {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
  }

  .pizza-nombre,
  .pizza-tamano {
    font-weight: bold;
  }

  .cantidad-controles {
    display: flex;
    gap: 10px;
    align-items: center;
  }

  .cantidad-controles button {
    background-color: #f82a2a;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
  }

  .pizza-precio {
    font-size: 14px;
    font-weight: bold;
    margin-left: 10px;
    color: #333;
  }

  .total-precio {
    margin-top: 10px;
    font-size: 16px;
    text-align: right;
  }

  .cupon {
    margin-top: 10px;
    font-size: 16px;
    text-align: right;
  }

  .descuento {
    margin-top: 10px;
    font-size: 16px;
    text-align: right;
  }

  .flete {
    margin-top: 10px;
    font-size: 16px;
    text-align: right;
  }

  .subtotal {
    margin-top: 10px;
    font-size: 16px;
    text-align: right;
  }

  .impuesto {
    margin-top: 10px;
    font-size: 16px;
    text-align: right;
  }

  .Btn {
    width: 130px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: rgb(15, 15, 15);
    border: none;
    color: white;
    font-weight: 600;
    gap: 8px;
    cursor: pointer;
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.103);
    position: relative;
    overflow: hidden;
    transition-duration: .3s;
  }

  .svgIcon {
    width: 16px;
  }

  .svgIcon path {
    fill: white;
  }

  .Btn::before {
    width: 130px;
    height: 130px;
    position: absolute;
    content: "";
    background-color: white;
    border-radius: 50%;
    left: -100%;
    top: 0;
    transition-duration: .3s;
    mix-blend-mode: difference;
  }

  .Btn:hover::before {
    transition-duration: .3s;
    transform: translate(100%, -50%);
    border-radius: 0;
  }

  .Btn:active {
    transform: translate(5px, 5px);
    transition-duration: .3s;
  }
</style>