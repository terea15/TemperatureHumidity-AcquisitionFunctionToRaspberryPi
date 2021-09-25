#######################################################################################
#
# <スクリプト名>
# 温湿度情報ログローテーションスクリプト
#
# <概要>
# 温湿度情報ログのローテーション処理を行う
#
# <更新履歴>
# 20210906 - 新規作成
#
#######################################################################################
#!/bin/bash

#####################################################################
## 事前設定
#####################################################################

# 日時取得
data=`date "+%Y%m%d"`

#####################################################################
## パラメーター設定
#####################################################################

# ログファイル
origin_FILE=/var/log/temp_humi.log

# ログ取得設定
LOGFILE=/var/log/temp_humi_${data}.log

# zipパス
LOGZIP=/var/log/temp_humi_${data}.zip


#####################################################################
## ローテーション処理
#####################################################################

exec >> ${LOGFILE} 2>&1
### ログローテート処理 ###
if [ -e ${origin_FILE} ]; then
  # ログファイルをoldログへ変換
  sudo mv ${origin_FILE} ${LOGFILE}
  # 新しいログファイルを作成
  sudo touch ${origin_FILE}
  # 移動したログファイルを圧縮
  sudo zip -j ${LOGZIP} ${LOGFILE}
  # 移動したログファイルを削除
  sudo rm -f ${LOGFILE}
else
  # スクリプトの終了
  exit
fi
