# Cài đặt môi trường Python với Script

> Hướng dẫn dưới đây cho phép bạn cài đặt môi trường sử dụng Python trên máy tính thông qua Script cài đặt thay vì phải thực hiện thủ công từng bước một cho mỗi phần mềm.

## Nội dung cài đặt

1. Cài ứng dụng Python cho máy tính
2. Cài ứng dụng Visual Studio Code sử dụng làm IDE để lập trình Python
3. Cài đặt các tiện ích mở rộng (extension) cho  VS Code để kết nối với Python gồm: `python`, `jupyter`
4. Cài đặt `jupyterlab` (tương tự như Jupyter trong VSCode hay Google Colab) sử dụng như ứng dụng soạn thảo lệnh có khả năng tương thích tốt nhất với hầu hết các thư viện Python.
5. Cài đặt các thư viện Python: `vnstock3`, `pandas`, `requests`, `beautifulsoup4`, `selenium`, `PyYAML`, `openpyxl`

# II. Hướng dẫn cài đặt

Xem video hướng dẫn: https://www.youtube.com/watch?v=uqxHCHDLqRE

## Cài đặt cho máy tính Windows

Để thực hiện cài đặt chương trình với PowerShell, bạn có thể mở Powershell bằng cách nhấp chuột phải vào biểu tượng Windows trên thanh Taskbar của máy tính sau đó chọn Windows PowerShell (Admin) và thực hiện tiếp các lệnh sau. 

1. Mở PowerShell từ thư mục chứa file cài đặt, giả sử địa chỉ lưu file mặc định là thư mục Downloads. 

```shell
cd Downloads
```	

1. Chạy lệnh cài đặt từ file script. 

```
powershell -ExecutionPolicy Bypass -File .\oneclick_python_vnstock3_windows.ps1
```

## Cài đặt cho máy tính macOS

Bạn cần mở ứng dụng Terminal trên máy tính Mac thông qua Launcher hoặc sử dụng tổ hợp phím tắt `Cmd` + `Space` sau đó nhập `Terminal` để tìm kiếm, chọn và `Enter`. Tiếp tục quá trình cài đặt với các bước dưới đây.
	
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

# Tham khảo

Nếu bạn cài đặt Python lần đầu, có thể tham khảo thêm file `requirements.txt` cung cấp danh sách các gói cài đặt và phiên bản đang được sử dụng cho môi trường Google Colab đảm bảo khả năng tương thích tốt với nhiều gói cài đặt phần mềm khác nhau.

Để sử dụng, chạy câu lệnh `python3 -m pip install -r requirements.txt` khi đã cài đặt xong Python. 