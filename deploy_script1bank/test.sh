# 用 sed 替换第一个匹配的 if 条件为 if false; then
# -i 表示直接修改文件，注意提前备份
# 1. 找到第一个符合条件的行号
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
CONFIG_FILE="${SCRIPT_DIR}/register_app_image_copy.sh"


cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"  # 显式备份

sed -i '84s/.*/  if false; then/' $CONFIG_FILE