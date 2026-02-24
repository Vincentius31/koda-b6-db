# Coffee Shop ERD (ENTITY RELATIONSHIP DIAGRAM)

```mermaid
erDiagram
    ROLES ||--o{ USERS : "memiliki"
    USERS ||--o{ TRANSACTION : "melakukan"
    USERS ||--o{ CART : "memiliki"
    USERS ||--o{ REVIEW : "memberi"

    CATEGORY ||--o{ PRODUCTS_CATEGORY : "mengkategorikan"
    PRODUCTS ||--o{ PRODUCTS_CATEGORY : "termasuk dalam"
    
    PRODUCTS ||--o{ PRODUCT_IMAGES : "memiliki"
    PRODUCTS ||--o{ PRODUCT_VARIANT : "memiliki"
    PRODUCTS ||--o{ PRODUCT_SIZE : "memiliki"
    PRODUCTS ||--o{ DISCOUNT : "mendapat"
    PRODUCTS ||--o{ REVIEW : "menerima"
    PRODUCTS ||--o{ CART : "menyimpan"

    TRANSACTION ||--|{ TRANSACTION_PRODUCT : "memiliki"
    PRODUCTS ||--o{ TRANSACTION_PRODUCT : "memiliki"

    ROLES {
        int id_roles PK
        string name_roles
    }

    USERS {
        int id_user PK
        int roles_id FK
        string fullname
        string email
        string password
        string address
        string phone
        string profile_picture
    }

    PRODUCTS {
        int id_product PK
        string name
        string desc
        int price
        int quantity
        boolean isActive
    }

    CATEGORY {
        int id_category PK
        string name_category
    }

    PRODUCTS_CATEGORY {
        int product_id FK
        int category_id FK
    }

    DISCOUNT {
        int id_discount PK
        int product_id FK
        float discount_rate
        string description
        boolean isFlashSale
    }

    PRODUCT_VARIANT {
        int id_variant PK
        int product_id FK
        string variant_name
        int additional_price
    }

    PRODUCT_SIZE {
        int id_size PK
        int product_id FK
        string size_name
        int additional_price
    }

    CART {
        int id_cart PK
        int user_id FK
        int product_id FK
        int variant_id FK
        int size_id FK
        int quantity
    }

    TRANSACTION {
        int id_transaction PK
        int user_id FK
        string delivery_method
        int subtotal
        int total
        string status
        string payment_method
    }

    TRANSACTION_PRODUCT {
        int id_trans_prod PK
        int transaction_id FK
        int product_id FK
        int quantity
        string size
        string variant
        int price
    }

    REVIEW {
        int id_review PK
        int user_id FK
        int product_id FK
        string messages
        int rating
    }

    PRODUCT_IMAGES {
        int id_image PK
        int product_id FK
        string path
    }

```
