<h1>Your Shopping Cart</h1>

{{if cartEmpty}}
    <p>Your cart is empty.</p>
{{else}}
    <table>
        <thead>
            <tr>
                <th>Pizza ID</th>
                <th>Size</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
            {{foreach cartItems}}
                <tr>
                    <td>{{pizza_id}}</td>
                    <td>{{size_id}}</td>
                    <td>{{quantity}}</td>
                    <td>{{price}}</td>
                </tr>
            {{endfor cartItems}}
        </tbody>
    </table>
{{endif cartEmpty}}

{{if error}}
    <p class="error">{$error}</p>
{{endif error}}
