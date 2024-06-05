# Cài đặt môi trường Python với Script

> Hướng dẫn dưới đây cho phép bạn cài đặt môi trường sử dụng Python trên máy tính thông qua Script cài đặt thay vì phải thực hiện thủ công từng bước một cho mỗi phần mềm.

## Nội dung cài đặt

1. Cài ứng dụng Python cho máy tính
2. Cài ứng dụng Visual Studio Code sử dụng làm IDE để lập trình Python
3. Cài đặt các tiện ích mở rộng (extension) cho  VS Code để kết nối với Python gồm: `python`, `jupyter`
4. Cài đặt các thư viện Python: `vnstock3`, `pandas`, `requests`, `beautifulsoup4`, `selenium`, `PyYAML`, `openpyxl`

# II. Hướng dẫn cài đặt

Xem video hướng dẫn: https://www.youtube.com/watch?v=uqxHCHDLqRE

## Cài đặt cho máy tính Windows

Để thực hiện cài đặt chương trình với PowerShell, bạn có thể mở Powershell bằng cách nhấp chuột phải vào biểu tượng Windows trên thanh Taskbar của máy tính sau đó thực hiện tiếp các lệnh sau. Nếu chế độ thông thường, bạn có thể sẽ phải mở Powershell dưới chế độ Admin.

1. Mở PowerShell từ thư mục chứa file cài đặt. 

```shell
cd Downloads
```

Câu lệnh trên cho phép chuyển đến thư mục Download để tiếp tục sử dụng chương trình Powershell.

2. Chạy lệnh cài đặt từ file script. 

```
powershell -ExecutionPolicy Bypass -File .\oneclick_python_vnstock3_windows.ps1
```

## Cài đặt cho máy tính macOS

> Để cài đặt bộ môi trường Python thông qua file cài đặt tất cả trong một, bạn cần sử dụng ứng dụng Terminal trên máy để thực hiện các thao tác.

1. Mở thư mục `Downloads` là thư mục lưu file cài đặt mà bạn tải về từ trình duyệt web bằng câu lệnh:

```shell
cd Downloads
```

2. Trao quyền thực thi cho file `oneclick_python_vnstock3_macos.sh` để hệ thống có thể hiểu đây là file cài đặt phần mềm

```shell
chmod +x oneclick_python_vnstock3_macos.sh
```

3. Chạy file cài đặt

```shell
bash ./oneclick_python_vnstock3_macos.sh
```

## Cài đặt cho máy tính Linux

1. Mở thư mục `Downloads` là thư mục lưu file cài đặt mà bạn tải về từ trình duyệt web bằng câu lệnh:

```shell
cd Downloads
```

2. Trao quyền thực thi cho file `oneclick_python_vnstock3_macos.sh` để hệ thống có thể hiểu đây là file cài đặt phần mềm

```shell
chmod +x oneclick_python_vnstock3_linux.sh
```

3. Chạy file cài đặt

```shell
bash ./oneclick_python_vnstock3_linux.sh
```