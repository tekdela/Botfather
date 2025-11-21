#!/bin/bash

# Script tạo báo cáo tổng hợp từ GitHub Issues
# Sử dụng: ./generate-report.sh [month] [year]

# Lấy tháng và năm hiện tại nếu không được cung cấp
MONTH=${1:-$(date +%m)}
YEAR=${2:-$(date +%Y)}

# Định dạng tên tháng tiếng Việt
case $MONTH in
    01) MONTH_NAME="Tháng 1" ;;
    02) MONTH_NAME="Tháng 2" ;;
    03) MONTH_NAME="Tháng 3" ;;
    04) MONTH_NAME="Tháng 4" ;;
    05) MONTH_NAME="Tháng 5" ;;
    06) MONTH_NAME="Tháng 6" ;;
    07) MONTH_NAME="Tháng 7" ;;
    08) MONTH_NAME="Tháng 8" ;;
    09) MONTH_NAME="Tháng 9" ;;
    10) MONTH_NAME="Tháng 10" ;;
    11) MONTH_NAME="Tháng 11" ;;
    12) MONTH_NAME="Tháng 12" ;;
esac

# Tính ngày đầu và cuối tháng
FIRST_DAY="${YEAR}-${MONTH}-01T00:00:00Z"
LAST_DAY="${YEAR}-${MONTH}-$(date -d "${YEAR}-${MONTH}-01 +1 month -1 day" +%d)T23:59:59Z"

echo "📊 Tạo báo cáo cho ${MONTH_NAME} ${YEAR}..."

# Lấy danh sách issues đã đóng trong tháng
CLOSED_ISSUES=$(gh issue list \
    --state closed \
    --limit 1000 \
    --json number,title,closedAt,labels \
    --jq "[.[] | select(.closedAt >= \"${FIRST_DAY}\" and .closedAt <= \"${LAST_DAY}\")]")

# Đếm số lượng issues
TOTAL_ISSUES=$(echo "$CLOSED_ISSUES" | jq 'length')

# Tạo file báo cáo
REPORT_FILE="/tmp/monthly-report-${MONTH}-${YEAR}.md"

cat > "$REPORT_FILE" << EOF
📊 *BÁO CÁO CÔNG VIỆC ${MONTH_NAME^^} ${YEAR}*

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 *Thời gian*: ${MONTH_NAME} ${YEAR}
✅ *Tổng số công việc hoàn thành*: ${TOTAL_ISSUES}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

if [ "$TOTAL_ISSUES" -gt 0 ]; then
    echo "📋 *Danh sách công việc đã hoàn thành*:" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    # Thêm từng issue vào báo cáo
    echo "$CLOSED_ISSUES" | jq -r '.[] | "• #\(.number) - \(.title)"' >> "$REPORT_FILE"
else
    echo "ℹ️ Không có công việc nào được hoàn thành trong tháng này." >> "$REPORT_FILE"
fi

cat >> "$REPORT_FILE" << EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 *Kết quả*: Đã hoàn thành ${TOTAL_ISSUES} công việc trong ${MONTH_NAME}!
💪 Hãy tiếp tục phát huy trong tháng tới!
EOF

echo "✅ Đã tạo báo cáo: $REPORT_FILE"

# In nội dung báo cáo
cat "$REPORT_FILE"

# Trả về đường dẫn file
echo "$REPORT_FILE"
