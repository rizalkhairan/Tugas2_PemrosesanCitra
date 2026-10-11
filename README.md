## Editor Citra Digital - Ranah Frekuensi

**Editor Citra Digital (MainApp)** adalah aplikasi berbasis MATLAB App Designer
untuk pengolahan citra dalam ranah frekuensi. Aplikasi menyediakan pengaturan
kecerahan, Low-Pass Filter, High-Pass Filter, Band Reject Filter, Notch Reject
Filter, serta restorasi motion blur menggunakan Inverse Filtering dan Wiener
Filtering.

Aplikasi menampilkan citra dan spektrum frekuensinya. Pengguna dapat melihat
pratinjau hasil, menerapkan atau membatalkan perubahan, menggunakan Undo/Redo,
dan menyimpan citra hasil pengolahan. Program mendukung citra grayscale dan
citra berwarna.

Restorasi motion blur bertujuan mengurangi kekaburan akibat pergerakan kamera
atau objek. Hasil restorasi tidak selalu dapat mengembalikan citra asli secara
sempurna karena dipengaruhi oleh ketepatan model gerakan, derau, dan hilangnya
informasi selama pengaburan. Citra hasil restorasi masih dapat mengandung
kekaburan, derau, atau artefak di sekitar tepi objek.

## Dependensi

- **MATLAB** dengan App Designer. Program dikembangkan dan diuji menggunakan
  MATLAB R2026a.
- **Image Processing Toolbox**, antara lain untuk fungsi `imshow`, `im2double`,
  `fspecial`, dan `psf2otf`.
- Berkas berikut berada dalam folder yang sama dengan `MainApp.mlapp`:
  - `ImageEditorState.m`
  - `FrequencyMeasure.m`
  - `LowPassFilter.m`
  - `HighPassFilter.m`
  - `BandRejectFilter.m`
  - `NotchRejectFilter.m`
  - `MotionBlurRestoration.m`
  - `Equations.m`

## Cara Menjalankan

1. Buka MATLAB dan arahkan **Current Folder** ke folder proyek.
2. Buka `MainApp.mlapp` melalui App Designer, lalu klik **Run**. Alternatifnya,
   ketik `MainApp` pada **Command Window**.
3. Klik **Load Image** untuk memuat citra.
4. Atur **Brightness** untuk mengubah kecerahan, atau pilih salah satu tab:
   - **Low-Pass Filter** untuk menghaluskan citra.
   - **High-Pass Filter** untuk menonjolkan perubahan intensitas dan detail.
   - **Band Reject** untuk menekan frekuensi dalam suatu rentang.
   - **Notch Reject** untuk menekan pasangan frekuensi tertentu, misalnya
     akibat derau periodik.
   - **Restoration** untuk mengurangi motion blur.
5. Pilih metode dan atur parameternya. Pada tab **Restoration**, masukkan
   panjang gerakan dalam piksel dan sudut dalam derajat sesuai data uji.
   Atur ambang batas **ε** untuk Inverse Filtering atau rasio derau terhadap
   sinyal **K** untuk Wiener Filtering.
6. Klik **Preview** untuk melihat hasil. Perubahan parameter filter juga
   memperbarui pratinjau. Klik **Apply** untuk menerapkan perubahan atau
   **Cancel** untuk membatalkannya. Gunakan **Undo/Redo** untuk berpindah
   antarhasil penyuntingan.
7. Saat membandingkan parameter restorasi, gunakan pratinjau dan terapkan
   hasil hanya setelah selesai memilih parameter. Jika hasil sudah diterapkan,
   gunakan **Undo** atau muat ulang citra masukan sebelum mencoba restorasi
   lain agar proses tidak diterapkan berulang kali pada hasil sebelumnya.
8. Klik **Save Image** untuk menyimpan hasil. Pastikan perubahan sudah
   diterapkan dengan **Apply** sebelum menyimpan.

##

Syahrizal Bani Khairan — 13523063  
Muhammad Ghifary Komara Putra — 13523066  

Tugas 2 IF4073 Pemrosesan Citra Digital
