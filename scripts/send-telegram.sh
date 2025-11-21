#!/bin/bash

# Script gửi tin nhắn qua Telegram Bot API
# Sử dụng: ./send-telegram.sh "Tin nhắn của bạn"

BOT_TOKEN="8512108880:AAEM3WCRZNbIbgqNH221rlyadEGxb6zMlIw"
CHAT_ID="@sirocon98"

# Kiểm tra tham số
if [ -z "$1" ]; then
    echo "❌ Lỗi: Vui lòng cung cấp nội dung tin nhắn"
    echo "Sử dụng: $0 \"Tin nhắn của bạn\""
    exit 1
fi

MESSAGE="$1"

# Gửi tin nhắn qua Telegram API
RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d "chat_id=${CHAT_ID}" \
    -d "text=${MESSAGE}" \
    -d "parse_mode=Markdown")

# Kiểm tra kết quả
if echo "$RESPONSE" | grep -q '"ok":true'; then
    echo "✅ Đã gửi tin nhắn thành công!"
    exit 0
else
    echo "❌ Gửi tin nhắn thất bại!"
    echo "Response: $RESPONSE"
    exit 1
fi
