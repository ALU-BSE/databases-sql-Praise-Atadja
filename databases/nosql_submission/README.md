# NoSQL Challenge: TechShop MongoDB Database

## Introduction
This project involves designing and implementing a NoSQL database using MongoDB for a startup called TechShop. TechShop is an online marketplace for tech products where users can buy and sell various tech items such as laptops, smartphones, and accessories. The database is designed to store information about users, products, and transactions.

## Database Schema
The database schema consists of three main collections: Users, Products, and Transactions.

### Users Collection
- **Name**: The name of the user.
- **Email**: Unique email address of the user.
- **Password**: Password of the user.

### Products Collection
- **Name**: Name of the product.
- **Description**: Description of the product.
- **Price**: Price of the product.
- **listedBy**: ID of the user who listed the product.

### Transactions Collection
- **buyerId**: ID of the buyer.
- **productId**: ID of the product.
- **Date**: Date of the transaction.
- **Quantity**: Quantity purchased.

## Indexes
An index is created on the name field of the Users collection to speed up queries related to user names.

## Sample Data
Here's some sample data inserted into the collections:

## MongoDB Queries
Here are some MongoDB queries for performing advanced tasks:

### Count the number of products listed by each user
```mongodb
db.Products.aggregate([
  {
    $group: {
      _id: "$listedBy",
      count: { $sum: 1 }
    }
  },
  {
    $lookup: {
      from: "Users",
      localField: "_id",
      foreignField: "_id",
      as: "user"
    }
  },
  {
    $project: {
      _id: 0,
      userName: { $arrayElemAt: ["$user.name", 0] },
      productListings: "$count"
    }
  }
]);
```

The queries effectively address the requirements and provide useful insights into the data stored in the TechShop MongoDB database.

---
