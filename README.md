# Báo cáo 
## Bộ môn : Lập Trình Ứng Dụng Di Động (N04)
## ĐỀ TÀI : Ứng dụng Cho Thuê Xe

- Giảng Viên Hướng Dẫn: Nguyễn Xuân Quế

- Sinh Viên Thực Hiện : Nguyễn Thế Dũng
- Mã Số Sinh Viên : 23010396

## Phần 1 - SRS (Software Requirements Specification)

### 1. Giới thiệu
Ứng dụng cho thuê xe là một ứng dụng di động được phát triển bằng Flutter, cho phép người dùng xem thông tin và đặt thuê các loại xe cao cấp.

### 2. Các chức năng chính

#### 2.1. Xem danh sách xe
- Hiển thị danh sách xe có sẵn để thuê
- Mỗi xe hiển thị: tên hãng, tên xe, giá thuê/ngày
- Hỗ trợ tính năng tìm kiếm và lọc theo danh mục

#### 2.2. Xem chi tiết xe
- Hiển thị thông tin chi tiết về xe:
  - Hình ảnh xe (carousel slider tự động)
  - Thông số kỹ thuật (động cơ, công suất, tốc độ...)
  - Tính năng đặc biệt (hệ thống âm thanh, điều hòa...)
  - Giá thuê và điều kiện
- Có thể thêm/xóa xe khỏi danh sách yêu thích

#### 2.3. Đặt thuê xe
- Form đặt thuê với các thông tin:
  - Thông tin người thuê
  - Thời gian thuê
  - Phương thức thanh toán
- Xác nhận đơn đặt thuê

#### 2.4. Đánh giá và bình luận
- Xem đánh giá của người dùng khác
- Thêm bình luận và đánh giá cho xe đã thuê

#### 2.5. Quản lý tài khoản
- Đăng ký/Đăng nhập tài khoản
- Xem danh sách xe yêu thích
- Quản lý đơn đặt thuê

### 3. Yêu cầu phi chức năng
- Giao diện người dùng thân thiện, dễ sử dụng
- Hiệu suất mượt mà, phản hồi nhanh
- Hỗ trợ đa nền tảng (iOS, Android)
- Bảo mật thông tin người dùng

## Phần 2 - SAD (Software Architecture Design)

### 1. Kiến trúc tổng thể

```
rentcar/
├── lib/
│   ├── bloc/           # State management
│   ├── model/          # Data models
│   ├── pages/          # Screen UI
│   └── widgets/        # Reusable components
```

### 2. Mô hình kiến trúc
Ứng dụng sử dụng mô hình BLoC (Business Logic Component):
- **Model**: Định nghĩa cấu trúc dữ liệu (Car, Comment, User...)
- **Bloc**: Quản lý trạng thái và logic nghiệp vụ
- **UI**: Các widget và pages hiển thị giao diện

### 3. Các thành phần chính

#### 3.1. Models
- **Car**: 
```dart
class Car {
  String companyName;
  String carName;
  int price;
  List<String> imgList;
  List<Map<Icon, String>> offerDetails;
  List<Map<Icon, String>> features;
  List<Map<Icon, Map<String, String>>> specifications;
}
```

#### 3.2. State Management
- Sử dụng Provider và BLoC pattern
- StateBloc: Quản lý trạng thái animation
- StateProvider: Quản lý trạng thái xe và yêu thích

#### 3.3. UI Components
- **Pages**:
  - HomePage: Danh sách xe
  - CarDetailPage: Chi tiết xe
  - LoginPage: Đăng nhập
  - RegisterPage: Đăng ký

- **Widgets**:
  - CarCarousel: Slider hình ảnh xe
  - CarDetails: Thông tin chi tiết
  - CustomBottomSheet: Bottom sheet tùy chỉnh
  - CommentsSection: Phần bình luận
  - RentFormBottomSheet: Form đặt thuê

### 4. Luồng dữ liệu
1. User tương tác với UI
2. UI gửi event đến BLoC
3. BLoC xử lý logic và cập nhật state
4. UI cập nhật theo state mới

### 5. Thiết kế giao diện
- Sử dụng Material Design
- Theme màu chủ đạo: Deep Purple và Pink
- Animations mượt mà:
  - Scale và fade transitions
  - Bottom sheet với gesture controls
  - Carousel slider tự động

### 6. Database Schema (Proposed)
```
Users
- id: string
- name: string
- email: string
- favorites: Car[]

Cars
- id: string
- companyName: string
- carName: string
- price: number
- images: string[]
- specifications: Map
- features: Map

Bookings
- id: string
- userId: string
- carId: string
- startDate: datetime
- endDate: datetime
- status: string

Comments
- id: string
- userId: string
- carId: string
- content: string
- rating: number
```

### 7. Security Considerations
- Xác thực người dùng với JWT
- Mã hóa dữ liệu nhạy cảm
- Validate input từ người dùng
- Kiểm soát quyền truy cập API