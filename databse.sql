Table admin {
  admin_user varchar(25) [primary key]
  admin_pass varchar(50) [not null]
  admin_name varchar(30) [not null]
  admin_elem varchar(250) [not null]
  admin_email varchar(100) [not null]
  admin_telephone varchar(15) [not null]
  admin_ip varchar(12) [not null]
  admin_online int [not null]
  admin_level_kode int [not null, ref: > admin_level.admin_level_kode]
  admin_status varchar(100) [not null]
  admin_created timestamp [not null]
  admin_updated timestamp [not null]
}

Table admin_level {
  admin_level_kode serial [primary key]
  admin_level_name varchar(30) [not null]
  admin_level_status char(1) [not null]
  admin_level_created timestamp [not null]
  admin_level_updated timestamp [not null]
}

Table customer {
  id_customer serial [primary key]
  nama_customer varchar(100) [not null]
  alamat_customer varchar(100) [not null]
  notelp_customer varchar(12) [not null]
  customer_created timestamp [not null, default: "current_timestamp"]
  customer_updated timestamp [not null, default: "current_timestamp"]
}

Table identitas {
  identitas_id serial [primary key]
  identitas_website varchar(250) [not null]
  identitas_deskripsi text [not null]
  identitas_keyword text [not null]
  identitas_alamat varchar(250) [not null]
  identitas_notelp char(20) [not null]
  identitas_fb varchar(100) [not null]
  identitas_email varchar(100) [not null]
  identitas_tw varchar(100) [not null]
  identitas_gp varchar(100) [not null]
  identitas_yb varchar(100) [not null]
  identitas_favicon varchar(250) [not null]
  identitas_author varchar(100) [not null]
  identitas_created timestamp [not null, default: "current_timestamp"]
  identitas_updated timestamp [not null, default: "current_timestamp"]
}

Table limitstock {
  limitstock_id serial [primary key]
  stock int [not null]
  limitstock_created timestamp [not null, default: "current_timestamp"]
  limitstock_updated timestamp [not null, default: "current_timestamp"]
}

Table master_barang {
  id_barang serial [primary key]
  nama_barang varchar(255) [not null]
  merek varchar(255) [not null]
  stock int [not null]
  barang_created timestamp [not null, default: "current_timestamp"]
  barang_updated timestamp [not null, default: "current_timestamp"]
}

Table sessions {
  session_id varchar(40) [not null, default: '0']
  ip_address varchar(16) [not null, default: '0']
  user_agent varchar(120) [not null]
  last_activity int [not null, default: 0]
  user_data text [not null]
}

Table supplier {
  id_supplier serial [primary key]
  nama_supplier varchar(100) [not null]
  alamat_supplier varchar(100) [not null]
  notelp_supplier varchar(12) [not null]
  supplier_created timestamp [not null, default: "current_timestamp"]
  supplier_updated timestamp [not null, default: "current_timestamp"]
}

Table transaksi_barang {
  id_transaksi serial [primary key]
  jumlah int
  tanggal_transaksi timestamp [default: "current_timestamp"]
  transaksi_updated timestamp [not null, default: "current_timestamp"]
  status_pergerakan char(1) [not null]
  id_barang int [not null, ref: > master_barang.id_barang]
  admin_user varchar(119) [not null, ref: > admin.admin_user]
  id_supplier int [not null, ref: > supplier.id_supplier]
  id_customer int [not null, ref: > customer.id_customer]
}

Table transaksi_barang_masuk {
  id_transaksi_masuk serial [primary key]
  id_transaksi int [not null, ref: > transaksi_barang.id_transaksi]
  transaksi_masuk_updated timestamp [not null, default: "current_timestamp"]
  id_supplier int [not null, ref: > supplier.id_supplier]
}

Table transaksi_barang_keluar {
  id_transaksi_keluar serial [primary key]
  id_transaksi int [not null, ref: > transaksi_barang.id_transaksi]
  transaksi_keluar_updated timestamp [not null, default: "current_timestamp"]
  id_customer int [not null, ref: > customer.id_customer]
}

Ref: admin_level.admin_level_kode > admin.admin_level_kode
Ref: master_barang.id_barang > transaksi_barang.id_barang
Ref: admin.admin_user > transaksi_barang.admin_user
Ref: supplier.id_supplier > transaksi_barang.id_supplier
Ref: customer.id_customer > transaksi_barang.id_customer
Ref: transaksi_barang.id_transaksi > transaksi_barang_masuk.id_transaksi
Ref: supplier.id_supplier > transaksi_barang_masuk.id_supplier
Ref: transaksi_barang.id_transaksi > transaksi_barang_keluar.id_transaksi
Ref: customer.id_customer > transaksi_barang_keluar.id_customer
