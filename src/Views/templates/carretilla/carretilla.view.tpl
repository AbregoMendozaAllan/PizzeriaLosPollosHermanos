<p>Hola</p>

{{foreach carretilla}}
<h1>{{cart_id}}</h1>
<h1>{{usercod}}</h1>
<h1>{{created_at}}</h1>
{{endfor carretilla}}

{{foreach cartItems}}
<h1>{{item_id}}</h1>
<h1>{{cart_id}}</h1>
<h1>{{pizza_id}}</h1>
<h1>{{size_id}}</h1>
<h1>{{quantity}}</h1>
<h1>{{price}}</h1>
<h1>{{added_at}}</h1>
{{endfor cartItems}}