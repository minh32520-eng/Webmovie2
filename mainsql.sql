IF DB_ID(N'Cinema') IS NULL
BEGIN
    CREATE DATABASE Cinema;
END
GO

USE Cinema;
GO

/* ============================================================
   XÓA OBJECT CŨ THEO ĐÚNG THỨ TỰ
   ============================================================ */
IF OBJECT_ID(N'dbo.InsertSeats', N'P') IS NOT NULL
    DROP PROCEDURE dbo.InsertSeats;
GO

IF OBJECT_ID(N'dbo.booking_seats', N'U') IS NOT NULL
    DROP TABLE dbo.booking_seats;
GO

IF OBJECT_ID(N'dbo.bookings', N'U') IS NOT NULL
    DROP TABLE dbo.bookings;
GO

IF OBJECT_ID(N'dbo.showtimes', N'U') IS NOT NULL
    DROP TABLE dbo.showtimes;
GO

IF OBJECT_ID(N'dbo.seats', N'U') IS NOT NULL
    DROP TABLE dbo.seats;
GO

IF OBJECT_ID(N'dbo.rooms', N'U') IS NOT NULL
    DROP TABLE dbo.rooms;
GO

IF OBJECT_ID(N'dbo.cinemas', N'U') IS NOT NULL
    DROP TABLE dbo.cinemas;
GO

IF OBJECT_ID(N'dbo.movies', N'U') IS NOT NULL
    DROP TABLE dbo.movies;
GO

IF OBJECT_ID(N'dbo.users', N'U') IS NOT NULL
    DROP TABLE dbo.users;
GO

/* ============================================================
   1. USERS
   ============================================================ */
CREATE TABLE dbo.users (
    user_id    INT IDENTITY(1,1) PRIMARY KEY,
    username   NVARCHAR(50) NOT NULL UNIQUE,
    [password] NVARCHAR(255) NOT NULL,
    email      NVARCHAR(100) NOT NULL UNIQUE,
    phone      NVARCHAR(20),
    avatar     VARCHAR(255) DEFAULT 'default-avatar.png',
    role       NVARCHAR(20) NOT NULL,
    is_active  BIT NOT NULL DEFAULT 1,
    CONSTRAINT CK_users_role CHECK (role IN ('admin', 'user'))
);
GO

/* ============================================================
   2. MOVIES
   ============================================================ */
CREATE TABLE dbo.movies (
    movie_id      INT IDENTITY(1,1) PRIMARY KEY,
    title         NVARCHAR(255) NOT NULL,
    poster        VARCHAR(255) DEFAULT 'default-poster.jpg',
    trailer       NVARCHAR(MAX) DEFAULT '',
    description   NVARCHAR(MAX),
    duration      INT NOT NULL,
    genre         NVARCHAR(150),
    language      NVARCHAR(100),
    director      NVARCHAR(100),
    cast_list     NVARCHAR(MAX),
    release_date  DATE,
    end_date      DATE,
    rating        DECIMAL(3,1) DEFAULT 0.0,
    age_limit     VARCHAR(10) DEFAULT 'P',
    status        VARCHAR(20) DEFAULT 'NOW_SHOWING',
    created_at    DATETIME DEFAULT GETDATE(),

    CONSTRAINT CK_movies_status
        CHECK (status IN ('NOW_SHOWING', 'COMING_SOON', 'SPECIAL_SHOW')),

    CONSTRAINT CK_movies_rating
        CHECK (rating BETWEEN 0.0 AND 10.0),

    CONSTRAINT CK_movies_duration
        CHECK (duration > 0),

    CONSTRAINT CK_movies_date
        CHECK (end_date IS NULL OR release_date IS NULL OR end_date >= release_date)
);
GO

/* ============================================================
   3. CINEMAS
   ============================================================ */
CREATE TABLE dbo.cinemas (
    cinema_id   INT IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(150) NOT NULL,
    address     NVARCHAR(255) NOT NULL,
    phone       VARCHAR(15),
    created_at  DATETIME NOT NULL DEFAULT GETDATE()
);
GO

/* ============================================================
   4. ROOMS
   ============================================================ */
CREATE TABLE dbo.rooms (
    room_id      INT IDENTITY(1,1) PRIMARY KEY,
    cinema_id    INT NOT NULL,
    room_name    NVARCHAR(50) NOT NULL,
    room_type    VARCHAR(20) DEFAULT 'STANDARD',
    total_rows   INT NOT NULL,
    total_cols   INT NOT NULL,

    CONSTRAINT CK_rooms_room_type
        CHECK (room_type IN ('STANDARD', 'IMAX', '4DX', 'PREMIUM')),

    CONSTRAINT CK_rooms_total_rows
        CHECK (total_rows > 0),

    CONSTRAINT CK_rooms_total_cols
        CHECK (total_cols > 0),

    CONSTRAINT FK_rooms_cinemas
        FOREIGN KEY (cinema_id) REFERENCES dbo.cinemas(cinema_id),

    CONSTRAINT UQ_rooms UNIQUE (cinema_id, room_name)
);
GO

/* ============================================================
   5. SEATS
   ============================================================ */
CREATE TABLE dbo.seats (
    seat_id     INT IDENTITY(1,1) PRIMARY KEY,
    room_id     INT NOT NULL,
    row_label   CHAR(1) NOT NULL,
    col_num     INT NOT NULL,
    seat_type   VARCHAR(10) DEFAULT 'STANDARD',
    is_active   BIT DEFAULT 1,

    CONSTRAINT CK_seats_seat_type
        CHECK (seat_type IN ('STANDARD', 'VIP', 'COUPLE')),

    CONSTRAINT CK_seats_col_num
        CHECK (col_num > 0),

    CONSTRAINT FK_seats_rooms
        FOREIGN KEY (room_id) REFERENCES dbo.rooms(room_id)
        ON DELETE CASCADE,

    CONSTRAINT UQ_seats UNIQUE (room_id, row_label, col_num)
);
GO

/* ============================================================
   6. SHOWTIMES
   ============================================================ */
CREATE TABLE dbo.showtimes (
    showtime_id    INT IDENTITY(1,1) PRIMARY KEY,
    movie_id       INT NOT NULL,
    room_id        INT NOT NULL,
    start_time     DATETIME NOT NULL,
    end_time       DATETIME NOT NULL,
    price_std      DECIMAL(10,0) NOT NULL DEFAULT 85000,
    price_vip      DECIMAL(10,0) NOT NULL DEFAULT 120000,
    price_couple   DECIMAL(10,0) NOT NULL DEFAULT 200000,
    format         VARCHAR(20) NOT NULL DEFAULT '2D',
    status         VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at     DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_showtimes_status
        CHECK (status IN ('ACTIVE', 'CANCELLED', 'FULL')),

    CONSTRAINT CK_showtimes_time
        CHECK (end_time > start_time),

    CONSTRAINT CK_showtimes_price_std
        CHECK (price_std >= 0),

    CONSTRAINT CK_showtimes_price_vip
        CHECK (price_vip >= 0),

    CONSTRAINT CK_showtimes_price_couple
        CHECK (price_couple >= 0),

    CONSTRAINT FK_showtimes_movies
        FOREIGN KEY (movie_id) REFERENCES dbo.movies(movie_id),

    CONSTRAINT FK_showtimes_rooms
        FOREIGN KEY (room_id) REFERENCES dbo.rooms(room_id)
);
GO

/* ============================================================
   7. BOOKINGS
   ============================================================ */
CREATE TABLE dbo.bookings (
    booking_id       INT IDENTITY(1,1) PRIMARY KEY,
    user_id          INT NOT NULL,
    showtime_id      INT NOT NULL,
    total_amount     DECIMAL(12,0) NOT NULL,
    payment_method   VARCHAR(10) NOT NULL DEFAULT 'COD',
    payment_status   VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    booking_code     VARCHAR(20) NOT NULL UNIQUE,
    note             NVARCHAR(MAX),
    created_at       DATETIME NOT NULL DEFAULT GETDATE(),
    paid_at          DATETIME NULL,

    CONSTRAINT CK_bookings_payment_method
        CHECK (payment_method IN ('COD', 'VNPAY', 'MOMO')),

    CONSTRAINT CK_bookings_payment_status
        CHECK (payment_status IN ('PENDING', 'PAID', 'CANCELLED', 'REFUNDED')),

    CONSTRAINT CK_bookings_total_amount
        CHECK (total_amount >= 0),

    CONSTRAINT FK_bookings_users
        FOREIGN KEY (user_id) REFERENCES dbo.users(user_id),

    CONSTRAINT FK_bookings_showtimes
        FOREIGN KEY (showtime_id) REFERENCES dbo.showtimes(showtime_id)
);
GO

/* ============================================================
   8. BOOKING_SEATS
   ============================================================ */
CREATE TABLE dbo.booking_seats (
    ticket_id    INT IDENTITY(1,1) PRIMARY KEY,
    booking_id   INT NOT NULL,
    showtime_id  INT NOT NULL,
    seat_id      INT NOT NULL,
    price        DECIMAL(10,0) NOT NULL,

    CONSTRAINT CK_booking_seats_price
        CHECK (price >= 0),

    CONSTRAINT FK_booking_seats_bookings
        FOREIGN KEY (booking_id) REFERENCES dbo.bookings(booking_id)
        ON DELETE CASCADE,

    CONSTRAINT FK_booking_seats_showtimes
        FOREIGN KEY (showtime_id) REFERENCES dbo.showtimes(showtime_id),

    CONSTRAINT FK_booking_seats_seats
        FOREIGN KEY (seat_id) REFERENCES dbo.seats(seat_id),

    CONSTRAINT UQ_booking_seat UNIQUE (booking_id, seat_id),
    CONSTRAINT UQ_seat_showtime UNIQUE (showtime_id, seat_id)
);
GO

/* ============================================================
   PROCEDURE TẠO GHẾ
   ============================================================ */
CREATE PROCEDURE dbo.InsertSeats
    @p_room_id INT,
    @p_rows INT,
    @p_cols INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @j INT;
    DECLARE @row_char CHAR(1);
    DECLARE @seat_t VARCHAR(10);

    WHILE @i <= @p_rows
    BEGIN
        SET @j = 1;
        SET @row_char = CHAR(64 + @i);

        WHILE @j <= @p_cols
        BEGIN
            IF @i >= @p_rows - 1
                SET @seat_t = 'VIP';
            ELSE
                SET @seat_t = 'STANDARD';

            INSERT INTO dbo.seats (room_id, row_label, col_num, seat_type)
            VALUES (@p_room_id, @row_char, @j, @seat_t);

            SET @j = @j + 1;
        END

        SET @i = @i + 1;
    END
END
GO

/* ============================================================
   INSERT DỮ LIỆU MẪU
   ============================================================ */

/* USERS */
INSERT INTO dbo.users (username, [password], email, phone, role)
VALUES
(N'admin', N'123', N'admin@gmail.com', N'0900000000', N'admin'),
(N'user1', N'123', N'user1@gmail.com', N'0911111111', N'user'),
(N'user2', N'123', N'user2@gmail.com', N'0922222222', N'user');
GO

/* MOVIES - 1 title */
INSERT INTO dbo.movies (
    title,
    poster,
    trailer,
    description,
    duration,
    genre,
    language,
    director,
    cast_list,
    release_date,
    end_date,
    rating,
    age_limit,
    status
)
-- ================== ĐANG CHIẾU ==================
VALUES
(
    N'Doraemon: Nobita và vùng đất lý tưởng',
    'https://pics.filmaffinity.com/eiga_doraemon_nobita_to_sora_no_utopia-894934386-large.jpg',
    'https://www.youtube.com/watch?v=doraemon_trailer',
    N'Cuộc phiêu lưu mới của Doraemon...',
    110,
    N'Hoạt hình',
    N'JP',
    N'Yamaguchi',
    N'Doraemon',
    '2024-05-20',
    NULL,
    8.0,
    'P',
    'NOW_SHOWING'
),
(
    N'Thám tử lừng danh Conan',
    'https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/3/image/1800x/71252117777b696995f01934522c402d/2/6/260625_poster_conan_6.jpg',
    'https://www.youtube.com/watch?v=conan_trailer',
    N'Vụ án liên quan tổ chức áo đen...',
    115,
    N'Hoạt hình / Trinh thám',
    N'Phụ đề Việt',
    N'Tachikawa Yuzuru',
    N'Conan, Ran',
    '2024-06-01',
    NULL,
    8.5,
    'C13',
    'NOW_SHOWING'
),
(
    N'Shin - Cậu bé bút chì',
    'https://upload.wikimedia.org/wikipedia/vi/2/23/Poster_for_the_21st_movie_of_crayon_shinchan_in_2013.jpg',
    'https://www.youtube.com/watch?v=shin_trailer',
    N'Những câu chuyện hài hước của Shin...',
    90,
    N'Hoạt hình / Hài',
    N'Lồng tiếng Việt',
    N'Keiichi Hara',
    N'Shin',
    '2024-05-01',
    NULL,
    8.3,
    'P',
    'NOW_SHOWING'
),

-- ================== SẮP CHIẾU ==================
(
    N'Mưa đỏ',
    'https://cdn2.tuoitre.vn/thumb_w/480/471584752817336320/2025/8/24/mua-do-6-1756027005405772261674.jpg',
    'https://www.youtube.com/watch?v=muado_trailer',
    N'Câu chuyện tình yêu dưới cơn mưa...',
    100,
    N'Tình cảm / Drama',
    N'Tiếng Việt',
    N'Nguyễn Quang Dũng',
    N'Diễn viên Việt',
    '2026-04-10',
    NULL,
    7.5,
    'C16',
    'COMING_SOON'
),
(
    N'Vùng đất luân hồi',
    'https://api-website.cinestar.com.vn/media/wysiwyg/Posters/03-2026/vung-dat-luan-hoi.jpg',
    'https://www.youtube.com/watch?v=luanhoi_trailer',
    N'Vòng luân hồi và nhân quả...',
    105,
    N'Kỳ ảo / Tâm linh',
    N'Phụ đề Việt',
    N'Đạo diễn giả lập',
    N'Diễn viên giả lập',
    '2026-05-01',
    NULL,
    7.0,
    'C16',
    'COMING_SOON'
),
(
    N'One Piece Film: Red',
    'https://j-books.shueisha.co.jp/icon/onepiece_filmred.jpg',
    'https://www.youtube.com/watch?v=onepiece_trailer',
    N'Cuộc phiêu lưu của băng Mũ Rơm...',
    120,
    N'Hoạt hình / Hành động',
    N'Phụ đề Việt',
    N'Goro Taniguchi',
    N'Luffy',
    '2026-05-15',
    NULL,
    9.0,
    'C13',
    'COMING_SOON'
),

-- ================== SUẤT CHIẾU ĐẶC BIỆT ==================
(
    N'Bố già',
    'https://cdn.tienphong.vn/images/acaaf3972f12824005b323aa5fc6b75ab27ec3363c1374552e3c751113f1f3e32082472aaaf27e30a86413e8249d057d864a468a135aa88d828cd4f7bc95f09ff0ca7ea95604f1801b5908427e7f00fe/bg_teaser_poster_brld.jpg',
    'https://www.youtube.com/watch?v=bogia_trailer',
    N'Phim Việt ăn khách chiếu lại đặc biệt...',
    128,
    N'Gia đình / Drama',
    N'Tiếng Việt',
    N'Trấn Thành',
    N'Trấn Thành',
    '2021-03-12',
    NULL,
    9.2,
    'C13',
    'SPECIAL_SHOW'
),
(
    N'Mùi phở',
    'https://iguov8nhvyobj.vcdn.cloud/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/3/5/350x495-muipho.jpg',
    'https://www.youtube.com/watch?v=muipho_trailer',
    N'Chiếu đặc biệt về văn hóa Việt...',
    95,
    N'Ẩm thực / Gia đình',
    N'Tiếng Việt',
    N'Trần Anh Hùng',
    N'Diễn viên Việt',
    '2024-06-15',
    NULL,
    7.8,
    'P',
    'SPECIAL_SHOW'
);
GO

/* CINEMAS */

INSERT INTO dbo.cinemas (name, address, phone)
VALUES
(N'CGV Vincom', N'TP.HCM', '0901234567'),
(N'Lotte Cinema', N'TP.HCM', '0907654321');
GO

/* ROOMS */
INSERT INTO dbo.rooms (cinema_id, room_name, room_type, total_rows, total_cols)
VALUES
(1, N'Phòng 1', 'STANDARD', 5, 6),
(1, N'Phòng 2', 'IMAX', 6, 8),
(2, N'Phòng 1', 'STANDARD', 5, 5);
GO

/* SEATS */
EXEC dbo.InsertSeats 1, 5, 6;
EXEC dbo.InsertSeats 2, 6, 8;
EXEC dbo.InsertSeats 3, 5, 5;
GO

/* SHOWTIMES - chỉ dùng movie_id = 1 vì hiện chỉ có 1 phim */
INSERT INTO dbo.showtimes (movie_id, room_id, start_time, end_time, format, status)
VALUES
-- ===== MOVIE 1 (Doraemon) =====
(1, 1, '2026-04-01 09:00:00', '2026-04-01 11:00:00', '2D', 'ACTIVE'),
(1, 2, '2026-04-01 13:00:00', '2026-04-01 15:00:00', '2D', 'ACTIVE'),
(1, 3, '2026-04-01 18:00:00', '2026-04-01 20:00:00', '2D', 'ACTIVE'),

-- ===== MOVIE 2 (Conan) =====
(2, 1, '2026-04-01 10:00:00', '2026-04-01 12:00:00', '2D', 'ACTIVE'),
(2, 2, '2026-04-01 14:00:00', '2026-04-01 16:00:00', '2D', 'ACTIVE'),
(2, 3, '2026-04-01 20:00:00', '2026-04-01 22:00:00', '2D', 'ACTIVE'),

-- ===== MOVIE 3 (Shin) =====
(3, 1, '2026-04-01 11:30:00', '2026-04-01 13:00:00', '2D', 'ACTIVE'),
(3, 2, '2026-04-01 16:00:00', '2026-04-01 18:00:00', '2D', 'ACTIVE'),

-- ===== COMING SOON (test trước) =====
(4, 1, '2026-04-10 18:00:00', '2026-04-10 20:00:00', '2D', 'ACTIVE'),
(5, 2, '2026-04-12 19:00:00', '2026-04-12 21:00:00', '2D', 'ACTIVE'),

-- ===== SPECIAL SHOW =====
-- Bố già (movie_id = 7)
(7, 1, '2026-04-02 19:00:00', '2026-04-02 21:00:00', '2D', 'ACTIVE'),
(7, 2, '2026-04-02 21:30:00', '2026-04-02 23:30:00', '2D', 'ACTIVE'),
-- Mùi Phở (movie_id = 8)
(8, 3, '2026-04-03 10:00:00', '2026-04-03 11:45:00', '2D', 'ACTIVE'),
(8, 1, '2026-04-03 14:00:00', '2026-04-03 15:45:00', '2D', 'ACTIVE'),
(8, 2, '2026-04-03 20:00:00', '2026-04-03 21:45:00', '2D', 'ACTIVE');
GO

/* BOOKINGS - showtime_id sẽ là 1, 2 */
INSERT INTO dbo.bookings (user_id, showtime_id, total_amount, booking_code)
VALUES
(2, 1, 170000, 'BK001'),
(3, 2, 240000, 'BK002');
GO

/* BOOKING_SEATS */
INSERT INTO dbo.booking_seats (booking_id, showtime_id, seat_id, price)
VALUES
(1, 1, 1, 85000),
(1, 1, 2, 85000),
(2, 2, 31, 120000),
(2, 2, 32, 120000);
GO

SELECT * FROM dbo.movies;
SELECT * FROM dbo.rooms;
SELECT * FROM dbo.showtimes;
SELECT * FROM dbo.bookings;
SELECT * FROM dbo.booking_seats;

SELECT * FROM movies WHERE status = 'COMING_SOON';
SELECT * FROM movies WHERE status = 'SPECIAL_SHOW';

UPDATE movies
SET poster = 'images/350x495-muipho.jpg'
WHERE title = N'Mùi phở';
SELECT * FROM movies WHERE status = 'NOW_SHOWING'
CREATE TABLE news (
    news_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    image VARCHAR(255),
    type VARCHAR(20), -- NEWS | PROMOTION
    created_at DATETIME DEFAULT GETDATE()
);
INSERT INTO news (title, content, image, type)
VALUES
(N'Tuần vui phơi phới ', N'Giảm giá cuối tuần', 'https://files.betacorp.vn/media/images/2026/02/16/binhngosecret-545x415-231623-160226-55.png', 'PROMOTION'),
(N'BÍNH NGỌ PHÁT TÀI - QUÀ TỚI LIỀN TAY', N'Mua 1 tặng 1', 'https://files.betacorp.vn/media/images/2026/03/22/tvpp-545x415-161708-220326-62.png', 'PROMOTION'),
(N'Ra mắt phim mới', N'Bom tấn tháng 4', 'https://files.betacorp.vn/media%2fimages%2f2026%2f02%2f26%2fanh%2Dchup%2Dman%2Dhinh%2D2026%2D02%2D26%2D151006%2D151102%2D260226%2D84.png', 'NEWS'),
(N'TUYỂN DỤNG PART-TIME TOÀN HỆ THỐNG', N'Gặp diễn viên', 'https://files.betacorp.vn/media/images/2025/11/28/tuyen-dung-nhan-vien-part-time-545x415-095515-281125-16.png', 'NEWS');




UPDATE dbo.movies SET poster = 'images/doraemon.png'       WHERE title = N'Doraemon: Nobita và vùng đất lý tưởng';
UPDATE dbo.movies SET poster = 'images/conan.png'          WHERE title = N'Thám tử lừng danh Conan';
UPDATE dbo.movies SET poster = 'images/shin.png'           WHERE title = N'Shin - Cậu bé bút chì';
UPDATE dbo.movies SET poster = 'images/MuaDo.png'          WHERE title = N'Mưa đỏ';
UPDATE dbo.movies SET poster = 'images/vungdatluanhoi.png' WHERE title = N'Vùng đất luân hồi';
UPDATE dbo.movies SET poster = 'images/red.png'            WHERE title = N'One Piece Film: Red';
UPDATE dbo.movies SET poster = 'images/bogia.png'          WHERE title = N'Bố già';
UPDATE dbo.movies SET poster = 'images/muipho.png'         WHERE title = N'Mùi phở';


SELECT * FROM dbo.movies;
SELECT * FROM dbo.rooms;
SELECT * FROM dbo.showtimes;
SELECT * FROM dbo.bookings;
SELECT * FROM dbo.booking_seats;
SELECT* FROM users

-- Cập nhật tất cả vé cũ sang PAID (hệ thống không có bước thanh toán riêng)
UPDATE dbo.bookings
SET payment_status = 'PAID',
    paid_at = created_at
WHERE payment_status = 'PENDING';

UPDATE news 
SET image = 'images/tuanvuive.png'
WHERE title = N'Tuần vui phơi phới';

UPDATE news 
SET image = 'images/binhngo.png'
WHERE title = N'BÍNH NGỌ PHÁT TÀI - QUÀ TỚI LIỀN TAY';

UPDATE news 
SET image = 'images/ramatphim.png'
WHERE title = N'Ra mắt phim mới';

UPDATE news 
SET image = 'images/tuyendung.png'
WHERE title = N'TUYỂN DỤNG PART-TIME TOÀN HỆ THỐNG';
