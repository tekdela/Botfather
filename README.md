# 🤖 Botfather - Hệ Thống Quản Lý Công Việc Hàng Ngày

Hệ thống tự động hóa quản lý công việc hàng ngày với GitHub Actions và thông báo Telegram 📱

## 📋 Mục Lục
- [Giới thiệu](#-giới-thiệu)
- [Tính năng](#-tính-năng)
- [Cấu trúc dự án](#-cấu-trúc-dự-án)
- [Cách sử dụng](#-cách-sử-dụng)
- [GitHub Actions Workflows](#-github-actions-workflows)
- [Scripts](#-scripts)
- [Cấu hình](#-cấu-hình)
- [Lưu ý](#-lưu-ý)

## 🎯 Giới Thiệu

Botfather là hệ thống tự động giúp bạn quản lý công việc hàng ngày thông qua:
- ✅ GitHub Issues để theo dõi công việc
- 📱 Telegram Bot để nhận thông báo tự động
- ⏰ GitHub Actions để lên lịch nhắc nhở

## ✨ Tính Năng

### 🌅 Nhắc nhở buổi sáng (8:00 AM)
- Tự động gửi thông báo "Chào buổi sáng!" vào lúc 8:00 AM mỗi ngày
- Tự động tạo issue mới cho công việc hôm nay
- Gửi link trực tiếp đến issue qua Telegram

### 🌆 Tổng kết buổi tối (5:00 PM)
- Gửi thông báo tổng kết vào lúc 5:00 PM mỗi ngày
- Liệt kê tất cả công việc đã hoàn thành trong ngày
- Động viên và khuyến khích tiếp tục

### 📊 Báo cáo cuối tháng
- Tự động tạo báo cáo tổng hợp vào ngày cuối mỗi tháng
- Thống kê số lượng công việc đã hoàn thành
- Gửi báo cáo chi tiết qua Telegram

## 📁 Cấu Trúc Dự Án

```
Botfather/
├── .github/
│   ├── workflows/
│   │   ├── morning-reminder.yml    # Workflow nhắc nhở buổi sáng
│   │   ├── evening-summary.yml     # Workflow tổng kết buổi tối
│   │   └── monthly-report.yml      # Workflow báo cáo cuối tháng
│   └── ISSUE_TEMPLATE/
│       └── daily-task.md           # Template cho issue hàng ngày
├── scripts/
│   ├── send-telegram.sh            # Script gửi tin nhắn Telegram
│   └── generate-report.sh          # Script tạo báo cáo tháng
└── README.md                       # Tài liệu hướng dẫn
```

## 🚀 Cách Sử Dụng

### 1️⃣ Nhận thông báo tự động

Hệ thống sẽ tự động:
- **8:00 AM** 🌅: Gửi lời chào và tạo issue mới cho ngày hôm nay
- **5:00 PM** 🌆: Gửi tổng kết công việc đã hoàn thành
- **Cuối tháng** 📊: Gửi báo cáo tổng hợp cả tháng

### 2️⃣ Làm việc với Issues

#### Tạo công việc mới:
```bash
# Issue sẽ tự động được tạo mỗi sáng, hoặc bạn có thể tạo thủ công:
gh issue create --template daily-task.md --label daily-task
```

#### Cập nhật tiến độ:
- Mở issue của ngày hôm nay
- Tick vào các công việc đã hoàn thành
- Thêm ghi chú nếu cần

#### Đóng issue:
```bash
# Khi hoàn thành tất cả công việc trong ngày
gh issue close <số-issue>
```

### 3️⃣ Chạy thủ công

Bạn có thể chạy workflow thủ công qua GitHub UI:
1. Vào tab **Actions** trên GitHub
2. Chọn workflow muốn chạy
3. Click **Run workflow**

## ⚙️ GitHub Actions Workflows

### 🌅 Morning Reminder (`morning-reminder.yml`)
- **Lịch chạy**: Mỗi ngày lúc 1:00 AM UTC (8:00 AM VN)
- **Chức năng**:
  - Tạo issue mới cho ngày hôm nay
  - Gửi thông báo chào buổi sáng qua Telegram
  - Gửi kèm link đến issue

### 🌆 Evening Summary (`evening-summary.yml`)
- **Lịch chạy**: Mỗi ngày lúc 10:00 AM UTC (5:00 PM VN)
- **Chức năng**:
  - Thu thập danh sách issues đã đóng trong ngày
  - Tổng hợp số lượng công việc hoàn thành
  - Gửi tổng kết qua Telegram

### 📊 Monthly Report (`monthly-report.yml`)
- **Lịch chạy**: Ngày cuối mỗi tháng lúc 23:00 UTC
- **Chức năng**:
  - Kiểm tra xem có phải ngày cuối tháng không
  - Tạo báo cáo tổng hợp công việc cả tháng
  - Gửi báo cáo chi tiết qua Telegram

## 🔧 Scripts

### 📤 `send-telegram.sh`
Script gửi tin nhắn qua Telegram Bot API

**Sử dụng**:
```bash
./scripts/send-telegram.sh "Nội dung tin nhắn"
```

**Tính năng**:
- Gửi tin nhắn với Markdown formatting
- Kiểm tra kết quả gửi
- Báo lỗi nếu thất bại

### 📊 `generate-report.sh`
Script tạo báo cáo tháng từ GitHub Issues

**Sử dụng**:
```bash
./scripts/generate-report.sh [tháng] [năm]

# Ví dụ:
./scripts/generate-report.sh 11 2025  # Báo cáo tháng 11/2025
./scripts/generate-report.sh          # Báo cáo tháng hiện tại
```

**Tính năng**:
- Lấy danh sách issues đã đóng trong tháng
- Tạo báo cáo định dạng Markdown
- Đếm tổng số công việc hoàn thành

## ⚙️ Cấu Hình

### Telegram Bot
- **Bot Token**: `8512108880:AAEM3WCRZNbIbgqNH221rlyadEGxb6zMlIw`
- **Chat ID**: `@sirocon98`

Token và Chat ID đã được cấu hình sẵn trong các script.

### Múi giờ
Hệ thống sử dụng múi giờ UTC trong GitHub Actions:
- 🌅 8:00 AM Việt Nam = 1:00 AM UTC
- 🌆 5:00 PM Việt Nam = 10:00 AM UTC

### Labels
Issues công việc hàng ngày được gắn label: `daily-task`

## 📝 Lưu Ý

### ⚠️ Quan trọng
- Các workflow cần quyền truy cập GitHub Issues (đã được cấu hình sẵn)
- GitHub Actions có thể chạy chậm hơn 5-10 phút so với lịch đã đặt
- Telegram Bot Token đã được cấu hình trực tiếp trong code (đã được cho phép)

### 💡 Tips
- Sử dụng emoji trong issue để dễ theo dõi: ✅ ❌ 🔄 ⏸️
- Thêm label để phân loại công việc: `urgent`, `important`, `later`
- Review issues đã đóng để đánh giá hiệu suất làm việc

### 🔒 Bảo mật
- Trong môi trường production, nên sử dụng GitHub Secrets để lưu Bot Token
- Tham khảo: Settings → Secrets and variables → Actions

## 🎨 Ví Dụ Tin Nhắn

### Buổi sáng 🌅
```
🌅 Chào buổi sáng!

📅 Ngày: 21/11/2025
⏰ Giờ: 8:00 AM

💼 Hôm nay bạn có công việc gì cần làm?

📝 Issue hôm nay: https://github.com/...

🎯 Hãy bắt đầu một ngày làm việc hiệu quả!
```

### Buổi tối 🌆
```
🌆 Tổng kết buổi tối!

📅 Ngày: 21/11/2025
⏰ Giờ: 5:00 PM

✅ Bạn đã hoàn thành 3 công việc hôm nay:

• #1 - Hoàn thành báo cáo
• #2 - Review code
• #3 - Meeting với team

🎉 Chúc mừng! Hãy nghỉ ngơi và thư giãn!
```

### Cuối tháng 📊
```
📊 BÁO CÁO CÔNG VIỆC THÁNG 11 2025

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 Thời gian: Tháng 11 2025
✅ Tổng số công việc hoàn thành: 45
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Danh sách công việc đã hoàn thành:
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 Kết quả: Đã hoàn thành 45 công việc trong Tháng 11!
💪 Hãy tiếp tục phát huy trong tháng tới!
```

## 🤝 Đóng Góp

Mọi đóng góp đều được chào đón! Hãy tạo issue hoặc pull request nếu bạn có ý tưởng cải thiện.

## 📄 License

MIT License - Tự do sử dụng và chỉnh sửa theo nhu cầu.

---

💖 Được tạo với tình yêu để giúp quản lý công việc hiệu quả hơn!
