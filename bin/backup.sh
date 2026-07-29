#!/bin/bash
set -euo pipefail

# ============== 配置区域 ==============
# 日志文件路径
LOG_FILE="/home/longyinstudio/Downloads/rsync_backup.log"

# 需要排除的文件/目录模式
EXCLUDE_LIST=(
    "*.tmp"
    "*.swp"
    ".DS_Store"
    "lost+found"
    ".cache/*"
    "node_modules"
)

# 是否启用镜像模式（删除目标中源目录不存在的文件，谨慎开启）
ENABLE_DELETE=false
# =======================================

# 使用说明
usage() {
    echo "用法: $0 <源目录> <目标目录>"
    echo "示例: $0 /home/user/data /mnt/external-disk/backup"
    echo ""
    echo "注意: 源目录末尾带 / 表示同步目录内的内容"
    exit 1
}

# 日志函数
log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_FILE"
}

# 前置检查
pre_check() {
    # 检查参数数量
    if [ $# -ne 2 ]; then
        echo "错误: 参数数量不正确"
        usage
    fi

    SRC_DIR="$1"
    DEST_DIR="$2"

    # 检查源目录是否存在
    if [ ! -d "$SRC_DIR" ]; then
        log "ERROR" "源目录不存在: $SRC_DIR"
        exit 1
    fi

    # 向上查找最近的挂载点，检查外置硬盘是否已挂载
    local mount_point="$DEST_DIR"
    while [ ! -d "$mount_point" ] || ! mountpoint -q "$mount_point"; do
        mount_point=$(dirname "$mount_point")
        if [ "$mount_point" = "/" ]; then
            log "ERROR" "目标路径不在已挂载的设备上: $DEST_DIR"
            log "INFO" "请先挂载外置硬盘后再运行脚本"
            exit 1
        fi
    done

    # 创建目标目录
    mkdir -p "$DEST_DIR"

    log "INFO" "前置检查通过"
    log "INFO" "源目录: $SRC_DIR"
    log "INFO" "目标目录: $DEST_DIR"
    log "INFO" "挂载点: $mount_point"
}

# 执行 rsync 同步
do_rsync() {
    log "INFO" "开始增量同步..."

    # 构造 rsync 命令
    local rsync_args=(
        -avh
        --progress
        --partial
        --stats
        --time-limit=7200
    )

    # 添加排除规则
    for pattern in "${EXCLUDE_LIST[@]}"; do
        rsync_args+=(--exclude="$pattern")
    done

    # 启用镜像删除模式
    if [ "$ENABLE_DELETE" = true ]; then
        rsync_args+=(--delete --delete-excluded)
        log "WARN" "已启用镜像模式：目标目录中多余的文件将被删除"
    fi

    # 执行同步
    rsync "${rsync_args[@]}" "$SRC_DIR" "$DEST_DIR" | tee -a "$LOG_FILE"

    # 判断执行结果
    local exit_code=${PIPESTATUS[0]}
    if [ $exit_code -eq 0 ]; then
        log "INFO" "同步完成，无错误"
    elif [ $exit_code -eq 24 ]; then
        log "WARN" "同步完成（部分源文件在传输中发生变化，退出码 24）"
    else
        log "ERROR" "同步失败，退出码: $exit_code"
        exit $exit_code
    fi
}

# 主流程
main() {
    log "INFO" "===== rsync 增量备份任务开始 ====="
    pre_check "$@"
    do_rsync
    log "INFO" "===== 任务结束 ====="
    echo "" >> "$LOG_FILE"
}

main "$@"
