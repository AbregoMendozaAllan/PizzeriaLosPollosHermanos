<h1>Cart Items</h1>
    <table>
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Pizza ID</th>
                <th>Size</th>
                <th>Price</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
            
            {{foreach cartitems}}
            <tr>
                <td>{{item_id}}</td>
                <td>{{pizza_id}}</td>
                <td>{{size_id}}</td>
                <td>{{price}}</td>
                <td>{{quantity}}</td>
            </tr>
            {{endfor cartitems}}
        </tbody>
    </table>

    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 18px;
            text-align: left;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>