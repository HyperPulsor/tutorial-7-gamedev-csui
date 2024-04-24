# Tutorial Game Development
## Authors

* **Rakan Fasya Athhar Rayyan** - *2106750950*

## Tutorial 7

### Pembuatan Movement Sprint dan Crouch (beserta HUD)

- Untuk membuat movement *sprint* dan *crouch*, buka script `Player.gd`. tambahkan variabel-variabel tersebut yang berperan untuk mengubah speed pemain saat *sprint* dan *crouch*, serta tinggi pemain saat melakukan *crouch*. Lalu, handle input pemain apabila menekan **Shift**, maka mengubah *speed* pemain menjadi lebih cepat. Selanjutnya, apabila pemain menekan **Ctrl**, maka mengubah *speed* pemain menjadi lebih lambat dan mengubah tinggi `CollisionShape` dari pemain menjadi lebih pendek. Selain itu, diset juga kecepatan perubahan pemain dari *crouch* dan *uncrouch*.<br></br>
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/4c7c825e-9ea5-4d97-8e60-4eeb18e721dd)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/cb65ab16-d5ee-40ec-8139-5d872d97bba1)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/9284c97c-2964-4955-a4a1-645f2c6a6ae4)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/e86bd8cc-f4b8-4dc8-b410-1dd44eaaf50a)

- Untuk pembuatan HUDnya, merupakan HUD yang menunjukkan state pemain (sedang berdiri, *crouch*, atau *sprint*). Buat `CanvasLayer` pada scene `Player` dengan *child node* berupa `GridContainer` (untuk inventory system) dan `TextureRect` untuk menampilkan sprite HUD. Pada `TextureRect` ini, sprite akan diatur berdasrkan state pemain yang sedang dilakukan. Berdasarkan kode sebelumnya, hal itu sudah diatur sehingga mengubah texture pada `TextureRect` dengan spite yang sesuai. Selain itu, skala dan posisi dari diatur sehingga tepat.<br></br>
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/0e2d0bcc-578f-4579-b1d5-8d16800d61d6)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/c2057666-fd7a-49c1-99b0-c31682e45eaa)

### Pembuatan Simple Pick Up and Inventory System

- Pertama, dibuat scene `Item` yang merupakan `RigidBody` beserta scriptnya `ItemPickup.gd`. Dalam scene tersbut, masukkan *child nodes* berupa `MeshInstance` (untuk memberikan bentuk) dan `CollisionShape`. Bentuk yang dipilih merukapan `CapsuleMesh`. Sedangkan, untuk memberikan *collision* dari shape tersebut, pilih `Simple Convex Collision` sehingga collision akurat sesuai bentuk mesh. Selanjutnya, script tadi dimasukkan ke root node. Script ini berisikan nama dari *item*.<br></br>
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/0f5f2e43-58a2-4cfb-b009-2b4b9f428398)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/488c6095-8410-40e6-b738-347cbfe9f301)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/bc458491-d466-4f7a-aec8-8ef53d01ce9e)

- Kedua, buat sebuah node `Area` beserta `CollisionShape`nya (Box) sebagai child node dari `Player` sebagai area untuk mengambil item yang ada pada level. Sambungkan signal `body_entered` ke script `Player.gd`. Signal ini berfungsi untuk memberi tahu saat item memasuki `Area` tersebut.<br></br>
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/d68d34dd-0942-4a35-9a10-1d9f3e324357)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/edd50787-b5eb-43d8-b8d8-ea19d1c8e9a8)

- Sebelum menghandle signal tersebut, buat script baru bernamakan `SignalManager.gd`. Berikut merupakan isi dari *script* ini:
```
extends Node

signal item_grabbed(item_name)
```
- Script ini akan menghandle semua custom signal yang dibuat. Selanjutnya, masukkan script ini ke dalam AutoLoad sehingga bisa diakses oleh semua node. Lalu, bagian `body_entered` pada `Player.gd` akan diimplementasikan dengan mengecek apakah *body* yang masuk merupakan `Item`. Jika iya, maka akan meng*emit* signal bahwa item diambil dan item tersebut dihapus dari level.<br></br>
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/dc471814-2cfc-44fa-a849-32b811ddc932)
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/53686290-863a-4673-8a61-7661fb63145f)

- Ketiga, pada `GridContainer` yang terdapat pada `CanvasLayer` di scene `Player`, masukkan script `HUD.gd`. Script ini berfungsi untuk mengupdate `PanelContainer` dan `Label` yang ada di dalamnya sesuai dengan item_list yang berisikan item yang diambil. Perubahan ini hanya akan terjadi pada saat signal diterima.
![image](https://github.com/HyperPulsor/tutorial-7-gamedev-csui/assets/101686378/db767007-f4e1-4399-a940-eec8c0faefad)

### Referensi
https://www.youtube.com/watch?v=AOqBCXaNjtA&t=591s&ab_channel=ChaffGames (Pick Up System)



