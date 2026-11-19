# API Testing Guide

Base URL: `http://localhost:5000`

You can run these requests in Postman or use the curl examples below.

## 1. Check the database connection

```http
GET /api/health
```

Expected response:

```json
{
  "status": "ok",
  "database": "connected",
  "service": "Queueless Canteen API"
}
```

## 2. Read menu

```http
GET /api/menu
```

## 3. Create a menu item

```http
POST /api/menu
Content-Type: application/json

{
  "name": "Paneer Puff",
  "category": "Snacks",
  "price": 30,
  "available": true
}
```

Expected: `201 Created`, with the saved item and generated ID.

## 4. Test validation

Send an invalid price:

```json
{
  "name": "Paneer Puff",
  "category": "Snacks",
  "price": -10
}
```

Expected: `400 Bad Request` with validation details.

## 5. Update menu item

```http
PATCH /api/menu/1
Content-Type: application/json

{
  "price": 55,
  "available": false
}
```

## 6. Delete menu item

```http
DELETE /api/menu/1
```

Expected: `204 No Content`. A non-existing ID returns `404`.

## 7. Place an order

Use an available menu item ID from `GET /api/menu`:

```http
POST /api/orders
Content-Type: application/json

{
  "name": "Student Demo",
  "items": [
    { "id": 1, "qty": 2 },
    { "id": 2, "qty": 1 }
  ]
}
```

Expected: `201 Created`, with a generated token, item snapshots and server-calculated total.

## 8. List orders

```http
GET /api/orders
```

## 9. Track an order

Replace `101` with the token returned when placing the order:

```http
GET /api/orders/101
```

## 10. Update order status

```http
PATCH /api/orders/101
Content-Type: application/json

{
  "status": "Preparing"
}
```

Allowed statuses: `Placed`, `Preparing`, `Ready`, `Collected`.

## Evidence to capture for Task 2

Take screenshots of:
1. PostgreSQL tables visible in pgAdmin.
2. `/api/health` returning database connected.
3. Successful `POST /api/menu` response.
4. Invalid menu price returning `400`.
5. Successful `POST /api/orders` response.
6. Order status update response.
