# SWYNEX – Backend API and Database
## Queueless Campus Canteen | Task 2

This repository extends the Queueless Campus Canteen project planned in Task 1. It contains a Node.js + Express REST API and a PostgreSQL persistence layer.

### Implemented in Task 2

- PostgreSQL tables for menu items, orders and order items.
- Complete Menu CRUD resource: create, read, update and delete.
- Input validation for menu names, prices, categories and availability.
- Order creation with item validation and server-side total calculation.
- PostgreSQL transaction to save an order and all its items together.
- Order listing, token lookup and order-status updates.
- Parameterized SQL queries to avoid SQL injection.

### Technology

- Node.js
- Express.js
- PostgreSQL
- `pg` PostgreSQL client
- dotenv and cors

> Authentication, role-based authorization, payment gateway integration, pickup-slot booking and live updates remain future enhancements. The Task 1 browser prototype uses localStorage and is not yet connected to these API routes. The backend API can be tested independently using Postman or curl.

## Folder structure

```text
SWYNEX-Backend-API-and-Database/
├── README.md
├── .gitignore
├── docs/
│   └── API-TESTING.md
├── backend/
│   ├── .env.example
│   ├── .gitignore
│   ├── package.json
│   ├── db/
│   │   └── schema.sql
│   └── src/
│       ├── db.js
│       ├── server.js
│       └── routes/
│           ├── menu.js
│           └── orders.js
└── frontend/
    ├── index.html
    ├── style.css
    ├── script.js
    ├── admin.html
    └── admin.js
```

## Setup

### 1. Install prerequisites
Install Node.js LTS and PostgreSQL. Create a PostgreSQL database named `queueless_canteen`.

### 2. Create database tables
Open pgAdmin Query Tool for `queueless_canteen`, open `backend/db/schema.sql`, and execute it. This creates the tables and inserts 15 starter menu dishes.

### 3. Configure environment
Open a terminal inside the `backend` folder:

```bash
npm install
```

Copy `.env.example` to `.env`, then update `DATABASE_URL` with your PostgreSQL username and password:

```env
PORT=5000
DATABASE_URL=postgresql://postgres:YOUR_PASSWORD@localhost:5432/queueless_canteen
```

Do not upload `.env` to GitHub.

### 4. Start the API

```bash
npm run dev
```

Or:

```bash
npm start
```

The API runs at `http://localhost:5000`.

Check database connection:
`GET http://localhost:5000/api/health`

## API summary

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/api/health` | Check API and database |
| GET | `/api/menu` | List menu items |
| POST | `/api/menu` | Add menu item |
| PATCH | `/api/menu/:id` | Edit menu item |
| DELETE | `/api/menu/:id` | Delete menu item |
| POST | `/api/orders` | Place an order |
| GET | `/api/orders` | List orders |
| GET | `/api/orders/:token` | Find order by token |
| PATCH | `/api/orders/:token` | Update order status |

See `docs/API-TESTING.md` for sample requests and expected validation behavior.

## Notes about prices
The API accepts and returns menu prices in rupees for easy testing. PostgreSQL stores prices as integer paise to avoid floating-point money calculations. Order totals are calculated by the backend from the saved menu prices; client-submitted totals are never trusted.

------------------------

*Developed as part of SWYNEX Technologies Internship – Task 2 .*
