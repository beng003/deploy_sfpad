# 用 sed 替换第一个匹配的 if 条件为 if false; then
# -i 表示直接修改文件，注意提前备份
# 1. 找到第一个符合条件的行号
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
CONFIG_FILE="${SCRIPT_DIR}/register_app_image_copy.sh"

line_num=$(grep -nF 'if docker exec -i "${KUSCIA_CONTAINER_NAME}" bash -c "kuscia image list 2>&1 | awk '\''{print \$1\":\"\$2}'\'' | grep -q \"^${IMAGE}$\""; then' "$CONFIG_FILE" | head -1 | cut -d: -f1)
# 2. 使用精确行号替换
# 提取原缩进（兼容性更好的写法）
original_indent=$(sed -n "${line_num}s/^$[[:space:]]*$.*/\1/p" "$CONFIG_FILE")

cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"  # 显式备份
# 在替换内容前加两个空格
sed -i "${line_num}s/.*/${original_indent}  if false; then/" "$CONFIG_FILE"