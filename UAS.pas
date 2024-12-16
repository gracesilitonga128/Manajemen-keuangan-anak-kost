program ManajemenKeuanganAnakKost;
uses crt;

{Tipe data record untuk menyimpan transaksi}
type
  Transaksi = record 
    kategori: string;  
    jumlah: longint;   
    tanggal: string;   //Tanggal transaksi dalam format DD/MM/YYYY
  end;

{Deklarasi variabel}
var
  daftarTransaksi: array[1..100] of Transaksi; 
  jumlahTransaksi, menu: integer;             
  saldo: longint;                             

{Prosedur untuk menambahkan transaksi baru}
procedure TambahTransaksi(var daftar: array of Transaksi; var jumlah: integer; var saldo: longint);
var
  t: Transaksi; //Variabel sementara untuk menyimpan data transaksi baru
begin
  clrscr; 
  writeln('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  writeln('       Tambah Transaksi       ');
  writeln('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  
  if jumlah < 100 then//Mengecek apakah data transaksi belum penuh
  begin
    { Menampilkan kategori transaksi dan meminta input pengguna }
    writeln('Kategori:');
    writeln('1. Makanan');
    writeln('2. Transportasi');
    writeln('3. Hiburan');
    write('Pilih kategori (1-3): ');
    readln(menu);
    
    {Menentukan kategori berdasarkan pilihan menu}
    case menu of
      1: t.kategori := 'Makanan';
      2: t.kategori := 'Transportasi';
      3: t.kategori := 'Hiburan';
    else
      begin
        writeln('Kategori tidak valid.');
        readln; 
        exit; {Keluar dari prosedur jika kategori tidak valid}
      end;
    end;

    write('Masukkan tanggal (DD/MM/YYYY): '); readln(t.tanggal);

    write('Masukkan jumlah pengeluaran: '); readln(t.jumlah);
    if t.jumlah > saldo then
    begin
      writeln('Saldo tidak mencukupi untuk transaksi ini.');
      readln;
      exit;
    end;

    saldo := saldo - t.jumlah; //Mengurangi saldo dan menambahkan transaksi ke daftar
    inc(jumlah); //Menambah jumlah transaksi
    daftar[jumlah] := t; //Menyimpan transaksi baru
    writeln('Transaksi berhasil ditambahkan!');
  end
  else
    writeln('Data transaksi penuh.'); 

  writeln('Tekan Enter untuk kembali ke menu utama...');
  readln;
end;

{Prosedur untuk menampilkan laporan transaksi}
procedure TampilkanLaporan(var daftar: array of Transaksi; jumlah: integer; saldo: longint);
var
  i: integer; 
  totalMakanan, totalTransportasi, totalHiburan: longint; 
begin
  clrscr; 
  totalMakanan := 0;
  totalTransportasi := 0;
  totalHiburan := 0;

  writeln('===================================');
  writeln('           Laporan Keuangan        ');
  writeln('===================================');
  writeln('No. | Tanggal     | Kategori       | Jumlah');
  writeln('-------------------------------------------');

  {Loop untuk menampilkan semua transaksi yang ada}
  for i := 1 to jumlah do
  begin
    writeln(i:3, ' | ', daftar[i].tanggal:10, ' | ', daftar[i].kategori:12, ' | ', daftar[i].jumlah:7);
    
    {Menghitung total pengeluaran berdasarkan kategori}
    if daftar[i].kategori = 'Makanan' then
      totalMakanan := totalMakanan + daftar[i].jumlah
    else if daftar[i].kategori = 'Transportasi' then
      totalTransportasi := totalTransportasi + daftar[i].jumlah
    else if daftar[i].kategori = 'Hiburan' then
      totalHiburan := totalHiburan + daftar[i].jumlah;
  end;

  {Menampilkan total pengeluaran dan saldo tersisa}
  writeln('-------------------------------------------');
  writeln('Total Pengeluaran Makanan     : ', totalMakanan);
  writeln('Total Pengeluaran Transportasi: ', totalTransportasi);
  writeln('Total Pengeluaran Hiburan     : ', totalHiburan);
  writeln('Saldo Tersisa                 : ', saldo);
  writeln('Tekan Enter untuk kembali ke menu utama...');
  readln;
end;

{Prosedur untuk mengatur saldo awal}
procedure AturSaldoAwal(var saldo: longint);
begin
  clrscr; 
  writeln('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  writeln('         Atur Saldo Awal       ');
  writeln('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  write('Masukkan saldo awal: '); 
  readln(saldo);
  writeln('Saldo awal berhasil diatur!');
  writeln('Tekan Enter untuk kembali ke menu utama...');
  readln;
end;

{Program utama}
begin
  jumlahTransaksi := 0; //Menginisialisasi jumlah transaksi
  saldo := 0;           //Menginisialisasi saldo awal

  {Menu utama dengan loop repeat-until}
  repeat
    clrscr;
    writeln('_________________________________________');
    writeln('     Manajemen Keuangan Anak Kost       ');
    writeln('_________________________________________');
    writeln('1. Atur Saldo Awal');
    writeln('2. Tambah Transaksi');
    writeln('3. Tampilkan Laporan');
    writeln('4. Keluar');
    writeln('_________________________________________');
    write('Pilih menu (1-4): ');
    readln(menu);

    {Menjalankan prosedur berdasarkan pilihan menu}
    case menu of
      1: AturSaldoAwal(saldo);                              //Menu untuk mengatur saldo awal
      2: TambahTransaksi(daftarTransaksi, jumlahTransaksi, saldo); //Menu untuk menambah transaksi
      3: TampilkanLaporan(daftarTransaksi, jumlahTransaksi, saldo); //Menu untuk menampilkan laporan
      4: writeln('Terima kasih telah menggunakan program ini!'); 
    else
      writeln('Pilihan tidak valid.'); 
    end;
  until menu = 4; //Loop akan berhenti jika menu = 4
end.
