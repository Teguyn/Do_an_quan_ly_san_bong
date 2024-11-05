-- Tạo database
CREATE DATABASE QuanLySanBong;
USE QuanLySanBong;

-- Bảng TaiKhoan
CREATE TABLE TaiKhoan (
    MaTaiKhoan INT PRIMARY KEY IDENTITY(1,1),   -- Khóa chính, tự tăng
    TenDangNhap VARCHAR(50) NOT NULL,           -- Tên đăng nhập
    MatKhau VARCHAR(255) NOT NULL,              -- Mật khẩu (đã mã hóa)
    VaiTro VARCHAR(20) NOT NULL                 -- Vai trò (QuanLy, KhachHang)
);

-- Bảng SanBong
CREATE TABLE SanBong (
    MaSanBong INT PRIMARY KEY IDENTITY(1,1),    -- Khóa chính, tự tăng
    TenSanBong NVARCHAR(100) NOT NULL,           -- Tên sân bóng
    KichThuoc VARCHAR(50),                      -- Kích thước sân
    GiaThue DECIMAL(18,2) NOT NULL,             -- Giá thuê theo giờ
    TrangThai BIT DEFAULT 1                     -- Trạng thái sân (1: trống, 0: đã đặt)
);

-- Bảng KhachHang
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY IDENTITY(1,1),  -- Khóa chính, tự tăng
    TenKhachHang NVARCHAR(100) NOT NULL,         -- Tên khách hàng
    SoDienThoai VARCHAR(15) NOT NULL,           -- Số điện thoại khách hàng
    Email VARCHAR(100)                          -- Email khách hàng
);

-- Bảng DatSan
CREATE TABLE DatSan (
    MaDatSan INT PRIMARY KEY IDENTITY(1,1),     -- Khóa chính, tự tăng
    MaKhachHang INT NOT NULL,                   -- Mã khách hàng
    MaSanBong INT NOT NULL,                     -- Mã sân bóng
    NgayDat DATE NOT NULL,                      -- Ngày đặt sân
    GioBatDau TIME NOT NULL,                    -- Giờ bắt đầu thuê
    GioKetThuc TIME NOT NULL,                   -- Giờ kết thúc thuê
    TongTien DECIMAL(18,2) NOT NULL,            -- Tổng tiền thuê
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),  -- Khóa ngoại tới KhachHang
    FOREIGN KEY (MaSanBong) REFERENCES SanBong(MaSanBong)         -- Khóa ngoại tới SanBong
);

-- Bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY IDENTITY(1,1),     -- Khóa chính, tự tăng
    MaDatSan INT NOT NULL,                      -- Mã đặt sân
    NgayThanhToan DATE NOT NULL,                -- Ngày thanh toán
    HinhThucThanhToan NVARCHAR(50),              -- Hình thức thanh toán (Tiền mặt, Thẻ, Online)
    TongTien DECIMAL(18,2) NOT NULL,            -- Tổng số tiền thanh toán
    FOREIGN KEY (MaDatSan) REFERENCES DatSan(MaDatSan)  -- Khóa ngoại tới DatSan
);

-- Bảng LichThiDau
CREATE TABLE LichThiDau (
    MaLichThiDau INT PRIMARY KEY IDENTITY(1,1), -- Khóa chính, tự tăng
    TenDoiA NVARCHAR(100),                       -- Tên đội A
    TenDoiB NVARCHAR(100),                       -- Tên đội B
    MaSanBong INT NOT NULL,                     -- Mã sân tổ chức
    NgayThiDau DATE NOT NULL,                   -- Ngày thi đấu
    GioThiDau TIME NOT NULL,                    -- Giờ thi đấu
    FOREIGN KEY (MaSanBong) REFERENCES SanBong(MaSanBong)  -- Khóa ngoại tới SanBong
);
USE QuanLySanBong;
DROP TABLE HoaDon;
DROP TABLE DatSan;
DROP TABLE LichThiDau;
DROP TABLE KhachHang;
DROP TABLE SanBong;
DROP TABLE TaiKhoan;

--Thêm tài khoản 
-- Thêm dữ liệu cho bảng TaiKhoan
INSERT INTO TaiKhoan (TenDangNhap, MatKhau, VaiTro)
VALUES 
    ('admin', '12345', 'QuanLy'), 
    ('khachhang02', 'matkhau_mahoa2', 'KhachHang'),
    ('khachhang03', 'matkhau_mahoa3', 'KhachHang'),
    ('quanly03', 'matkhau_mahoa3', 'QuanLy'),
    ('khachhang04', 'matkhau_mahoa4', 'KhachHang');

-- Thêm dữ liệu cho bảng SanBong
INSERT INTO SanBong (TenSanBong, KichThuoc, GiaThue, TrangThai)
VALUES 
    (N'Sân 3', '11x11', 500000, 1), 
    (N'Sân 4', '7x7', 300000, 0),
    (N'Sân 5', '5x5', 200000, 1),
    (N'Sân 7', '11x11', 550000, 0);

-- Thêm dữ liệu cho bảng KhachHang
INSERT INTO KhachHang (TenKhachHang, SoDienThoai, Email)
VALUES 
    (N'Lê Thị C', '0933445566', 'ltc@gmail.com'), 
    (N'Phạm Văn D', '0977554433', 'pvd@gmail.com'),
    (N'Hoàng Thị E', '0900112233', 'hte@gmail.com'),
    (N'Nguyễn Văn F', '0900334455', 'nvf@gmail.com'),
    (N'Trần Thị G', '0911552244', 'ttg@gmail.com');

-- Thêm dữ liệu cho bảng DatSan
INSERT INTO DatSan (MaKhachHang, MaSanBong, NgayDat, GioBatDau, GioKetThuc, TongTien)
VALUES 
    (1, 2, '2024-10-21', '15:00', '17:00', 600000),
    (2, 3, '2024-10-22', '09:00', '11:00', 1000000),
    (3, 4, '2024-10-23', '10:00', '12:00', 600000),
    (5, 1, '2024-10-25', '14:00', '16:00', 400000);

-- Thêm dữ liệu cho bảng HoaDon
INSERT INTO HoaDon (MaDatSan, NgayThanhToan, HinhThucThanhToan, TongTien)
VALUES 
    (2, '2024-10-21', N'Thẻ', 600000),
    (3, '2024-10-22', N'Online', 1000000),
    (4, '2024-10-23', N'Tiền mặt', 600000),

    (1, '2024-10-25', N'Online', 400000);


	INSERT INTO LichThiDau (TenDoiA, TenDoiB, MaSanBong, NgayThiDau, GioThiDau)
	VALUES 
    (N'Đội X', N'Đội Y', 1, '2024-11-01', '08:00'),
    (N'Đội A', N'Đội B', 2, '2024-11-02', '10:00'),
    (N'Đội C', N'Đội D', 3, '2024-11-03', '16:00');

--Truy vấn danh sách sân bóng:
SELECT * FROM SanBong WHERE TrangThai = 1;  -- Lấy các sân đang trống

SELECT * FROM HoaDon
--Truy vấn thông tin đặt sân của khách hàng 
SELECT ds.*, kh.TenKhachHang, sb.TenSanBong 
FROM DatSan ds
JOIN KhachHang kh ON ds.MaKhachHang = kh.MaKhachHang
JOIN SanBong sb ON ds.MaSanBong = sb.MaSanBong;	