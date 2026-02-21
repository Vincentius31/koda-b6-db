# Coffee Shop ERD (ENTITY RELATIONSHIP DIAGRAM)

```mermaid
erDiagram
    ROLE ||--o{ USER : "memiliki"
    CATEGORY ||--o{ PRODUCT : "mengkategorikan"
    USER ||--o{ CART : "memasukkan"
    USER ||--o{ ORDER : "membuat"
    PRODUCT ||--o{ CART : "ditambahkan ke"
    PRODUCT ||--o{ DETAIL_ORDER : "tercatat di"
    ORDER ||--|{ DETAIL_ORDER : "terdiri dari"

    USER {
        int id_pengguna PK
        string nama
        string email
        string kata_sandi
        int id_peran FK
    }

    ROLE {
        int id_peran PK
        string nama_peran "Admin / Pelanggan"
    }

    CATEGORY {
        int id_kategori PK
        string nama_kategori "Coffee, Food, dll"
    }

    PRODUCT {
        int id_produk PK
        int id_kategori FK
        string nama_produk
        int harga
        int hargaDiskon
        string url_gambar
        string deskripsi
        int stok
        int sales
    }

    CART {
        int id_keranjang PK
        int id_pengguna FK
        int id_produk FK
        int jumlah
    }

    ORDER {
        int id_pesanan PK
        int id_pengguna FK
        datetime tanggal_pesanan
        int total_harga
        string status_pesanan
    }

    DETAIL_ORDER {
        int id_detail PK
        int id_pesanan FK
        int id_produk FK
        int jumlah
        int harga_total
    }   
```
